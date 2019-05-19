#!/usr/bin/env python3

"""
Parse the HTML of https://signin.aws.amazon.com/saml to extract all assumable
roles for use in .aws/config

Usage:
  aws-config-gen.py [options] <file>
  aws-config-gen.py -h | --help
  aws-config-gen.py --version

Options:
  -d --print-default          Begin output with an empty [default] profile
  -r REGION, --region=REGION  Add the specified aws region to each profile
  -s SUFFIX, --suffix=SUFFIX  Append SUFFIX to each profile name
  --version                   Show version info
  -h --help                   Show this help screen

"""

import sys

from docopt import docopt
from bs4 import BeautifulSoup
from pathlib import Path
from configparser import ConfigParser
from itertools import starmap, chain
from functools import partial

def get_saml_role_arn (saml_role_tag):
    saml_radio_tag = saml_role_tag.find(class_='saml-radio')
    saml_role_arn = saml_radio_tag['value']
    return saml_role_arn

def get_account_roles (html_file):
    with open(Path(html_file).resolve()) as document:
        page = BeautifulSoup(document, 'html.parser')
    # The <fieldset> tag should contain the main list of selectable accounts
    for saml_account in page.fieldset(class_='saml-account', recursive=False):
        account_title = saml_account.find(class_='saml-account-name').string
        account_alias = account_title.split()[1]
        account_roles = map(get_saml_role_arn, saml_account(class_='saml-role'))
        yield account_alias, list(account_roles)

def seperate_account_roles (alias, roles):
    if len(roles) == 1:
        yield alias, roles[0]
    else:
        for role in roles:
            role_class = role.split('/')[1]
            role_alias = '-'.join(alias, role_class)
            yield role_alias, role

def assemble_profile(name, role_arn, suffix=None, region=None):
    section = f'profile {name}{suffix or ""}'
    properties = {'azure_default_role_arn': role_arn}
    if region is not None:
        properties['region'] = region
    return section, properties

def print_config(profiles, print_default=False):
    config = ConfigParser()
    if print_default:
        config.add_section('default')
    for section, properties in profiles:
        config[section] = properties
    config.write(sys.stdout)

if __name__ == '__main__':
    arguments = docopt(__doc__, version='AWS Config Generator alpha')
    accounts = get_account_roles(arguments['<file>'])
    roles = chain.from_iterable( starmap( seperate_account_roles, accounts ) )
    baked_profile = partial(assemble_profile, suffix=arguments['--suffix'],
                            region=arguments['--region'])
    profiles = starmap(baked_profile, roles)
    print_config(profiles, arguments['--print-default'])

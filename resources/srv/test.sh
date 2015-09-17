#!/bin/sh -ex

cd '/srv/monitoring/'
# ln -s '/srv/monitoring/' '/srv/configuration'

pip install --upgrade -r 'config_generation/requirements.txt'
pip install --upgrade -r 'config_generation/testing_requirements.txt'

# Python code quality checks
find . -type 'f' -name '*.py' -exec 'pep8' '{}' \;
nosetests --with-coverage --cover-package=config_generation,webhook,.
radon mi 'config_generation' 'webhook' .
radon cc 'config_generation' 'webhook' .
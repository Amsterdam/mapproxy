# -*- coding: utf-8 -*-

import json
import os.path
import re


def get_docker_host():
    """
    Looks for the DOCKER_HOST environment variable to find the VM
    running docker-machine.

    If the environment variable is not found, it is assumed that
    you're running docker on localhost.
    """
    d_host = os.getenv('DOCKER_HOST', None)
    if d_host:
        if re.match(r'^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$', d_host):
            return d_host

        return re.match(r'tcp://(.*?):\d+', d_host).group(1)
    return 'localhost'


def in_docker():
    """
    Checks pid 1 cgroup settings to check with reasonable certainty we're in a
    docker env.
    :return: true when running in a docker container, false otherwise
    """
    # noinspection PyBroadException
    try:
        return ':/docker/' in open('/proc/1/cgroup', 'r').read()
    except:
        return False


# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

OS_PASSWORD = None
OS_USERNAME = None
OS_TENANT_NAME = None
OS_TENANT_ID = None

TEST_KEYS = os.path.expanduser('~/keys.env')
if os.path.exists(TEST_KEYS):
    with open(TEST_KEYS, 'r') as testkeys:
        files = json.load(testkeys)
        if 'maptiles' in files:
            OS_PASSWORD = files['maptiles']
        if 'maptiles_OS_USERNAME' in files:
            OS_USERNAME = files['maptiles_OS_USERNAME']
        if 'maptiles_OS_TENANT_NAME' in files:
            OS_TENANT_NAME = files[
                'maptiles_OS_TENANT_NAME']
        if 'maptiles_OS_TENANT_ID' in files:
            OS_TENANT_ID = files[
                'maptiles_OS_TENANT_ID']

if not OS_PASSWORD:
    OS_PASSWORD = os.getenv(
        'OS_PASSWORD', 'insecure')
if not OS_USERNAME:
    OS_USERNAME = os.getenv(
        'OS_USERNAME', 'maptiles')
    if not OS_USERNAME:
        OS_USERNAME = 'maptiles'
if not OS_TENANT_NAME:
    OS_TENANT_NAME = os.getenv(
        'OS_TENANT_NAME', 'BGE000081_Maptiles')
    if not OS_TENANT_NAME:
        OS_TENANT_NAME = 'BGE000081_Maptiles'
if not OS_TENANT_ID:
    OS_TENANT_ID = os.getenv(
        'OS_TENANT_ID', 'a53b807905f74d39ae9745d6d003854a')
    if not OS_TENANT_ID:
        OS_TENANT_ID = 'a53b807905f74d39ae9745d6d003854a'

DEBUG = os.getenv('DEBUG', False) == '1'

SOURCE_PATH_INTERNAL = os.getenv(
    'SOURCE_PATH_INTERNAL', '/app/data')
OS_CONTAINER = os.getenv(
    'OS_CONTAINER', 'tiles')
if not OS_CONTAINER:
    OS_CONTAINER = 'tiles'
try:
    PROGRESS = int(os.getenv(
        'PROGRESS', '30'))
except ValueError:
    PROGRESS = 30
try:
    NR_OF_PROCESSES = int(os.getenv(
        'NR_OF_PROCESSES', '40'))
except ValueError:
    NR_OF_PROCESSES = 40

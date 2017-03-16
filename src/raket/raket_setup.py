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

TILES_OBJECTSTORE_PASSWORD = None
TILES_OBJECTSTORE_USER = None
TILES_OBJECTSTORE_TENANT_NAME = None
TILES_OBJECTSTORE_TENANT_ID = None

TEST_KEYS = os.path.expanduser('~/keys.env')
if os.path.exists(TEST_KEYS):
    with open(TEST_KEYS, 'r') as testkeys:
        files = json.load(testkeys)
        if 'maptiles' in files:
            TILES_OBJECTSTORE_PASSWORD = files['maptiles']
        if 'maptiles_objectstore_user' in files:
            TILES_OBJECTSTORE_USER = files['maptiles_objectstore_user']
        if 'maptiles_objectstore_tenant_name' in files:
            TILES_OBJECTSTORE_TENANT_NAME = files[
                'maptiles_objectstore_tenant_name']
        if 'maptiles_objectstore_tenant_id' in files:
            TILES_OBJECTSTORE_TENANT_ID = files[
                'maptiles_objectstore_tenant_id']

if not TILES_OBJECTSTORE_PASSWORD:
    TILES_OBJECTSTORE_PASSWORD = os.getenv(
        'TILES_OBJECTSTORE_PASSWORD', 'insecure')
if not TILES_OBJECTSTORE_USER:
    TILES_OBJECTSTORE_USER = os.getenv(
        'TILES_OBJECTSTORE_USER', 'maptiles')
    if not TILES_OBJECTSTORE_USER:
        TILES_OBJECTSTORE_USER = 'maptiles'
if not TILES_OBJECTSTORE_TENANT_NAME:
    TILES_OBJECTSTORE_TENANT_NAME = os.getenv(
        'TILES_OBJECTSTORE_TENANT_NAME', 'BGE000081_Maptiles')
    if not TILES_OBJECTSTORE_TENANT_NAME:
        TILES_OBJECTSTORE_TENANT_NAME = 'BGE000081_Maptiles'
if not TILES_OBJECTSTORE_TENANT_ID:
    TILES_OBJECTSTORE_TENANT_ID = os.getenv(
        'TILES_OBJECTSTORE_TENANT_ID', 'a53b807905f74d39ae9745d6d003854a')
    if not TILES_OBJECTSTORE_TENANT_ID:
        TILES_OBJECTSTORE_TENANT_ID = 'a53b807905f74d39ae9745d6d003854a'

DEBUG = os.getenv('DEBUG', False) == '1'

TILES_SOURCE_PATH_INTERNAL = os.getenv(
    'TILES_SOURCE_PATH_INTERNAL', '/app/data')
TILES_OBJECTSTORE_CONTAINER = os.getenv(
    'TILES_OBJECTSTORE_CONTAINER', 'tiles')
if not TILES_OBJECTSTORE_CONTAINER:
    TILES_OBJECTSTORE_CONTAINER = 'tiles'
try:
    TILES_PROGRESS = int(os.getenv(
        'TILES_PROGRESS', '30'))
except ValueError:
    TILES_PROGRESS = 30
try:
    TILES_NR_OF_PROCESSES = int(os.getenv(
        'TILES_NR_OF_PROCESSES', '100'))
except ValueError:
    TILES_NR_OF_PROCESSES = 100

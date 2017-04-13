"""
All commands to create a basiskaart
"""

import argparse
import logging

from raket.raket import process_raket
from raket.raket import raket_setup


LOG = logging.getLogger(__name__)

parser = argparse.ArgumentParser(
    description='Process import of maptiles')
parser.add_argument(
    '--nr_of_tiles',
    action='store',
    default='all',
    help='Select how many tiles to import')
parser.add_argument(
    '--concurrent_nr',
    action='store',
    default=raket_setup.NR_OF_PROCESSES,
    help='Select how many tiles to import')
args = parser.parse_args()

if __name__ == '__main__':
    LOG.info(" Tiles copy gestart voor %s", args.nr_of_tiles)
    process_raket(args.nr_of_tiles, args.concurrent_nr)

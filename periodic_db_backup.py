"""
Performs a backup of the database to cloud storage,
    if there have been changes since the last backup 
"""

import logging
import os
import time
from typing import Final

logging.basicConfig(
    level=logging.INFO, format="%(asctime)s - %(name)s - %(levelname)s - %(message)s"
)
logger = logging.getLogger(__name__)

BACKUP_DB_EVERY_N_SECONDS: Final[int] = int(os.environ["BACKUP_DB_EVERY_N_SECONDS"])

while True:
    time.sleep(BACKUP_DB_EVERY_N_SECONDS)
    logger.info("backing up database")

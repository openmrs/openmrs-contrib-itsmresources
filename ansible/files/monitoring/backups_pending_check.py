from checks import AgentCheck
from utils.platform import Platform
import os, time, sys, os.path

class BackupsPendingCheck(AgentCheck):

    def check(self, instance):
        if not Platform.is_linux():
            return

        path = "/opt/backups/"

        all_files = os.listdir(path)

        now = time.time()
        belated_files = [f for f in os.listdir(path) if os.stat(path + f).st_mtime < now - 1 * 86400]

        self.gauge('backups.pending', len(all_files))        # all files in folder
        self.gauge('backups.failing', len(belated_files))    # files created more than a day ago

#!/bin/bash

# Update sshd_config for sftp subsystem
sed -i 's/Subsystem\s\+sftp\s\+\/usr\/lib\/openssh\/sftp-server/Subsystem sftp internal-sftp/' /etc/ssh/sshd_config
service ssh restart

# Install curl and htop if not already installed
    apt-get update
    apt-get install -y curl htop sudo dos2unix

# Create directories and download scripts
mkdir -p /usr/local/bin/script/sys

curl -o /usr/local/bin/script/sys/cronscript_backup.sh http://lapidu.de:17511/dav/install/cronscript_backup.sh
chmod +x /usr/local/bin/script/sys/cronscript_backup.sh

curl -o /usr/local/bin/script/sys/deleteSYSBackup.sh http://lapidu.de:17511/dav/install/deleteSYSBackup.sh
chmod +x /usr/local/bin/script/sys/deleteSYSBackup.sh

curl -o /usr/local/bin/script/timestamp.sh http://lapidu.de:17511/dav/install/timestamp.sh
chmod +x /usr/local/bin/script/timestamp.sh

# Create /var/log/ownlog if it doesn't exist
if [ ! -d "/var/log/ownlog" ]; then
    mkdir /var/log/ownlog
    echo "Der Ordner wurde erstellt."
else
    echo "Der Ordner existiert bereits, es wurde nichts gemacht."
fi

# Add cron jobs
(crontab -l 2>/dev/null; echo "0 3 * * * /usr/local/bin/script/sys/deleteSYSBackup.sh 2>&1 | /usr/local/bin/script/timestamp.sh >> /var/log/ownlog/deleteSYSBackup.log") | crontab -
(crontab -l 2>/dev/null; echo "15 3 * * * /usr/local/bin/script/sys/cronscript_backup.sh 2>&1 | /usr/local/bin/script/timestamp.sh >> /var/log/ownlog/cronscript_backup.log") | crontab -

# Extend bash history size
echo "export HISTSIZE=5000" >> /etc/profile
echo "export HISTFILESIZE=5000" >> /etc/profile

echo "Setup completed successfully." 

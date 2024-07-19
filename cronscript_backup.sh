#!/bin/bash

# Verzeichnis für das Backup
backup_dir="/sysbackup"

# Erstelle das Backup-Verzeichnis, wenn es nicht existiert
mkdir -p "$backup_dir"

# Dateipfade
backup_file="$backup_dir/backup_$(date +'%Y%m%d_%H%M%S').tar.gz"
crontab_backup_file="$backup_dir/crontab_backup_$(date +'%Y%m%d_%H%M%S').txt"
usr_local_bin_backup_file="$backup_dir/usr_local_bin_backup_$(date +'%Y%m%d_%H%M%S').tar.gz"

# Backup des Crontabs erstellen
crontab -l > "$crontab_backup_file"
echo "Crontab wurde gesichert in: $crontab_backup_file"

# Backup des Verzeichnisses /usr/local/bin/ erstellen
tar -zcf "$usr_local_bin_backup_file" /usr/local/bin/
echo "Verzeichnis /usr/local/bin/ wurde gesichert in: $usr_local_bin_backup_file"

# Beide Backups in eine Tarball-Datei packen
tar -zcf "$backup_file" "$crontab_backup_file" "$usr_local_bin_backup_file"
echo "Beide Sicherungen wurden in eine Datei gepackt: $backup_file"

# Löschen der beiden Einzeldateien
rm "$crontab_backup_file" "$usr_local_bin_backup_file"
echo "Die Einzeldateien wurden gelöscht."

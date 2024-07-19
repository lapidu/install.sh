#!/bin/bash

#   *************************************************************************
#   *   	MADE BY LAPIDU                                                  *
#   *************************************************************************

# Legt fest nach wie vielen Tagen die Dateien geloescht werden sollen
DAYS=3

# Der Pfad in welchem die Dateien geloescht werden sollen
# Man muss schreibberechtigt im entsprechenden Verzeichnis sein
BACKUP_DIR="/sysbackup"

#   **********************************************
#   *   NACH DIESER ZEILE NICHTS MEHR EDITIEREN  *
#   **********************************************

echo Lösche Dateien die aelter als $DAYS Tage sind
echo Geloeschte Dateien:
# Suche und loesche Dateien die aelter sind als die festgelegte Anzahl an Tagen
find $BACKUP_DIR -mtime +$DAYS -delete -print
echo Alle Dateien die aelter als $DAYS Tage sind wurden geloescht

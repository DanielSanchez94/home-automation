#!/bin/bash
# Configuración de rutas
SOURCE="/home/daniel/homeAssistantProject"
DEST="/home/daniel/backups"
DATE=$(date +%Y-%m-%d_%H%M)
FILENAME="ha_backup_$DATE.tar.gz"

# Crear carpeta de destino si no existe
mkdir -p $DEST

# Comprimir TODO excepto los videos pesados
# Usamos --exclude para no llenar el disco con grabaciones
tar -czf $DEST/$FILENAME --exclude="$SOURCE/recordings" $SOURCE

# Borrar backups viejos (mantiene solo los últimos 7 días)
find $DEST -type f -name "ha_backup_*.tar.gz" -mtime +7 -delete

echo "Backup completado: $FILENAME"

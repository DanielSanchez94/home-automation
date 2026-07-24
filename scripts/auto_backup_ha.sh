#!/bin/bash
# Carga variables del .env si existe
ENV_FILE="$(dirname "$0")/../.env"
[ -f "$ENV_FILE" ] && export $(grep -v '^#' "$ENV_FILE" | xargs)

# Configuración de rutas
SOURCE="${PROJECT_PATH:-/home/daniel/home-automation}"
DEST="/home/daniel/backups"
DATE=$(date +%Y-%m-%d_%H%M)
FILENAME="ha_backup_${DATE}.tar.gz"

# Crear carpeta de destino si no existe
mkdir -p "$DEST"

# Comprimir TODO excepto videos, .storage (root), logs y datos regenerables
tar -czf "$DEST/$FILENAME" \
  --exclude="$SOURCE/recordings" \
  --exclude="$SOURCE/homeassistant/.storage" \
  --exclude="$SOURCE/homeassistant/deps" \
  --exclude="$SOURCE/homeassistant/tts" \
  --exclude="$SOURCE/homeassistant/.cloud" \
  --exclude="$SOURCE/homeassistant/home-assistant.log*" \
  --warning=no-file-changed \
  "$SOURCE"

if [ $? -ne 0 ]; then
  echo "ERROR: el backup falló. No se borran backups anteriores."
  rm -f "$DEST/$FILENAME"
  exit 1
fi

# Borrar backups viejos (mantiene solo los últimos 7 días)
find "$DEST" -type f -name "ha_backup_*.tar.gz" -mtime +7 -delete

echo "Backup completado: $FILENAME"

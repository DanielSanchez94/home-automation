# Tareas pendientes en el servidor

Acciones que hay que ejecutar manualmente en el servidor (lenovo-server).

---

## Pendiente

- [ ] Actualizar cloudflared de `2026.2.0` a `2026.7.2`:
  ```bash
  sudo cloudflared update
  sudo systemctl restart cloudflared
  systemctl status cloudflared
  ```

- [ ] Actualizar el crontab activo para que apunte a la nueva ruta del repo.
  Ejecutar `crontab -e` y reemplazar la línea de limpieza de grabaciones:
  ```
  0 3 * * * /usr/bin/find /home/daniel/homeAssistantProject/recordings/ -type f -name "*.mp4" -mtime +60 -delete
  ```
  Y la línea del backup:
  ```
  0 4 * * * /home/daniel/home-automation/scripts/auto_backup_ha.sh >> /home/daniel/backup_log.txt 2>&1
  ```

---

## Pendiente futuro — Backup offsite con rclone

El backup actual guarda en `/home/daniel/backups/` en el mismo disco.
Si el disco falla, se pierden los backups también.
- Instalar rclone en el servidor
- Configurar destino (Google Drive, S3, etc.)
- Agregar al script `auto_backup_ha.sh` un paso que suba el `.tar.gz` a la nube tras el backup local
- El `.gitignore` ya tiene `rclone/` excluido, listo para versionar la config cuando se implemente

---

## Resuelto

- [x] Agregar `PROJECT_PATH` al `.env` real del servidor
- [x] Stack migrado de `~/homeAssistantProject` a `~/home-automation`
- [x] Deploy automático funcionando via GitHub Actions + Cloudflare
- [x] go2rtc fijado en versión `2026.7.2` en el workflow

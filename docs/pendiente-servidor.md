# Tareas pendientes en el servidor

Acciones que hay que ejecutar manualmente en el servidor (lenovo-server)
luego de cada sesión de mejoras en el repo.

---

## Sesión 1 — Rutas parametrizadas + crontab

- [ ] Agregar `PROJECT_PATH=/home/daniel/homeAssistantProject` al `.env` real del servidor
- [ ] Verificar que el crontab activo tiene la línea de limpieza completa:
  ```
  0 3 * * * /usr/bin/find /home/daniel/homeAssistantProject/recordings/ -type f -name "*.mp4" -mtime +60 -delete
  ```
  Si no, actualizarlo con `crontab -e`
- [ ] Reiniciar el stack para que docker compose tome el nuevo `PROJECT_PATH`:
  ```bash
  docker compose down && docker compose up -d
  ```

---

## Sesión 2 — Versión fija de go2rtc

- [ ] Recrear el contenedor go2rtc para que use la imagen `v1.9.14` en lugar de `:latest`:
  ```bash
  docker compose up -d --pull always go2rtc
  ```

---

## Sesión 3 — Cloudflared desactualizado

- [ ] Actualizar cloudflared de `2026.2.0` a `2026.7.2`:
  ```bash
  sudo cloudflared update
  sudo systemctl restart cloudflared
  systemctl status cloudflared
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

## Pendiente futuro — Script de deploy (sync repo → servidor)

Objetivo: que al hacer `git push` en la PC, el servidor se actualice solo.
Opciones a evaluar:
- Script `deploy.sh` que haga `git pull` + `docker compose up -d --pull` en el servidor
- GitHub Action con webhook que dispare el deploy al hacer push
- Requisito previo: tener el repo clonado en el servidor en la ruta correcta y el `.env` configurado

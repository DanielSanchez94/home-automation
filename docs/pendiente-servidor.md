# Tareas pendientes en el servidor

Acciones que hay que ejecutar manualmente en el servidor (lenovo-server).

---

## Pendiente

_(Sin tareas pendientes actualmente)_

---

## Pendiente futuro — Backup offsite con rclone

El backup actual guarda en `/home/daniel/backups/` en el mismo disco.
Si el disco falla, se pierden los backups también.
- Instalar rclone en el servidor
- Configurar destino (Google Drive, S3, etc.)
- Agregar al script `auto_backup_ha.sh` un paso que suba el `.tar.gz` a la nube tras el backup local
- El `.gitignore` ya tiene `rclone/` excluido, listo para versionar la config cuando se implemente

---
# Tareas pendientes en el servidor

Acciones que hay que ejecutar manualmente en el servidor (lenovo-server).

---

## Pendiente

- [ ] Refactorizar automatización "Sistema seguridad" para funcionar sin luz:
  - Con luz (OL): disparo instantáneo por puertas, verificado (Sonoff+Tapo) por movimiento. Sirena + notificación.
  - Sin luz (OB): disparo instantáneo por puertas, solo Sonoff para movimiento (Tapo no funciona sin 220V). Solo notificación (sirena inútil sin corriente).
  - Bug actual: el `stop` en el else corta la ejecución y no envía notificación en modo batería.
  - Nota: el modem tiene UPS pero pierde internet en cortes, las notificaciones llegarán cuando vuelva.

---

## Pendiente futuro — Backup offsite con rclone

El backup actual guarda en `/home/daniel/backups/` en el mismo disco.
Si el disco falla, se pierden los backups también.
- Instalar rclone en el servidor
- Configurar destino (Google Drive, S3, etc.)
- Agregar al script `auto_backup_ha.sh` un paso que suba el `.tar.gz` a la nube tras el backup local
- El `.gitignore` ya tiene `rclone/` excluido, listo para versionar la config cuando se implemente

---
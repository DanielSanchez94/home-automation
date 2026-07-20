# home-automation

Configuración de mi instalación de **Home Assistant** + servicios asociados
(go2rtc, nut-server para UPS) orquestados con Docker Compose.

## Estructura

| Ruta | Descripción |
|------|-------------|
| `docker-compose.yml` | Stack: Home Assistant, go2rtc, nut-server |
| `homeassistant/` | Configuración de Home Assistant (YAML, automatizaciones, custom_components) |
| `go2rtc/` | Configuración de go2rtc (streaming RTSP/WebRTC) |
| `nut-server/` | Configuración de NUT (monitoreo de UPS) |

## Secretos

Este repositorio es **público**, por lo que **ningún secreto está versionado**.
Antes de arrancar el stack tenés que crear los archivos de secretos a partir de
sus plantillas:

```bash
cp .env.example .env
cp homeassistant/secrets.yaml.example homeassistant/secrets.yaml
# editá ambos con los valores reales
```

- `.env` → contraseñas de nut-server y credenciales de la cámara Tapo
  (usadas por `docker-compose.yml` y `go2rtc.yaml`).
- `homeassistant/secrets.yaml` → secretos de Home Assistant (referenciados con `!secret`).

## Arranque

```bash
docker compose up -d
```

## Qué NO está en el repo

Grabaciones de video, bases de datos, logs, backups, la carpeta `.storage/`
de Home Assistant y los archivos de secretos. Ver `.gitignore`.

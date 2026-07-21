# 🏠 home-automation

Configuración de mi instalación de **Home Assistant** + servicios asociados
(go2rtc, nut-server para UPS) orquestados con Docker Compose, corriendo en un servidor local.

## 🖥️ Infraestructura

* Hardware: Lenovo ThinkCentre Tiny — Intel Core i3, 8GB DDR4
* Sistema Operativo: Ubuntu Server (Headless)
* Repositorio: https://github.com/DanielSanchez94/home-automation
* Deploy automático: GitHub Actions — cada push a `main` sincroniza el servidor via Cloudflare SSH

### Acceso remoto (Cloudflare Zero Trust)
* Panel HA: https://homesmart.ar
* SSH: https://ssh.lenovoserver.com.ar
* Tecnología: Cloudflare Tunnel — cifrado sin apertura de puertos, bypass de CGNAT
* Seguridad SSH: OTP al correo + políticas de acceso restringidas

## 📁 Estructura

| Ruta | Descripción |
|------|-------------|
| `docker-compose.yml` | Stack: Home Assistant, go2rtc, nut-server |
| `homeassistant/` | Configuración de Home Assistant (YAML, automatizaciones) |
| `go2rtc/` | Configuración de go2rtc (streaming RTSP/WebRTC) |
| `scripts/` | Backup automático y crontab |
| `.env.example` | Plantilla de variables de entorno |

## 🔌 Conectividad y protocolos

### Zigbee
* Coordinador: Sonoff Zigbee 3.0 USB Dongle Plus
* Sensores: Movimiento (Sonoff SNZB-03P) y apertura de puertas/ventanas
* 100% local, independiente del Wi-Fi

### Wi-Fi LAN
* Iluminación: Yeelight en modo LAN (IP fija: 192.168.0.172)
* Cámara: Tapo C200 — streaming local y detección de eventos (IP fija: 192.168.0.173)

## 🛡️ Sistema de seguridad

Lógica de presencia basada en SSIDs de confianza: `limalimon`, `naranjamandarina`.

* Sirena (enchufe Zigbee) y notificaciones se activan si ningún teléfono está en la red
* Disparo instantáneo: apertura de puerta living o ventana garage
* Disparo verificado: detección simultánea en sensor Sonoff + cámara Tapo (evita falsos positivos)
* Grabación automática de clips de 30s con 2s de lookback, solo en modo ausencia

## 💡 Iluminación inteligente

Automatización Yeelight Dormitorio (ciclo circadiano):
* 20:00 a 00:00 — Rojo 100% (protección de melatonina)
* 00:00 a 08:00 — Rojo 50% (navegación nocturna)
* Resto del día — Blanco cálido 2700K al 80%

## 🔐 Secretos

Este repositorio es **público** — ningún secreto está versionado.
Antes de arrancar el stack creá los archivos a partir de sus plantillas:

```bash
cp .env.example .env
cp homeassistant/secrets.yaml.example homeassistant/secrets.yaml
# editá ambos con los valores reales
```

## 🚀 Arranque

```bash
docker compose up -d
```

## ⚙️ Deploy automático

Cada push a `main` dispara un GitHub Actions workflow que:
1. Se conecta al servidor via Cloudflare SSH
2. Ejecuta `git pull`
3. Reinicia los contenedores modificados con `docker compose up -d`

Para configurarlo en un servidor nuevo, agregá estos secrets en GitHub → Settings → Secrets and variables → Actions:

| Secret | Descripción |
|--------|-------------|
| `SSH_HOST` | Dominio SSH del servidor |
| `SSH_USER` | Usuario SSH |
| `SSH_PRIVATE_KEY` | Clave privada SSH |
| `CF_ACCESS_CLIENT_ID` | Service Token ID de Cloudflare |
| `CF_ACCESS_CLIENT_SECRET` | Service Token Secret de Cloudflare |

## 🛠️ Mantenimiento (cron)

* 03:00 AM — Limpieza de grabaciones con más de 60 días
* 04:00 AM — Backup automático del sistema (retención 7 días)

Script: `scripts/auto_backup_ha.sh` — guarda en `/home/daniel/backups/`

## ⌨️ Cheat sheet

```bash
docker logs -f homeassistant                          # logs de HA
docker ps                                             # estado contenedores
cd ~/home-automation && docker compose restart        # reiniciar stack
df -h                                                 # espacio en disco
du -sh ~/homeAssistantProject/recordings              # peso de grabaciones
```

## 🚫 Qué NO está en el repo

Grabaciones, bases de datos, logs, backups, `.storage/` de HA y archivos de secretos. Ver `.gitignore`.

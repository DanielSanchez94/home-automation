# 🏠 DOCUMENTACIÓN TÉCNICA: ECOSISTEMA HOME ASSISTANT
# Propietario: Daniel Sanchez
# Ubicación: Río Cuarto, Córdoba, Argentina
# Última Actualización: 06 de abril de 2026
# ---------------------------------------------------------

## 🖥️ 1. INFRAESTRUCTURA CORE (EL CEREBRO)
El sistema opera sobre un nodo dedicado (Lenovo Tiny) para garantizar disponibilidad y control local.

* Hardware: Lenovo ThinkCentre Tiny (identificado como lenovo-server).
    - Procesador: Intel Core i3.
    - Memoria RAM: 8GB DDR4.
* Sistema Operativo: Ubuntu Server (Headless).
* Gestión de Servicios: Docker & Docker Compose (Home Assistant, Mosquitto, Cloudflared).
* Acceso Remoto Seguro (Cloudflare Zero Trust):
    - Dominio Principal: homesmart.ar (Acceso al panel de control).
    - Dominio Admin: lenovoserver.com.ar (Acceso SSH).
    - Tecnología: Cloudflare Tunnel. Permite el cifrado sin apertura de puertos (Bypass de CGNAT).
    - Seguridad SSH: Browser-Rendered SSH habilitado con autenticación OTP (One-Time Password) al correo y políticas de acceso restringidas.

## 🔌 2. CONECTIVIDAD Y PROTOCOLOS
Arquitectura híbrida que prioriza la independencia de la nube y la baja latencia.

### Zigbee (Red de Sensores)
* Coordinador: Sonoff Zigbee 3.0 USB Dongle Plus.
* Sensores: Movimiento (Sonoff SNZB-03P) y sensores de apertura en puertas/ventanas.
* Ventaja: Funcionamiento 100% local e independiente del estado del Wi-Fi.

### Wi-Fi Local (LAN Control)
* Iluminación: Yeelight (Modo LAN habilitado para comunicación directa con el servidor).
* Cámaras: Tapo C200 (Integración local para streaming y eventos).

## 🛡️ 3. SISTEMA DE SEGURIDAD Y VIGILANCIA
Sistema de detección con lógica de presencia basada en SSIDs de confianza: ['limalimon', 'naranjamandarina'].

### Lógica de Alarma (Sirena y Notificaciones)
La sirena (enchufe inteligente) y las alertas de alta prioridad se disparan si:
1. Ausencia: Ni el Samsung A54 (Daniel) ni el iPhone (Agostina) están en el Wi-Fi.
2. Evento: 
   - Instantáneo: Apertura de 'binary_sensor.sensor_puerta_living' o 'ventana_garage'.
   - Verificado: Detección simultánea en Sensor Sonoff Y Cámara Tapo (Evita falsos positivos).

### Grabación de Eventos (Vigilancia)
* Acción: Grabación automática de clips de 30s en /media/recordings/.
* Disparadores: Movimiento o Sonido detectado por la Tapo C200 (solo en modo ausencia).
* Configuración: 2 segundos de lookback (pre-grabación).

## 💡 4. ILUMINACIÓN INTELIGENTE (CICLO CIRCADIANO)
Automatización Yeelight Dormitorio:
* 20:00 a 00:00: Color Rojo al 100% (Protección de melatonina).
* 00:00 a 08:00: Color Rojo al 50% (Navegación nocturna).
* Resto del día: Blanco Cálido (2700K) al 80%.

## 🛠️ 5. MANTENIMIENTO Y TAREAS PROGRAMADAS (CRON)
Tareas automatizadas para estabilidad del sistema y backups.

### Crontab Usuario (daniel) - 03:00 AM:
* Limpieza de grabaciones: Borra archivos .mp4 con más de 60 días de antigüedad.
  Comando: find /home/daniel/homeAssistantProject/recordings/ -type f -name "*.mp4" -mtime +60 -delete

### Crontab Root (sudo) - 04:00 AM:
* Backup del Sistema: Ejecuta script de respaldo automático.
  Comando: /home/daniel/auto_backup_ha.sh >> /home/daniel/backup_log.txt 2>&1

## ⌨️ CHEAT SHEET (COMANDOS RÁPIDOS)
- Acceso SSH Web: https://ssh.lenovoserver.com.ar
- Ver peso de videos: du -sh ~/homeAssistantProject/recordings
- Ver logs de HA: docker logs -f homeassistant
- Reiniciar Túnel: docker-compose restart cloudflared
- Espacio en disco: df -h

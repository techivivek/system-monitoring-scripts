#!/bin/bash
# ---------------------------------------
# Author: Vivek Sikarwar
# Title: System Info + Email Alert Script 💌
# Description: Collects system info, saves logs, and sends email alerts if CPU or Memory exceeds limits.
# ---------------------------------------

# ----------------------------
# Configuration
# ----------------------------
LOG_DIR="/var/log/vivek-system-report"
LOG_FILE="$LOG_DIR/system_info_$(date +'%Y-%m-%d_%H-%M-%S').log"
EMAIL="your_email@example.com"   # <-- Replace with your email
CPU_LIMIT=80
MEM_LIMIT=80

mkdir -p "$LOG_DIR"

# ----------------------------
# Function to log & display
# ----------------------------
log() {
  echo -e "$1" | tee -a "$LOG_FILE"
}

# ----------------------------
# Start logging
# ----------------------------
log "=============================="
log "👋 Hello Vivek!"
log "🕒 Script started at: $(date)"
log "=============================="

log "📁 Current Directory: $(pwd)"
log "=============================="

log "⏱️ System Uptime: $(uptime -p)"
log "=============================="

log "💽 Disk Usage:"
df -h --total | grep total | tee -a "$LOG_FILE"
log "=============================="

# Memory Usage
MEM_USAGE=$(free | awk '/Mem/{printf("%.0f"), $3/$2*100}')
log "🧠 Memory Usage: $MEM_USAGE% used"
log "=============================="

# CPU Usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
CPU_USAGE=${CPU_USAGE%.*}
log "🔥 CPU Usage: ${CPU_USAGE}% used"
log "=============================="

# IP Address
log "🌐 IP Address: $(hostname -I | awk '{print $1}')"
log "=============================="

# ----------------------------
# Check resource limits
# ----------------------------
ALERT_MSG=""

if [ "$CPU_USAGE" -gt "$CPU_LIMIT" ]; then
  ALERT_MSG+="⚠️ CPU usage is above ${CPU_LIMIT}% (Current: ${CPU_USAGE}%)\n"
fi

if [ "$MEM_USAGE" -gt "$MEM_LIMIT" ]; then
  ALERT_MSG+="⚠️ Memory usage is above ${MEM_LIMIT}% (Current: ${MEM_USAGE}%)\n"
fi

# ----------------------------
# Send email alert if needed
# ----------------------------
if [ ! -z "$ALERT_MSG" ]; then
  echo -e "$ALERT_MSG\n\nLog File: $LOG_FILE" | mail -s "🚨 System Alert on $(hostname)" "$EMAIL"
  log "📨 ALERT SENT to $EMAIL"
else
  log "✅ System resources normal. No alert sent."
fi

log "📁 Log saved at: $LOG_FILE"
log "=============================="

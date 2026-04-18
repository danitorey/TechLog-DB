#!/bin/bash
# ============================================================
#  TechLog DB — Autostart
#  Detecta la ruta del proyecto automaticamente
#  Funciona en cualquier maquina sin cambios
# ============================================================

# Obtiene la ruta real del proyecto (donde esta este script)
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "[TechLog] Proyecto en: $PROJECT_DIR"

# Inicia Docker si no esta corriendo
if ! service docker status 2>&1 | grep -q "running"; then
  echo "[TechLog] Iniciando Docker..."
  sudo service docker start
  sleep 3
fi

# Levanta los contenedores
echo "[TechLog] Levantando contenedores..."
cd "$PROJECT_DIR" && docker compose up -d

echo "[TechLog] Listo. Servicios disponibles:"
echo "  -> n8n:        http://localhost:$(grep N8N_PORT "$PROJECT_DIR/.env" | cut -d= -f2)"
echo "  -> PostgreSQL: localhost:$(grep POSTGRES_PORT "$PROJECT_DIR/.env" | cut -d= -f2)"

#!/bin/bash
# ============================================================
#  TechLog DB — Instala arranque automatico en WSL/Linux
#  Ejecutar UNA sola vez despues de clonar el repo:
#  bash scripts/install-autostart.sh
# ============================================================

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/autostart.sh"
BASHRC="$HOME/.bashrc"
MARKER="# techlog-db autostart"

# Verificar que no este ya instalado
if grep -q "$MARKER" "$BASHRC"; then
  echo "⚠️  El autostart ya esta instalado en $BASHRC"
  echo "   Para reinstalar, elimina las lineas con '$MARKER' en ~/.bashrc"
  exit 0
fi

# Dar permisos de ejecucion
chmod +x "$SCRIPT_PATH"

# Escribir en .bashrc con la ruta real de ESTA maquina
cat >> "$BASHRC" << EOF

$MARKER
if ! docker ps 2>/dev/null | grep -q "techlog_postgres"; then
  bash "$SCRIPT_PATH"
fi
EOF

echo "✅ Autostart instalado para el usuario: $USER"
echo "   Ruta del proyecto: $(dirname "$SCRIPT_PATH")"
echo ""
echo "   Cada vez que abras WSL los contenedores se levantaran solos."
echo "   Para desinstalar: elimina las lineas '$MARKER' en ~/.bashrc"

#!/bin/bash
# ============================================================
#  TechLog DB — Instala arranque automatico en WSL/Linux
#  Ejecutar UNA sola vez despues de clonar el repo:
#  bash scripts/install-autostart.sh
# ============================================================

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/autostart.sh"
BASHRC="$HOME/.bashrc"
MARKER="# techlog-db autostart"

if grep -q "$MARKER" "$BASHRC"; then
  echo "⚠️  El autostart ya esta instalado en $BASHRC"
  exit 0
fi

chmod +x "$SCRIPT_PATH"

cat >> "$BASHRC" << EOF

$MARKER
_cleanup_port() {
  local PIDS
  PIDS=\$(sudo lsof -ti :"\$1" 2>/dev/null)
  if [ -n "\$PIDS" ]; then
    echo "[Autostart] Liberando puerto \$1..."
    sudo kill -9 \$PIDS 2>/dev/null
    sleep 1
  fi
}

if ! docker ps 2>/dev/null | grep -q "techlog_postgres"; then
  echo "[Autostart] Levantando techlog-db..."
  _cleanup_port 5433
  _cleanup_port 5678
  bash "$SCRIPT_PATH"
fi
EOF

# Agregar regla sudo sin password para lsof y kill
SUDOERS_LINE="$USER ALL=(ALL) NOPASSWD: /usr/bin/lsof, /bin/kill"
if ! sudo grep -q "$SUDOERS_LINE" /etc/sudoers 2>/dev/null; then
  echo "$SUDOERS_LINE" | sudo tee -a /etc/sudoers > /dev/null
  echo "✅ Regla sudo configurada — no pedira password al arrancar"
fi

echo "✅ Autostart instalado para: $USER"
echo "   Abre una nueva terminal para activarlo"

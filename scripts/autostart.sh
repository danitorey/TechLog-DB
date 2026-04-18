#!/bin/bash
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
echo "[TechLog] Iniciando servicios..."
cd "$PROJECT_DIR" && docker compose up -d
echo "[TechLog] Listo"

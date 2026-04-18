## Compartir el proyecto con un compañero

Este proyecto es 100% genérico. Para que tu compañero lo use:

### El compañero ejecuta:

```bash
# 1. Clonar el repo
git clone https://github.com/tu-usuario/techlog-db.git
cd techlog-db

# 2. Crear su propio .env con sus credenciales
cp .env.example .env
nano .env

# 3. Levantar todo
docker compose up -d

# 4. Instalar autostart (opcional, una sola vez)
bash scripts/install-autostart.sh
```

Cada quien tiene:
- Su propia base de datos local independiente
- Sus propios workflows en n8n
- Sus propias credenciales en `.env`
- El `.env` nunca se sube al repo (está en `.gitignore`)

# TechLog DB

PostgreSQL 17 local en Docker para registrar instalaciones técnicas.
Se integrará con n8n para generar manuales PDF y entregables en OneDrive.

## Levantar el proyecto

```bash
cp .env.example .env   # edita tus credenciales
docker compose up -d
docker compose ps      # verificar estado
```

## Conectarse desde DBeaver en Windows

| Campo    | Valor               |
|----------|---------------------|
| Host     | localhost           |
| Port     | 5432                |
| Database | techlog             |
| Username | techlog_user        |
| Password | techlog_pass_2024   |

**Pasos:**
1. DBeaver → New Database Connection → PostgreSQL
2. Llenar los campos de arriba
3. Test Connection → Finish

## Detener

```bash
docker compose down          # conserva datos
docker compose down -v       # borra todo
```

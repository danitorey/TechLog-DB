-- TechLog DB — Datos iniciales

INSERT INTO areas (nombre, descripcion, ruta_onedrive) VALUES
('Infraestructura', 'Servidores, Docker, VMs, Kubernetes',          '/Documentos/Manuales/Infraestructura'),
('Bases de Datos',  'PostgreSQL, SQL Server, migraciones, backups', '/Documentos/Manuales/BasesDatos'),
('Redes',           'VPN, DNS, firewalls, switches',                '/Documentos/Manuales/Redes'),
('Automatizacion',  'n8n, NiFi, scripts Bash, pipelines ETL',      '/Documentos/Manuales/Automatizacion'),
('Seguridad',       'Certificados SSL, hardening, auditorias',      '/Documentos/Manuales/Seguridad')
ON CONFLICT (nombre) DO NOTHING;

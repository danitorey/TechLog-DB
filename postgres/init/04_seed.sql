-- ============================================================
--  TechLog DB — Datos iniciales
--  Areas basadas en carpetas reales de entregables UnADM
-- ============================================================

INSERT INTO areas (nombre, descripcion, ruta_base) VALUES
('1. Diagrama de arquitectura de los sitios',
 'Diagramas y documentacion de arquitectura de sitios web y sistemas',
 '1. Diagrama de arquitectura de los sitios'),

('2. Reporte de cambios realizados a la plataforma tecnologica de la UnADM',
 'Reportes de cambios, actualizaciones y modificaciones a la plataforma',
 '2. Reporte de cambios realizados a la plataforma tecnologica de la UnADM'),

('3. Plan de trabajo y mejoras',
 'Planes de trabajo, propuestas de mejora y roadmaps tecnicos',
 '3. Plan de trabajo y mejoras'),

('4. Carpeta con evidencia de la inspeccion',
 'Evidencias, capturas y documentacion de inspecciones realizadas',
 '4. Carpeta con evidencia de la inspeccion'),

('5. Reporte de tickets atendidos de soporte tecnico en el periodo',
 'Reportes de tickets de soporte tecnico atendidos en el periodo',
 '5. Reporte de tickets atendidos de soporte tecnico en el periodo'),

('6. Carpeta digital',
 'Documentos digitales varios y archivos de soporte',
 '6. Carpeta digital'),

('7. Actividades adicionales',
 'Actividades extra, tareas adicionales y colaboraciones',
 '7. Actividades adicionales')

ON CONFLICT (nombre) DO NOTHING;

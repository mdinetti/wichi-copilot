-- --------------------------------------------------------------------------------------------------------------------------------
-- Script para migrar los datos de Unidad Academica Generica de la base siu_wichi 4.1.0 a la base siu_wichi 5.0.0
-- --------------------------------------------------------------------------------------------------------------------------------
-- Se ejecutan cada uno de los querys en la base origen (wichi 4.1.0).
-- Se corta el texto de resultado de cada uno y se ejecuta en la base destino (wichi 5.0.0)
-- Hay que revisar los resultados obtenidos
-- --------------------------------------------------------------------------------------------------------------------------------

-- Actualizacion de los datos de la Institucion (Universidad)
SELECT 
	'UPDATE public.d_institucion set institucion_codigo_saf=''' || institucion_codigo_saf ||
	''', institucion_codigo_ona=''' || institucion_codigo_ona || 
	''', institucion_sigla=''' || institucion_sigla || 
	''', institucion_desc=''' || institucion_desc || 
	''' WHERE institucion_id=1;'
FROM public.int_dw_d_instituciones WHERE institucion_id=1;

-- Carga de datos de otras Instituciones (si los hubiera) 
-- Si los datos de la Institucion estan en el registro con clave 2 deberian pasarse al 1. En este caso hay que adecuar los siguientes insert obtenidos.
-- Esto significa que si tiene la institucion en el registro con clave 2 deberia pasarlo a clave 1 y ademas deberia adecuar los insert que estan luego de este.
-- Por lo tanto preferentemente no ejecute el query siguiente
--SELECT 
--	'INSERT INTO public.d_institucion (institucion_id, institucion_codigo_ona, institucion_codigo_saf,
--					institucion_sigla, institucion_desc )
--	VALUES (' || institucion_id || 
--		', ''' || institucion_codigo_ona ||
--		''', ''' || institucion_codigo_saf ||
--		''', ''' || institucion_sigla ||
--		''', ''' || institucion_desc ||
--	''');'
--FROM public.int_dw_d_instituciones WHERE institucion_id<>1;

-- Carga las Unidades Academicas Genericas 
SELECT 
	'INSERT INTO public.d_unidad_generica (unidad_generica_id, institucion_id, unidad_generica_desc, rol_desc)
	VALUES (' || unidadgenerica_id || 
		', ' || institucion_id ||
		', ''' || unidadgenerica_desc ||
		''', ''' || rol_desc ||
	''');'
FROM public.int_dw_d_unidadgenerica WHERE unidadgenerica_id>0;

-- Asigna las UA Genericas correspondientes a las Unidades cargadas.
SELECT
	'UPDATE public.d_unidad
	SET unidad_generica_id=' || unidadgenerica_id ||
	' WHERE fuente_dato_id=' || fuentedatos_id || ' AND unidad_desc=''' || unidad_desc || ''';'
FROM public.int_dw_d_unidad;

-- --------------------------------------------------------------------------------------------------------------------------------
-- Luego de ejecutar los Querys generados en la nueva base hay que ejecutar los siguientes (tambien en la base 5.0.0)
-- --------------------------------------------------------------------------------------------------------------------------------
SELECT setval('d_unidad_generica_unidad_generica_id_seq', (SELECT COALESCE(max(unidad_generica_id)+1,1) FROM public.d_unidad_generica));



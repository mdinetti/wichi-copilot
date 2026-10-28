-- Este script es parte de la migracion de SIU-Wichi 6.7.0 a 6.8.0

-----------------------------
---Mapuche
-----------------------------

--BORRO LOS ESQUEMAS VIEJOS
DROP SCHEMA mapuche_tmp CASCADE;
DROP SCHEMA mapuche_dsa CASCADE;
DROP SCHEMA mapuche CASCADE;
  
--RENOMBRO LOS NUEVOS ESQUEMAS
ALTER SCHEMA mapuche_nuevo
  RENAME TO mapuche;
ALTER SCHEMA mapuche_nuevo_dsa
  RENAME TO mapuche_dsa;
ALTER SCHEMA mapuche_nuevo_tmp
  RENAME TO mapuche_tmp;
  
--FUNCION UTILIZADA PARA OBTENER LAS DESCRIPCIONES DE LAS LICENCIAS
CREATE OR REPLACE FUNCTION mapuche_dsa.obtener_licencia_desc(character varying)
  RETURNS character varying AS
$BODY$
	DECLARE
		licencias ALIAS FOR $1;
		licencia_descripcion character varying ='';
		_lic record;
BEGIN

		FOR _lic IN SELECT regexp_split_to_table(licencias, '-') LOOP
				licencia_descripcion = licencia_descripcion || (Select licencia_desc from mapuche_tmp.d_licencia where licencia_codigo = _lic.regexp_split_to_table) || '- ';
				 
			END LOOP;
			
		RETURN licencia_descripcion;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION mapuche_dsa.obtener_licencia_desc(character varying)
  OWNER TO postgres;

-- VISTAS PARA ACCESO A LOS CUBOS 
CREATE OR REPLACE VIEW mapuche.ft_personal_cerrada  
    AS SELECT * FROM mapuche.ft_personal WHERE liquidacion_id IN (SELECT liquidacion_id FROM mapuche.d_liquidacion WHERE es_cerrada IN('Cerrada','VACIO/NULO'));

CREATE OR REPLACE VIEW mapuche.ft_personal_abierta  
    AS SELECT * FROM mapuche.ft_personal WHERE liquidacion_id IN (SELECT liquidacion_id FROM mapuche.d_liquidacion WHERE es_cerrada = 'Abierta');


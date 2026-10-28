-- Este script es parte de la migración de SIU-Wichi 6.7.0 a 6.8.0

-----------------------------
-- Guarani 3
-----------------------------
ALTER TABLE guarani3_tmp.d_localidad
  ADD COLUMN dpto_partido_id integer;
ALTER TABLE guarani3_tmp.d_localidad
  ADD COLUMN dpto_partido_desc character varying;

ALTER TABLE guarani3_dsa.d_localidad
  ADD COLUMN dpto_partido_codigo integer;
ALTER TABLE guarani3_dsa.d_localidad
  ADD COLUMN dpto_partido_desc character varying;

ALTER TABLE guarani3.d_localidad
  ADD COLUMN dpto_partido_codigo integer;
ALTER TABLE guarani3.d_localidad
  ADD COLUMN dpto_partido_desc character varying;

ALTER TABLE guarani3_dsa.d_procedencia
  ADD COLUMN dpto_partido_id integer;
ALTER TABLE guarani3_dsa.d_procedencia
  ADD COLUMN dpto_partido_desc character varying;

ALTER TABLE guarani3.d_procedencia
  ADD COLUMN dpto_partido_id integer;
ALTER TABLE guarani3.d_procedencia
  ADD COLUMN dpto_partido_desc character varying;


-----------------------------
-- Pilaga
-----------------------------
--TMP
ALTER TABLE pilaga_tmp.ft_movimientos_ingresos
  ADD COLUMN codigo_ud character varying;
ALTER TABLE pilaga_tmp.ft_movimientos_ingresos
  ADD COLUMN tipo_resolucion character varying;
ALTER TABLE pilaga_tmp.ft_movimientos_ingresos
  ADD COLUMN nro_resolucion character varying;
ALTER TABLE pilaga_tmp.ft_movimientos_ingresos
  ADD COLUMN anio_resolucion integer;

ALTER TABLE pilaga_tmp.ft_movimientos_gastos
  ADD COLUMN codigo_ud character varying;
ALTER TABLE pilaga_tmp.ft_movimientos_gastos
  ADD COLUMN tipo_resolucion character varying;
ALTER TABLE pilaga_tmp.ft_movimientos_gastos
  ADD COLUMN nro_resolucion character varying;
ALTER TABLE pilaga_tmp.ft_movimientos_gastos
  ADD COLUMN anio_resolucion integer;

CREATE TABLE pilaga_tmp.d_codigo_ud
(
  codigo text,
  nivel1_desc text,
  nivel2_desc text,
  nivel3_desc text,
  nivel4_desc text
);

CREATE TABLE pilaga_tmp.d_tipo_resolucion
(
  tipo_resolucion_codigo text,
  tipo_resolucion_desc text
);

--DSA
ALTER TABLE pilaga_dsa.ft_movimientos_ingresos
  ADD COLUMN codigo_ud_id integer;
ALTER TABLE pilaga_dsa.ft_movimientos_ingresos
  ADD COLUMN tipo_resolucion_id integer;
ALTER TABLE pilaga_dsa.ft_movimientos_ingresos
  ADD COLUMN nro_resolucion character varying;
ALTER TABLE pilaga_dsa.ft_movimientos_ingresos
  ADD COLUMN anio_resolucion integer;

ALTER TABLE pilaga_dsa.ft_movimientos_gastos
  ADD COLUMN codigo_ud_id integer;
ALTER TABLE pilaga_dsa.ft_movimientos_gastos
  ADD COLUMN tipo_resolucion_id integer;
ALTER TABLE pilaga_dsa.ft_movimientos_gastos
  ADD COLUMN nro_resolucion character varying;
ALTER TABLE pilaga_dsa.ft_movimientos_gastos
  ADD COLUMN anio_resolucion integer;

CREATE TABLE pilaga_dsa.d_codigo_ud
(
  codigo_ud_id integer NOT NULL,
  codigo character varying,
  nivel1_desc character varying,
  nivel2_desc character varying,
  nivel3_desc character varying,
  nivel4_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
 CONSTRAINT pk_d_codigo_ud PRIMARY KEY (codigo_ud_id)
);

CREATE TABLE pilaga_dsa.d_tipo_resolucion
 (
  tipo_resolucion_id integer NOT NULL, 
  tipo_resolucion_codigo character varying,
  tipo_resolucion_desc character varying,
  fecha_desde date, 
  fecha_hasta date, 
  version integer, 
  vigente character varying,
  fecha_actualizacion TIMESTAMP WITHOUT TIME ZONE,
CONSTRAINT pk_d_tipo_resolucion PRIMARY KEY (tipo_resolucion_id)
);

--DW
ALTER TABLE pilaga.ft_movimientos
  ADD COLUMN codigo_ud_id integer;
ALTER TABLE pilaga.ft_movimientos
  ADD COLUMN tipo_resolucion_id integer;
ALTER TABLE pilaga.ft_movimientos
  ADD COLUMN nro_resolucion character varying;
ALTER TABLE pilaga.ft_movimientos
  ADD COLUMN anio_resolucion integer;

CREATE TABLE pilaga.d_codigo_ud
(
  codigo_ud_id integer NOT NULL,
  codigo character varying,
  nivel1_desc character varying,
  nivel2_desc character varying,
  nivel3_desc character varying,
  nivel4_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
 CONSTRAINT pk_d_codigo_ud PRIMARY KEY (codigo_ud_id)
);

CREATE TABLE pilaga.d_tipo_resolucion
 (
  tipo_resolucion_id integer NOT NULL, 
  tipo_resolucion_codigo character varying,
  tipo_resolucion_desc character varying,
  fecha_desde date, 
  fecha_hasta date, 
  version integer, 
  vigente character varying,
  fecha_actualizacion TIMESTAMP WITHOUT TIME ZONE,
CONSTRAINT pk_d_tipo_resolucion PRIMARY KEY (tipo_resolucion_id)
);

-----------------------------
-- Diaguita
-----------------------------
-- tmp
CREATE TABLE diaguita_tmp.d_catalogo_bienes_servicios
(
  id_catalogo_bien_patrimonial text,
  id_catalogo_bien_uso_padre text,
  codigo_completo text,
  nombre text
);
-- dsa
CREATE TABLE diaguita_dsa.d_catalogo_bien_servicio
(
  catalogo_bien_id serial NOT NULL,
  catalogo_bien_nivel1_codigo integer,
  catalogo_bien_nivel1_desc text,
  catalogo_bien_nivel2_codigo integer,
  catalogo_bien_nivel2_desc text,
  catalogo_bien_nivel3_codigo integer,
  catalogo_bien_nivel3_desc text,
  catalogo_bien_nivel4_codigo integer,
  catalogo_bien_nivel4_desc text,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone
);
--dw
CREATE TABLE diaguita.d_catalogo_bien_servicio
(
  catalogo_bien_id serial NOT NULL,
  catalogo_bien_nivel1_codigo integer,
  catalogo_bien_nivel1_desc text,
  catalogo_bien_nivel2_codigo integer,
  catalogo_bien_nivel2_desc text,
  catalogo_bien_nivel3_codigo integer,
  catalogo_bien_nivel3_desc text,
  catalogo_bien_nivel4_codigo integer,
  catalogo_bien_nivel4_desc text,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT pk_d_catalogo_bien_servicio PRIMARY KEY (catalogo_bien_id)
);

-- amortizacion_acumulada
--tmp
ALTER TABLE diaguita_tmp.ft_patrimonio
  ADD COLUMN amortizacion_acumulada text;
--dsa
ALTER TABLE diaguita_dsa.ft_patrimonio
  ADD COLUMN amortizacion_acumulada numeric(15,2);
--dw
ALTER TABLE diaguita.ft_patrimonio
  ADD COLUMN amortizacion_acumulada numeric(15,2);

----------------------------- 
--     mapuche_nuevo
----------------------------- 
--Crea al esquema mapuche_nuevo_tmp
CREATE SCHEMA mapuche_nuevo_tmp;

--Tablas temporales mapuche_nuevo
CREATE TABLE mapuche_nuevo_tmp.ft_liqconceptosxcargos (
	periodo_info integer,
	liquidacion_nro VARCHAR,
	concepto_id VARCHAR,
	cargo_id VARCHAR,
	legajo_id VARCHAR,
	unidad_presupuestaria_id VARCHAR,
	tipo_ejercicio_id VARCHAR,
	grupo_presupuestario_id VARCHAR,
	imp_presup_fuente_id VARCHAR,
	obj_gasto_id VARCHAR,
	red_programatica_id VARCHAR,
	finalidad_id VARCHAR,
	funcion_id VARCHAR,
	importe_liq numeric(11,2),
	nro_cargo_base VARCHAR,
	porc_imppresup VARCHAR,
	antiguedad_liq smallint,
	dias_trabajados smallint,
	anio_retro VARCHAR,
	mes_retro VARCHAR,
	nro_recibo integer,
	nro_orimp SMALLINT,
    cant_cargosxconcepto smallint
);
CREATE TABLE mapuche_nuevo_tmp.ft_cargos (
    periodo_info integer,
    cargo_id VARCHAR,
    legajo_id VARCHAR,
    dependencia_desig_id VARCHAR,
    nudo VARCHAR,
    dependencia_desemp_id VARCHAR,
    categoria_id VARCHAR,
    agrupamiento_id VARCHAR,
    subrogancia_id VARCHAR,
    categoria_subrogada_id VARCHAR,
    caracter_id VARCHAR,
    asociado_id VARCHAR,
    estado_del_cargo_id VARCHAR,
    cant_hs_dedicacion numeric(11,2),
    antiguedad_en_escalafon smallint,
    porcentaje_trabajado_en_el_mes VARCHAR,
    porcentaje_reduccion_horaria VARCHAR,
    cant_cargos_activos smallint,
    cant_cargos_liq smallint,
    importe_neto numeric(11,2),
    importe_bruto numeric(11,2),
    importe_gasto_total numeric(11,2),
    regional VARCHAR,
    fecha_alta date,
    fecha_baja date,
    nro_cargo_base VARCHAR,
    tipo_escalafon VARCHAR,
    licencia_codigo VARCHAR
);
CREATE TABLE mapuche_nuevo_tmp.ft_legajos (
    periodo_info integer,
    legajo_id VARCHAR,
    activo_id VARCHAR,
    sexo_id VARCHAR,
    edad integer,
    estado_civil_id VARCHAR,
    nivel_estudio_id VARCHAR,
    categoria_incentivo_codigo VARCHAR,
    dedicacion_incentivo_codigo VARCHAR,
    discapacidad_id VARCHAR,
    total_carga_horaria_hs smallint,
    cant_legajos_con_cargo_activo smallint,
    cant_legajos_liq smallint,
    apellido VARCHAR,
    nombre VARCHAR,
    cuil VARCHAR,
    titulo VARCHAR,
    nivel_estudio_liq VARCHAR,
    correo_electronico VARCHAR,
    regional_cabecera_id VARCHAR,
    dependencia_cabecera_id VARCHAR,
    fecha_nacimiento date
);

CREATE TABLE mapuche_nuevo_tmp.d_antiguedad
(
  legajo character varying,
  antiguedaduno character varying,
  antiguedadud character varying,
  antiguedadusu character varying
);

CREATE TABLE mapuche_nuevo_tmp.d_estadolaboral
(
  estado_laboral_codigo character varying,
  estado_laboral_desc character varying
);

CREATE TABLE mapuche_nuevo_tmp.d_objgasto
(
  obj_gasto_codigo VARCHAR
, obj_gasto_desc VARCHAR
);

CREATE TABLE mapuche_nuevo_tmp.d_agrupamiento (
    agrupamiento_codigo VARCHAR,
    agrupamiento_desc VARCHAR
);

CREATE TABLE mapuche_nuevo_tmp.d_caracter (
    caracter_codigo VARCHAR,
    caracter_desc VARCHAR,
    tipo_planta_codigo VARCHAR
);
CREATE TABLE mapuche_nuevo_tmp.d_categoriascargo (
    categoria_codigo VARCHAR,
    categoria_desc VARCHAR,
    escalafon_codigo VARCHAR,
    estado_laboral_codigo VARCHAR,
    dedicacion_codigo VARCHAR
);

CREATE TABLE mapuche_nuevo_tmp.d_concepto (
    concepto_codigo VARCHAR,
    concepto_desc VARCHAR,
    concepto_tipo_codigo VARCHAR
);
CREATE TABLE mapuche_nuevo_tmp.d_dedicacion (
    dedicacion_codigo VARCHAR,
    dedicacion_desc VARCHAR
);
CREATE TABLE mapuche_nuevo_tmp.d_dependenciadesemp (
    dependencia_desemp_codigo VARCHAR,
    dependencia_desemp_desc VARCHAR
);
CREATE TABLE mapuche_nuevo_tmp.d_dependenciadesig (
    dependencia_desig_codigo VARCHAR,
    dependencia_desig_desc VARCHAR
);

CREATE TABLE mapuche_nuevo_tmp.d_escalafon (
    escalafon_codigo VARCHAR,
    escalafon_desc VARCHAR
);
CREATE TABLE mapuche_nuevo_tmp.d_estadocivil (
    estado_civil_codigo VARCHAR,
    estado_civil_desc VARCHAR
);
CREATE TABLE mapuche_nuevo_tmp.d_unidad_presupuestaria (
    unidad_presupuestaria_codigo VARCHAR,
    unidad_presupuestaria_desc VARCHAR,
    subunidad_presupuestaria_desc VARCHAR,
    subsubunidad_presupuestaria_desc VARCHAR
);
CREATE TABLE mapuche_nuevo_tmp.d_liquidacion (
    liquidacion_codigo VARCHAR,
    liquidacion_desc VARCHAR,
	es_cerrada VARCHAR
);
CREATE TABLE mapuche_nuevo_tmp.d_nivelestudio (
    nivel_estudio_codigo VARCHAR,
    nivel_estudio_desc VARCHAR
);
CREATE TABLE mapuche_nuevo_tmp.d_redprogramatica (
	codn_progr integer,
	codn_subpr integer,
	codn_proye integer,
	codn_activ integer,
	codn_obra integer,
	desc_imput VARCHAR
);
CREATE TABLE mapuche_nuevo_tmp.d_regional
(
  regional_codigo character varying,
  regional_desc character varying
);
CREATE TABLE mapuche_nuevo_tmp.d_titulo (
    titulo_codigo VARCHAR,
    titulo_desc VARCHAR
);

CREATE TABLE mapuche_nuevo_tmp.d_grupo_presupuestario (
    grupo_presupuestario_codigo VARCHAR,
    grupo_presupuestario_desc VARCHAR
);

CREATE TABLE mapuche_nuevo_tmp.d_finalidad_funcion (
    finalidad_codigo VARCHAR,
    finalidad_desc VARCHAR,
    funcion_codigo VARCHAR,
    funcion_desc VARCHAR
);

CREATE TABLE mapuche_nuevo_tmp.d_licencia (
    licencia_codigo VARCHAR,
    licencia_desc VARCHAR
);


--Crea esquema mapuche_nuevo
CREATE SCHEMA mapuche_nuevo_dsa;

--Tablas cubos mapuche_nuevo
CREATE TABLE mapuche_nuevo_dsa.d_periodo_retroactivo
(
  periodo_retroactivo_id SMALLINT NOT NULL,
  periodo_retroactivo_codigo character varying,
  anio_codigo character varying,
  anio_desc character varying,
  mes_codigo character varying,
  mes_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  es_retroactivo character varying DEFAULT 'Retroactivo'::character varying,
  CONSTRAINT d_periodo_retroactivo_pk PRIMARY KEY (periodo_retroactivo_id)
);

CREATE TABLE mapuche_nuevo_dsa.d_grupo_presupuestario (
	grupo_presupuestario_id SMALLINT NOT NULL,
    grupo_presupuestario_codigo character varying,
    grupo_presupuestario_desc character varying,
	fecha_desde date,
	fecha_hasta date,
	version integer,
	vigente character varying,
	fecha_actualizacion timestamp without time zone,
	CONSTRAINT d_grupo_presupuestario_pk PRIMARY KEY (grupo_presupuestario_id)
);

CREATE TABLE mapuche_nuevo_dsa.d_finalidad_funcion (
	finalidad_funcion_id SMALLINT NOT NULL,
    	finalidad_codigo character varying,
    	finalidad_desc character varying,
	funcion_codigo character varying,
    	funcion_desc character varying,
	fecha_desde date,
	fecha_hasta date,
	version integer,
	vigente character varying,
	fecha_actualizacion timestamp without time zone,
	CONSTRAINT d_finalidad_funcion_pk PRIMARY KEY (finalidad_funcion_id)
);

CREATE TABLE mapuche_nuevo_dsa.d_tipo_ejercicio
(
  tipo_ejercicio_id SMALLINT NOT NULL,
  tipo_ejercicio_codigo character varying,
  tipo_ejercicio_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT d_tipo_ejercicio_pk PRIMARY KEY (tipo_ejercicio_id)
);

CREATE TABLE mapuche_nuevo_dsa.d_condicion
(
  condicion_id SMALLINT NOT NULL,
  condicion_codigo character varying,
  condicion_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT d_condicion_pk PRIMARY KEY (condicion_id)
);

CREATE TABLE mapuche_nuevo_dsa.d_categoria_incentivo
(
                categoria_incentivo_id SMALLINT NOT NULL,
                categoria_incentivo_codigo character varying,
                categoria_incentivo_desc character varying,
                orden integer,   
                fecha_desde date,
                fecha_hasta date,
                version integer,
                vigente character varying,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_categoria_incentivo_pk PRIMARY KEY (categoria_incentivo_id )
);

CREATE TABLE mapuche_nuevo_dsa.d_dedicacion_incentivo
(
                dedicacion_incentivo_id SMALLINT NOT NULL,
                dedicacion_incentivo_codigo character varying,
                dedicacion_incentivo_desc character varying,
                fecha_desde date,
                fecha_hasta date,
                version integer,
                vigente character varying,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_dedicacion_incentivo_pk PRIMARY KEY (dedicacion_incentivo_id )
);

CREATE TABLE mapuche_nuevo_dsa.d_porctrabajado
(
  porcentaje_id SMALLINT NOT NULL,
  porcentaje_codigo VARCHAR,
  fecha_desde DATE,
  fecha_hasta DATE,
  version INT,
  vigente VARCHAR,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT d_porctrabajado_pk PRIMARY KEY (porcentaje_id)
);
CREATE TABLE mapuche_nuevo_dsa.d_porcreduchoraria
(
  porcentaje_id SMALLINT NOT NULL,
  porcentaje_codigo VARCHAR,
  fecha_desde DATE,
  fecha_hasta DATE,
  version INT,
  vigente VARCHAR,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT d_porcreduchoraria_pk PRIMARY KEY (porcentaje_id)
);
CREATE TABLE mapuche_nuevo_dsa.d_antiguedad
(
  antiguedad_id SMALLINT NOT NULL,
  rangoantiguedad_desc VARCHAR,
  anios integer,
  fecha_desde DATE,
  fecha_hasta DATE,
  version INT,
  vigente VARCHAR,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT map_dsa_ids_antiguedad_pk PRIMARY KEY (antiguedad_id)
);
CREATE TABLE mapuche_nuevo_dsa.d_rangoedad
(
  edad_id SMALLINT NOT NULL,
  rangoedad_desc VARCHAR,
  edad integer,
  fecha_desde DATE,
  fecha_hasta DATE,
  version INT,
  vigente VARCHAR,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT map_dw_lt_rango_edades_pk PRIMARY KEY (edad_id)
);
CREATE TABLE mapuche_nuevo_dsa.d_redprogramatica (
                red_programatica_id SMALLINT NOT NULL,
                red_programatica_codigo VARCHAR,
		programa_codigo VARCHAR,
		programa_desc VARCHAR,
		subprograma_codigo VARCHAR,
		subprograma_desc VARCHAR,
		proyecto_codigo VARCHAR,
		proyecto_desc VARCHAR,
		actividad_codigo VARCHAR,
		actividad_desc VARCHAR,
		obra_codigo VARCHAR,
		obra_desc VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_redprogramatica_pk PRIMARY KEY (red_programatica_id)
);
CREATE TABLE mapuche_nuevo_dsa.d_objetodelgasto (
                objetodelgasto_id SMALLINT NOT NULL,
                objetodelgasto_codigo VARCHAR ,
                resumen_desc VARCHAR,
                inciso_desc VARCHAR,
                partidappal_desc VARCHAR,
                partidaparcial_desc VARCHAR,
		orden INTEGER,
                fecha_desde DATE,
                fecha_hasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_objetodelgasto_pk PRIMARY KEY (objetodelgasto_id)
);
CREATE TABLE mapuche_nuevo_dsa.d_liquidacion (
                liquidacion_id SMALLINT NOT NULL,
                liquidacion_codigo VARCHAR,
                liquidacion_desc VARCHAR,
		es_cerrada VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_liquidacion_pk PRIMARY KEY (liquidacion_id)
);
CREATE TABLE mapuche_nuevo_dsa.d_imppresupfuente (
                imppresupfuente_id SMALLINT NOT NULL,
                imppresupfuente_codigo VARCHAR,
                imppresupfuente_desc VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_imppresupfuente_pk PRIMARY KEY (imppresupfuente_id)
);
CREATE TABLE mapuche_nuevo_dsa.d_unidad_presupuestaria (
                unidad_presupuestaria_id SMALLINT NOT NULL,
		unidad_presupuestaria_codigo VARCHAR,
		unidad_presupuestaria_desc VARCHAR,
		subunidad_presupuestaria_desc VARCHAR,
		subsubunidad_presupuestaria_desc VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_unidad_presupuestaria_pk PRIMARY KEY (unidad_presupuestaria_id)
);
CREATE TABLE mapuche_nuevo_dsa.d_concepto (
                concepto_id INTEGER NOT NULL,
                concepto_codigo VARCHAR,
                concepto_desc VARCHAR,
                conceptotipo_codigo VARCHAR,
                conceptotipo_desc VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_concepto_pk PRIMARY KEY (concepto_id)
);
CREATE TABLE mapuche_nuevo_dsa.d_dependenciadesemp (
                dependenciadesemp_id SMALLINT NOT NULL,
                dependenciadesemp_codigo VARCHAR,
                dependenciadesemp_desc VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_dependenciadesemp_pk PRIMARY KEY (dependenciadesemp_id)
);
CREATE TABLE mapuche_nuevo_dsa.d_regional (
                regional_id SMALLINT NOT NULL,
                regional_codigo varchar,
                regional_desc VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_regional_pk PRIMARY KEY (regional_id)
);
CREATE TABLE mapuche_nuevo_dsa.d_hsdedicacion (
                hsdedicacion_id SMALLINT NOT NULL,
                horas numeric(11,2),
                fecha_desde DATE,
                fecha_hasta DATE,
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_hsdedicacion_pk PRIMARY KEY (hsdedicacion_id)
);
CREATE TABLE mapuche_nuevo_dsa.d_asociado (
                asociado_id SMALLINT NOT NULL,
                asociado_codigo VARCHAR,
                asociado_desc VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_asociado_pk PRIMARY KEY (asociado_id)
);
CREATE TABLE mapuche_nuevo_dsa.d_subrogancia (
                subrogancia_id SMALLINT NOT NULL,
                subrogancia_codigo VARCHAR,
                subrogancia_desc VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_subrogancia_pk PRIMARY KEY (subrogancia_id)
);
CREATE TABLE mapuche_nuevo_dsa.d_agrupamiento (
                agrupamiento_id SMALLINT NOT NULL,
                agrupamiento_codigo VARCHAR,
                agrupamiento_desc VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_agrupamiento_pk PRIMARY KEY (agrupamiento_id)
);
CREATE TABLE mapuche_nuevo_dsa.d_tipoplantacaracter (
                plantacarac_id SMALLINT NOT NULL,
                tipoplanta_codigo VARCHAR,
                tipoplanta_desc VARCHAR,
                caracter_codigo VARCHAR,
                caracter_desc VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_tipoplantacaracter_pk PRIMARY KEY (plantacarac_id)
);
CREATE TABLE mapuche_nuevo_dsa.d_estadodelcargo (
                estadodelcargo_id SMALLINT NOT NULL,
                estadodelcargo_codigo VARCHAR,
                estadodelcargo_desc VARCHAR,
                cargoactivo_codigo VARCHAR,
                cargoactivo_desc VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,                
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT map_dsa_ids_estadodelcargo_pk PRIMARY KEY (estadodelcargo_id)
);
CREATE TABLE mapuche_nuevo_dsa.d_categoriascargo (
                categoria_id SMALLINT NOT NULL,
                categoria_codigo VARCHAR,
                categoria_desc VARCHAR,
                escalafon_codigo VARCHAR,
                escalafon_desc VARCHAR,
                dedicacion_codigo VARCHAR,
                dedicacion_desc VARCHAR,
                estadolaboral_codigo VARCHAR,
                estadolaboral_desc VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_categorioscargo_pk PRIMARY KEY (categoria_id)
);
CREATE TABLE mapuche_nuevo_dsa.d_dependenciadesig (
                dependenciadesign_id SMALLINT NOT NULL,
                dependenciadesign_codigo VARCHAR,
                dependenciadesign_desc VARCHAR,
                instalacion_id INTEGER,
                fecha_desde DATE,
                fecha_hasta DATE,                
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_dependenciadesign_pk PRIMARY KEY (dependenciadesign_id)
);
CREATE TABLE mapuche_nuevo_dsa.d_persona (
                persona_id INTEGER NOT NULL,
                legajo_codigo VARCHAR,
                cuil VARCHAR,
                apellido VARCHAR,
                nombre VARCHAR,
                apellidonombre_desc VARCHAR,
		fecha_nacimiento date,
		correo_electronico VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,                
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_persona_pk PRIMARY KEY (persona_id)
);
COMMENT ON COLUMN mapuche_nuevo_dsa.d_persona.fecha_nacimiento IS 'No se usa. Creado para permitir copia de dw a dsa';

CREATE TABLE mapuche_nuevo_dsa.d_titulo
(
  titulo_id SMALLINT NOT NULL,
  titulo_codigo character varying,
  titulo_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT d_titulo_pk PRIMARY KEY (titulo_id)
);

CREATE TABLE mapuche_nuevo_dsa.d_licencia (
	licencia_id SMALLINT NOT NULL,
        licencia_codigo character varying,
        licencia_desc character varying,
	fecha_desde date,
	fecha_hasta date,
	version integer,
	vigente character varying,
	fecha_actualizacion timestamp without time zone,
	CONSTRAINT d_licencia_pk PRIMARY KEY (licencia_id)
);

CREATE TABLE mapuche_nuevo_dsa.d_discapacidad (
                discapacidad_id SMALLINT NOT NULL,
                discapacidad_codigo VARCHAR,
                discapacidad_desc VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_discapacidad_pk PRIMARY KEY (discapacidad_id)
);

CREATE TABLE mapuche_nuevo_dsa.d_nivelestudio (
                nivelestudio_id SMALLINT NOT NULL,
                nivelestudio_codigo VARCHAR,
                nivelestudio_desc VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_nivelestudio_pk PRIMARY KEY (nivelestudio_id)
);
CREATE TABLE mapuche_nuevo_dsa.d_estadocivil (
                estadocivil_id SMALLINT NOT NULL,
                estadocivil_codigo VARCHAR,
                estadocivil_desc VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_estadocivil_pk PRIMARY KEY (estadocivil_id)
);
CREATE TABLE mapuche_nuevo_dsa.d_sexo (
                sexo_id SMALLINT NOT NULL,
                sexo_codigo VARCHAR(2),
                sexo_desc VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,                
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_sexo_pk PRIMARY KEY (sexo_id)
);
CREATE TABLE mapuche_nuevo_dsa.d_activo (
                activo_id SMALLINT NOT NULL,
                activo_codigo VARCHAR,
                activo_desc VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_activo_pk PRIMARY KEY (activo_id)
);

CREATE TABLE mapuche_nuevo_dsa.ft_cargos (
                periodo_id integer NOT NULL,
		anio_id integer,
		mes_id integer,
		persona_id INTEGER,
		nro_cargo_base INTEGER,
		nro_cargo INTEGER,
                dependenciadesigncargo_id SMALLINT,
                categoria_id SMALLINT,
                nudo VARCHAR,
                estadodelcargo_id SMALLINT,      
                plantacarac_id SMALLINT,
                agrupamiento_id SMALLINT,
                subrogancia_id SMALLINT,
                categoria_subrogada_id SMALLINT,
                asociado_id SMALLINT,
                antiguedadescalafon_id SMALLINT,
                hsdedicacion_id SMALLINT,
                porctrabajado_id SMALLINT,
                porcreduccionhoraria_id SMALLINT,
                regional_id SMALLINT,
                fechaalta DATE,     
                fechabaja DATE,
                dependenciadesemp_id SMALLINT,
		licencia_id SMALLINT,
                cantcargosliq INTEGER,
                cantcargosactivos INTEGER,
                importenetocargo NUMERIC(15,2),
                importebrutocargo NUMERIC(15,2),
                importegastototalcargo NUMERIC(15,2),
                fechacarga DATE NOT NULL,                
                CONSTRAINT ft_cargos_pk PRIMARY KEY (periodo_id, persona_id, nro_cargo)
);
CREATE TABLE mapuche_nuevo_dsa.ft_legajos (
                periodo_id integer NOT NULL,
		anio_id integer,
		mes_id integer,
                persona_id INTEGER NOT NULL,
                nivelestudio_id SMALLINT,
		categoria_incentivo_id SMALLINT,
		dedicacion_incentivo_id SMALLINT,
                estadocivil_id SMALLINT,
                activo_id SMALLINT,
                sexo_id SMALLINT,
                discapacidad_id SMALLINT,
                edad_id SMALLINT,
		titulo_id SMALLINT,
		nivel_estudio_liq_id SMALLINT,
                cargahorariahs SMALLINT,
                legajosconcargoactivo INTEGER,
                legajosliq INTEGER,
		regional_cabecera_id SMALLINT,
                dependencia_cabecera_id SMALLINT,
                fechacarga DATE,
                CONSTRAINT ft_legajos_pk PRIMARY KEY (periodo_id, persona_id)
);
CREATE TABLE mapuche_nuevo_dsa.ft_liqconceptosxcargos (
                periodo_id integer NOT NULL,
		anio_id integer,
		mes_id integer,
                liquidacion_id INT NOT NULL,
                concepto_id  INT NOT NULL,
		persona_id INTEGER NOT NULL,
                nro_cargo_base INTEGER NOT NULL,
                nro_cargo INTEGER NOT NULL,
                unidad_presupuestaria_id SMALLINT,
		tipo_ejercicio_id SMALLINT,
		grupo_presupuestario_id SMALLINT,
		finalidad_funcion_id SMALLINT,
                imppresupfuente_id SMALLINT,
                objetogasto_id SMALLINT,
                red_programatica_id SMALLINT,
		antiguedadliq_id SMALLINT,
		dias_trabajados SMALLINT,
		periodo_retroactivo_id SMALLINT,
                importe_liq NUMERIC(15,2),
		porc_imppresup VARCHAR,
		nro_recibo integer,
		nro_orimp SMALLINT,
                cargosxcptosximputaciones INTEGER,
                importenetocargo NUMERIC(15,2),
                importedescuentoscargo NUMERIC(15,2),
                importebrutocargo NUMERIC(15,2),
                importeaportescargo NUMERIC(15,2),
                importegastototalcargo NUMERIC(15,2),
                importeasigfam NUMERIC(15,2),
                importeremconap NUMERIC(15,2),
                importeremsinap NUMERIC(15,2),
                importeotrosrem NUMERIC(15,2),
                fechacarga DATE NOT NULL 
 
);


--Crea el esquema mapuche_nuevo
CREATE SCHEMA mapuche_nuevo;

--Tablas cubos mapuche_nuevo
CREATE TABLE mapuche_nuevo.d_periodo_retroactivo
(
  periodo_retroactivo_id SMALLINT NOT NULL,
  periodo_retroactivo_codigo character varying,
  anio_codigo character varying,
  anio_desc character varying,
  mes_codigo character varying,
  mes_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  es_retroactivo character varying DEFAULT 'Retroactivo'::character varying,
  CONSTRAINT d_periodo_retroactivo_pk PRIMARY KEY (periodo_retroactivo_id)
);

CREATE TABLE mapuche_nuevo.d_grupo_presupuestario (
	grupo_presupuestario_id SMALLINT NOT NULL,
    	grupo_presupuestario_codigo character varying,
    	grupo_presupuestario_desc character varying,
	fecha_desde date,
	fecha_hasta date,
	version integer,
	vigente character varying,
	fecha_actualizacion timestamp without time zone,
	CONSTRAINT d_grupo_presupuestario_pk PRIMARY KEY (grupo_presupuestario_id)
);

CREATE TABLE mapuche_nuevo.d_finalidad_funcion (
	finalidad_funcion_id SMALLINT NOT NULL,
    	finalidad_codigo character varying,
    	finalidad_desc character varying,
	funcion_codigo character varying,
    	funcion_desc character varying,
	fecha_desde date,
	fecha_hasta date,
	version integer,
	vigente character varying,
	fecha_actualizacion timestamp without time zone,
	CONSTRAINT d_finalidad_funcion_pk PRIMARY KEY (finalidad_funcion_id)
);

CREATE TABLE mapuche_nuevo.d_tipo_ejercicio
(
  tipo_ejercicio_id SMALLINT NOT NULL,
  tipo_ejercicio_codigo character varying,
  tipo_ejercicio_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT d_tipo_ejercicio_pk PRIMARY KEY (tipo_ejercicio_id)
);

CREATE TABLE mapuche_nuevo.d_condicion
(
  condicion_id SMALLINT NOT NULL,
  condicion_codigo character varying,
  condicion_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT d_condicion_pk PRIMARY KEY (condicion_id)
);

CREATE TABLE mapuche_nuevo.d_porctrabajado
(
  porcentaje_id SMALLINT NOT NULL,
  porcentaje_codigo varchar,
  fecha_desde DATE,
  fecha_hasta DATE,
  version INT,
  vigente VARCHAR,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT d_porctrabajado_pk PRIMARY KEY (porcentaje_id)
);
CREATE TABLE mapuche_nuevo.d_porcreduchoraria
(
  porcentaje_id SMALLINT NOT NULL,
  porcentaje_codigo varchar,
  fecha_desde DATE,
  fecha_hasta DATE,
  version INT,
  vigente VARCHAR,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT d_porcreduchoraria_pk PRIMARY KEY (porcentaje_id)
);
CREATE TABLE mapuche_nuevo.d_antiguedad
(
  antiguedad_id SMALLINT NOT NULL,
  rangoantiguedad_desc VARCHAR,
  anios integer,
  fecha_desde DATE,
  fecha_hasta DATE,
  version INT,
  vigente VARCHAR,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT d_antiguedad_pk PRIMARY KEY (antiguedad_id)
);
CREATE TABLE mapuche_nuevo.d_rangoedad
(
  edad_id SMALLINT NOT NULL,
  rangoedad_desc VARCHAR,
  edad integer,
  fecha_desde DATE,
  fecha_hasta DATE,
  version INT,
  vigente VARCHAR,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT d_rangoedades_pk PRIMARY KEY (edad_id)
);
CREATE TABLE mapuche_nuevo.d_redprogramatica (
                red_programatica_id SMALLINT NOT NULL,
                red_programatica_codigo VARCHAR,
		programa_codigo VARCHAR,
		programa_desc VARCHAR,
		subprograma_codigo VARCHAR,
		subprograma_desc VARCHAR,
		proyecto_codigo VARCHAR,
		proyecto_desc VARCHAR,
		actividad_codigo VARCHAR,
		actividad_desc VARCHAR,
		obra_codigo VARCHAR,
		obra_desc VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_redprogramatica_pk PRIMARY KEY (red_programatica_id)
);
CREATE TABLE mapuche_nuevo.d_objetodelgasto (
                objetodelgasto_id SMALLINT NOT NULL,
                objetodelgasto_codigo VARCHAR ,
                resumen_desc VARCHAR,
                inciso_desc VARCHAR,
                partidappal_desc VARCHAR,
                partidaparcial_desc VARCHAR,
		orden INTEGER,
                fecha_desde DATE,
                fecha_hasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_objetodelgasto_pk PRIMARY KEY (objetodelgasto_id)
);
CREATE TABLE mapuche_nuevo.d_liquidacion (
                liquidacion_id SMALLINT NOT NULL,
                liquidacion_codigo VARCHAR,
                liquidacion_desc VARCHAR,
		es_cerrada VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_liquidaciones_pk PRIMARY KEY (liquidacion_id)
);
CREATE TABLE mapuche_nuevo.d_imppresupfuente (
                imppresupfuente_id SMALLINT NOT NULL,
                imppresupfuente_codigo VARCHAR,
                imppresupfuente_desc VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_imppresupfuentes_pk PRIMARY KEY (imppresupfuente_id)
);
CREATE TABLE mapuche_nuevo.d_unidad_presupuestaria (
                unidad_presupuestaria_id SMALLINT NOT NULL,
		unidad_presupuestaria_codigo VARCHAR,
		unidad_presupuestaria_desc VARCHAR,
		subunidad_presupuestaria_desc VARCHAR,
		subsubunidad_presupuestaria_desc VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_unidad_presupuestaria_pk PRIMARY KEY (unidad_presupuestaria_id)
);
CREATE TABLE mapuche_nuevo.d_concepto (
                concepto_id INTEGER NOT NULL,
                concepto_codigo VARCHAR,
                concepto_desc VARCHAR,
                conceptotipo_codigo VARCHAR,
                conceptotipo_desc VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_conceptos_pk PRIMARY KEY (concepto_id)
);
CREATE TABLE mapuche_nuevo.d_dependenciadesemp (
                dependenciadesemp_id SMALLINT NOT NULL,
                dependenciadesemp_codigo varCHAR,
                dependenciadesemp_desc VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_dependenciadesemp_pk PRIMARY KEY (dependenciadesemp_id)
);
CREATE TABLE mapuche_nuevo.d_regional (
                regional_id SMALLINT NOT NULL,
                regional_codigo varchar,
                regional_desc VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_regional_pk PRIMARY KEY (regional_id)
);
CREATE TABLE mapuche_nuevo.d_hsdedicacion (
                hsdedicacion_id SMALLINT NOT NULL,
                horas numeric(11,2),
                fecha_desde DATE,
                fecha_hasta DATE,
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_hsdedicacion_pk PRIMARY KEY (hsdedicacion_id)
);
CREATE TABLE mapuche_nuevo.d_asociado (
                asociado_id SMALLINT NOT NULL,
                asociado_codigo VARCHAR,
                asociado_desc VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_asociado_pk PRIMARY KEY (asociado_id)
);
CREATE TABLE mapuche_nuevo.d_subrogancia (
                subrogancia_id SMALLINT NOT NULL,
                subrogancia_codigo VARCHAR,
                subrogancia_desc VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_subrogancia_pk PRIMARY KEY (subrogancia_id)
);
CREATE TABLE mapuche_nuevo.d_agrupamiento (
                agrupamiento_id SMALLINT NOT NULL,
                agrupamiento_codigo VARCHAR,
                agrupamiento_desc VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_agrupamiento_pk PRIMARY KEY (agrupamiento_id)
);
CREATE TABLE mapuche_nuevo.d_tipoplantacaracter (
                plantacarac_id SMALLINT NOT NULL,
                tipoplanta_codigo VARCHAR,
                tipoplanta_desc VARCHAR,
                caracter_codigo VARCHAR,
                caracter_desc VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_tipoplantacaracter_pk PRIMARY KEY (plantacarac_id)
);
CREATE TABLE mapuche_nuevo.d_estadodelcargo (
                estadodelcargo_id SMALLINT NOT NULL,
                estadodelcargo_codigo VARCHAR,
                estadodelcargo_desc VARCHAR,
                cargoactivo_codigo VARCHAR,
                cargoactivo_desc VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,                
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_estadodelcargo_pk PRIMARY KEY (estadodelcargo_id)
);
CREATE TABLE mapuche_nuevo.d_categoriascargo (
                categoria_id SMALLINT NOT NULL,
                categoria_codigo VARCHAR,
                categoria_desc VARCHAR,
                escalafon_codigo VARCHAR,
                escalafon_desc VARCHAR,
                dedicacion_codigo VARCHAR,
                dedicacion_desc VARCHAR,
                estadolaboral_codigo VARCHAR,
                estadolaboral_desc VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_categorioscargo_pk PRIMARY KEY (categoria_id)
);
CREATE TABLE mapuche_nuevo.d_dependenciadesig (
                dependenciadesign_id SMALLINT NOT NULL,
                dependenciadesign_codigo VARCHAR,
                dependenciadesign_desc VARCHAR,
                instalacion_id INTEGER NOT NULL,
                fecha_desde DATE,
                fecha_hasta DATE,                
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_dependenciadesign_pk PRIMARY KEY (dependenciadesign_id)
);
CREATE TABLE mapuche_nuevo.d_persona (
                persona_id INTEGER NOT NULL,
                legajo_codigo VARCHAR,
                cuil VARCHAR,
                apellido VARCHAR,
                nombre VARCHAR,
                apellidonombre_desc VARCHAR,
                fecha_nacimiento DATE,  
		correo_electronico VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,           
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_persona_pk PRIMARY KEY (persona_id)
);

CREATE TABLE mapuche_nuevo.d_titulo
(
  titulo_id SMALLINT NOT NULL,
  titulo_codigo character varying,
  titulo_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT d_titulo_pk PRIMARY KEY (titulo_id)
);
CREATE TABLE mapuche_nuevo.d_discapacidad (
                discapacidad_id SMALLINT NOT NULL,
                discapacidad_codigo VARCHAR,
                discapacidad_desc VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_discapacidad_pk PRIMARY KEY (discapacidad_id)
);

CREATE TABLE mapuche_nuevo.d_nivelestudio (
                nivelestudio_id SMALLINT NOT NULL,
                nivelestudio_codigo VARCHAR,
                nivelestudio_desc VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_nivelestudios_pk PRIMARY KEY (nivelestudio_id)
);


CREATE TABLE mapuche_nuevo.d_estadocivil (
                estadocivil_id SMALLINT NOT NULL,
                estadocivil_codigo VARCHAR,
                estadocivil_desc VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_estadocivil_pk PRIMARY KEY (estadocivil_id)
);
CREATE TABLE mapuche_nuevo.d_sexo (
                sexo_id SMALLINT NOT NULL,
                sexo_codigo VARCHAR,
                sexo_desc VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,                
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_sexo_pk PRIMARY KEY (sexo_id)
);
CREATE TABLE mapuche_nuevo.d_activo (
                activo_id SMALLINT NOT NULL,
                activo_codigo VARCHAR,
                activo_desc VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_activo_pk PRIMARY KEY (activo_id)
);

CREATE TABLE mapuche_nuevo.d_categoria_incentivo
(
                categoria_incentivo_id SMALLINT NOT NULL,
                categoria_incentivo_codigo character varying,
                categoria_incentivo_desc character varying,
                orden integer,   
                fecha_desde date,
                fecha_hasta date,
                version integer,
                vigente character varying,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_categoria_incentivo_pk PRIMARY KEY (categoria_incentivo_id )
);

CREATE TABLE mapuche_nuevo.d_dedicacion_incentivo
(
                dedicacion_incentivo_id SMALLINT NOT NULL,
                dedicacion_incentivo_codigo character varying,
                dedicacion_incentivo_desc character varying,
                fecha_desde date,
                fecha_hasta date,
                version integer,
                vigente character varying,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_dedicacion_incentivo_pk PRIMARY KEY (dedicacion_incentivo_id )
);

CREATE TABLE mapuche_nuevo.d_licencia (
	licencia_id SMALLINT NOT NULL,
        licencia_codigo character varying,
        licencia_desc character varying,
	fecha_desde date,
	fecha_hasta date,
	version integer,
	vigente character varying,
	fecha_actualizacion timestamp without time zone,
	CONSTRAINT d_licencia_pk PRIMARY KEY (licencia_id)
);

CREATE TABLE mapuche_nuevo.ft_personal(
  id serial NOT NULL,
  importacion_id integer,
  unidad_generica_id integer,
  periodo_id integer NOT NULL,
  anio_id integer,
  mes_id integer,
  condicion_id SMALLINT NOT NULL,
  liquidacion_id SMALLINT NOT NULL,
  concepto_id integer NOT NULL,
  persona_id integer NOT NULL,
  nro_cargo_base integer,
  nro_cargo integer,
  unidad_presupuestaria_id SMALLINT,
  tipo_ejercicio_id SMALLINT,
  grupo_presupuestario_id SMALLINT,
  finalidad_funcion_id SMALLINT,
  imppresupfuente_id SMALLINT,
  objetogasto_id SMALLINT,
  red_programatica_id SMALLINT,
  antiguedadliq_id SMALLINT,
  dias_trabajados SMALLINT,
  periodo_retroactivo_id SMALLINT,
  importe_liq numeric(15,2),
  porc_imppresup VARCHAR,
  nro_recibo integer,
  nro_orimp SMALLINT,
  importenetocargo numeric(15,2),
  importebrutocargo numeric(15,2),
  importegastototalcargo numeric(15,2),
  importedescuentoscargo numeric(15,2),
  importeaportescargo numeric(15,2),
  importeasigfam NUMERIC(15,2),
  importeremconap NUMERIC(15,2),
  importeremsinap NUMERIC(15,2),
  importeotrosrem NUMERIC(15,2),
  dependenciadesigncargo_id SMALLINT,
  categoria_id SMALLINT,
  nudo character varying,
  estadodelcargo_id SMALLINT,
  plantacarac_id SMALLINT,
  agrupamiento_id SMALLINT,
  subrogancia_id SMALLINT,
  categoria_subrogada_id SMALLINT,
  asociado_id SMALLINT,
  antiguedadescalafon_id SMALLINT,
  hsdedicacion_id SMALLINT,
  porctrabajado_id SMALLINT,
  porcreduccionhoraria_id SMALLINT,
  regional_id SMALLINT,
  fechaalta date,
  fechabaja date,
  dependenciadesemp_id SMALLINT,
  nivelestudio_id SMALLINT,
  estadocivil_id SMALLINT,
  activo_id SMALLINT,
  sexo_id SMALLINT,
  discapacidad_id SMALLINT,
  edad_id SMALLINT,
  titulo_id SMALLINT,
  nivel_estudio_liq_id SMALLINT,
  cargahorariahs SMALLINT,
  categoria_incentivo_id SMALLINT DEFAULT '0'::integer,
  dedicacion_incentivo_id SMALLINT,
  regional_cabecera_id SMALLINT,
  dependencia_cabecera_id SMALLINT,
  dependenciadesign_id SMALLINT,
  es_migrado character varying(2),
  licencia_id SMALLINT,
  fechacarga date
);


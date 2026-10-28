-- Este script es parte de la migración de SIU-Wichi 6.5.0 a 6.6.0
-----------------------------
-- Agregar fechas nulas
-----------------------------
INSERT INTO d_fecha(
            fecha_id, anio, mes, dia, dia_semana, dia_semana_desc, dia_semana_abreviada_desc, 
            mes_desc, mes_abreviado_desc, trimestre, trimestre_desc, semestre, 
            semestre_desc)
    VALUES ('1900-01-01', 1900, 1, 1, 1, 'VALOR ERRONEO', 'VALOR ERRONEO', 
            'VALOR ERRONEO', 'VALOR ERRONEO', 1, 'VALOR ERRONEO', 1, 
            'VALOR ERRONEO');

INSERT INTO d_fecha(
            fecha_id, anio, mes, dia, dia_semana, dia_semana_desc, dia_semana_abreviada_desc, 
            mes_desc, mes_abreviado_desc, trimestre, trimestre_desc, semestre, 
            semestre_desc)
    VALUES ('2199-12-31', 2199, 12, 31, 1, 'VACIO/NULO', 'VACIO/NULO', 
            'VACIO/NULO', 'VACIO/NULO', 4, 'VACIO/NULO', 2, 
            'VACIO/NULO');


----------------------------- 
--     Sanaviron/Quilmes  
----------------------------- 

--Esquema tmp

ALTER TABLE sq_tmp.ft_ventas
  ADD COLUMN leyenda text;

ALTER TABLE sq_tmp.ft_ventas
  ADD COLUMN id_servicio text;

ALTER TABLE sq_tmp.ft_ventas
  ADD COLUMN id_concepto_venta text;


CREATE TABLE sq_tmp.d_concepto_venta
(
  id text,
  codigo text,
  descripcion text
);

CREATE TABLE sq_tmp.d_servicio
(
  id text,
  descripcion text
);


--Esquema dsa

ALTER TABLE sq_dsa.ft_ventas
  ADD COLUMN leyenda character varying;

ALTER TABLE sq_dsa.ft_ventas
  ADD COLUMN servicio_id integer;

ALTER TABLE sq_dsa.ft_ventas
  ADD COLUMN concepto_venta_id integer;

CREATE TABLE sq_dsa.d_concepto_venta
(
  concepto_venta_id serial NOT NULL,
  concepto_venta_id_sq integer,
  concepto_venta_codigo character varying,
  concepto_venta_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT d_concepto_venta_pk PRIMARY KEY (concepto_venta_id)
);

CREATE TABLE sq_dsa.d_servicio
(
  servicio_id serial NOT NULL,
  servicio_id_sq integer,
  servicio_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT d_servicio_pk PRIMARY KEY (servicio_id)
);


--Esquema sq

ALTER TABLE sq.ft_ventas
  ADD COLUMN leyenda character varying;

ALTER TABLE sq.ft_ventas
  ADD COLUMN servicio_id integer;

ALTER TABLE sq.ft_ventas
  ADD COLUMN concepto_venta_id integer;


CREATE TABLE sq.d_concepto_venta
(
  concepto_venta_id serial NOT NULL,
  concepto_venta_id_sq integer,
  concepto_venta_codigo character varying,
  concepto_venta_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT d_concepto_venta_pk PRIMARY KEY (concepto_venta_id)
);

CREATE TABLE sq.d_servicio
(
  servicio_id serial NOT NULL,
  servicio_id_sq integer,
  servicio_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT d_servicio_pk PRIMARY KEY (servicio_id)
);



----------------------------- 
--     Diaguita
----------------------------- 
ALTER TABLE diaguita_dsa.ft_patrimonio
  ALTER COLUMN valor_bien TYPE numeric(15,2);

ALTER TABLE diaguita.ft_patrimonio
  ALTER COLUMN valor_bien TYPE numeric(15,2);

ALTER TABLE diaguita_dsa.ft_patrimonio
  ALTER COLUMN valor_residual TYPE numeric(15,2);

ALTER TABLE diaguita.ft_patrimonio
  ALTER COLUMN valor_residual TYPE numeric(15,2);


CREATE TABLE diaguita_tmp.d_rubro
(
  rubro_codigo text,
  rubro_desc text
);

ALTER TABLE diaguita_tmp.ft_compras
  ADD COLUMN id_rubro_solicitud character varying;
ALTER TABLE diaguita_tmp.ft_compras
  ADD COLUMN id_rubro_convocatoria character varying;

CREATE TABLE diaguita_dsa.d_rubro
(
  id_rubro integer NOT NULL,
  rubro_desc character varying,
  CONSTRAINT d_rubro_pkey PRIMARY KEY (id_rubro)
);

ALTER TABLE diaguita_dsa.ft_compras
  ADD COLUMN id_rubro_solicitud integer;
ALTER TABLE diaguita_dsa.ft_compras
  ADD COLUMN id_rubro_convocatoria integer;

CREATE TABLE diaguita.d_rubro
(
  id_rubro integer NOT NULL,
  rubro_desc character varying,
  CONSTRAINT d_rubro_pkey PRIMARY KEY (id_rubro)
);

ALTER TABLE diaguita.ft_compras
  ADD COLUMN id_rubro_solicitud integer;
ALTER TABLE diaguita.ft_compras
  ADD COLUMN id_rubro_convocatoria integer;

ALTER TABLE diaguita_tmp.ft_compras
  ADD COLUMN fecha_vencimiento_oc character varying;

ALTER TABLE diaguita_dsa.ft_compras
  ADD COLUMN fecha_vencimiento_oc date;

ALTER TABLE diaguita.ft_compras
  ADD COLUMN fecha_vencimiento_oc date;

CREATE TABLE diaguita_tmp.d_moneda
(
  moneda_codigo text,
  moneda_desc text
);

ALTER TABLE diaguita_tmp.ft_compras
  ADD COLUMN id_moneda_oc character varying;

CREATE TABLE diaguita_dsa.d_moneda
(
  id_moneda integer NOT NULL,
  moneda_desc character varying,
  CONSTRAINT d_moneda_pkey PRIMARY KEY (id_moneda)
);

ALTER TABLE diaguita_dsa.ft_compras
  ADD COLUMN id_moneda_oc integer;

CREATE TABLE diaguita.d_moneda
(
  id_moneda integer NOT NULL,
  moneda_desc character varying,
  CONSTRAINT d_moneda_pkey PRIMARY KEY (id_moneda)
);

ALTER TABLE diaguita.ft_compras
  ADD COLUMN id_moneda_oc integer;

ALTER TABLE diaguita_tmp.ft_compras
  ADD COLUMN descripcion_mcc character varying;

ALTER TABLE diaguita_dsa.ft_compras
  ADD COLUMN descripcion_mcc character varying;

ALTER TABLE diaguita.ft_compras
  ADD COLUMN descripcion_mcc character varying;
-----------------------------
-- Guarani 3
-----------------------------
TRUNCATE TABLE guarani3_dsa.d_localidad;
TRUNCATE TABLE guarani3.d_localidad;

ALTER TABLE guarani3_tmp.d_persona
  ADD COLUMN email character varying;
ALTER TABLE guarani3_tmp.d_persona
  ADD COLUMN telefono character varying;

ALTER TABLE guarani3_dsa.d_persona
  ADD COLUMN email character varying;
ALTER TABLE guarani3_dsa.d_persona
  ADD COLUMN telefono character varying;

ALTER TABLE guarani3.d_persona
  ADD COLUMN email character varying;
ALTER TABLE guarani3.d_persona
  ADD COLUMN telefono character varying;


------------------------------
-- Querandies
------------------------------
DROP TABLE querandies.d_tipo_uso;



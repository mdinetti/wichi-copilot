-- Este script es parte de la migración de SIU-Wichi 6.3.1 a 6.4.0.


----------------------------- 
--     Diaguita  
----------------------------- 
--Agrega en compras:
  -- la oficina de contratacion u oficina de la convocatoria a la tabla de compras.
  -- procedimiento_modalidad
  -- procedimiento_clase
  -- fecha_acto_apertura (extrae date de inicio_acto_apertura)

DROP TABLE diaguita_tmp.ft_compras;
CREATE TABLE diaguita_tmp.ft_compras
(
  id_compras serial not null,
  etapa character varying,
  identificador_solicitud character varying,
  fecha_creacion_solicitud character varying,
  descripcion_solicitud character varying,
  prioridad_solicitud character varying,
  estado_solicitud character varying,
  referente_solicitud character varying,
  id_lugar_entrega_solicitud character varying,
  id_oficina_central_contratacion_solicitud character varying,
  id_area_solicitud character varying,
  descripcion_item_solicitado character varying,
  cantidad_item_solicitado character varying DEFAULT 0,
  unidad_medida_item_solicitado character varying,
  precio_estimado_item_solicitado character varying DEFAULT 0,
  id_area_item_solicitado character varying,
  identificador_convocatoria character varying,
  fecha_creacion_convocatoria character varying,
  descripcion_convocatoria character varying,
  estado_convocatoria character varying,
  prioridad_convocatoria character varying,
  id_convocatoria character varying,
  expediente_convocatoria character varying,
  tipo_procedimiento_convocatoria character varying,
  id_oficina_convocatoria character varying, 
  id_procedimiento_modalidad character varying,
  id_procedimiento_clase character varying,
  id_renglon character varying,
  descripcion_renglon character varying,
  numero_renglon character varying,
  precio_estimado_renglon character varying DEFAULT 0,
  catalogo_bien_servicio_renglon character varying,
  id_renglon_area character varying,
  cantidad_renglon character varying DEFAULT 0,
  id_item_area character varying,
  id_convocatoria_aa character varying,
  id_acto_apertura character varying,
  inicio_acto_apertura character varying,
  fin_acto_apertura character varying,
  oficina_acto_apertura character varying,
  lugar_acto_apertura character varying,
  identificador_acto_apertura character varying,
  estado_acto_apertura character varying,
  id_acto_apertura_de character varying,
  fecha_creacion_dictamen character varying,
  fecha_generacion_dictamen character varying,
  identificador_dictamen character varying,
  estado_dictamen character varying,
  -- Adjudicacion
  id_renglon_ad character varying,
  estado_adjudicacion character varying,
  identificador_adjudicacion character varying,
  id_proveedor character varying,
  cantidad_ad character varying DEFAULT 0,
  monto_unitario character varying DEFAULT 0,
  id_adjudicacion character varying, -- Clave para Orden de Compra
  -- Orden de Compra
  id_renglon_area_oc character varying,
  id_detalle_orden_compra_oc character varying,
  id_proveedor_oc character varying,
  id_area_oc character varying,
  estado_orden_compra character varying,
  identificador_orden_compra character varying,
  fecha_emision_oc character varying,
  id_lugar_entrega_oc character varying,
  cantidad_oc character varying DEFAULT 0,
  id_adjudicacion_oc character varying, -- Clave para Adjudicacion
  -- Recepciones
  id_detalle_orden_compra_re character varying,
  fecha_recepcion character varying,
  estado_recepcion character varying,
  remito character varying,
  factura_numero character varying,
  identificador_acta_provisoria_recepcion character varying,
  fecha_acta_provisoria_re character varying,
  id_area_re character varying,
  identificador_acta_definitiva_recepcion character varying,
  fecha_acta_definitiva_re character varying,
  cantidad_recibida character varying DEFAULT 0,
  cantidad_aceptada character varying DEFAULT 0,
  cantidad_rechazada character varying DEFAULT 0
);
CREATE TABLE diaguita_tmp.d_procedimiento_modalidades
(
  id_procedimiento_modalidad character varying NOT NULL,
  nombre character varying
);
CREATE TABLE diaguita_tmp.d_procedimiento_clases
(
  id_procedimiento_clase character varying NOT NULL,
  nombre character varying
);

DROP TABLE diaguita_dsa.ft_compras;
CREATE TABLE diaguita_dsa.ft_compras
(
  id_compras serial not null,
  etapa character varying,
  identificador_solicitud character varying,
  fecha_creacion_solicitud date,
  descripcion_solicitud character varying,
  prioridad_solicitud character varying,
  estado_solicitud character varying,
  referente_solicitud character varying,
  id_lugar_entrega_solicitud integer,
  id_oficina_central_contratacion_solicitud integer,
  id_area_solicitud integer,
  descripcion_item_solicitado character varying,
  cantidad_item_solicitado double precision DEFAULT 0,
  unidad_medida_item_solicitado character varying,
  precio_estimado_item_solicitado double precision DEFAULT 0,
  id_area_item_solicitado integer,
  identificador_convocatoria character varying,
  fecha_creacion_convocatoria date,
  descripcion_convocatoria character varying,
  estado_convocatoria character varying,
  prioridad_convocatoria character varying,
  id_convocatoria integer,
  expediente_convocatoria character varying,
  tipo_procedimiento_convocatoria character varying,
  id_oficina_convocatoria integer,
  id_procedimiento_modalidad integer,
  id_procedimiento_clase integer,
  id_renglon integer,
  descripcion_renglon character varying,
  numero_renglon character varying,
  precio_estimado_renglon double precision DEFAULT 0,
  catalogo_bien_servicio_renglon integer,
  id_renglon_area integer,
  cantidad_renglon double precision DEFAULT 0,
  id_item_area integer,
  id_convocatoria_aa integer,
  id_acto_apertura integer,
  inicio_acto_apertura timestamp without time zone,
  fecha_acto_apertura date,
  fin_acto_apertura timestamp without time zone,
  oficina_acto_apertura character varying,
  lugar_acto_apertura character varying,
  identificador_acto_apertura character varying,
  estado_acto_apertura character varying,
  id_acto_apertura_de integer,
  fecha_creacion_dictamen date,
  fecha_generacion_dictamen date,
  identificador_dictamen character varying,
  estado_dictamen character varying,
  -- Adjudicacion
  id_renglon_ad integer,
  estado_adjudicacion character varying,
  identificador_adjudicacion character varying,
  id_proveedor integer,
  cantidad_ad double precision DEFAULT 0,
  monto_unitario double precision DEFAULT 0,
  id_adjudicacion integer, -- Clave para Orden de Compra
  -- Orden de Compra
  id_renglon_area_oc integer,
  id_detalle_orden_compra_oc integer,
  id_proveedor_oc integer,
  id_area_oc integer,
  estado_orden_compra character varying,
  identificador_orden_compra character varying,
  fecha_emision_oc date,
  id_lugar_entrega_oc integer,
  cantidad_oc double precision DEFAULT 0,
  monto_unitario_oc double precision DEFAULT 0,
  id_adjudicacion_oc integer, -- Clave para Adjudicacion
  -- Recepciones
  id_detalle_orden_compra_re integer,
  fecha_recepcion date,
  estado_recepcion character varying,
  remito character varying,
  factura_numero character varying,
  identificador_acta_provisoria_recepcion character varying,
  fecha_acta_provisoria_re date,
  id_area_re integer,
  identificador_acta_definitiva_recepcion character varying,
  fecha_acta_definitiva_re date,
  cantidad_recibida double precision DEFAULT 0,
  cantidad_aceptada double precision DEFAULT 0,
  cantidad_rechazada double precision DEFAULT 0,
  importe_total_solicitud double precision DEFAULT 0,
  importe_total_convocatoria double precision DEFAULT 0,
  importe_total_adjudicado double precision DEFAULT 0,
  importe_total_oc double precision DEFAULT 0,
  CONSTRAINT ft_compras_pkey PRIMARY KEY (id_compras)
);
CREATE TABLE diaguita_dsa.d_procedimiento_modalidades
(
  id_procedimiento_modalidad integer not null,
  nombre character varying,
  CONSTRAINT d_procedimiento_modalidad_pkey PRIMARY KEY (id_procedimiento_modalidad)
);
CREATE TABLE diaguita_dsa.d_procedimiento_clases
(
  id_procedimiento_clase integer not null,
  nombre character varying,
  CONSTRAINT d_procedimiento_clase_pkey PRIMARY KEY (id_procedimiento_clase)
);

DROP TABLE diaguita.ft_compras;
CREATE TABLE diaguita.ft_compras
(
  id_compras serial not null,
  etapa character varying,
  identificador_solicitud character varying,
  fecha_creacion_solicitud date,
  descripcion_solicitud character varying,
  prioridad_solicitud character varying,
  estado_solicitud character varying,
  referente_solicitud character varying,
  id_lugar_entrega_solicitud integer,
  id_oficina_central_contratacion_solicitud integer,
  id_area_solicitud integer,
  descripcion_item_solicitado character varying,
  cantidad_item_solicitado double precision DEFAULT 0,
  unidad_medida_item_solicitado character varying,
  precio_estimado_item_solicitado double precision DEFAULT 0,
  id_area_item_solicitado integer,
  identificador_convocatoria character varying,
  fecha_creacion_convocatoria date,
  descripcion_convocatoria character varying,
  estado_convocatoria character varying,
  prioridad_convocatoria character varying,
  id_convocatoria integer,
  expediente_convocatoria character varying,
  tipo_procedimiento_convocatoria character varying,
  id_oficina_convocatoria integer,
  id_procedimiento_modalidad integer,
  id_procedimiento_clase integer,
  id_renglon integer,
  descripcion_renglon character varying,
  numero_renglon character varying,
  precio_estimado_renglon double precision DEFAULT 0,
  catalogo_bien_servicio_renglon integer,
  id_renglon_area integer,
  cantidad_renglon double precision DEFAULT 0,
  id_item_area integer,
  id_convocatoria_aa integer,
  id_acto_apertura integer,
  inicio_acto_apertura timestamp without time zone,
  fecha_acto_apertura date,
  fin_acto_apertura timestamp without time zone,
  oficina_acto_apertura character varying,
  lugar_acto_apertura character varying,
  identificador_acto_apertura character varying,
  estado_acto_apertura character varying,
  id_acto_apertura_de integer,
  fecha_creacion_dictamen date,
  fecha_generacion_dictamen date,
  identificador_dictamen character varying,
  estado_dictamen character varying,
  -- Adjudicacion
  id_renglon_ad integer,
  estado_adjudicacion character varying,
  identificador_adjudicacion character varying,
  id_proveedor integer,
  cantidad_ad double precision DEFAULT 0,
  monto_unitario double precision DEFAULT 0,
  id_adjudicacion integer, -- Clave para Orden de Compra
  -- Orden de Compra
  id_renglon_area_oc integer,
  id_detalle_orden_compra_oc integer,
  id_proveedor_oc integer,
  id_area_oc integer,
  estado_orden_compra character varying,
  identificador_orden_compra character varying,
  fecha_emision_oc date,
  id_lugar_entrega_oc integer,
  cantidad_oc double precision DEFAULT 0,
  monto_unitario_oc double precision DEFAULT 0,
  id_adjudicacion_oc integer, -- Clave para Adjudicacion
  -- Recepciones
  id_detalle_orden_compra_re integer,
  fecha_recepcion date,
  estado_recepcion character varying,
  remito character varying,
  factura_numero character varying,
  identificador_acta_provisoria_recepcion character varying,
  fecha_acta_provisoria_re date,
  id_area_re integer,
  identificador_acta_definitiva_recepcion character varying,
  fecha_acta_definitiva_re date,
  cantidad_recibida double precision DEFAULT 0,
  cantidad_aceptada double precision DEFAULT 0,
  cantidad_rechazada double precision DEFAULT 0,
  importe_total_solicitud double precision DEFAULT 0,
  importe_total_convocatoria double precision DEFAULT 0,
  importe_total_adjudicado double precision DEFAULT 0,
  importe_total_oc double precision DEFAULT 0,
  unidad_generica_id integer,
  CONSTRAINT ft_compras_pkey PRIMARY KEY (id_compras)
);
CREATE TABLE diaguita.d_procedimiento_modalidades
(
  id_procedimiento_modalidad integer not null,
  nombre character varying,
  CONSTRAINT d_procedimiento_modalidad_pkey PRIMARY KEY (id_procedimiento_modalidad)
);
CREATE TABLE diaguita.d_procedimiento_clases
(
  id_procedimiento_clase integer not null,
  nombre character varying,
  CONSTRAINT d_procedimiento_clase_pkey PRIMARY KEY (id_procedimiento_clase)
);
--Agrega la dimension de responsable de uso de patrimonio
CREATE TABLE diaguita_tmp.d_responsable
(
  responsable_codigo text,
  responsable_desc text,
  cuil text
);

CREATE TABLE diaguita_dsa.d_responsable
(
  responsable_id serial NOT NULL,
  responsable_codigo text,
  responsable_desc text,
  cuil text,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone
);

CREATE TABLE diaguita.d_responsable
(
  responsable_id serial NOT NULL,
  responsable_codigo text,
  responsable_desc text,
  cuil text,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT pk_d_responsable PRIMARY KEY (responsable_id)
);


--Agrega el responsable de uso a la tabla de patrimonio.
ALTER TABLE diaguita_tmp.ft_patrimonio ADD COLUMN id_empleado_responsable_uso text;
ALTER TABLE diaguita_dsa.ft_patrimonio ADD COLUMN responsable_uso_id integer;
ALTER TABLE diaguita.ft_patrimonio ADD COLUMN responsable_uso_id integer;  
-----------------------------
-----------------------------
-----------------------------

----------------------------- 
--     Pilaga  
----------------------------- 
--Agrega los importes de devengado y pagado de deuda exigible.
ALTER TABLE pilaga_tmp.ft_movimientos_gastos ADD COLUMN devengado_ex numeric;
ALTER TABLE pilaga_tmp.ft_movimientos_gastos ADD COLUMN pagado_ex numeric;
ALTER TABLE pilaga_dsa.ft_movimientos_gastos ADD COLUMN devengado_ex numeric(13,2);
ALTER TABLE pilaga_dsa.ft_movimientos_gastos ADD COLUMN pagado_ex numeric(13,2);
ALTER TABLE pilaga.ft_movimientos ADD COLUMN devengado_ex numeric(13,2);
ALTER TABLE pilaga.ft_movimientos ADD COLUMN pagado_ex numeric(13,2);
-----------------------------
-----------------------------
--Agrega campos banco y sucursal para completar la cuenta bancaria
ALTER TABLE pilaga_tmp.ft_tesorerias ADD COLUMN bancocb text;
ALTER TABLE pilaga_tmp.ft_tesorerias ADD COLUMN sucursalcb text;
-----------------------------
-----------------------------
--Agrega campos para completar jerarquia de rubro ingreso
ALTER TABLE pilaga_tmp.d_rubro_ingreso ADD COLUMN grupo_desc text;
ALTER TABLE pilaga_tmp.d_rubro_ingreso ADD COLUMN rubro_desc text;
ALTER TABLE pilaga_tmp.d_rubro_ingreso ADD COLUMN tipo_desc text;
ALTER TABLE pilaga_tmp.d_rubro_ingreso ADD COLUMN clase_desc text;
ALTER TABLE pilaga_dsa.d_rubro_ingreso ADD COLUMN grupo_desc character varying;
ALTER TABLE pilaga_dsa.d_rubro_ingreso ADD COLUMN rubro_desc character varying;
ALTER TABLE pilaga_dsa.d_rubro_ingreso ADD COLUMN tipo_desc character varying;
ALTER TABLE pilaga_dsa.d_rubro_ingreso ADD COLUMN clase_desc character varying;
ALTER TABLE pilaga.d_rubro_ingreso ADD COLUMN grupo_desc character varying;
ALTER TABLE pilaga.d_rubro_ingreso ADD COLUMN rubro_desc character varying;
ALTER TABLE pilaga.d_rubro_ingreso ADD COLUMN tipo_desc character varying;
ALTER TABLE pilaga.d_rubro_ingreso ADD COLUMN clase_desc character varying;

---------------------------------- 
--     Pilaga Servicios Publicos
---------------------------------- 
--Tablas del esquema pilaga_tmp

--d_factura;
CREATE TABLE pilaga_tmp.d_factura
(
  comprobante_codigo text,
  fecha_prox_venc date,
  periodo_desde date,
  periodo_hasta date
);


--d_servicio_publico;
CREATE TABLE pilaga_tmp.d_servicio_publico
(
  servicio_publico_codigo text,
  servicio_publico_desc text
);


--d_concepto_sp;
CREATE TABLE pilaga_tmp.d_concepto_sp
(
  concepto_sp_codigo text,
  concepto_sp_desc text
);


--d_medidor;
CREATE TABLE pilaga_tmp.d_medidor
(
  medidor_codigo text,
  medidor_numero text
);


--d_unidad_medida;
CREATE TABLE pilaga_tmp.d_unidad_medida
(
  unidad_medida_codigo text,
  unidad_medida_desc text
);


--d_edificio;
CREATE TABLE pilaga_tmp.d_edificio
(
  edificio_codigo text,
  edificio_desc text
);

--ft_servicios_publicos;
CREATE TABLE pilaga_tmp.ft_servicios_publicos
(
  tramite integer,
  paso integer,
  paso_anterior integer,
  fecha_valor date,
  tipo_contenedor text,
  anio_contenedor integer,
  nro_contenedor text,
  ejercicio integer,
  fecha_movimiento date,
  fecha_vencimiento date,
  concepto_desc text,
  tipo_ejercicio text,
  codup text,
  codgru text,
  codfuente text,
  codinciso text,
  coddec text,
  codprog text,
  codfun text,
  codfi text,
  devengado numeric,
  moneda text,
  codpersona text,
  tipo_doc_ppal text,
  nro_doc_ppal text,
  anio_doc_ppal integer,
  tipo_operacion text,
  estado_liquidacion_codigo text,
  mes integer,
  comprobante_codigo text,
  comprobante_tipo_codigo text,
  numero text,
  anio integer,
  medidor_codigo text,
  concepto_codigo text,
  servicio_publico_codigo text,
  unidad_medida_codigo text,
  unidad_presupuestaria_medidor_codigo text,
  edificio_codigo text,
  devengado_total numeric,
  devengado_partida numeric,
  importe_total_comprobante numeric,
  porc_dev_partida numeric,
  importe_porc numeric,
  consumo numeric,
  importe numeric,
  consumo_calculado numeric,
  importe_calculado numeric,
  periodo text,
  periodo_desde date,
  periodo_hasta date,
  dias_totales integer,
  dias_periodo integer,
  importe_final numeric,
  consumo_final numeric
);

--Tablas del esquema pilaga_dsa

--d_concepto_sp;
CREATE TABLE pilaga_dsa.d_concepto_sp
(
  concepto_sp_id integer NOT NULL,
  concepto_sp_codigo character varying,
  concepto_sp_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT pk_d_concepto_sp PRIMARY KEY (concepto_sp_id)
);


--d_edificio;
CREATE TABLE pilaga_dsa.d_edificio
(
  edificio_id integer NOT NULL,
  edificio_codigo character varying,
  edificio_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT pk_d_edificio PRIMARY KEY (edificio_id)
);


--d_medidor;
CREATE TABLE pilaga_dsa.d_medidor
(
  medidor_id integer NOT NULL,
  medidor_codigo character varying,
  medidor_numero character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT pk_d_medidor PRIMARY KEY (medidor_id)
);


--d_servicio_publico;
CREATE TABLE pilaga_dsa.d_servicio_publico
(
  servicio_publico_id integer NOT NULL,
  servicio_publico_codigo character varying,
  servicio_publico_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT pk_d_servicio_publico PRIMARY KEY (servicio_publico_id)
);


--d_unidad_medida;
CREATE TABLE pilaga_dsa.d_unidad_medida
(
  unidad_medida_id integer NOT NULL,
  unidad_medida_codigo character varying,
  unidad_medida_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT pk_d_unidad_medida PRIMARY KEY (unidad_medida_id)
);

--ft_servicios_publicos;
CREATE TABLE pilaga_dsa.ft_servicios_publicos
(
  fecha_id date,
  expediente_id integer,
  fecha_vencimiento_id date,
  concepto_id integer,
  ejercicio_id integer,
  unidad_gestion_id integer,
  unidad_presupuestaria_id integer,
  grupo_presupuestario_id integer,
  fuente_id integer,
  objeto_del_gasto_id integer,
  codigo_economico_id integer,
  red_programatica_id integer,
  finalidad_funcion_id integer,
  moneda_id integer,
  persona_id integer,
  tipo_persona_id integer,
  tipo_documento_id integer,
  documento_principal_id integer,
  tipo_operacion_id integer,
  estado_liquidacion_id integer,
  comprobante_id integer,
  medidor_id integer,
  concepto_sp_id integer,
  servicio_publico_id integer,
  unidad_medida_id integer,
  unidad_presupuestaria_medidor_id integer,
  edificio_id integer,
  periodo_id integer,
  importe numeric(13,2),
  consumo numeric(13,2)
);


--Tablas del esquema pilaga
--d_concepto_sp;
CREATE TABLE pilaga.d_concepto_sp
(
  concepto_sp_id integer NOT NULL,
  concepto_sp_codigo character varying,
  concepto_sp_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT pk_d_concepto_sp PRIMARY KEY (concepto_sp_id)
);

--d_edificio;
CREATE TABLE pilaga.d_edificio
(
  edificio_id integer NOT NULL,
  edificio_codigo character varying,
  edificio_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT pk_d_edificio PRIMARY KEY (edificio_id)
);


--d_medidor;
CREATE TABLE pilaga.d_medidor
(
  medidor_id integer NOT NULL,
  medidor_codigo character varying,
  medidor_numero character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT pk_d_medidor PRIMARY KEY (medidor_id)
);


--d_servicio_publico;
CREATE TABLE pilaga.d_servicio_publico
(
  servicio_publico_id integer NOT NULL,
  servicio_publico_codigo character varying,
  servicio_publico_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT pk_d_servicio_publico PRIMARY KEY (servicio_publico_id)
);


--d_unidad_medida;
CREATE TABLE pilaga.d_unidad_medida
(
  unidad_medida_id integer NOT NULL,
  unidad_medida_codigo character varying,
  unidad_medida_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT pk_d_unidad_medida PRIMARY KEY (unidad_medida_id)
);


--ft_servicios_publicos;
CREATE TABLE pilaga.ft_servicios_publicos
(
  id serial NOT NULL,
  importacion_id integer,
  unidad_generica_id integer,
  fecha_id date,
  expediente_id integer,
  fecha_vencimiento_id date,
  concepto_id integer,
  ejercicio_id integer,
  unidad_gestion_id integer,
  unidad_presupuestaria_id integer,
  grupo_presupuestario_id integer,
  fuente_id integer,
  objeto_del_gasto_id integer,
  codigo_economico_id integer,
  red_programatica_id integer,
  finalidad_funcion_id integer,
  moneda_id integer,
  persona_id integer,
  tipo_persona_id integer,
  tipo_documento_id integer,
  documento_principal_id integer,
  tipo_operacion_id integer,
  estado_liquidacion_id integer,
  comprobante_id integer,
  medidor_id integer,
  concepto_sp_id integer,
  servicio_publico_id integer,
  unidad_medida_id integer,
  unidad_presupuestaria_medidor_id integer,
  edificio_id integer,
  periodo_id integer,
  importe numeric,
  consumo numeric
);


--Agrega la fuente de datos
INSERT INTO d_fuente_dato(fuente_dato_id, fuente_dato_desc)   VALUES (11, 'SIGEVA');
INSERT INTO d_fuente_dato(fuente_dato_id, fuente_dato_desc)   VALUES (12, 'SIU-Sanavirón/Quilmes');

--------------------------------------------------------------
--SIU-Sanavirón/Quilmes
--------------------------------------------------------------
create schema sq_tmp;


create table sq_tmp.d_canal_venta(
	id text,
	codigo text,
	descripcion text
	);

create table sq_tmp.d_cliente(
	id text,
	nombre text,
	identificacion text,
	es_persona_fisica text,
	id_global text
	);

create table sq_tmp.d_condicion_venta(
	id text,
	codigo text,
	descripcion text
	);

create table sq_tmp.d_consumidor(
	id text,
	nombre text,
	identificacion text,
	es_persona_fisica text
	);

create table sq_tmp.d_medio_pago(
	id text,
	codigo text,
	descripcion text,
	codigo_tipo_mp text,
	descripcion_tipo_mp text,
	cuenta_tesoreria text,
	tesoreria text
	);


create table sq_tmp.d_unidad_venta(
	id text,
	unidad_venta_codigo text,
	unidad_venta_descripcion text,
	unidad_negocio_codigo text,
	unidad_negocio_descripcion text
	);

create table sq_tmp.d_venta_estado(
	id text,
	codigo text,
	descripcion text
	);

create table sq_tmp.ft_ventas(
	id_venta text,
	id_unidad_venta text,
	id_cliente text,
	id_canal_venta text,
	id_condicion_venta text,
	id_venta_estado text,
	id_medio_pago text,
	cobrado_en_id date, 
	reportado_pilaga text,
	id_consumidor text,
	fecha_id date,
	importe_total text,
	importe_total_a_cobrar text,
	importe_total_cobrado text
	);


create schema sq_dsa;

create table sq_dsa.d_canal_venta(
	canal_venta_id serial,
	canal_venta_id_sq integer,
	canal_venta_codigo character varying,
	canal_venta_desc character varying
	,instalacion_id integer
	,fecha_desde date
  	,fecha_hasta date
	,version integer
  	,vigente character varying
  	,fecha_actualizacion timestamp without time zone
	);

create table sq_dsa.d_cliente(
	cliente_id serial,
	cliente_id_sq integer,
	nombre character varying,
	identificacion character varying,
	es_persona_fisica character varying,
	id_global character varying
	,fecha_desde date
  	,fecha_hasta date
	,version integer
  	,vigente character varying
  	,fecha_actualizacion timestamp without time zone
	);


create table sq_dsa.d_condicion_venta(
	condicion_venta_id serial,
	condicion_venta_id_sq integer,
	condicion_venta_codigo character varying,
	condicion_venta_desc character varying
	,fecha_desde date
  	,fecha_hasta date
	,version integer
  	,vigente character varying
  	,fecha_actualizacion timestamp without time zone
	);

create table sq_dsa.d_consumidor(
	consumidor_id serial,
	consumidor_id_sq integer, 
	nombre character varying,
	identificacion character varying,
	es_persona_fisica character varying
	,fecha_desde date
  	,fecha_hasta date
	,version integer
  	,vigente character varying
  	,fecha_actualizacion timestamp without time zone
	);

create table sq_dsa.d_medio_pago(
	medio_pago_id serial,
	medio_pago_id_sq integer,
	medio_pago_codigo character varying,
	medio_pago_desc character varying,
	codigo_tipo_mp character varying ,
	descripcion_tipo_mp character varying,
	cuenta_tesoreria character varying,
	tesoreria character varying
	,fecha_desde date
  	,fecha_hasta date
	,version integer
  	,vigente character varying
  	,fecha_actualizacion timestamp without time zone
	);


create table sq_dsa.d_unidad_venta(
	unidad_venta_id serial,
	unidad_venta_id_sq integer,
	unidad_venta_codigo character varying,
	unidad_venta_desc character varying,
	unidad_negocio_codigo character varying,
	unidad_negocio_desc character varying
	,fecha_desde date
  	,fecha_hasta date
	,version integer
  	,vigente character varying
  	,fecha_actualizacion timestamp without time zone
	);

create table sq_dsa.d_venta_estado(
	venta_estado_id serial,
	venta_estado_id_sq integer,
	venta_estado_codigo character varying,
	venta_estado_desc character varying
	,fecha_desde date
  	,fecha_hasta date
	,version integer
  	,vigente character varying
  	,fecha_actualizacion timestamp without time zone
	);


create table sq_dsa.ft_ventas(
	id serial,
	venta_id integer NOT NULL,
	unidad_venta_id integer NOT NULL,
	cliente_id integer NOT NULL,
	canal_venta_id integer NOT NULL,
	condicion_venta_id integer NOT NULL,
	venta_estado_id integer NOT NULL,
	cobrado_en_id date NOT NULL, 
	reportado_pilaga character varying,
	medio_pago_id integer NOT NULL,
	consumidor_id integer NOT NULL,
	fecha_id date NOT NULL,
	importe_total numeric(20,4),
	importe_total_a_cobrar numeric(20,4),
	importe_total_cobrado numeric(20,4)
	);

create schema sq;


create table sq.d_canal_venta(
	canal_venta_id serial,
	canal_venta_id_sq integer,
	canal_venta_codigo character varying,
	canal_venta_desc character varying
	,instalacion_id integer
	,fecha_desde date
  	,fecha_hasta date
	,version integer
  	,vigente character varying
  	,fecha_actualizacion timestamp without time zone
	);

create table sq.d_cliente(
	cliente_id serial,
	cliente_id_sq integer,
	nombre character varying,
	identificacion character varying,
	es_persona_fisica character varying,
	id_global character varying
	,fecha_desde date
  	,fecha_hasta date
	,version integer
  	,vigente character varying
  	,fecha_actualizacion timestamp without time zone
	);

create table sq.d_condicion_venta(
	condicion_venta_id serial,
	condicion_venta_id_sq integer,
	condicion_venta_codigo character varying,
	condicion_venta_desc character varying
	,fecha_desde date
  	,fecha_hasta date
	,version integer
  	,vigente character varying
  	,fecha_actualizacion timestamp without time zone
	);


create table sq.d_consumidor(
	consumidor_id serial,
	consumidor_id_sq integer, 
	nombre character varying,
	identificacion character varying,
	es_persona_fisica character varying
	,fecha_desde date
  	,fecha_hasta date
	,version integer
  	,vigente character varying
  	,fecha_actualizacion timestamp without time zone
	);

create table sq.d_medio_pago(
	medio_pago_id serial,
	medio_pago_id_sq integer,
	medio_pago_codigo character varying,
	medio_pago_desc character varying,
	codigo_tipo_mp character varying ,
	descripcion_tipo_mp character varying,
	cuenta_tesoreria character varying,
	tesoreria character varying
	,fecha_desde date
  	,fecha_hasta date
	,version integer
  	,vigente character varying
  	,fecha_actualizacion timestamp without time zone
	);


create table sq.d_unidad_venta(
	unidad_venta_id serial,
	unidad_venta_id_sq integer,
	unidad_venta_codigo character varying,
	unidad_venta_desc character varying,
	unidad_negocio_codigo character varying,
	unidad_negocio_desc character varying
	,fecha_desde date
  	,fecha_hasta date
	,version integer
  	,vigente character varying
  	,fecha_actualizacion timestamp without time zone
	);

create table sq.d_venta_estado(
	venta_estado_id serial,
	venta_estado_id_sq integer,
	venta_estado_codigo character varying,
	venta_estado_desc character varying
	,fecha_desde date
  	,fecha_hasta date
	,version integer
  	,vigente character varying
  	,fecha_actualizacion timestamp without time zone
	);

create table sq.ft_ventas(
	id serial,
	venta_id integer NOT NULL,
	unidad_venta_id integer NOT NULL,
	cliente_id integer NOT NULL,
	canal_venta_id integer NOT NULL,
	condicion_venta_id integer NOT NULL,
	venta_estado_id integer NOT NULL,
	cobrado_en_id date NOT NULL, 
	reportado_pilaga character varying,
	medio_pago_id integer NOT NULL,
	consumidor_id integer NOT NULL,
	fecha_id date NOT NULL,
	unidad_generica_id integer NOT NULL,
	importacion_id integer NOT NULL,
	importe_total numeric(20,4),
	importe_total_a_cobrar numeric(20,4),
	importe_total_cobrado numeric(20,4)
	);

---------------------------------------------------------
--- GUARANI 2
---------------------------------------------------------
--Cambia el tipo de dato de legajo en FT_ALumnos_Arau

ALTER TABLE guarani_tmp.gua_dsa_ft_alumnosarau ALTER COLUMN legajo TYPE character varying; 

--Quita restriccion de no nulo en las medidas
ALTER TABLE guarani_dsa.gua_dsa_ids_ft_alumnosarau ALTER COLUMN nuevosinscriptos DROP NOT NULL;
ALTER TABLE guarani_dsa.gua_dsa_ids_ft_alumnosarau ALTER COLUMN reinscriptos DROP NOT NULL;
ALTER TABLE guarani_dsa.gua_dsa_ids_ft_alumnosarau ALTER COLUMN egresados DROP NOT NULL;

ALTER TABLE guarani.gua_dw_ft_alumnosarau ALTER COLUMN nuevosinscriptos DROP NOT NULL;
ALTER TABLE guarani.gua_dw_ft_alumnosarau ALTER COLUMN reinscriptos DROP NOT NULL;
ALTER TABLE guarani.gua_dw_ft_alumnosarau ALTER COLUMN egresados DROP NOT NULL;

-- Asigna nulos donde tenia valores 0
UPDATE guarani.gua_dw_ft_alumnosarau SET  nuevosinscriptos= null WHERE nuevosinscriptos = 0;
UPDATE guarani.gua_dw_ft_alumnosarau SET  reinscriptos= null WHERE reinscriptos = 0;
UPDATE guarani.gua_dw_ft_alumnosarau SET  egresados= null WHERE egresados = 0;

--Borro columna con totales, ya que las calcula el cubo
ALTER TABLE guarani_dsa.gua_dsa_ids_ft_alumnosarau DROP COLUMN totalalumnos;
ALTER TABLE guarani.gua_dw_ft_alumnosarau DROP COLUMN totalalumnos;



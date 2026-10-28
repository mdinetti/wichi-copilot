-- Este script es parte de la migración de SIU-Wichi 5.4.0 a 5.5.0.

-- ----------------------------------
-- instalaciones y estructura general
-- ----------------------------------

CREATE TABLE public.d_instalacion
(
  instalacion_id serial not null,
  instalacion_desc text,
  instalacion_codigo text default cast(trunc(random()*1000) as text),
  fuente_dato_id integer not null,
  CONSTRAINT d_instalacion_pkey PRIMARY KEY (instalacion_id),
  CONSTRAINT d_instalacion_fuente_dato_fkey FOREIGN KEY (fuente_dato_id)
      REFERENCES d_fuente_dato (fuente_dato_id)
);

CREATE TABLE public.parametro_instalacion
(
  instalacion_id integer not null,
  nombre text not null,
  valor text,
  CONSTRAINT d_parametro_instalacion_pkey PRIMARY KEY (instalacion_id, nombre),
  CONSTRAINT d_parametro_instalacion_instalacion_fkey FOREIGN KEY (instalacion_id)
      REFERENCES d_instalacion (instalacion_id)
);

alter table public.d_unidad
  add column instalacion_id integer,
  add CONSTRAINT d_unidad_instalacion_id_fkey FOREIGN KEY (instalacion_id)
      REFERENCES d_instalacion (instalacion_id)
      ON UPDATE NO ACTION ON DELETE NO ACTION;


-- ----------------------------------
-- datos iniciales
-- ----------------------------------

insert into d_fuente_dato (
  fuente_dato_id, fuente_dato_desc)
values
  (-1, 'VALOR ERRONEO');

insert into d_instalacion (
  instalacion_id,
  instalacion_desc,
  instalacion_codigo,
  fuente_dato_id)
values
  (-1, 'VALOR ERRONEO', 'VALOR ERRONEO', -1);

-- ----------------------------------
-- Se agrega Kolla en d_fuente_dato
-- ----------------------------------

INSERT INTO public.d_fuente_dato (fuente_dato_id, fuente_dato_desc)
VALUES (9,'SIU-Kolla');

-- ----------------------------------
-- pilaga
-- ----------------------------------

ALTER TABLE pilaga_dsa.d_unidad_presupuestaria
  ADD instalacion_id INTEGER;

ALTER TABLE pilaga.d_unidad_presupuestaria
  ADD instalacion_id INTEGER;

-- ----------------------------------
-- diaguita
-- ----------------------------------

create table diaguita_tmp.d_tipo_documento(
  tipo_documento_codigo text,
  tipo_documento_desc text,
  ejercicio integer
);

create table diaguita_tmp.d_expediente(
  expediente_codigo text,
  expediente_desc text
);

create table diaguita_tmp.d_numero_anterior(
  numero_anterior_codigo text,
  numero_anterior_desc text
);

alter table diaguita_tmp.ft_patrimonio
  add tipo_documento text,
  add expediente text,
  add numero_anterior text;

create table diaguita_dsa.d_tipo_documento(
  tipo_documento_id serial,  
  tipo_documento_codigo text,
  tipo_documento_desc text
  ,fecha_desde date
  ,fecha_hasta date
  ,version integer
  ,vigente character varying
  ,fecha_actualizacion timestamp without time zone
);

create table diaguita_dsa.d_expediente(
  expediente_id serial,  
  expediente_codigo text,
  expediente_desc text
  ,fecha_desde date
  ,fecha_hasta date
  ,version integer
  ,vigente character varying
  ,fecha_actualizacion timestamp without time zone
);

create table diaguita_dsa.d_numero_anterior(
  numero_anterior_id serial,  
  numero_anterior_codigo text,
  numero_anterior_desc text
  ,fecha_desde date
  ,fecha_hasta date
  ,version integer
  ,vigente character varying
  ,fecha_actualizacion timestamp without time zone
);

alter table diaguita_dsa.ft_patrimonio
  add tipo_documento_id integer,
  add expediente_id integer,
  add numero_anterior_id integer;

create table diaguita.d_tipo_documento(
  tipo_documento_id serial,  
  tipo_documento_codigo text,
  tipo_documento_desc text
  ,fecha_desde date
  ,fecha_hasta date
  ,version integer
  ,vigente character varying
  ,fecha_actualizacion timestamp without time zone
  ,CONSTRAINT pk_d_tipo_documento PRIMARY KEY (tipo_documento_id)
);

create table diaguita.d_expediente(
  expediente_id serial,  
  expediente_codigo text,
  expediente_desc text
  ,fecha_desde date
  ,fecha_hasta date
  ,version integer
  ,vigente character varying
  ,fecha_actualizacion timestamp without time zone
  ,CONSTRAINT pk_d_expediente PRIMARY KEY (expediente_id)
);

create table diaguita.d_numero_anterior(
  numero_anterior_id serial,  
  numero_anterior_codigo text,
  numero_anterior_desc text
  ,fecha_desde date
  ,fecha_hasta date
  ,version integer
  ,vigente character varying
  ,fecha_actualizacion timestamp without time zone
  ,CONSTRAINT pk_d_numero_anterior PRIMARY KEY (numero_anterior_id)
);

alter table diaguita.ft_patrimonio
  add tipo_documento_id integer,
  add expediente_id integer,
  add numero_anterior_id integer;

alter table diaguita.d_area
  ADD instalacion_id INTEGER;

alter table diaguita_dsa.d_area
  ADD instalacion_id INTEGER;


  
  -- ----------------------------------
-- rhun
-- ----------------------------------

alter table rhun.d_persona
  drop inicial;

alter table rhun_dsa.d_persona
  drop inicial;

-- ----------------------------------
-- mapuche
-- ----------------------------------

alter table mapuche_tmp.map_dsa_ft_lt_legajos
  add cuil character varying;
  
alter table mapuche_dsa.map_dsa_ids_lt_persona
  drop letra;
alter table mapuche_dsa.map_dsa_ids_lt_persona 
  add cuil character varying;
  
alter table mapuche.map_dw_lt_persona
  drop letra;
alter table mapuche.map_dw_lt_persona 
  add cuil character varying;

ALTER TABLE mapuche_dsa.map_dsa_ids_lt_dependenciadesig
  ADD instalacion_id INTEGER;

ALTER TABLE mapuche.map_dw_lt_dependenciadesig
  ADD instalacion_id INTEGER;

-- ----------------------------------
-- kolla
-- ----------------------------------
-- Crea tablas del esquema kolla_tmp
CREATE SCHEMA kolla_tmp;

CREATE TABLE kolla_tmp.aux_strings (
    id serial NOT NULL,
    tipo character varying,
    texto character varying,
    CONSTRAINT pk_aux_strings PRIMARY KEY (id)
);

CREATE TABLE kolla_tmp.d_encuesta (
    id serial NOT NULL,
    instalacion_id character varying NOT NULL,
    encuesta_codigo character varying NOT NULL,
    encuesta_desc character varying NOT NULL,
    habilitacion character varying NOT NULL,
    encuesta_periodo character varying NOT NULL,
    unidad_gestion_desc character varying NOT NULL
);

CREATE TABLE kolla_tmp.d_pregunta_respuesta (
    id serial NOT NULL,
    instalacion_id character varying NOT NULL,
    pregunta_codigo character varying NOT NULL,
    pregunta_desc character varying NOT NULL,
    respuesta_codigo character varying,
    respuesta_desc character varying,
    respuesta_codigo_combinado character varying
);


CREATE TABLE kolla_tmp.ft_encuesta_datos (
    id serial NOT NULL,
    instalacion_id character varying NOT NULL,
    encuestado_codigo character varying NOT NULL,
    encuesta_codigo character varying NOT NULL,
    habilitacion character varying NOT NULL,
    pregunta_codigo character varying NOT NULL,
    respuesta_codigo character varying,
    respuesta_valor character varying,
    posicion character varying,
    bloque_codigo character varying,
    fecha date
);

CREATE TABLE kolla_tmp.posiciones (
    id serial NOT NULL,
    instalacion_id character varying NOT NULL,
    encuesta_codigo character varying NOT NULL,
    pregunta_codigo character varying NOT NULL,
    posicion character varying NOT NULL,
    bloque_codigo character varying
);

--Crea el esquema kolla_dsa
CREATE SCHEMA kolla_dsa;

CREATE TABLE kolla_dsa.d_encuesta (
    encuesta_id serial NOT NULL, -- ojo, era una secuencia, lo pase a serial
    instalacion_id integer NOT NULL,
    encuesta_codigo integer NOT NULL,
    encuesta_desc character varying NOT NULL,
    habilitacion character varying NOT NULL,
    encuesta_periodo character varying NOT NULL,
    unidad_gestion_desc character varying NOT NULL,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone,
    CONSTRAINT pk_d_encuesta PRIMARY KEY (encuesta_id)
);

CREATE TABLE kolla_dsa.d_pregunta_respuesta (
    pregunta_respuesta_id serial NOT NULL,
    instalacion_id integer NOT NULL,
    pregunta_codigo integer NOT NULL,
    pregunta_desc character varying NOT NULL,
    respuesta_codigo integer,
    respuesta_desc character varying,
    respuesta_codigo_combinado character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone,
    CONSTRAINT pk_d_pregunta_respuesta PRIMARY KEY (pregunta_respuesta_id)
);

CREATE TABLE kolla_dsa.ft_entrevista (
    entrevista_id serial NOT NULL,
    encuesta_id integer NOT NULL,
    encuestado_id integer NOT NULL,
    instalacion_id integer NOT NULL,
    unidad_generica_id integer NOT NULL,
    fecha_id date NOT NULL,
    pregunta_1 integer,
    pregunta_2 integer,
    pregunta_3 integer,
    pregunta_4 integer,
    pregunta_5 integer,
    pregunta_6 integer,
    pregunta_7 integer,
    pregunta_8 integer,
    pregunta_9 integer,
    pregunta_10 integer,
    pregunta_11 integer,
    pregunta_12 integer,
    pregunta_13 integer,
    pregunta_14 integer,
    pregunta_15 integer,
    pregunta_16 integer,
    pregunta_17 integer,
    pregunta_18 integer,
    pregunta_19 integer,
    pregunta_20 integer,
    pregunta_21 integer,
    pregunta_22 integer,
    pregunta_23 integer,
    pregunta_24 integer,
    pregunta_25 integer,
    pregunta_26 integer,
    pregunta_27 integer,
    pregunta_28 integer,
    pregunta_29 integer,
    pregunta_30 integer,
    pregunta_31 integer,
    pregunta_32 integer,
    pregunta_33 integer,
    pregunta_34 integer,
    pregunta_35 integer,
    pregunta_36 integer,
    pregunta_37 integer,
    pregunta_38 integer,
    pregunta_39 integer,
    pregunta_40 integer,
    pregunta_41 integer,
    pregunta_42 integer,
    pregunta_43 integer,
    pregunta_44 integer,
    pregunta_45 integer,
    pregunta_46 integer,
    pregunta_47 integer,
    pregunta_48 integer,
    pregunta_49 integer,
    pregunta_50 integer,
    pregunta_51 integer,
    pregunta_52 integer,
    pregunta_53 integer,
    pregunta_54 integer,
    pregunta_55 integer,
    pregunta_56 integer,
    pregunta_57 integer,
    pregunta_58 integer,
    pregunta_59 integer,
    pregunta_60 integer,
    pregunta_61 integer,
    pregunta_62 integer,
    pregunta_63 integer,
    pregunta_64 integer,
    pregunta_65 integer,
    pregunta_66 integer,
    pregunta_67 integer,
    pregunta_68 integer,
    pregunta_69 integer,
    pregunta_70 integer,
    pregunta_71 integer,
    pregunta_72 integer,
    pregunta_73 integer,
    pregunta_74 integer,
    pregunta_75 integer,
    pregunta_76 integer,
    pregunta_77 integer,
    pregunta_78 integer,
    pregunta_79 integer,
    pregunta_80 integer,
    pregunta_81 integer,
    pregunta_82 integer,
    pregunta_83 integer,
    pregunta_84 integer,
    pregunta_85 integer,
    pregunta_86 integer,
    pregunta_87 integer,
    pregunta_88 integer,
    pregunta_89 integer,
    pregunta_90 integer,
    pregunta_91 integer,
    pregunta_92 integer,
    pregunta_93 integer,
    pregunta_94 integer,
    pregunta_95 integer,
    pregunta_96 integer,
    pregunta_97 integer,
    pregunta_98 integer,
    pregunta_99 integer,
    pregunta_100 integer,
    pregunta_101 integer,
    pregunta_102 integer,
    pregunta_103 integer,
    pregunta_104 integer,
    pregunta_105 integer,
    pregunta_106 integer,
    pregunta_107 integer,
    pregunta_108 integer,
    pregunta_109 integer,
    pregunta_110 integer,
    pregunta_111 integer,
    pregunta_112 integer,
    pregunta_113 integer,
    pregunta_114 integer,
    pregunta_115 integer,
    pregunta_116 integer,
    pregunta_117 integer,
    pregunta_118 integer,
    pregunta_119 integer,
    pregunta_120 integer,
    pregunta_121 integer,
    pregunta_122 integer,
    pregunta_123 integer,
    pregunta_124 integer,
    pregunta_125 integer,
    pregunta_126 integer,
    pregunta_127 integer,
    pregunta_128 integer,
    pregunta_129 integer,
    pregunta_130 integer,
    pregunta_131 integer,
    pregunta_132 integer,
    pregunta_133 integer,
    pregunta_134 integer,
    pregunta_135 integer,
    pregunta_136 integer,
    pregunta_137 integer,
    pregunta_138 integer,
    pregunta_139 integer,
    pregunta_140 integer,
    pregunta_141 integer,
    pregunta_142 integer,
    pregunta_143 integer,
    pregunta_144 integer,
    pregunta_145 integer,
    pregunta_146 integer,
    pregunta_147 integer,
    pregunta_148 integer,
    pregunta_149 integer,
    pregunta_150 integer,
    pregunta_151 integer,
    pregunta_152 integer,
    pregunta_153 integer,
    pregunta_154 integer,
    pregunta_155 integer,
    pregunta_156 integer,
    pregunta_157 integer,
    pregunta_158 integer,
    pregunta_159 integer,
    pregunta_160 integer,
    pregunta_161 integer,
    pregunta_162 integer,
    pregunta_163 integer,
    pregunta_164 integer,
    pregunta_165 integer,
    pregunta_166 integer,
    pregunta_167 integer,
    pregunta_168 integer,
    pregunta_169 integer,
    pregunta_170 integer,
    pregunta_171 integer,
    pregunta_172 integer,
    pregunta_173 integer,
    pregunta_174 integer,
    pregunta_175 integer,
    pregunta_176 integer,
    pregunta_177 integer,
    pregunta_178 integer,
    pregunta_179 integer,
    pregunta_180 integer,
    pregunta_181 integer,
    pregunta_182 integer,
    pregunta_183 integer,
    pregunta_184 integer,
    pregunta_185 integer,
    pregunta_186 integer,
    pregunta_187 integer,
    pregunta_188 integer,
    pregunta_189 integer,
    pregunta_190 integer,
    pregunta_191 integer,
    pregunta_192 integer,
    pregunta_193 integer,
    pregunta_194 integer,
    pregunta_195 integer,
    pregunta_196 integer,
    pregunta_197 integer,
    pregunta_198 integer,
    pregunta_199 integer,
    pregunta_200 integer,
    cantidad integer DEFAULT 1,
    CONSTRAINT pk_ft_encuesta PRIMARY KEY (entrevista_id)
);

--Crea el esquema kolla en dw
CREATE SCHEMA kolla;

CREATE TABLE kolla.d_encuesta (
    encuesta_id serial NOT NULL,
    instalacion_id integer NOT NULL,
    encuesta_codigo integer NOT NULL,
    encuesta_desc character varying NOT NULL,
    habilitacion character varying NOT NULL,
    encuesta_periodo character varying NOT NULL,
    unidad_gestion_desc character varying NOT NULL,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone,
    CONSTRAINT pk_d_encuesta PRIMARY KEY (encuesta_id)
);

CREATE TABLE kolla.d_pregunta_respuesta (
    pregunta_respuesta_id serial NOT NULL,
    instalacion_id integer NOT NULL,
    pregunta_codigo integer NOT NULL,
    pregunta_desc character varying NOT NULL,
    respuesta_codigo integer,
    respuesta_desc character varying,
    respuesta_codigo_combinado character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone,
    CONSTRAINT pk_d_pregunta_respuesta PRIMARY KEY (pregunta_respuesta_id)
);

CREATE TABLE kolla.ft_entrevista (
    entrevista_id serial NOT NULL,
    encuesta_id integer NOT NULL,
    encuestado_id integer NOT NULL,
    instalacion_id integer NOT NULL,
    unidad_generica_id integer NOT NULL,
    fecha_id date NOT NULL,
    pregunta_1 integer,
    pregunta_2 integer,
    pregunta_3 integer,
    pregunta_4 integer,
    pregunta_5 integer,
    pregunta_6 integer,
    pregunta_7 integer,
    pregunta_8 integer,
    pregunta_9 integer,
    pregunta_10 integer,
    pregunta_11 integer,
    pregunta_12 integer,
    pregunta_13 integer,
    pregunta_14 integer,
    pregunta_15 integer,
    pregunta_16 integer,
    pregunta_17 integer,
    pregunta_18 integer,
    pregunta_19 integer,
    pregunta_20 integer,
    pregunta_21 integer,
    pregunta_22 integer,
    pregunta_23 integer,
    pregunta_24 integer,
    pregunta_25 integer,
    pregunta_26 integer,
    pregunta_27 integer,
    pregunta_28 integer,
    pregunta_29 integer,
    pregunta_30 integer,
    pregunta_31 integer,
    pregunta_32 integer,
    pregunta_33 integer,
    pregunta_34 integer,
    pregunta_35 integer,
    pregunta_36 integer,
    pregunta_37 integer,
    pregunta_38 integer,
    pregunta_39 integer,
    pregunta_40 integer,
    pregunta_41 integer,
    pregunta_42 integer,
    pregunta_43 integer,
    pregunta_44 integer,
    pregunta_45 integer,
    pregunta_46 integer,
    pregunta_47 integer,
    pregunta_48 integer,
    pregunta_49 integer,
    pregunta_50 integer,
    pregunta_51 integer,
    pregunta_52 integer,
    pregunta_53 integer,
    pregunta_54 integer,
    pregunta_55 integer,
    pregunta_56 integer,
    pregunta_57 integer,
    pregunta_58 integer,
    pregunta_59 integer,
    pregunta_60 integer,
    pregunta_61 integer,
    pregunta_62 integer,
    pregunta_63 integer,
    pregunta_64 integer,
    pregunta_65 integer,
    pregunta_66 integer,
    pregunta_67 integer,
    pregunta_68 integer,
    pregunta_69 integer,
    pregunta_70 integer,
    pregunta_71 integer,
    pregunta_72 integer,
    pregunta_73 integer,
    pregunta_74 integer,
    pregunta_75 integer,
    pregunta_76 integer,
    pregunta_77 integer,
    pregunta_78 integer,
    pregunta_79 integer,
    pregunta_80 integer,
    pregunta_81 integer,
    pregunta_82 integer,
    pregunta_83 integer,
    pregunta_84 integer,
    pregunta_85 integer,
    pregunta_86 integer,
    pregunta_87 integer,
    pregunta_88 integer,
    pregunta_89 integer,
    pregunta_90 integer,
    pregunta_91 integer,
    pregunta_92 integer,
    pregunta_93 integer,
    pregunta_94 integer,
    pregunta_95 integer,
    pregunta_96 integer,
    pregunta_97 integer,
    pregunta_98 integer,
    pregunta_99 integer,
    pregunta_100 integer,
    pregunta_101 integer,
    pregunta_102 integer,
    pregunta_103 integer,
    pregunta_104 integer,
    pregunta_105 integer,
    pregunta_106 integer,
    pregunta_107 integer,
    pregunta_108 integer,
    pregunta_109 integer,
    pregunta_110 integer,
    pregunta_111 integer,
    pregunta_112 integer,
    pregunta_113 integer,
    pregunta_114 integer,
    pregunta_115 integer,
    pregunta_116 integer,
    pregunta_117 integer,
    pregunta_118 integer,
    pregunta_119 integer,
    pregunta_120 integer,
    pregunta_121 integer,
    pregunta_122 integer,
    pregunta_123 integer,
    pregunta_124 integer,
    pregunta_125 integer,
    pregunta_126 integer,
    pregunta_127 integer,
    pregunta_128 integer,
    pregunta_129 integer,
    pregunta_130 integer,
    pregunta_131 integer,
    pregunta_132 integer,
    pregunta_133 integer,
    pregunta_134 integer,
    pregunta_135 integer,
    pregunta_136 integer,
    pregunta_137 integer,
    pregunta_138 integer,
    pregunta_139 integer,
    pregunta_140 integer,
    pregunta_141 integer,
    pregunta_142 integer,
    pregunta_143 integer,
    pregunta_144 integer,
    pregunta_145 integer,
    pregunta_146 integer,
    pregunta_147 integer,
    pregunta_148 integer,
    pregunta_149 integer,
    pregunta_150 integer,
    pregunta_151 integer,
    pregunta_152 integer,
    pregunta_153 integer,
    pregunta_154 integer,
    pregunta_155 integer,
    pregunta_156 integer,
    pregunta_157 integer,
    pregunta_158 integer,
    pregunta_159 integer,
    pregunta_160 integer,
    pregunta_161 integer,
    pregunta_162 integer,
    pregunta_163 integer,
    pregunta_164 integer,
    pregunta_165 integer,
    pregunta_166 integer,
    pregunta_167 integer,
    pregunta_168 integer,
    pregunta_169 integer,
    pregunta_170 integer,
    pregunta_171 integer,
    pregunta_172 integer,
    pregunta_173 integer,
    pregunta_174 integer,
    pregunta_175 integer,
    pregunta_176 integer,
    pregunta_177 integer,
    pregunta_178 integer,
    pregunta_179 integer,
    pregunta_180 integer,
    pregunta_181 integer,
    pregunta_182 integer,
    pregunta_183 integer,
    pregunta_184 integer,
    pregunta_185 integer,
    pregunta_186 integer,
    pregunta_187 integer,
    pregunta_188 integer,
    pregunta_189 integer,
    pregunta_190 integer,
    pregunta_191 integer,
    pregunta_192 integer,
    pregunta_193 integer,
    pregunta_194 integer,
    pregunta_195 integer,
    pregunta_196 integer,
    pregunta_197 integer,
    pregunta_198 integer,
    pregunta_199 integer,
    pregunta_200 integer,
    cantidad integer DEFAULT 1,
    CONSTRAINT pk_ft_encuesta PRIMARY KEY (entrevista_id)
);


-- ----------------------------------
-- guarani
-- ----------------------------------

alter table guarani.gua_dw_lt_unidadesacademicas
  ADD instalacion_id INTEGER;
alter table guarani_dsa.gua_dsa_ids_lt_unidadesacademicas
  ADD instalacion_id INTEGER;


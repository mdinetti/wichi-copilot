
-- ----------------------------
-- estructura de diaguita
-- ----------------------------

--elimina de estructura vieja

drop schema if exists diaguita_tmp cascade;
drop schema if exists diaguita_dsa cascade;
drop schema if exists diaguita cascade;

--Crea el esquema diaguita_tmp

create schema diaguita_tmp;


--Crea las tablas de diaguita_tmp

create table diaguita_tmp.d_estado_bien(
  id_estado_bien text, nombre text);

create table diaguita_tmp.d_ubicacion_fisica(
  id_ubicacion_fisica text, nombre text);

create table diaguita_tmp.d_catalogo_bienes(
   id_catalogo_bien_patrimonial text
  ,id_catalogo_bien_uso_padre text
  ,codigo_completo text
  ,nombre text);

create table diaguita_tmp.d_bien_patrimonial(
   id_bien_patrimonial text
  ,numero_patrimonial text
  ,descripcion_bien text);

create table diaguita_tmp.d_motivo_alta_bien(
  id_motivo_alta text, nombre text);

create table diaguita_tmp.d_motivo_baja_bien(
  id_motivo_baja text, nombre text);

create table diaguita_tmp.d_area(
   id_area text
  ,id_area_padre text
  ,nombre text
  ,id_oficina_patrimonio text
);

create table diaguita_tmp.d_vida_util(
  vida_util text);

create table diaguita_tmp.d_tipo_bien(
  id_bien_tipo text, nombre text);

create table diaguita_tmp.d_oficina_patrimonio(
  id_oficina_patrimonio text, nombre text);

create table diaguita_tmp.ft_patrimonio(
   id_bien_patrimonial text
  ,numero_patrimonial text
  ,id_motivo_baja text
  ,fecha_alta text
  ,id_motivo_alta text
  ,id_estado_bien text
  ,id_catalogo_bien_patrimonial text
  --,id_empleado_responsable
  ,id_area_responsable text
  ,id_ubicacion_fisica text
  ,fecha_incorporacion text
  ,fecha_baja text
  ,vida_util text
  ,valor_bien text
  ,valor_residual text
  ,id_oficina_patrimonio text
  ,id_tipo_bien text
);


--Crea el esquema diaguita_dsa


create schema diaguita_dsa;


--Crea las tablas de diaguita_dsa


create table diaguita_dsa.d_estado_bien(
   estado_bien_id serial
  ,estado_bien_codigo text
  ,estado_bien_desc text
  ,fecha_desde date
  ,fecha_hasta date
  ,version integer
  ,vigente character varying
  ,fecha_actualizacion timestamp without time zone
);

create table diaguita_dsa.d_ubicacion_fisica(
   ubicacion_fisica_id serial
  ,ubicacion_fisica_codigo text
  ,ubicacion_fisica_desc text
  ,fecha_desde date
  ,fecha_hasta date
  ,version integer
  ,vigente character varying
  ,fecha_actualizacion timestamp without time zone
);

create table diaguita_dsa.d_catalogo_bien(
   catalogo_bien_id serial
  ,catalogo_bien_nivel1_codigo integer
  ,catalogo_bien_nivel1_desc text
  ,catalogo_bien_nivel2_codigo integer
  ,catalogo_bien_nivel2_desc text
  ,catalogo_bien_nivel3_codigo integer
  ,catalogo_bien_nivel3_desc text
  ,catalogo_bien_nivel4_codigo integer
  ,catalogo_bien_nivel4_desc text
  ,fecha_desde date
  ,fecha_hasta date
  ,version integer
  ,vigente character varying
  ,fecha_actualizacion timestamp without time zone
);

create table diaguita_dsa.d_bien_patrimonial(
   bien_patrimonial_id serial
  ,bien_patrimonial_codigo text
  ,bien_patrimonial_desc text
  ,fecha_desde date
  ,fecha_hasta date
  ,version integer
  ,vigente character varying
  ,fecha_actualizacion timestamp without time zone
);

create table diaguita_dsa.d_numero_patrimonial(
   numero_patrimonial_id serial
  ,numero_patrimonial_codigo text
  ,numero_patrimonial_desc text
  ,fecha_desde date
  ,fecha_hasta date
  ,version integer
  ,vigente character varying
  ,fecha_actualizacion timestamp without time zone
);

create table diaguita_dsa.d_motivo_alta_bien(
   motivo_alta_id serial
  ,motivo_alta_codigo text
  ,motivo_alta_desc text
  ,fecha_desde date
  ,fecha_hasta date
  ,version integer
  ,vigente character varying
  ,fecha_actualizacion timestamp without time zone
);

create table diaguita_dsa.d_motivo_baja_bien(
   motivo_baja_id serial
  ,motivo_baja_codigo text
  ,motivo_baja_desc text
  ,fecha_desde date
  ,fecha_hasta date
  ,version integer
  ,vigente character varying
  ,fecha_actualizacion timestamp without time zone
);

create table diaguita_dsa.d_area(
   area_id serial
  ,area_nivel1_codigo text
  ,area_nivel2_codigo text
  ,area_nivel1_desc text
  ,area_nivel2_desc text
  ,oficina_patrimonio_codigo text
  ,fecha_desde date
  ,fecha_hasta date
  ,version integer
  ,vigente character varying
  ,fecha_actualizacion timestamp without time zone
);

create table diaguita_dsa.d_vida_util(
   vida_util_id serial
  ,vida_util_codigo text
  ,vida_util_desc text
  ,fecha_desde date
  ,fecha_hasta date
  ,version integer
  ,vigente character varying
  ,fecha_actualizacion timestamp without time zone
);

create table diaguita_dsa.d_tipo_bien(
   tipo_bien_id serial
  ,tipo_bien_codigo text
  ,tipo_bien_desc text
  ,fecha_desde date
  ,fecha_hasta date
  ,version integer
  ,vigente character varying
  ,fecha_actualizacion timestamp without time zone
);

create table diaguita_dsa.d_alta_baja(
   alta_baja_id serial
  ,alta_baja_codigo text
  ,alta_baja_desc text
  ,fecha_desde date
  ,fecha_hasta date
  ,version integer
  ,vigente character varying
  ,fecha_actualizacion timestamp without time zone
);

create table diaguita_dsa.d_oficina_patrimonio(
   oficina_patrimonio_id serial
  ,oficina_patrimonio_codigo text
  ,oficina_patrimonio_desc text
  ,fecha_desde date
  ,fecha_hasta date
  ,version integer
  ,vigente character varying
  ,fecha_actualizacion timestamp without time zone
);

create table diaguita_dsa.ft_patrimonio(
   bien_patrimonial_id integer
  ,numero_patrimonial_id integer
  ,motivo_baja_id smallint
  ,fecha_alta_id date
  ,motivo_alta_id smallint
  ,estado_bien_id smallint
  ,catalogo_bien_id integer
  ,area_responsable_id integer
  ,ubicacion_fisica_id integer
  ,fecha_incorporacion_id date
  ,fecha_baja_id date
  ,alta_baja_id smallint
  ,vida_util smallint
  ,tipo_bien_id smallint
  ,oficina_patrimonio_id smallint
  ,valor_bien numeric(13,2)
  ,valor_residual numeric(13,2)
  ,cant_bienes integer
);

create table diaguita_dsa.w_area(
   codigo text
  ,codigo_padre text
  ,codigo_asignado text
  ,nombre text
  ,id_oficina_patrimonio text
);

--Crea las funciones de diaguita_dsa

create or replace function diaguita_dsa.podar_area() returns text as $$
  declare
    n integer;
    m integer;
    id text;
    noUsados integer := 0;
    noUsados1 integer;
    unicosEnNivel integer := 0;
    ascensos integer := 0;
  begin
    truncate table diaguita_dsa.w_area;
    insert into diaguita_dsa.w_area
      (codigo, codigo_padre, codigo_asignado, nombre, id_oficina_patrimonio)
      select id_area, id_area_padre, id_area, nombre, id_oficina_patrimonio
        from diaguita_tmp.d_area;
    loop
      select count(*) into noUsados1
        from diaguita_dsa.w_area a
        where not exists (
          select ah.codigo
            from diaguita_dsa.w_area ah
            where ah.codigo_padre = a.codigo
        ) and not exists (
          select f.id_area_responsable
            from diaguita_tmp.ft_patrimonio f
            where f.id_area_responsable = a.codigo
        );
      if noUsados1 = 0 then
        exit;
      end if;
      delete from diaguita_dsa.w_area a
        where not exists (
          select ah.codigo
            from diaguita_dsa.w_area ah
            where ah.codigo_padre = a.codigo
        ) and not exists (
          select f.id_area_responsable
            from diaguita_tmp.ft_patrimonio f
            where f.id_area_responsable = a.codigo
        );
      noUsados := noUsados + noUsados1;
    end loop;
    loop
      select count(*) into n
        from diaguita_dsa.w_area
        where codigo_padre is null;
      if n = 0 then
        raise 'Error en la estructura de áreas';
        return 'ERROR';
      elsif n > 1 then
        exit;
      end if;
      select codigo into id
        from diaguita_dsa.w_area
        where codigo_padre is null;
      update diaguita_dsa.w_area
        set codigo_padre = null
        where codigo_padre = id;
      delete from diaguita_dsa.w_area
        where codigo = id;
      unicosEnNivel := unicosEnNivel + 1;
    end loop;
    loop
      select count(*) into m
        from diaguita_dsa.w_area ah
        left join diaguita_dsa.w_area aa on aa.codigo = ah.codigo_asignado
        left join diaguita_dsa.w_area ap on ap.codigo = aa.codigo_padre
        where ah.codigo_padre is not null
          and aa.codigo_padre is not null
          and ap.codigo_padre is not null;
      if m = 0 then
        exit;
      end if;
      update diaguita_dsa.w_area ah
        set codigo_asignado = aa.codigo_padre
        from diaguita_dsa.w_area aa
        left join diaguita_dsa.w_area ap on ap.codigo = aa.codigo_padre
        where ah.codigo_padre is not null
          and aa.codigo_padre is not null
          and ap.codigo_padre is not null
          and aa.codigo = ah.codigo_asignado;
      ascensos := ascensos + 1;
    end loop;
    select count(*) into m
      from diaguita_dsa.w_area
      where codigo_padre is not null and codigo_padre!=codigo_asignado;
    return noUsados || '|' || unicosEnNivel || '|' || n || '|' || ascensos || '|' || m;
  end;
$$ LANGUAGE plpgsql;


--Crea el esquema diaguita

create schema diaguita;


--Crea las tablas de diaguita_dw


create table diaguita.d_estado_bien(
   estado_bien_id serial not null
  ,estado_bien_codigo text
  ,estado_bien_desc text
  ,fecha_desde date
  ,fecha_hasta date
  ,version integer
  ,vigente character varying
  ,fecha_actualizacion timestamp without time zone
  ,CONSTRAINT pk_d_estado_bien PRIMARY KEY (estado_bien_id)
);

create table diaguita.d_ubicacion_fisica(
   ubicacion_fisica_id serial not null
  ,ubicacion_fisica_codigo text
  ,ubicacion_fisica_desc text
  ,fecha_desde date
  ,fecha_hasta date
  ,version integer
  ,vigente character varying
  ,fecha_actualizacion timestamp without time zone
  ,CONSTRAINT pk_d_ubicacion_fisica PRIMARY KEY (ubicacion_fisica_id)
);

create table diaguita.d_catalogo_bien(
   catalogo_bien_id serial not null
  ,catalogo_bien_nivel1_codigo integer
  ,catalogo_bien_nivel1_desc text
  ,catalogo_bien_nivel2_codigo integer
  ,catalogo_bien_nivel2_desc text
  ,catalogo_bien_nivel3_codigo integer
  ,catalogo_bien_nivel3_desc text
  ,catalogo_bien_nivel4_codigo integer
  ,catalogo_bien_nivel4_desc text
  ,fecha_desde date
  ,fecha_hasta date
  ,version integer
  ,vigente character varying
  ,fecha_actualizacion timestamp without time zone
  ,CONSTRAINT pk_d_catalogo_bien PRIMARY KEY (catalogo_bien_id)
);

create table diaguita.d_bien_patrimonial(
   bien_patrimonial_id serial not null
  ,bien_patrimonial_codigo text
  ,bien_patrimonial_desc text
  ,fecha_desde date
  ,fecha_hasta date
  ,version integer
  ,vigente character varying
  ,fecha_actualizacion timestamp without time zone
  ,CONSTRAINT pk_d_bien_patrimonial PRIMARY KEY (bien_patrimonial_id)
);

create table diaguita.d_numero_patrimonial(
   numero_patrimonial_id serial not null
  ,numero_patrimonial_codigo text
  ,numero_patrimonial_desc text
  ,fecha_desde date
  ,fecha_hasta date
  ,version integer
  ,vigente character varying
  ,fecha_actualizacion timestamp without time zone
  ,CONSTRAINT pk_d_numero_patrimonial PRIMARY KEY (numero_patrimonial_id)
);

create table diaguita.d_motivo_alta_bien(
   motivo_alta_id serial not null
  ,motivo_alta_codigo text
  ,motivo_alta_desc text
  ,fecha_desde date
  ,fecha_hasta date
  ,version integer
  ,vigente character varying
  ,fecha_actualizacion timestamp without time zone
  ,CONSTRAINT pk_d_motivo_alta_bien PRIMARY KEY (motivo_alta_id)
);

create table diaguita.d_motivo_baja_bien(
   motivo_baja_id serial not null
  ,motivo_baja_codigo text
  ,motivo_baja_desc text
  ,fecha_desde date
  ,fecha_hasta date
  ,version integer
  ,vigente character varying
  ,fecha_actualizacion timestamp without time zone
  ,CONSTRAINT pk_d_motivo_baja_bien PRIMARY KEY (motivo_baja_id)
);

create table diaguita.d_area(
   area_id serial not null
  ,area_nivel1_codigo text
  ,area_nivel2_codigo text
  ,area_nivel1_desc text
  ,area_nivel2_desc text
  ,oficina_patrimonio_codigo text
  ,fecha_desde date
  ,fecha_hasta date
  ,version integer
  ,vigente character varying
  ,fecha_actualizacion timestamp without time zone
  ,CONSTRAINT pk_d_area PRIMARY KEY (area_id)
);

create table diaguita.d_vida_util(
   vida_util_id serial
  ,vida_util_codigo text
  ,vida_util_desc text
  ,fecha_desde date
  ,fecha_hasta date
  ,version integer
  ,vigente character varying
  ,fecha_actualizacion timestamp without time zone
  ,CONSTRAINT pk_d_vida_util PRIMARY KEY (vida_util_id)
);

create table diaguita.d_tipo_bien(
   tipo_bien_id serial not null
  ,tipo_bien_codigo text
  ,tipo_bien_desc text
  ,fecha_desde date
  ,fecha_hasta date
  ,version integer
  ,vigente character varying
  ,fecha_actualizacion timestamp without time zone
  ,CONSTRAINT pk_d_tipo_bien PRIMARY KEY (tipo_bien_id)
);

create table diaguita.d_alta_baja(
   alta_baja_id serial not null
  ,alta_baja_codigo text
  ,alta_baja_desc text
  ,fecha_desde date
  ,fecha_hasta date
  ,version integer
  ,vigente character varying
  ,fecha_actualizacion timestamp without time zone
  ,CONSTRAINT pk_d_alta_baja PRIMARY KEY (alta_baja_id)
);

create table diaguita.d_oficina_patrimonio(
   oficina_patrimonio_id serial not null
  ,oficina_patrimonio_codigo text
  ,oficina_patrimonio_desc text
  ,fecha_desde date
  ,fecha_hasta date
  ,version integer
  ,vigente character varying
  ,fecha_actualizacion timestamp without time zone
  ,CONSTRAINT pk_d_oficina_patrimonio PRIMARY KEY (oficina_patrimonio_id)
);

create table diaguita.ft_patrimonio(
   id serial
  ,importacion_id integer
  ,unidad_generica_id integer
  ,bien_patrimonial_id integer not null
  ,numero_patrimonial_id integer not null
  ,motivo_baja_id smallint
  ,fecha_alta_id date not null
  ,motivo_alta_id smallint not null
  ,estado_bien_id smallint not null
  ,catalogo_bien_id integer not null
  ,area_responsable_id integer not null
  ,ubicacion_fisica_id integer not null
  ,fecha_incorporacion_id date not null
  ,fecha_baja_id date
  ,alta_baja_id smallint not null
  ,vida_util smallint not null
  ,tipo_bien_id smallint
  ,oficina_patrimonio_id smallint
  ,valor_bien numeric(13,2)
  ,valor_residual numeric(13,2)
  ,cant_bienes integer
);


-- ----------------------------
-- datos fijos
-- ----------------------------


-- d_alta_baja

INSERT INTO diaguita.d_alta_baja (alta_baja_id, alta_baja_codigo, alta_baja_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion) VALUES (-1, NULL, 'VALOR ERRONEO', '1900-01-01', '2199-01-01', 1, 'Y', '1900-01-01 00:00:00');
INSERT INTO diaguita.d_alta_baja (alta_baja_id, alta_baja_codigo, alta_baja_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion) VALUES (0, NULL, 'VACIO/NULO', '1900-01-01', '2199-01-01', 1, 'Y', '1900-01-01 00:00:00');
INSERT INTO diaguita.d_alta_baja (alta_baja_id, alta_baja_codigo, alta_baja_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion) VALUES (1, NULL, 'Alta', '1900-01-01', '2199-01-01', 1, 'Y', '1900-01-01 00:00:00');
INSERT INTO diaguita.d_alta_baja (alta_baja_id, alta_baja_codigo, alta_baja_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion) VALUES (2, NULL, 'Baja', '1900-01-01', '2199-01-01', 1, 'Y', '1900-01-01 00:00:00');


-- ----------------------------
-- version
-- ----------------------------

-- inserta nueva version
INSERT INTO public.version ("version",descripcion,fechacarga) VALUES('050400','actualizada',now());


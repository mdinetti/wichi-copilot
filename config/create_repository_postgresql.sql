--
-- note: this script assumes pg_hba.conf is configured correctly
--

--\connect postgres postgres

drop database if exists hibernate;
drop user if exists hibuser;

CREATE USER hibuser PASSWORD 'password';

CREATE DATABASE hibernate WITH OWNER = hibuser ENCODING = 'UTF8' TABLESPACE = pg_default;

GRANT ALL PRIVILEGES ON DATABASE hibernate to hibuser;

\c hibernate postgres

CREATE TABLE pro_audit
(
  id_mensaje serial NOT NULL
, job_id character varying(255) NOT NULL
, inst_id character varying(256)
, obj_id character varying(256)
, obj_type character varying(255)
, actor character varying(45)
, message_type character varying(255)
, message_name character varying(256)
, message_text_value character varying
, message_num_value bigint
, duration numeric(7,2)
, audit_time timestamp without time zone
);


ALTER TABLE IF EXISTS public.pro_audit
    OWNER to hibuser;

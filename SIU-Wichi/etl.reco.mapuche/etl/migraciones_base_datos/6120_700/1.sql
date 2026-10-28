-- Este script es parte de la migración de SIU-Wichi 6.12.0 a 7.0.0

-----------------------------
--Guarani 3
-----------------------------
ALTER TABLE guarani3_tmp.ft_alumnos
    ALTER COLUMN discapacidad_id TYPE character varying;
	
ALTER TABLE guarani3_tmp.ft_cursado
    ALTER COLUMN discapacidad_id TYPE character varying;		
	
ALTER TABLE guarani3_tmp.ft_equivalencia
    ALTER COLUMN discapacidad_id TYPE character varying;
	
ALTER TABLE guarani3_tmp.ft_examen
    ALTER COLUMN discapacidad_id TYPE character varying;
    
-- Agregar campo elemento

ALTER TABLE IF EXISTS guarani3.d_actividad
    ADD COLUMN elemento integer;

ALTER TABLE IF EXISTS guarani3_dsa.d_actividad
    ADD COLUMN elemento integer;

ALTER TABLE IF EXISTS guarani3_tmp.d_actividad
    ADD COLUMN elemento integer;
	

-----------------------------
--Mapuche
-----------------------------
ALTER TABLE IF EXISTS mapuche_tmp.d_liquidacion
    ADD COLUMN sino_cerra character varying;	
    
ALTER TABLE IF EXISTS mapuche_dsa.d_liquidacion
    ADD COLUMN sino_cerra character varying;    
    
ALTER TABLE IF EXISTS mapuche.d_liquidacion
    ADD COLUMN sino_cerra character varying;    
    
UPDATE mapuche.d_liquidacion SET sino_cerra = es_cerrada where sino_cerra is null;    


-----------------------------
--Pilaga
-----------------------------
--TMP
ALTER TABLE pilaga_tmp.d_comprobante
    ALTER COLUMN importe TYPE numeric(14, 2);
      
ALTER TABLE pilaga_tmp.ft_tesorerias
    ALTER COLUMN debito TYPE numeric;

ALTER TABLE pilaga_tmp.ft_tesorerias
    ALTER COLUMN credito TYPE numeric;
    
    
--DSA
ALTER TABLE pilaga_dsa.d_comprobante
    ALTER COLUMN importe TYPE numeric(14, 2);
    
ALTER TABLE pilaga_dsa.ft_movimientos_gastos
    ALTER COLUMN credito_original TYPE numeric(14, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_gastos
    ALTER COLUMN credito_modificatorio TYPE numeric(14, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_gastos
    ALTER COLUMN credito TYPE numeric(14, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_gastos
    ALTER COLUMN preventivo TYPE numeric(14, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_gastos
    ALTER COLUMN compromiso TYPE numeric(14, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_gastos
    ALTER COLUMN devengado TYPE numeric(14, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_gastos
    ALTER COLUMN pagado TYPE numeric(14, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_gastos
    ALTER COLUMN devengado_ex TYPE numeric(14, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_gastos
    ALTER COLUMN pagado_ex TYPE numeric(14, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_gastos
    ALTER COLUMN retenciones TYPE numeric(14, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_gastos
    ALTER COLUMN disponibilidades TYPE numeric(14, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_gastos
    ALTER COLUMN previsto_de_ingreso TYPE numeric(14, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_gastos
    ALTER COLUMN estimado_de_ingreso TYPE numeric(14, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_gastos
    ALTER COLUMN devengado_de_ingreso TYPE numeric(14, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_gastos
    ALTER COLUMN cobrado TYPE numeric(14, 2);
    
ALTER TABLE pilaga_dsa.ft_movimientos_ingresos
    ALTER COLUMN credito_original TYPE numeric(14, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_ingresos
    ALTER COLUMN credito_modificatorio TYPE numeric(14, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_ingresos
    ALTER COLUMN credito TYPE numeric(14, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_ingresos
    ALTER COLUMN preventivo TYPE numeric(14, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_ingresos
    ALTER COLUMN compromiso TYPE numeric(14, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_ingresos
    ALTER COLUMN devengado TYPE numeric(14, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_ingresos
    ALTER COLUMN pagado TYPE numeric(14, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_ingresos
    ALTER COLUMN retenciones TYPE numeric(14, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_ingresos
    ALTER COLUMN disponibilidades TYPE numeric(14, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_ingresos
    ALTER COLUMN previsto_de_ingreso TYPE numeric(14, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_ingresos
    ALTER COLUMN estimado_de_ingreso TYPE numeric(14, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_ingresos
    ALTER COLUMN devengado_de_ingreso TYPE numeric(14, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_ingresos
    ALTER COLUMN cobrado TYPE numeric(14, 2);
    
ALTER TABLE pilaga_dsa.ft_servicios_publicos
    ALTER COLUMN importe TYPE numeric(14, 2);

ALTER TABLE pilaga_dsa.ft_servicios_publicos
    ALTER COLUMN consumo TYPE numeric(14, 2);
    
ALTER TABLE pilaga_dsa.ft_tesorerias
    ALTER COLUMN debito TYPE numeric(14, 2);

ALTER TABLE pilaga_dsa.ft_tesorerias
    ALTER COLUMN credito TYPE numeric(14, 2);     
    
--DW
ALTER TABLE pilaga.d_comprobante
    ALTER COLUMN importe TYPE numeric(14, 2);

ALTER TABLE pilaga.ft_movimientos
    ALTER COLUMN credito_original TYPE numeric(14, 2);

ALTER TABLE pilaga.ft_movimientos
    ALTER COLUMN credito_modificatorio TYPE numeric(14, 2);

ALTER TABLE pilaga.ft_movimientos
    ALTER COLUMN credito TYPE numeric(14, 2);

ALTER TABLE pilaga.ft_movimientos
    ALTER COLUMN preventivo TYPE numeric(14, 2);

ALTER TABLE pilaga.ft_movimientos
    ALTER COLUMN compromiso TYPE numeric(14, 2);

ALTER TABLE pilaga.ft_movimientos
    ALTER COLUMN devengado TYPE numeric(14, 2);

ALTER TABLE pilaga.ft_movimientos
    ALTER COLUMN pagado TYPE numeric(14, 2);

ALTER TABLE pilaga.ft_movimientos
    ALTER COLUMN devengado_ex TYPE numeric(14, 2);

ALTER TABLE pilaga.ft_movimientos
    ALTER COLUMN pagado_ex TYPE numeric(14, 2);

ALTER TABLE pilaga.ft_movimientos
    ALTER COLUMN retenciones TYPE numeric(14, 2);

ALTER TABLE pilaga.ft_movimientos
    ALTER COLUMN disponibilidades TYPE numeric(14, 2);

ALTER TABLE pilaga.ft_movimientos
    ALTER COLUMN previsto_de_ingreso TYPE numeric(14, 2);

ALTER TABLE pilaga.ft_movimientos
    ALTER COLUMN estimado_de_ingreso TYPE numeric(14, 2);

ALTER TABLE pilaga.ft_movimientos
    ALTER COLUMN devengado_de_ingreso TYPE numeric(14, 2);

ALTER TABLE pilaga.ft_movimientos
    ALTER COLUMN cobrado TYPE numeric(14, 2);      
    
ALTER TABLE pilaga.ft_servicios_publicos
    ALTER COLUMN importe TYPE numeric(14, 2);

ALTER TABLE pilaga.ft_servicios_publicos
    ALTER COLUMN consumo TYPE numeric(14, 2);
    
ALTER TABLE pilaga.ft_tesorerias
    ALTER COLUMN debito TYPE numeric(14, 2);

ALTER TABLE pilaga.ft_tesorerias
    ALTER COLUMN credito TYPE numeric(14, 2);     
    
-------------------------------------------------------
----Araucano
-------------------------------------------------------
ALTER TABLE IF EXISTS araucano.academica_ft_cuadro3
    ADD COLUMN cantidad double precision;

ALTER TABLE IF EXISTS araucano.academica_ft_cuadro4
    ADD COLUMN cantidad double precision;
    
ALTER TABLE IF EXISTS araucano.academica_ft_cuadro5
    ADD COLUMN cantidad double precision;                                      
    
ALTER TABLE IF EXISTS araucano.academica_ft_cuadro6
    ADD COLUMN cantidad double precision;

ALTER TABLE IF EXISTS araucano.academica_ft_cuadro7
    ADD COLUMN cantidad double precision;
    
ALTER TABLE IF EXISTS araucano.academica_ft_cuadro8
    ADD COLUMN cantidad double precision;

ALTER TABLE IF EXISTS araucano.academica_ft_cuadro12
    ADD COLUMN cantidad double precision;

ALTER TABLE IF EXISTS araucano.academica_ft_cuadro13
    ADD COLUMN cantidad double precision;
    
ALTER TABLE IF EXISTS araucano.academica_ft_cuadro14
    ADD COLUMN cantidad double precision; 
    
ALTER TABLE IF EXISTS araucano.academica_ft_cuadro15
    ADD COLUMN cantidad double precision;

ALTER TABLE IF EXISTS araucano.academica_ft_cuadro16
    ADD COLUMN cantidad double precision;
    
ALTER TABLE IF EXISTS araucano.academica_ft_cuadro17
    ADD COLUMN cantidad double precision;                                      
    
ALTER TABLE IF EXISTS araucano.academica_ft_cuadro18
    ADD COLUMN cantidad double precision;

ALTER TABLE IF EXISTS araucano.academica_ft_cuadro19
    ADD COLUMN cantidad double precision;
    
ALTER TABLE IF EXISTS araucano.academica_ft_cuadro20
    ADD COLUMN cantidad double precision;

ALTER TABLE IF EXISTS araucano.academica_ft_cuadro21
    ADD COLUMN cantidad double precision;

ALTER TABLE IF EXISTS araucano.academica_ft_cuadro22
    ADD COLUMN cantidad double precision;
    
ALTER TABLE IF EXISTS araucano.academica_ft_cuadros1y2
    ADD COLUMN cantidad double precision;
    
ALTER TABLE IF EXISTS araucano.academica_ft_cuadros9y10
    ADD COLUMN cantidad double precision;
    
    
--DSA

ALTER TABLE IF EXISTS araucano_dsa.academica_ft_cuadro3
    ADD COLUMN cantidad double precision;

ALTER TABLE IF EXISTS araucano_dsa.academica_ft_cuadro4
    ADD COLUMN cantidad double precision;
    
ALTER TABLE IF EXISTS araucano_dsa.academica_ft_cuadro5
    ADD COLUMN cantidad double precision;                                      
    
ALTER TABLE IF EXISTS araucano_dsa.academica_ft_cuadro6
    ADD COLUMN cantidad double precision;

ALTER TABLE IF EXISTS araucano_dsa.academica_ft_cuadro7
    ADD COLUMN cantidad double precision;
    
ALTER TABLE IF EXISTS araucano_dsa.academica_ft_cuadro8
    ADD COLUMN cantidad double precision;

ALTER TABLE IF EXISTS araucano_dsa.academica_ft_cuadro12
    ADD COLUMN cantidad double precision;

ALTER TABLE IF EXISTS araucano_dsa.academica_ft_cuadro13
    ADD COLUMN cantidad double precision;
    
ALTER TABLE IF EXISTS araucano_dsa.academica_ft_cuadro14
    ADD COLUMN cantidad double precision; 
    
ALTER TABLE IF EXISTS araucano_dsa.academica_ft_cuadro15
    ADD COLUMN cantidad double precision;

ALTER TABLE IF EXISTS araucano_dsa.academica_ft_cuadro16
    ADD COLUMN cantidad double precision;
    
ALTER TABLE IF EXISTS araucano_dsa.academica_ft_cuadro17
    ADD COLUMN cantidad double precision;                                      
    
ALTER TABLE IF EXISTS araucano_dsa.academica_ft_cuadro18
    ADD COLUMN cantidad double precision;

ALTER TABLE IF EXISTS araucano_dsa.academica_ft_cuadro19
    ADD COLUMN cantidad double precision;
    
ALTER TABLE IF EXISTS araucano_dsa.academica_ft_cuadro20
    ADD COLUMN cantidad double precision;

ALTER TABLE IF EXISTS araucano_dsa.academica_ft_cuadro21
    ADD COLUMN cantidad double precision;

ALTER TABLE IF EXISTS araucano_dsa.academica_ft_cuadro22
    ADD COLUMN cantidad double precision;
    
ALTER TABLE IF EXISTS araucano_dsa.academica_ft_cuadros1y2
    ADD COLUMN cantidad double precision;
    
ALTER TABLE IF EXISTS araucano_dsa.academica_ft_cuadros9y10
    ADD COLUMN cantidad double precision;                                          

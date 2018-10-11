/* ***************************
-- ***** Esquema_Almacen *****
   ***************************
*/
-- Creamos la tabla almacén

CREATE TABLE Almacen(Numero_Almacen INTEGER,Ubicacion_Almacen VARCHAR2(50),CONSTRAINT PK_NUM_ALMACEN PRIMARY KEY(Numero_Almacen));

-- Creamos la tabla cliente que se relaciona a almacén

CREATE TABLE Cliente(Numero_Cliente INTEGER,Numero_Almacen INTEGER, Nombre_Cliente VARCHAR2(50),CONSTRAINT PK_NUM_CLIENTE PRIMARY KEY(Numero_Cliente),
CONSTRAINT FK1_NUM_ALMACEN FOREIGN KEY(Numero_Almacen) REFERENCES Almacen(Numero_Almacen));

-- Procedimiento GUARDAR_ALMACEN
CREATE OR REPLACE PROCEDURE GUARDAR_ALMACEN(MI_ID IN INTEGER,MI_UBI IN VARCHAR2)
AS
BEGIN
INSERT INTO Almacen VALUES(MI_ID, MI_UBI);
END;
/

-- Procedimiento Guardar_Cliente
CREATE OR REPLACE PROCEDURE GUARDAR_CLIENTE(MI_ID IN INTEGER,ID_ALMACEN IN INTEGER, NOM_CLIENTE IN VARCHAR2)
AS
BEGIN
INSERT INTO CLIENTE VALUES(MI_ID, ID_ALMACEN, NOM_CLIENTE);
END;
/

/* ****************************
-- ***** Esquema_Vendedor *****
   ****************************
*/

CREATE TABLE Vendedor(Numero_Vendedor INTEGER,Nombre_Vendedor VARCHAR2(60),Area_Ventas VARCHAR2(40),CONSTRAINT PK_NV PRIMARY KEY(Numero_Vendedor));

CREATE TABLE Ventas(ID_Ventas INTEGER,Numero_Cliente INTEGER,Numero_Vendedor INTEGER,Monto_Ventas FLOAT,CONSTRAINT PK_ID PRIMARY KEY(ID_Ventas),
CONSTRAINT FK_NC1 FOREIGN KEY(Numero_Cliente) REFERENCES Cliente(Numero_Cliente),CONSTRAINT FK_NV1 FOREIGN KEY(Numero_Vendedor) REFERENCES Vendedor(Numero_Vendedor)
);

-- Secuencia para auto-incrementar Ventas
CREATE SEQUENCE SEC_AUTO_INCREMENTO START WITH 1 INCREMENT BY 1 NOMAXVALUE;

-- Procedimiento Guardar_Vendedor
CREATE OR REPLACE PROCEDURE GUARDAR_VENDEDOR(MI_ID IN INTEGER,NOMBRE_V IN VARCHAR2, AREA_V IN VARCHAR2)
AS
BEGIN
INSERT INTO VENDEDOR VALUES(MI_ID, NOMBRE_V, AREA_V);
END;
/

-- Procedimiento Guardar_Ventas

CREATE OR REPLACE PROCEDURE GUARDAR_VENTAS(MI_ID OUT INTEGER,NUMERO_C IN INTEGER, NUMERO_V IN INTEGER, MONTO IN FLOAT)
AS 
BEGIN
SELECT SEC_AUTO_INCREMENTO.NEXTVAL INTO MI_ID FROM DUAL;
INSERT INTO VENTAS VALUES(MI_ID, NUMERO_C, NUMERO_V,MONTO);
END;
/  

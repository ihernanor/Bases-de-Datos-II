SET SERVEROUTPUT ON;
--Ejercicio #1: Guardar el siguiente cliente ->
CREATE TABLE Cliente_GYM(ID INTEGER PRIMARY KEY, Nombre VARCHAR2(60),Entrada DATE);
INSERT INTO Cliente_GYM(ID,Nombre)VALUES(1,'Juan');
SELECT * FROM Cliente_GYM;
/*Ejercicio #2: Generar un procedimiento almacenado que se llame REGISTRAR_ENTRADA() que tenga
                un solo argumento y que �se sea el ID, al invocarlo y pasarle un ID, deber�
                actualizar el registro, agregando el campo "entrada" a la fecha actual.

CREATE SEQUENCE SEC_CLIENTE
START WITH 1
INCREMENT BY 1
NOMAXVALUE;
*/
CREATE OR REPLACE PROCEDURE REGISTRAR_ENTRADA(ID_ENTRADA IN INTEGER)
AS
BEGIN
--SELECT SEC_CLIENTE.NEXTVAL INTO ID_ENTRADA FROM DUAL;
UPDATE Cliente_GYM SET Entrada=SYSDATE WHERE ID=ID_ENTRADA;
END;
/
BEGIN
REGISTRAR_ENTRADA(1);
END;
/
SELECT * FROM Cliente_GYM;

/*Ejercicio #3: Generar un trigger cuya l�gica sea la siguiente: Al invocar el procedimiento
                anterior se deber� "disparar" el trigger y debe impedir el update de ese 
                procedimiento SI el d�a de registro es domingo, con el siguiente mensaje: "No
                te puedes registrar en domingo, no abrimos".
                tip: D-> D�a de la semana(n�mero)
                     DD->D�a del mes
                     DDD->D�as que lleva el a�o
                     MM->Mes del a�o
                     YYYY->Muestra el a�o por compelto(2018)
                     MI-> Muestra los minutos
*/
DECLARE
VALOR CHAR(90);
BEGIN
VALOR:=TO_CHAR(SYSDATE,'D');
DBMS_OUTPUT.PUT_LINE(VALOR);
END;
/

CREATE OR REPLACE TRIGGER DISP_FECHA BEFORE INSERT ON Cliente_GYM
FOR EACH ROW
DECLARE
VALOR CHAR(90);
BEGIN
VALOR:=TO_CHAR(SYSDATE,'D');
IF VALOR=3 THEN
RAISE_APPLICATION_ERROR(-20001,'No te puedes registrar en domingo, no abrimos.');--(-20001) Es un c�digo de error (comod�n)
END IF;
END;
/
INSERT INTO Cliente_GYM(ID,Nombre)VALUES(3,'Gaby');

SELECT * FROM Cliente_GYM;



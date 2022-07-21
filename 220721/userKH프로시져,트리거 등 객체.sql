--PL/SQL�� ���õ� ����Ŭ ��ü
-- Function, Procedure, Cursor, Package, Trigger, Job,...

-- PL/SQL�� ����
-- PL/SQL ������ 3������ ����, �͸���(Anonymous Block), ���ν���(Procedure), �Լ�(Function)
-- �͸��� : �̸� ���� ����̶� �Ҹ��� ������ block ����� ����
-- ���ν��� : ������ Ư��ó���� �����ϴ� �������α׷��� �� �������� �ܵ����� ����ǰų�
-- �ٸ� ���ν����� �ٸ� �� � ���� ȣ��Ǿ� �����
-- �Լ� : Procedure�� ����Ǵ� ����� �����ϳ� �� ��ȯ ���ο� ���� ���̰� ����
-- �Լ��� ��ȯ���� ����.

-- ���ν����� �Ϸ��� �۾������� �����ؼ� ������ �� ��
-- ���� SQL���� ��� �̸� �����صΰ� �ϳ��� ��û���� ���� �� �� ����
-- ���� ���Ǵ� ������ �۾����� �����ϰ� �̸� ����� �θ� ���� ����� ������
-- �ڹٷ� �� �ذ��� �� �ִ� �κ���.

SET SERVEROUTPUT ON;

--1. Stored Procedure
--����
CREATE TABLE EMP_DUP AS SELECT * FROM EMPLOYEE;
SELECT * FROM EMP_DUP;

--EMP_DUP�� �����͸� ��� �����ϴ� ���ν��� ����.
CREATE PROCEDURE DEL_ALL_EMP
IS
BEGIN
    DELETE FROM EMP_DUP;
    COMMIT;
END;
/

EXECUTE DEL_ALL_EMP;
SELECT * FROM EMP_DUP;  --����ϰ� ������

SELECT * FROM USER_PROCEDURES;
--DEVELOPER GUIȯ�濡�� Ȯ���ϰų� CLI�� Ȯ���� �� �ִ�.
--���ν����� �ҽ��� Ȯ���ϴ� ������ ��ųʸ�
SELECT * FROM  USER_SOURCE
WHERE NAME = 'DEL_ALL_EMP';

SELECT *FROM USER_SOURCE;

--����2. �Ű����� �ִ� ���ν��� ����� -- ���� ã��..
--0/0       PL/SQL: Compilation unit analysis terminated
--1/37      PLS-00201: identifier 'EMP_DUM.EMP_ID' must be declared
INSERT INTO EMP_DUP (SELECT * FROM EMPLOYEE); --�����͸� �ٽ� �־���
SELECT * FROM EMP_DUP;
COMMIT;

CREATE PROCEDURE PROC_DEL_EMP_ID(
    P_EMP_ID  EMPLOYEE.EMP_ID%TYPE
)
IS
BEGIN
    DELETE FROM EMP_DUP WHERE EMP_ID = P_EMP_ID;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE(P_EMP_ID || '�� ����� �����߽��ϴ�.');
END;
/

DROP PROCEDURE PROC_DEL_EMP_ID;

EXECUTE PROC_DEL_EMP_ID(&�����ȣ);


--����3. �Ű������� �������(IN,OUT,INOUT),���ε庯��
--�Ű����� IN: �����͸� ���޹��� ��
--�Ű����� OUT: ����� ����� ��ȯ�� ��
--�Ű�����INOUT: �����͸� ���޹ް� ����� ����� ��ȯ�� ��
--���ε� ����: ���� �޾� ����ϴ� ����

--����Ʈ�� ���ִ� ���ν���

CREATE PROCEDURE PROC_SELECT_EMP_ID(
    P_EMP_ID IN EMPLOYEE.EMP_ID%TYPE,
    P_EMP_NAME OUT EMPLOYEE.EMP_NAME%TYPE,
    P_SALARY OUT EMPLOYEE.SALARY%TYPE,
    P_BONUS OUT EMPLOYEE.BONUS%TYPE
)
IS
BEGIN
    SELECT EMP_NAME, SALARY, NVL(BONUS,0)
    INTO P_EMP_NAME, P_SALARY, P_BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = P_EMP_ID;
END;
/
SELECT * FROM USER_PROCEDURES;

--���ε� ���� ����
--VAR [LIABLE] : ���ε庯���� �Ű������� �ڷ����� �ݵ�� ���ƾ���
--�ּ��ޱ� ����

VAR B_EMP_NAME VARCHAR2(30);
VAR B_SALARY NUMBER;
VAR B_BONUS NUMBER;

EXEC PROC_SELECT_EMP_ID('202',:B_EMP_NAME,:B_SALARY,:B_BONUS);

PRINT B_EMP_NAME;
PRINT B_SALARY;
PRINT B_BONUS;

--��ƺ���
VAR RESULT VARCHAR2(100);
EXEC :RESULT := (:B_EMP_NAME ||' '|| :B_SALARY ||' '|| :B_BONUS);
PRINT RESULT;

--���ν��� ����� ���ÿ� ��� ���ε� ������ ���
--���� ������ �����ϰ� �����
SET AUTOPRINT ON;


-- �ǽ�1) JOB���̺� INSERT�� �� �� ���� �����ڵ尡 ������ UPDATE�� �����ϰ� ������
-- �״�� INSERT�� �ϴ� PROCEDURE�� �ۼ��Ͻÿ�.
-- 1�ܰ�. JOB���̺� INSERT�ϴ� ���ν����� �ۼ�
-- 2�ܰ�. �䱸���׿� �°� ���ǹ��� �߰��Ͽ� ����

CREATE TABLE JOB_COPY AS SELECT * FROM JOB;
SELECT * FROM JOB_COPY;

CREATE OR REPLACE PROCEDURE PROC_INSERT_JOB_CODE (
    P_JOB_CODE IN JOB_COPY.JOB_CODE%TYPE,
    P_JOB_NAME IN JOB_COPY.JOB_NAME%TYPE
)
IS
    V_CNT NUMBER := 0;
BEGIN
    SELECT COUNT(*)
    INTO V_CNT
    FROM JOB_COPY
    WHERE JOB_CODE = P_JOB_CODE;

    IF(V_CNT > 0)
    THEN
        UPDATE JOB_COPY SET JOB_NAME = P_JOB_NAME
        WHERE JOB_CODE = P_JOB_CODE;
    ELSE
        INSERT INTO JOB_COPY VALUES(P_JOB_CODE, P_JOB_NAME);
    END IF;
    COMMIT;
END;
/

--����� �ڵ�
CREATE OR REPLACE PROCEDURE PROC_ADD_JOB_DUP(
    P_JOB_CODE IN JOB_DUP.JOB_CODE%TYPE,
    P_JOB_NAME IN JOB_DUP.JOB_NAME%TYPE
)
IS
    V_CNT NUMBER := 0;
BEGIN
    SELECT COUNT(*)
    INTO V_CNT
    FROM JOB_DUP
    WHERE JOB_CODE = P_JOB_CODE;
    
    IF(V_CNT > 0)
    THEN 
        UPDATE JOB_DUP SET JOB_NAME = P_JOB_NAME
        WHERE JOB_CODE = P_JOB_CODE;
    ELSE
        INSERT INTO JOB_DUP VALUES(P_JOB_CODE, P_JOB_NAME);
    END IF;
    COMMIT;
END;
/





SELECT * FROM USER_PROCEDURES;
DROP PROCEDURE PROC_INSERT_JOB_CODE;

EXECUTE PROC_INSERT_JOB_CODE('J9','�̻���');
SELECT * FROM JOB_COPY;

ALTER TABLE JOB_COPY 
ADD CONSTRAINT PK_JOB_CODE PRIMARY KEY(JOB_CODE);

ALTER TABLE JOB_COPY ADD (TEST_COL NUMBER CHECK(TEST_COL IN(1,2));
ALTER TABLE JOB_COPY DROP (TEST_COL);

ALTER TABLE JOB_COPY 
MODIFY CONSTRAINT PK_JOB_CODE FOREIGN KEY (JOB_CODE);
ALTER TABLE JOB_COPY DROP CONSTRAINT SYS_C007265;


-- 2. FUNCTION
-->���ϰ��� �ݵ�� �����ϴ� ��ü
/*
    CREATE OR REPLACE FUNCTION �Լ��̸�(�Ű������� �ڷ���,...)
    RETURN �ڷ���
    IS
        ������������;
    BEGIN
        ���๮
        RETURN ������;
    END;
    /
*/
--������ ����  �Ű����� ������ ������Ÿ�� ũ�⸦ �����ϸ� ������ ����.

--����, ����� �����
CREATE OR REPLACE FUNCTION MAKE_HEADPHONE(P_STR VARCHAR2)
RETURN VARCHAR2 
--����Ÿ�� ����
IS
    MADEHEADPHONE VARCHAR2(32767);
BEGIN
    MADEHEADPHONE := 'd'||P_STR||'b';
    RETURN MADEHEADPHONE;
END;
/
VAR RESULT VARCHAR2;

EXECUTE :RESULT := MAKE_HEADPHONE('^-^');

--����1. ����� �Է� �޾� �ش� ����� ������ ����Ͽ� �����ϴ� �����Լ��� ����� ����Ͻÿ�
CREATE OR REPLACE FUNCTION FN_BONUS_CALC(
    P_EMP_ID EMPLOYEE.EMP_ID%TYPE
)
RETURN NUMBER
IS
    V_SAL EMPLOYEE.SALARY%TYPE;
    V_BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT SALARY, NVL(BONUS,0)
    INTO V_SAL, V_BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = P_EMP_ID;
    RETURN (V_SAL * 12 + V_SAL * V_BONUS);
END;
/


VAR VAR_CALC NUMBER;
EXEC : VAR_CALC := FN_BONUS_CALC('204');

--@�ǽ�����
--1.�����ȣ�� �Է¹޾Ƽ� ������ �����ϴ� �����Լ� FN_GET_GENDER�� �����ϰ�, �����ϼ���.
CREATE OR REPLACE FUNCTION FN_GET_GENDER ( F_EMP_ID EMPLOYEE.EMP_ID%TYPE)
RETURN VARCHAR2
IS 
    V_SSN VARCHAR2(32767);
BEGIN
    SELECT CASE SUBSTR(EMP_NO,8,1) WHEN '1' THEN '��' WHEN '2' THEN '��' END "����"
    INTO V_SSN
    FROM EMPLOYEE
    WHERE EMP_ID = F_EMP_ID;

    RETURN V_SSN;
END;
/

VAR V_GENDER VARCHAR2;
EXEC :V_GENDER := FN_GET_GENDER('203');

--FUNCTION �� SQL���� ������ �� �ִ�!
SELECT EMP_ID, EMP_NAME, FN_GET_GENDER(EMP_ID)
FROM EMPLOYEE;



--2. ����ڷκ��� �Է¹��� ��������� �˻��Ͽ� �ش����� ���޸��� ��� ���� �����Լ�
-- FN_GET_JOB_NAME�� �ۼ��ϼ���. (�ش����� ���ٸ� '�ش�������' ���)

CREATE OR REPLACE FUNCTION FN_GET_JOB_NAME (P_EMP_NAME EMPLOYEE.EMP_NAME%TYPE)
RETURN VARCHAR2
IS
 ANSWER VARCHAR2(32767);
BEGIN
    SELECT JOB_NAME
    INTO ANSWER
    FROM EMPLOYEE E JOIN JOB J USING(JOB_CODE)
    WHERE E.EMP_NAME = P_EMP_NAME;
    
    RETURN ANSWER;
END;
/

VAR V_JOB_NAME VARCHAR2;
EXECUTE :V_JOB_NAME := FN_GET_JOB_NAME('������');



--3. ������� Ư���󿩱�(���ʽ�)�� �����Ϸ��� �ϴµ�, �Ի��ϱ������� ���� �����Ϸ� �Ѵ�.
-- �Ի��ϱ��� 10���̻��̸� 150%, 3���̻� 10��̸��̸� 125%, 3��̸��̸� 50%�� ������.
-- �����Լ��� : FN_BONUS_CALC, FN_GET_WORKING_DAYS(HIRE_DATE)
-- ��ȸ�÷� : ���, �����, �Ի���, �ٹ��Ⱓ(~�� ~����), ���ʽ��ݾ� �Ű������� �����.

CREATE OR REPLACE FUNCTION FN_BONUS_CALC(
    P_EMP_ID EMPLOYEE.EMP_ID%TYPE
)
RETURN NUMBER
IS
 V_ID VARCHAR2(30);
 V_NAME VARCHAR2(30);
 V_DATE DATE;
 V_WORKINGDAY
BEGIN
    SELECT EMP_ID, EMP_NAME, HIRE_DATE, FN_GET_WORKING_DAYS(HIRE_DATE)
    INTO V_ID, V_NAME, V_DATE, V_WORKINGDAY
    FROM EMPLOYEE
    WHERE EMP_ID = P_EMP_ID;
    
    -- �䱸���� ���ǹ�
    
    RETURN
END;
/


CREATE OR REPLACE FUNCTION FN_GET_WORKING_DAYS(P_HIRE_DATE EMPLOYEE.HIRE_DATE%TYPE)
RETURN NUMBER
IS
    
    COUNTYEAR NUMBER;
BEGIN
    SELECT (SYSDATE -  HIRE_DATE)
    INTO COUNTYEAR
    FROM EMPLOYEE
    WHERE HIRE_DATE = P_HIRE_DATE;
    RETURN COUNTYEAR;
END;
/




--@�ǽ�����
--�����μ����̺��� DEPT_ID, DEPT_TITLE�� ������ DEPT_COPY�� �����Ѵ�.
--DEPT_ID �÷� PK�߰�. DEPT_ID �÷� Ȯ�� CHAR(3)
--DEPT_COPY�� �����ϴ� ���ν��� PROC_MAN_DEPT_COPY�� �����Ѵ�.
-- ù��° ���ڷ� ����FLAG�� UPDATE/DELETE�� �޴´�.
-- UPDATE��, �����Ͱ� �������� ������ INSERT, �����Ͱ� �����ϸ�, UPDATE
-- DELETE��, �ش�μ��� ����� �����ϴ����� �˻��ؼ�, �����ϸ�, ���޼����� �Բ� ���������. �׷��� ������, ����.
-- ���ν����� �Ű������� �⺻���� �����ϸ�, ����������.

CREATE TABLE DEPT_COPY AS SELECT DEPT_ID, DEPT_TITLE FROM DEPARTMENT;
SELECT * FROM DEPT_COPY;
DESC DEPT_COPY;
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME ='DEPT_COPY';
ALTER TABLE DEPT_COPY ADD CONSTRAINT PK_DEPT_ID PRIMARY KEY(DEPT_ID);
ALTER TABLE DEPT_COPY  MODIFY (DEPT_ID CHAR(3));

CREATE OR REPLACE PROCEDURE PROC_MAN_DEPT_COPY


--3. Trigger
-- Ʈ������ ������ �ǹ�: ��Ƽ� , �������
--> Ư�� �̺�Ʈ�� DDL, DML������ ����Ǿ��� ��
--�ڵ�������  � �Ϸ��� ����(Operation), ó���� ����ǵ��� �ϴ� ����Ÿ���̽� ��ü�� �ϳ�

-- 1). ȸ�� Ż�� �̷���� ��� (EMPLOYEE���� DELETE�� �Ǿ��� ��)
--    �ش� ȸ�������� �ٸ� ���̺� ������ �ʿ��� ���( �ڵ������� INSERT�� �ǵ���)
--    Ż��ȸ�� ������ ���� �и��Ͽ� ������ ��
-- 2) ������ ������ ���� �� (DEPARTMENT���� UPDATE�� �Ǿ��� ��)
--    �ش� �������� �����ϴ� ���(LOG���� INSERT�� ��)

/*
    CREATE TRIGGER Ʈ�����̸�
        BEFORE(OR AFTER)
        UPDATE(OR DELETE OR INSERT) ON  ���̺��
        [FOR EACH ROW]
    BEGIN
        (���๮)
    END;
    /
*/

-- # Ʈ������ �Ӽ�
/*
    1.BEFORE: ������ ó���� ����Ǳ� �� ����
    2.AFTER: ������ ó���� ����� �� ����
    3.FOR EACH ROW: ������ ó�� �� �Ǻ���(�ະ��) ����,�෹�� Ʈ����
    4.OLD.�÷��� : ���ε庯��, DELETE���� �� ������ ������ ����
    5.NEW.�÷��� : ���ε庯��, INSERT�߰� �� ������ ������ ���� UPDATE�� �� ��
*/
CREATE TABLE EMP_TEMP AS SELECT EMP_ID,EMP_NAME FROM EMPLOYEE;


--����1. ��� ���̺� ���ο� �����Ͱ� ������"���Ի���� �Ի��Ͽ����ϴ�"�� ����ϱ�.
CREATE OR REPLACE TRIGGER TRG_EMP_NEW
    AFTER
    INSERT ON EMP_TEMP
    FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('���� ����� �Ի��߽��ϴ�.');
END;
/
DROP TRIGGER TRG_EMP_NEW;

INSERT INTO EMP_TEMP VALUES('230','ȫ�浿');
COMMIT;

ALTER TABLE EMP_TEMP ADD (SALARY NUMBER);
SELECT * FROM EMP_TEMP;
INSERT INTO EMP_TEMP SELECT SALARY FROM EMPLOYEE;

--## �ǻ緹�ڵ� OLD, NEW
-- FOR EACH ROW�� ����ؾ� ��
-- 1. INSERT Ʈ���� : OLD -> NULL, NEW -> �����ͺ������� ���ڵ�
-- 2. UPDATE Ʈ���� : OLD -> �����ͺ����� ���ڵ�, NEW -> �����ͺ������� ���ڵ�
-- 3. DELETE Ʈ���� : OLD -> �����ͺ����� ���ڵ�, NEW -> NULL
CREATE TABLE EMP_SAL_TBL
AS SELECT * FROM EMPLOYEE;

-- ����2. �޿����� ���������� ȭ�鿡 ����ϴ� Ʈ���Ÿ� �����غ���
CREATE OR REPLACE TRIGGER TRG_EMP_SAL
    BEFORE
    UPDATE ON EMP_SAL_TBL
    FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('���� �� :' || :OLD.SALARY);
    DBMS_OUTPUT.PUT_LINE('���� �� :' || :NEW.SALARY);
END;
/

SELECT * FROM USER_TRIGGERS;
UPDATE EMP_SAL_TBL SET SALARY = SALARY*2 WHERE EMP_ID = '205';
COMMIT;

--����3. ��ǰ ���̺��� �����ϰ� ��ǰ �԰� �� ��ǰ��� ���̺��� ��ġ�� �����غ���
--   Ʈ���Ÿ� ����� ��� ������ �ڵ����� ��� �Էµǵ��� �غ���.
--1. ��ǰ���̺� PRODUCT 
--2. ��ǰ ����� PRODUCT_IO
CREATE TABLE PRODUCT(
  PCODE NUMBER PRIMARY KEY,
  PNAME VARCHAR2(30),
  BRAND VARCHAR2(30),
  PRICE NUMBER,
  STOCK NUMBER DEFAULT 0
);

CREATE TABLE PRODUCT_IO(
  IOCODE NUMBER PRIMARY KEY,
  PCODE NUMBER,
  PDATE DATE,
  AMOUNT NUMBER,
  STATUS VARCHAR2(10) CHECK (STATUS IN ('�԰�', '���')),
  CONSTRAINT FK_PRODUCT_IO FOREIGN KEY (PCODE) REFERENCES PRODUCT(PCODE)
);

--SEQUENCE ����
CREATE SEQUENCE SEQ_PRODUCT_PCODE
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOMINVALUE
NOCYCLE
NOCACHE;

CREATE SEQUENCE SEQ_PRODUCTIO_IOCODE
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOMINVALUE
NOCYCLE
NOCACHE;

SELECT * FROM PRODUCT;

INSERT INTO PRODUCT
VALUES (SEQ_PRODUCT_PCODE.NEXTVAL,'����������4','�Ｚ','2400000',DEFAULT);
INSERT INTO PRODUCT
VALUES (SEQ_PRODUCT_PCODE.NEXTVAL,'������14','����','2000000',DEFAULT);
INSERT INTO PRODUCT
VALUES (SEQ_PRODUCT_PCODE.NEXTVAL,'�ȼ�','������','500000',DEFAULT);
COMMIT;
--Ʈ���� ����
--�԰�, ���� �� PRODUCT ���̺� STOCK���� ������Ʈ�� �Ǿ����
CREATE OR REPLACE TRIGGER TRG_PRODUCT_STOCK
    AFTER
    INSERT ON PRODUCT_IO
    FOR EACH ROW
BEGIN
    IF:NEW.STATUS = '�԰�' 
    THEN
       UPDATE PRODUCT
       SET STOCK = STOCK + :NEW.AMOUNT;
       WHERE PRODUCT.PCODE = :NEW.PCODE;
    ELSE
        UPDATE PRODUCT
        SET STOCK = STOCK - :NEW.AMOUNT;
        WHERE PRODUCT.PCODE = :NEW.PCODE;
END;
/


CREATE OR REPLACE TRIGGER TRG_PRODUCT_STOCK
    AFTER
    INSERT ON PRODUCT_IO
    FOR EACH ROW
BEGIN
    IF :NEW.STATUS = '�԰�'
    THEN UPDATE PRODUCT SET STOCK = STOCK + :NEW.AMOUNT WHERE PCODE = :NEW.PCODE;
    ELSE UPDATE PRODUCT SET STOCK = STOCK - :NEW.AMOUNT WHERE PCODE = :NEW.PCODE;
    END IF;
END;
/

INSERT INTO PRODUCT_IO VALUES(SEQ_PRODUCTIO_IOCODE.NEXTVAL, 1, SYSDATE,5, '�԰�');
INSERT INTO PRODUCT_IO VALUES(SEQ_PRODUCTIO_IOCODE.NEXTVAL, 2, SYSDATE,10, '�԰�');
INSERT INTO PRODUCT_IO VALUES(SEQ_PRODUCTIO_IOCODE.NEXTVAL, 3, SYSDATE,3, '�԰�');
INSERT INTO PRODUCT_IO VALUES(SEQ_PRODUCTIO_IOCODE.NEXTVAL, 1, SYSDATE,3, '���');
INSERT INTO PRODUCT_IO VALUES(SEQ_PRODUCTIO_IOCODE.NEXTVAL, 2, SYSDATE,7, '���');
ROLLBACK;

SELECT * FROM PRODUCT_IO;
SELECT * FROM PRODUCT;
--���� �μ�Ʈ�� �ϴµ� ��� ������ �Ǵ� ��!
--Ʈ���Ÿ� ������ �Ŀ��� PRODUCT_IO���̺� �԰� �ϸ� STOCK+1�ϰ�
--��� �ϸ� STOCK-1�� �ǵ��� ����

--@�ǽ�����
--1. EMPLOYEE���̺��� ����ڰ����� ������ ���̺� TBL_EMP_QUIT���� �Ϸ��� �Ѵ�.
--������ ���� TBL_EMP_JOIN, TBL_EMP_QUIT���̺��� �����ϰ�, TBL_EMP_JOIN���� DELETE�� �ڵ����� ����� �����Ͱ� TBL_EMP_QUIT�� INSERT�ǵ��� Ʈ���Ÿ� �����϶�.

--TBL_EMP_JOIN ���̺� ���� : QUIT_DATE, QUIT_YN ����
--2. ������泻���� ����ϴ� emp_log���̺��� �����ϰ�, ������̺��� insert, update�� ���� ������ �űԵ����͸� ����ϴ� Ʈ���Ÿ� �����϶�.
--�α����̺�� emp_log : �÷� log_no(��������ü�κ��� ä����. pk), log_date(�⺻�� sysdate, not null), emp���̺��� ��� �÷�
--Ʈ���Ÿ� trg_emp_log


SELECT * FROM ROLE_SYS_PRIVS WHERE ROLE='DBA';
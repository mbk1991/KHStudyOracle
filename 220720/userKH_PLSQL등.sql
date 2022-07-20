--PL/SQL
-->Procedural Language extension to SQL�� ����
-->����Ŭ ��ü�� ����Ǿ� �ִ� ������ ���ν�, SQL�� ������ �����Ͽ�
--SQL���� ������ ������ ����, ����ó��, �ݺ�ó�� ���� ������

--#PL/SQL ��� ����
/*
    DECLARE
        [�����]      - ����
    BEGIN
        [�����]      - �ʼ�
    EXCEPTION
        [����ó����]  -����
    END;
    /



*/

--#�⺻����
SET SERVEROUTPUT ON;  --�õ��ɱ�
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello PL/SQL'); 
END;
/

--# ���� ����
-- ������ [CONSTANT] �ڷ��� (����Ʈũ��) [NOT NULL] [:=�ʱⰪ];
DECLARE
    EMPNO NUMBER := 1720;
    ENAME VARCHAR2(20) := '�տ���';
BEGIN
    DBMS_OUTPUT.PUT_LINE('���: ' || EMPNO);
    DBMS_OUTPUT.PUT_LINE('�̸�: ' || ENAME);
END;
/
-- # ������ ����
-- �Ϲ�(��Į��)����, ���, %TYPE, %ROWTYPE, ���ڵ�(Record)

-- # ��� : �Ϲݺ����� �����ϳ� constant��� Ű���尡 �ڷ��� �տ� �ٰ�
-- ���� �ÿ� ���� �Ҵ����־�� ��

DECLARE
    USER_NAME CONSTANT VARCHAR2(20) := '�Ͽ���';
    USER_NAME2 VARCHAR2(20) := '�̿���';
BEGIN
    DBMS_OUTPUT.PUT_LINE('����� : ' || USER_NAME);
    DBMS_OUTPUT.PUT_LINE('������ : ' || USER_NAME2);
END;
/

-- PL/SQL���� SELECT��
--> SQL���� ����ϴ� ��ɾ �״�� ����� �� ������ SELECT ���� ����� ���� ����
--������ �Ҵ��ϱ� ���� ����� .SELECT�� ���� ������ �ְ� ������ ����ϴ� ����.

DECLARE
    VEMPNO EMPLOYEE.EMP_NO%TYPE;
    VENAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN
    SELECT EMP_NO, EMP_NAME
    INTO VEMPNO, VENAME
    FROM EMPLOYEE
    WHERE EMP_NAME = '������';
    DBMS_OUTPUT.PUT_LINE('�ֹε�Ϲ�ȣ: ' || VEMPNO);
    DBMS_OUTPUT.PUT_LINE('�̸�: ' ||VENAME);
END;
/

--���� 2)
--�����ȣ�� �Է� �޾Ƽ� ����� �����ȣ, �̸�, �޿�, �Ի����� ����Ͻÿ�
DECLARE
    VEMP_ID EMPLOYEE.EMP_ID%TYPE;
    VEMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    VSALARY EMPLOYEE.SALARY%TYPE;
    VHIRE_DATE EMPLOYEE.HIRE_DATE%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE
    INTO VEMP_ID,VEMP_NAME,VSALARY,VHIRE_DATE
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMP_ID';
    
    DBMS_OUTPUT.PUT_LINE('VEMP_ID:' || VEMP_ID);
    DBMS_OUTPUT.PUT_LINE('VEMP_NAME:' || VEMP_NAME);
    DBMS_OUTPUT.PUT_LINE('VSALARY: ' || VSALARY);
    DBMS_OUTPUT.PUT_LINE('VHIRE_DATE:' || VHIRE_DATE);
END;
/

--����1)
--��� ��ȣ�� �Է� �޾Ƽ� ���� ����� �����ȣ,�̸�,�μ��ڵ�,�μ����� ����ϵ��� �Ͻÿ�
DECLARE
    VEMP_ID EMPLOYEE.EMP_ID%TYPE;
    VEMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    VDEPT_CODE EMPLOYEE.DEPT_CODE%TYPE;
    VDEPT_TITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
    INTO VEMP_ID, VEMP_NAME, VDEPT_CODE, VDEPT_TITLE
    FROM EMPLOYEE JOIN DEPARTMENT ON ( DEPT_CODE = DEPT_ID)
    WHERE EMP_ID = '&EMP_ID';
    
    DBMS_OUTPUT.PUT_LINE('�����ȣ:' || VEMP_ID);
    DBMS_OUTPUT.PUT_LINE('�̸�:' || VEMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�μ��ڵ�:' || VDEPT_CODE);
    DBMS_OUTPUT.PUT_LINE('�μ���:' || VDEPT_TITLE);
    
END;
/


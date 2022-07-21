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

--Stored Procedure
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

EXECUTE PROC_SELECT_EMP_ID (&�����ȣ);
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

--## ���� �ǽ� 1 ##
-- �ش� ����� �����ȣ�� �Է½�
-- �̸�,�μ��ڵ�,�����ڵ尡 ��µǵ��� PL/SQL�� ����� ���ÿ� 
DECLARE
    VEMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    VDEPT_CODE EMPLOYEE.DEPT_CODE%TYPE;
    VJOB_CODE EMPLOYEE.JOB_CODE%TYPE;
BEGIN
    SELECT EMP_NAME, DEPT_CODE,JOB_CODE
    INTO VEMP_NAME, VDEPT_CODE, VJOB_CODE
    FROM EMPLOYEE
    WHERE EMP_ID ='&EMP_ID';
    DBMS_OUTPUT.PUT_LINE('�̸�:' || VEMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�μ��ڵ�:' || VDEPT_CODE);
    DBMS_OUTPUT.PUT_LINE('�����ڵ�:' || VJOB_CODE);
END;
/

--## ���� �ǽ� 2 ##
-- �ش� ����� �����ȣ�� �Է½�
-- �̸�,�μ���,���޸��� ��µǵ��� PL/SQL�� ����� ���ÿ�

DECLARE
    VEMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    VDEPT_TITLE DEPARTMENT.DEPT_TITLE%TYPE;
    VJOB_NAME JOB.JOB_NAME%TYPE;
BEGIN
    SELECT EMP_NAME,DEPT_TITLE,JOB_NAME
    INTO VEMP_NAME,VDEPT_TITLE,VJOB_NAME
    FROM EMPLOYEE E LEFT JOIN DEPARTMENT D ON DEPT_ID = DEPT_CODE
                    LEFT JOIN JOB J ON E.JOB_CODE =  J.JOB_CODE
    WHERE EMP_ID = '&EMP_ID';
    
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || VEMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�μ��� : ' || VDEPT_TITLE);
    DBMS_OUTPUT.PUT_LINE('���޸� : ' || VJOB_NAME);
    
END;
/
--PL/SQL�� ���ù�
--��� ������� ����� ������� ���������� �����
-- ������ ���������� �����Ϸ��� IF���� ����ϸ餧 �ʤ�
--IF THEN END IF; ��

--����) �����ȣ�� ������ ����� ���,�̸�,�޿�,���ʽ����� ����ϰ�
--���ʽ����� ������ '���ʽ��� ���޹��� �ʴ� ����Դϴ�'�� ����Ͻÿ�

DECLARE
    VEMP_ID EMPLOYEE.EMP_ID%TYPE;
    VEMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    VSALARY EMPLOYEE.SALARY%TYPE;
    VBONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS,0)
    INTO VEMP_ID, VEMP_NAME, VSALARY, VBONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMP_ID';
    
    IF(VBONUS = 0)
    THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�.');
    ELSE
    DBMS_OUTPUT.PUT_LINE('���:' || VEMP_ID);
    DBMS_OUTPUT.PUT_LINE('�̸�:' || VEMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�޿�:' || VSALARY);
    DBMS_OUTPUT.PUT_LINE('���ʽ���:' || VBONUS*100 ||'%');
    END IF;
END;
/

--����) ����ڵ带 �Է¹޾��� �� ���,�̸�,�����ڵ�,���޸�,�Ҽ� ���� ����Ͻÿ�
--�׶�, �ҼӰ��� J1,J2�� �ӿ���, �� �ܿ��� �Ϲ��������� ��µǰ� �Ͻÿ�.

DECLARE
    VEMP_ID EMPLOYEE.EMP_ID%TYPE;
    VEMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    VJOB_CODE EMPLOYEE.JOB_CODE%TYPE;
    VJOB_NAME JOB.JOB_NAME%TYPE;
    ETEAM VARCHAR2(30);

BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
    INTO VEMP_ID, VEMP_NAME, VJOB_CODE, VJOB_NAME
    FROM EMPLOYEE LEFT JOIN JOB USING(JOB_CODE)
    WHERE EMP_ID = '&EMP_ID';
    
    IF(VJOB_CODE IN('J1','J2'))
    THEN ETEAM := '������';
    ELSE ETEAM := '�Ϲ�����';
    END IF;


    DBMS_OUTPUT.PUT_LINE('���: ' ||VEMP_ID);
    DBMS_OUTPUT.PUT_LINE('�̸�: ' ||VEMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�����ڵ�: ' ||VJOB_CODE);
    DBMS_OUTPUT.PUT_LINE('���޸�: ' ||VJOB_NAME);
    DBMS_OUTPUT.PUT_LINE('�Ҽ�: ' || ETEAM);
    
END;
/




--## ���� �ǽ� 1 ##
-- ��� ��ȣ�� ������ �ش� ����� ��ȸ
-- �̶� �����,�μ��� �� ����Ͽ���.
-- ���� �μ��� ���ٸ� �μ����� ������� �ʰ�,
-- '�μ��� ���� ��� �Դϴ�' �� ����ϰ�
-- �μ��� �ִٸ� �μ����� ����Ͽ���.

DECLARE
    VEMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    VDEPT_TITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
    SELECT EMP_NAME, DEPT_TITLE
    INTO VEMP_NAME, VDEPT_TITLE
    FROM EMPLOYEE LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    WHERE EMP_ID = '&�����ȣ';
    
     DBMS_OUTPUT.PUT_LINE('�̸� : ' || VEMP_NAME);
    IF(VDEPT_TITLE IS NULL)
    THEN 
        DBMS_OUTPUT.PUT_LINE('�μ��� ���� ����Դϴ�.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('�μ� : ' || VDEPT_TITLE);
    END IF;

END;
/


--IF
--IF THEN
--ELSIF THEN
--ELSE
--END IF;

--## �ǽ� ���� ##
--����� �Է� ���� �� �޿��� ���� ����� ������ ����ϵ��� �Ͻÿ� 
--�׶� ��� ���� ���,�̸�,�޿�,�޿������ ����Ͻÿ�

--0���� ~ 99���� : F
--100���� ~ 199���� : E
--200���� ~ 299���� : D
--300���� ~ 399���� : C
--400���� ~ 499���� : B
--500���� �̻�(�׿�) : A

--ex) 200
--��� : 200
--�̸� : ������
--�޿� : 8000000
--��� : A
DECLARE
    VEMP_ID EMPLOYEE.EMP_ID%TYPE;
    VEMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    VSALARY EMPLOYEE.SALARY%TYPE;
    SALGRADE VARCHAR2(2);
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO VEMP_ID, VEMP_NAME, VSALARY
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMP_ID';
    /*
    IF(VSALARY >=0 AND VSALARY <1000000) THEN SALGRADE := 'F';
    ELSIF(VSALARY >=1000000 AND VSALARY <2000000) THEN SALGRADE := 'E';
    ELSIF(VSALARY >=2000000 AND VSALARY <3000000) THEN SALGRADE := 'D';
    ELSIF(VSALARY >=3000000 AND VSALARY <4000000) THEN SALGRADE := 'C';
    ELSIF(VSALARY >=4000000 AND VSALARY <5000000) THEN SALGRADE := 'B';
    ELSE SALGRADE := 'A';
    END IF;
    */
    CASE FLOOR(VSALARY/1000000)
        WHEN 0 THEN SALGRADE := 'F';
        WHEN 1 THEN SALGRADE := 'E';
        WHEN 2 THEN SALGRADE := 'D';
        WHEN 3 THEN SALGRADE := 'C';
        WHEN 4 THEN SALGRADE := 'B';
        ELSE SALGRADE := 'A';
    END CASE;
    
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || VEMP_ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || VEMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || VSALARY);
    DBMS_OUTPUT.PUT_LINE('�޿���� : ' || SALGRADE);
END;
/



--CASE ��
/*
    CASE ����
        WHEN ��1 THEN ���๮;
        WHEN ��2 THEN ���๮;
        ELSE ���๮
    END CASE;

*/

-- ���� ) 1~3������ ���� �Է¹ް� 1�� �Է¹����� 	'1�� �Է��Ͽ����ϴ�', 2�� �Է� ������ '2�� �Է��Ͽ����ϴ�',
-- 3�� �Է¹����� '3�� �Է��Ͽ����ϴ�'�� ����Ͻÿ�. �׿� ���� �Է½� �߸� �Է��Ͽ����ϴٸ� ���
DECLARE
    INPUTVALUE NUMBER;
BEGIN
    INPUTVALUE :='&INPUT';
    CASE INPUTVALUE
        WHEN 1 THEN DBMS_OUTPUT.PUT_LINE(INPUTVALUE || '��(��) �Է��Ͽ����ϴ�.');
        WHEN 2 THEN DBMS_OUTPUT.PUT_LINE(INPUTVALUE || '��(��) �Է��Ͽ����ϴ�.');
        WHEN 3 THEN DBMS_OUTPUT.PUT_LINE(INPUTVALUE || '��(��) �Է��Ͽ����ϴ�.');
        ELSE DBMS_OUTPUT.PUT_LINE('�߸��Է��ϼ̽��ϴ�.');
    END CASE;
END;
/

--# PL/SQL �ݺ���
--BASIC LOOP : ���Ǿ��� ���� �ݺ�
--LOOP
--END LOOP;

DECLARE 
    N NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        N := N+1;
        IF N > 5 THEN EXIT;
        END IF;
    END LOOP;
END;
/

--# FOR LOOP
-->ī��Ʈ�� ������ �ڵ����� �����, ���� ������ ������ �ʿ䰡 ����
--ī��Ʈ ���� �ڵ����� 1�� ������. REVERSE�� ����ϸ� 1�� ������

BEGIN
    FOR N IN  REVERSE 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/

--FOR LOOP���� Ȱ��. �������� �����͸� ����ϱ�.
DECLARE
    VEMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    VSALARY EMPLOYEE.SALARY%TYPE;
BEGIN
    FOR N IN 0..4 LOOP
        SELECT EMP_NAME, SALARY
        INTO VEMP_NAME, VSALARY
        FROM EMPLOYEE
        WHERE EMP_ID = 200+N;
        
        DBMS_OUTPUT.PUT_LINE ( '�̸� : ' || VEMP_NAME);
        DBMS_OUTPUT.PUT_LINE ( '�޿� : ' || VSALARY);
          
    END LOOP;
END;
/


-- ����) 1~10 ���� �ݺ��Ͽ� TEST1 ���̺� �����Ͱ� ����ǰ� �Ͻÿ�
-- TEST1(BUNHO, B_DATE)

CREATE TABLE TEST1(
    BUNHO NUMBER PRIMARY KEY,
    B_DATE DATE DEFAULT SYSDATE
);

DROP TABLE TEST1;


BEGIN
    FOR N IN 11..20 LOOP
    INSERT INTO TEST1 VALUES(N,SYSDATE);
    END LOOP;
END;
/
SELECT BUNHO, TO_CHAR(B_DATE,'YYYY"��" MM"��" DD"��" HH"��" MI"��"') FROM TEST1;
ROLLBACK;

--# WHILE LOOP
--���� ������ TRUE�� ���ȸ� ������ �ݺ������
--LOOP�� ������ �� ������ ó������ FALSE�̸� �ѹ��� ������� ����
--EXIT�� ���̵� �������� �ݺ��� ���� ������ ����� �� ����
/*
    WHILE �ݺ���ų ���ǹ� LOOP
            (���๮)
    END LOOP;
*/

DECLARE
 N NUMBER := 1;
BEGIN
    WHILE N <= 5 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        N:=N+1;
    END LOOP;
END;
/

-- �ǽ�����
-- ����ڷκ��� 2~9������ ���� �Է¹޾� ������ ����Ͻÿ�
DECLARE
    N NUMBER := 1;
    INPUT NUMBER := '&INPUT';
BEGIN
    IF INPUT BETWEEN 2 AND 9 THEN
        WHILE N <10 LOOP
            DBMS_OUTPUT.PUT_LINE(N * INPUT);
            N := N+1;
        END LOOP;
    ELSE DBMS_OUTPUT.PUT_LINE('2~9���̸� �Է��ϼ���.');
        INPUT := '&INPUT';
    END IF;
END;
/


-- Ȧ���ܸ� ����ϱ�..

DECLARE
    N NUMBER := 1;
    INPUT NUMBER := '&INPUT';
BEGIN
     WHILE N <= INPUT LOOP
        IF(MOD(N,2) = 0) 
        THEN DBMS_OUTPUT.PUT_LINE(N);
        END IF;
        N := N+1;
     END LOOP;
END;
/


-- TOP N �м��� ���� PL/SQL�� ������
-- '�޿�' / '���ʽ�' / '�Ի���' Ű�����Է�.
-- ������ 1��~5�� ������ ����ϴ� PL/SQL�� ������.
--TOP N �м��� ���� �Լ��� ����� �ʾ����� ã�ƺ��鼭 ������.

DECLARE 
   -- VEMP_NAME EMPLOYEE.EMP_NAME%TYPE;
   -- VSALARY EMPLOYEE.SALARY%TYPE;
   -- VBONUS EMPLOYEE.BONUS%TYPE;
   -- VHIRE_DATE EMPLOYEE.HIRE_DATE%TYPE;
    KEYWORD NUMBER(1);
BEGIN
    KEYWORD := &Ű����;
    CASE 
        WHEN 1 THEN DBMS_OUTPUT.PUT_LINE('�޿���ŷ');
                SELECT EMP_NAME, SALARY 
                INTO VEMP_NAME, VSALARY
                FROM (SELECT EMP_NAME, SALARY FROM EMPLOYEE 
                        ORDER BY 2 DESC)
                WHERE NUMS <=5;
              
            
        WHEN 2 THEN DBMS_OUTPUT.PUT_LINE('���ʽ���ŷ');
        WHEN 3 THEN DBMS_OUTPUT.PUT_LINE('�Ի��Ϸ�ŷ');
        ELSE DBMS_OUTPUT.PUT_LINE('�ùٸ� Ű���带 �Է��ϼ���');
    END CASE;
END;
/

--# ����ó��
/*DECLARE
BEGIN
EXCEPTION
END;
*/
--#Exception�� ����
/*
    1.ACCESS_INTO_NULL
    2.CASE_NOT_FOUND
    3.COLLECTION_IS_NULL
    4.CURSOR.ALREADY_OPEN
    ...
    5.LOGIN_DENIED
    6.NO_DATA_FOUND
    ���...
*/
/*
    EXCEPTION
        WHEN �����̸�1 THEN ó������1
        WHEN �����̸�2 THEN ó������2
    END;
    /

*/
--NO_DATA_FOUND
--�����ȣ�� �Է¹޾Ƽ� ����̸�, �޿� �̸��� ���
DECLARE
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    ESAL EMPLOYEE.SALARY%TYPE;
    EMAIL EMPLOYEE.EMAIL%TYPE;
BEGIN
    SELECT EMP_NAME, SALARY, EMAIL
    INTO ENAME, ESAL, EMAIL
    FROM  EMPLOYEE
    WHERE EMP_ID = &�����ȣ;
    DBMS_OUTPUT.PUT_LINE ( '�̸�:' || ENAME);
    DBMS_OUTPUT.PUT_LINE ( '�޿�:' || ESAL);
    DBMS_OUTPUT.PUT_LINE ( '�̸���:' || EMAIL);
EXCEPTION
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('�������� �ʴ� ����Դϴ�.');
END;
/

--2. ����� 200�� ����� ����� 200������ �ٲٷ��� �� ��
-- DUB_VAL_ON_INDEX
BEGIN
 --   INSERT INTO EMPLOYEE 
   -- VALUES(200,'�Ͽ���','888888-1111111','khuser01@iei.or.kr',
   --     '01000000000','D5','J3','S4',3000000,0.3,203,SYSDATE,DEFAULT,DEFAULT);
        
    UPDATE EMPLOYEE SET EMP_ID := &�����ȣ WHERE EMP_ID = '200';
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('�̹� �����ϴ� ����Դϴ�.');
END;
/
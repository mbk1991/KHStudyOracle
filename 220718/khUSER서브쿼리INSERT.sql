--���������� �̿��� INSERT

CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)
    );
SELECT * FROM EMP_01;

--���������� �̿��Ͽ� ���� �����͸� �̾Ƽ� INSERT�Ѵ�

INSERT INTO EMP_01
(   SELECT EMP_ID, EMP_NAME,DEPT_TITLE
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    );
    

--CREATE & SUBQUERY
--���̺� ���� -> �÷��� ����, �÷���, �÷��� Ÿ�� .. ��� ���� ->��Ű����� �Ѵ�.
--���̺� ��Ű���� ��� �ǳ�? ��� ǥ��
DESC EMPLOYEE;
CREATE TABLE EMPLOYEE_COPY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE  --*�� ��ü ���簡��, ���ø� ���� ���ݸ� ��.
    FROM EMPLOYEE
    WHERE 1 = 0;   -- FALSE��
    
DESC EMPLOYEE_COPY;
SELECT * FROM EMPLOYEE_COPY;

CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
FROM EMPLOYEE
WHERE 1 = 0;
SELECT * FROM EMP_MANAGER;
DELETE FROM EMP_MANAGER;

COMMIT;

--INSERT & SUBQUERY
--INSERT ALL > �ѹ��� 2�� ���̺� ������ �ֱ�.
--[EMPLOYEE_COPY ���̺� EMPLOYEE���̺��� �μ� �ڵ尡 D2�� ������ ��ȸ��
--���, �̸�, �ҼӺμ�, �Ի����� �����ϰ�, 
--EMP_MANAGER ���̺� EMPLOYEE ���̺��� �μ� �ڵ尡 D2�� ������
--���, �̸�, �����ڻ���� ��ȸ�ؼ� �����ϼ���]

--�ѹ��� ������ �� ���� ���̺� ����. ��Ȳ�� ���� ��� ����ϸ� ����.
INSERT ALL
INTO EMPLOYEE_COPY VALUES(EMP_ID, EMP_NAME, DEPT_CODE,HIRE_DATE)
INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID -- �� ���̺� �ѹ��� ���� ���� �� �ʿ��� �÷��� �� �Է��ؾ��Ѵ�.
FROM EMPLOYEE WHERE DEPT_CODE = 'D1';


--UPDATE & SUBQUERY
--������������ �� ���� �ִ� ���̽� �Ұ�
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE,SALARY,BONUS
FROM EMPLOYEE;

UPDATE EMP_SALARY
SET SALARY = (SELECT SALARY FROM EMP_SALARY WHERE EMP_NAME = '�����'),
    BONUS = (SELECT BONUS FROM EMP_SALARY WHERE EMP_NAME = '�����')
WHERE EMP_NAME = '������';

SELECT * FROM EMP_SALARY;

ROLLBACK;

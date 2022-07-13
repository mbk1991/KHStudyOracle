SHOW USER;
--INSERT
INSERT INTO EMPLOYEE
VALUES('900',
    '��ä��',
    '901123-2080503',
    'jang_ch@kh.or.kr',
    '01000000000',
    'D1',
    'J8',
    'S3',
    430000,
    0.2,
    '200',
    SYSDATE,
    NULL,
    'N');
    
    DESC DEPARTMENT;
    SELECT DEPT_ID, DEPT_TITLE FROM DEPARTMENT;
    UPDATE DEPARTMENT
    SET DEPT_TITLE = '������ȹ��'
    WHERE DEPT_ID = 'D9';
    
    DELETE
    FROM EMPLOYEE
    WHERE EMP_NAME = '��ä��';
    
    --DQL SELECT ����
    
    SELECT EMP_ID, EMP_NAME, SALARY
    FROM EMPLOYEE;
    
    --AS�� �ֵ���ǥ�� ����ϸ� ������ �����ϴ�. ����ϴ� Į���� �̸��� ������
    SELECT EMP_NAME, SALARY, SALARY * 12 AS "����", '��' "����"
    FROM EMPLOYEE;

-- 1. JOB���̺��� JOB_NAME�� ������ ��µǵ��� �Ͻÿ�
SELECT JOB_NAME
FROM JOB;

-- 2. DEPARTMENT���̺��� ���� ��ü�� ����ϴ� SELECT���� �ۼ��Ͻÿ�

SELECT * FROM DEPARTMENT;


-- 3. EMPLOYEE ���̺��� �̸�(EMP_NAME),�̸���(EMAIL),
-- ��ȭ��ȣ(PHONE),�����(HIRE_DATE)�� ����Ͻÿ�

SELECT EMP_NAME,EMAIL,PHONE,HIRE_DATE FROM EMPLOYEE;

-- 4. EMPLOYEE ���̺��� �����(HIRE_DATE) �̸�(EMP_NAME),����(SALARY)�� ����Ͻÿ�

SELECT HIRE_DATE, EMP_NAME, SALARY
FROM EMPLOYEE;

-- 5. EMPLOYEE ���̺��� ����(SALARY)�� 2,500,000���̻��� ����� 
-- EMP_NAME �� SAL_LEVEL�� ����Ͻÿ� 
-- (��Ʈ : >(ũ��) , <(�۴�) �� �̿�)

SELECT EMP_NAME, SAL_LEVEL, SALARY
FROM EMPLOYEE
WHERE SALARY > 2500000;

-- 6. EMPLOYEE ���̺��� ����(SALARY)�� 350���� �̻��̸鼭 
-- JOB_CODE�� 'J3' �� ����� 
-- �̸�(EMP_NAME)�� ��ȭ��ȣ(PHONE)�� ����Ͻÿ�
-- (��Ʈ : AND(�׸���) , OR (�Ǵ�))

SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND JOB_CODE = 'J3';


-- ���� �ǽ� ����
--1. EMPLOYEE ���̺��� �̸�,����, �Ѽ��ɾ�(���ʽ�����), 
-- �Ǽ��ɾ�(�� ���ɾ�-(����*���� 3%*12))
--�� ��µǵ��� �Ͻÿ�

SELECT 
    EMP_NAME "�̸�",
    SALARY*12 "����",
    SALARY*(1+BONUS)"�Ѽ��ɾ�(���ʽ�����)",
    SALARY*12 - (SALARY*12*0.03)"�Ǽ��ɾ�"
FROM EMPLOYEE;

--2. EMPLOYEE ���̺��� �̸�, �ٹ� �ϼ��� ����غ��ÿ� 
--(SYSDATE�� ����ϸ� ���� �ð� ���)
SELECT 
    EMP_NAME"�̸�",
    SYSDATE - HIRE_DATE"�ٹ� �ϼ�"
FROM EMPLOYEE;

--3. EMPLOYEE ���̺��� 20�� �̻� �ټ����� �̸�,����,���ʽ����� ����Ͻÿ�.
SELECT 
    EMP_NAME"�̸�",
    SALARY"����",
    BONUS"���ʽ���"
FROM EMPLOYEE
WHERE (SYSDATE-HIRE_DATE)/365 > 20;



-- DISTINCT 
-- �÷��� ���Ե� �ߺ� ���� �ѹ����� ǥ���ϰ��� �� �� ���
SELECT DISTINCT JOB_CODE FROM EMPLOYEE;

-- ��������(AND, OR)
-- �μ��ڵ尡 D6�̰� �޿��� 2,000,000���� ���� �޴� 
-- ����� �̸�, �μ��ڵ�, �޿��� ��ȸ�Ͻÿ�.

SELECT EMP_NAME"�̸�",DEPT_CODE"�μ��ڵ�",SALARY"�޿�"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' AND SALARY> 2000000;


-- �μ��ڵ尡 D5 �Ǵ� �޿��� 3,000,000���� ���� �޴� 
-- ����� �̸�, �μ��ڵ�, �޿��� ��ȸ�Ͻÿ�

SELECT EMP_NAME"�̸�", DEPT_CODE"�μ��ڵ�", SALARY"�޿�"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY> 3000000;


-- ���� ������(||)
-- ���� �÷��� �ϳ��� �÷��� �� ó�� �����ϰų� �÷��� ���ͷ� ����
SELECT EMP_NAME||DEPT_CODE, SALARY|| '��' "�޿�"
FROM EMPLOYEE;


-- �񱳿����� ( >, >=, <, <=, .... )
-- BETWEEN A AND B
-- �޿��� 3500000�� �̻� �ް� 6000000�� ���Ϸ� �޴� ������ �̸��� �޿�
-- ��ȸ�Ͻÿ�

SELECT EMP_NAME"�̸�", SALARY"�޿�"
FROM EMPLOYEE
--WHERE SALARY>=3500000 AND SALARY<=6000000;
WHERE SALARY BETWEEN 3500000 AND 6000000;


-- BETWEEN AND
-- EMPLOYEE ���̺��� ������� 90/01/01 ~ 01/01/01�� �����
-- ��ü ������ ����Ͻÿ�

SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';


--�� ������(LIKE)
--���Ϸ��� ���� ������ Ư�������� ������Ű�� TRUE�� �����ϴ� ������
--'%' �� '_'�� ���ϵ�ī��� ����� �� ����
--*���ϵ� ī��: �ƹ� ���ڳ� ��ü�켭 ����� �� �ִ� ��

SELECT EMP_NAME, SALARY
FROM EMPLOYEE
--WHERE EMP_NAME = '�̿���' OR EMP_NAME = '���¸�';
WHERE EMP_NAME LIKE '��%';

SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%';  -- ���� �ִ� ��� ��찡 �� �˻���.
    
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��__';   -- �� ���� �� �ڸ��� ����

-- �ǽ�����
--1. EMPLOYEE ���̺��� �̸� ���� ������ ������ ����� �̸��� ����Ͻÿ�
SELECT EMP_NAME"�̸�" FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';


--2. EMPLOYEE ���̺��� ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ����� �̸�, ��ȭ��ȣ��
--����Ͻÿ�

SELECT EMP_NAME"�̸�",PHONE"��ȭ��ȣ"
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';


--3. EMPLOYEE ���̺��� �����ּ��� 's'�� ���鼭, DEPT_CODE�� D9 �Ǵ� D6�̰�
--������� 90/01/01 ~ 01/12/01�̸鼭, ������ 270�����̻��� ����� ��ü ������ ����Ͻÿ�

SELECT *
FROM EMPLOYEE
WHERE 
EMAIL LIKE '%s%' 
AND(DEPT_CODE = 'D9' OR DEPT_CODE = 'D6') 
AND HIRE_DATE BETWEEN '90/01/01' AND '01/12/01' 
AND SALARY >= 2700000;


--4. EMPLOYEE ���̺��� EMAIL ID �� @ ���ڸ��� 5�ڸ��� ������ ��ȸ�Ѵٸ�?
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '_____@%';


--5. EMPLOYEE ���̺��� EMAIL ID �� '_' ���ڸ��� 3�ڸ��� ������ ��ȸ�Ѵٸ�?
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '___!_%' ESCAPE '!';

--�񱳿����� (IN)
-- ���Ϸ��� �� ��Ͽ� ��ġ�ϴ� ���� ������ TRUE �� ��ȯ�ϴ� ������
-- EMPOYEE ���̺��� DEPT_CODE�� D9 �Ǵ� D6�� ������ �̸�, �޿��� ����Ͻÿ�.
-- OR�� ��ü�� �� �ִ�.

SELECT EMP_NAME, SALARY, DEPT_CODE FROM EMPLOYEE
WHERE DEPT_CODE IN('D9','D6','D5','D1');

--�񱳿����� (IS NULL/ IS NOT NULL)
--NULL ���θ� ���ϴ� ������

SELECT BONUS, MANAGER_ID
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;
    
    
-- 1. ������(MANAGER_ID)�� ���� �μ� ��ġ(DEPT_CODE)�� ���� ���� 
-- ������ �̸� ��ȸ

SELECT EMP_NAME"�̸�"
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

-- 2. �μ���ġ�� ���� �ʾ����� ���ʽ��� �����ϴ� ���� ��ü ���� ��ȸ

SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

--��������
--�ϳ��� SQL�� �ȿ� ���ԵǾ� �ִ� �� �ٸ� SQL�� (SELECT)
--�˷����� ���� ���ǿ� �ٰ��� ������ �˻��ϴ� SELECT������ �ۼ��ϴµ� ������
--�߿�) ���������� �ݵ�� �Ұ�ȣ�� ����� ��
--���������� �������� �����ʿ� ��ġ�ؾ� ��
--�������� ���� ORDER BY ������ �����ȵ�!


--1. ������ ��������
--ex) �޿� ��հ� �̻��� �޿��� �޴� ����� �˻��Ͻÿ�
SELECT AVG(SALARY) FROM EMPLOYEE;
-- ��հ��� ���� Ȯ���Ͽ�
SELECT * FROM EMPLOYEE
WHERE SALARY >= 3047662.60869565217391304347826086956522;
--���� ���� ������ ������ ��ȭ�� ������ �� ����.
--���� ���� ���� �ڸ��� �������� �־���
SELECT * FROM EMPLOYEE
WHERE SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEE);


--������ ������ ������ �̸��� ����Ͽ���.
SELECT MANAGER_ID FROM EMPLOYEE
WHERE EMP_NAME = '������';

SELECT EMP_NAME FROM EMPLOYEE
WHERE EMP_ID = (SELECT MANAGER_ID FROM EMPLOYEE
WHERE EMP_NAME = '������');

--@�ǽ����� 
--1. �����ؿ� �޿��� ���� ������� �˻��ؼ�, �����ȣ,����̸�, �޿��� ����϶�.

SELECT SALARY FROM EMPLOYEE
WHERE EMP_NAME = '������';

SELECT EMP_ID,EMP_NAME,SALARY FROM EMPLOYEE
WHERE SALARY = (SELECT SALARY FROM EMPLOYEE
WHERE EMP_NAME = '������');



--2. employee ���̺��� �⺻�޿��� ���� ���� ����� ���� ���� ����� ������ 
-- ���, �����, �⺻�޿��� ��Ÿ������.

SELECT MAX(SALARY) FROM EMPLOYEE;
SELECT MIN(SALARY) FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, SALARY FROM EMPLOYEE
WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE) OR
      SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);



--3. D1, D2�μ��� �ٹ��ϴ� ����� �߿���
--�⺻�޿��� D5 �μ� �������� '��տ���' ���� ���� ����鸸 
--�μ���ȣ, �����ȣ, �����, ������ ��Ÿ������.

SELECT AVG(SALARY) FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

SELECT DEPT_CODE, EMP_ID, EMP_NAME, SALARY FROM EMPLOYEE
WHERE SALARY = (SELECT AVG(SALARY) FROM EMPLOYEE
WHERE DEPT_CODE = 'D5');


--2.������ ��������
--���������� ��ȸ ��� ���� ���� �� �� ��
--������ �������� �տ��� �Ϲ� �񱳿����� ���Ұ�!
--��밡�� ������: IN / NOT IN, ANY, ALL, EXIST

--ex)�����⳪ �ڳ��� ���� �μ��� ���� ������� ������ ����Ͻÿ�.
SELECT DEPT_CODE FROM EMPLOYEE
WHERE EMP_NAME IN ('������','�ڳ���');

SELECT * FROM EMPLOYEE
WHERE DEPT_CODE IN(SELECT DEPT_CODE FROM EMPLOYEE
WHERE EMP_NAME IN ('������','�ڳ���'));

-- 2. ������ ��������
--@�ǽ�����
-- ������, ������ ����� �޿����(emplyee���̺��� sal_level�÷�)�� 
--���� ����� ���޸�, ������� ���.

SELECT SAL_LEVEL FROM EMPLOYEE
WHERE EMP_NAME IN ('���¿�','������');

SELECT JOB_CODE, EMP_NAME FROM EMPLOYEE
WHERE SAL_LEVEL IN(SELECT SAL_LEVEL FROM EMPLOYEE
WHERE EMP_NAME IN ('���¿�','������'));

--@�ǽ�����
--1.������ ��ǥ, �λ����� �ƴ� ��� ����� �μ����� ���. 
SELECT JOB_CODE FROM JOB
WHERE JOB_NAME IN('��ǥ','�λ���');

SELECT DEPT_CODE,COUNT(*) FROM EMPLOYEE
WHERE JOB_CODE NOT IN(SELECT JOB_CODE FROM JOB
WHERE JOB_NAME IN('��ǥ','�λ���'))
GROUP BY DEPT_CODE;

SELECT DEPT_TITLE, EMP_NAME FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE JOB_CODE NOT IN(SELECT JOB_CODE FROM JOB
WHERE JOB_NAME IN('��ǥ','�λ���'));


--2.Asia1������ �ٹ��ϴ� ��� �������, �μ��ڵ�, �����.(�������� ���α���)

SELECT DEPT_ID FROM LOCATION
JOIN DEPARTMENT ON LOCATION_ID = LOCAL_CODE
WHERE LOCAL_NAME = 'ASIA1';

SELECT DEPT_CODE,EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE IN(SELECT DEPT_ID FROM LOCATION
JOIN DEPARTMENT ON LOCATION_ID = LOCAL_CODE
WHERE LOCAL_NAME = 'ASIA1');

--�������� ��ġ�� WHERE �Ӹ� �ƴ϶� FROM �ڿ�, SELECT �ڿ� �� �� ����.
--��������� SELECT �ڿ� ���� ��! ��������� ������� 1���� ���� ��Į�� ������� �Ѵ�.
--�ζ��� ��� FROM�ڿ� ���� ��!

--3. ��� ��������(��ȣ����)
-->���� ������ ���� ���������� �ְ� ���������� ������ ���� �װ����
--�ٽ� ���������� ��ȯ�ؼ� �����ϴ� ���� (������ ������)
-->���������� WHERE ������ ���ؼ� ���������� ���� ����Ǵ� ����
-->�������� ���̺��� ���ڵ�(��)�� ���� ���������� ������� �ٲ�
--������������ ó���Ǵ� �� ���� �÷����� ���� ������ �޶������ϴ� ��쿡 ����

--3.1 EXISTS
--���������� ��� �߿��� �����ϴ� ���� �ϳ��� �����ϸ� ��

SELECT * FROM EMPLOYEE WHERE DEPT_CODE = (SELECT DEPT_ID FROM DEPARTMENT);

SELECT * FROM EMPLOYEE
WHERE 1 = 2;  -- �ƹ��͵� ��ȸ�� ���� ����. WHERE���� ���̸� SELECT���ǰ� �����̸� SELECT����������.

SELECT * FROM EMPLOYEE
WHERE EXISTS ( SELECT 1 FROM EMPLOYEE WHERE DEPT_CODE = '010');

--���� ������ ���������� ������ �ִ� ��. ���������� ���� �����ϸ� ���������� ���� ������
--���������� ���� �������� ������ ���������� ���� ������ ����
--�� �ึ�� ������üũ, ���� �����ϸ� ��, �ƴϸ� ����

--ex) ���������� �Ѹ��̶� �ִ� ���� ���
SELECT DISTINCT MANAGER_ID FROM EMPLOYEE;

SELECT EMP_NAME
FROM EMPLOYEE E
WHERE EXISTS (SELECT EMP_NAME FROM EMPLOYEE WHERE MANAGER_ID = E.EMP_ID);

--EX) DEPT_CODE �� ���� ��� �Ÿ���
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE E
WHERE EXISTS(SELECT 1 FROM DEPARTMENT WHERE DEPT_ID = E.DEPT_CODE);


--@�ǽ�����
--1. �ɺ��� ����� ���� �μ��� ����� �μ��ڵ�, �����, ����ձ޿��� ��ȸ.

SELECT DEPT_CODE, EMP_NAME, SALARY
FROM EMPLOYEE E
WHERE EXISTS(SELECT 1 FROM EMPLOYEE WHERE E.EMP_NAME = '�ɺ���');

SELECT DEPT_CODE, EMP_NAME
FROM EMPLOYEE E
--WHERE DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '�ɺ���');
WHERE EXISTS (SELECT 1 FROM EMPLOYEE WHERE DEPT_CODE = E.DEPT_CODE AND EMP_NAME='�ɺ���');


SELECT 1 FROM EMPLOYEE WHERE EMP_NAME='�ɺ���';


--2. ���帹�� �޿��� �޴� ����� exists ��� ���������� �̿��ؼ� ���϶�.
--not exists (�������� ���� ���޺��� ���� �޿��� �޴� ����� �������� ������ ��)

SELECT * FROM EMPLOYEE
WHERE SALARY >= (SELECT MAX(SALARY) FROM EMPLOYEE);

SELECT * FROM EMPLOYEE E
WHERE NOT EXISTS (SELECT 1 FROM EMPLOYEE WHERE SALARY < E.SALARY);

--3. ������ J1, J2, J3�� �ƴ� ����߿��� �ڽ��� �μ��� ��ձ޿����� ���� �޿��� �޴� ������.
-- �μ��ڵ�, �����, �޿�, �μ��� �޿����

SELECT E.DEPT_CODE , EMP_NAME, SALARY,AVG_SAL
FROM EMPLOYEE E JOIN (SELECT DEPT_CODE,ROUND(AVG(SALARY)) AVG_SAL  -- �ϳ��� ���̺�� ���� ��������.
FROM EMPLOYEE 
GROUP BY DEPT_CODE) A
ON E.DEPT_CODE = A.DEPT_CODE
WHERE JOB_CODE NOT IN ('J1','J2','J3') AND SALARY < AVG_SAL;

SELECT DEPT_CODE,ROUND(AVG(SALARY)) AVG_SAL  -- �ϳ��� ���̺�� ���� ��������.
FROM EMPLOYEE
GROUP BY DEPT_CODE;

--�̸� ��ȣ�������� ��Į�������� �Ѵٸ�

SELECT DEPT_CODE, EMP_NAME, SALARY, 
      (SELECT ROUND(AVG(SALARY)) FROM EMPLOYEE WHERE DEPT_CODE = E.DEPT_CODE)
FROM EMPLOYEE E
WHERE JOB_CODE NOT IN ('J1','J2','J3')AND SALARY > (SELECT ROUND(AVG(SALARY)) FROM EMPLOYEE WHERE DEPT_CODE = E.DEPT_CODE);

--4. ��Į�� ��������
--������� 1���� �����������, SELECT������ ����
--4.1 ��Į�� �������� -SELECT�� , WHERE�� ORDER BY���� �����ϱ��ϴ�.
--EX) ��� ����� ���, �̸�, �����ڻ��, �����ڸ��� ��ȸ�ϼ���!
SELECT E.EMP_NO, E.EMP_NAME,E.MANAGER_ID,
    ( SELECT EMP_NAME FROM EMPLOYEE M WHERE E.MANAGER_ID = M.EMP_ID) "�����ڸ�"
FROM EMPLOYEE E;

--4.2 ��Į�� �������� -WHERE��

--4.3 ��Į�� �������� -ORDER BY��

--@�ǽ�����
--1. �����, �μ���, �μ��� ����ӱ��� ��Į�󼭺������� �̿��ؼ� ���.
SELECT EMP_NAME, 
    (SELECT DEPT_TITLE FROM DEPARTMENT D WHERE D.DEPT_ID = E.DEPT_CODE)"�μ���", 
    (SELECT ROUND(AVG(SALARY)) FROM EMPLOYEE M WHERE M.DEPT_CODE = E.DEPT_CODE)"�μ��� ����ӱ�"
FROM EMPLOYEE E;

SELECT DEPT_TITLE FROM DEPARTMENT;

--2. ������ J1�� �ƴ� ����߿��� �ڽ��� �μ��� ��ձ޿����� ���� �޿��� �޴� ������.
-- �μ��ڵ�, �����, �޿�, �μ��� �޿����
SELECT DEPT_CODE, EMP_NAME, SALARY, 
        (SELECT ROUND(AVG(SALARY)) FROM EMPLOYEE M WHERE M.DEPT_CODE = E.DEPT_CODE )"�μ���ձ޿�"
FROM EMPLOYEE E
WHERE JOB_CODE != 'J1' AND SALARY < (SELECT ROUND(AVG(SALARY)) FROM EMPLOYEE M WHERE M.DEPT_CODE = E.DEPT_CODE );
--WHERE EXISTS(SELECT 1 FROM EMPLOYEE WHERE JOB_CODE != 'J1' AND

-- 5.�ζ��� ��  
--FROM���� ���������� ����� ���� �ζ��� �� ( INLINE_VIEW)��� ��
--EX) EMPLOYEE ���̺��� ������� ������ ���

SELECT * FROM EMPLOYEE WHERE SUBSTR(EMP_NO,8,1) = 2;

SELECT EMP_ID, EMP_NAME,DEPT_CODE,
    DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��','3','��','4','��')"����"
FROM EMPLOYEE
WHERE  DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��','3','��','4','��') = '��';

SELECT *
FROM (SELECT EMP_ID, EMP_NAME,DEPT_CODE,
    DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��','3','��','4','��')"����" FROM EMPLOYEE)
WHERE ���� = '��';

--ROWNUM�� �̿��Ͽ� ��ŷ TOP5 ���ϱ� , ROW������ ��ȣ�� ����
SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT EMP_NAME, SALARY FROM EMPLOYEE ORDER BY SALARY DESC)
WHERE ROWNUM < 6;
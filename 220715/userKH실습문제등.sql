-- �׷��Լ�    ������ �Լ� ������ �Լ�  / �������Լ��� �ٽ� �����Լ�, �׷��Լ�, ������ �Լ��� �з�.
--SUM, AVG, COUNT, MAX, MIN
--�������� �����Ͱ��� �޾Ƽ� ����� �ϳ��� ��Ÿ���� �Լ�.
SELECT *FROM TAB;

SELECT SALARY FROM EMPLOYEE;

SELECT ROUND(AVG(SALARY),2)"�޿� ���" FROM EMPLOYEE;

SELECT SUM(SALARY) FROM EMPLOYEE;

SELECT COUNT(*) FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

SELECT MAX(SALARY) FROM EMPLOYEE;

SELECT MIN(SALARY) FROM EMPLOYEE;

SELECT DEPT_CODE,
            (AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;


--GROUB BY��
--������ �׷��������� ����� �׷��Լ��� �� �� ���� ������� �����ϱ� ������,
--�׷��Լ��� �̿��Ͽ� �������� ������� �����ϱ� ���ؼ���
--�׷��Լ��� ����� �׷��� ������ GROUP BY���� ����Ͽ� ����ؾ���
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) < 7000000;

SELECT JOB_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY 1 ASC;

--[EMPLOYEE] ���̺��� �μ��ڵ� �׷캰 �޿��� �հ�, �׷캰 �޿��� ���(����ó��), �ο����� ��ȸ�ϰ�, �μ��ڵ� ������ ����
SELECT DEPT_CODE,
            SUM(SALARY)"�μ��� �޿��հ�",
            FLOOR(AVG(SALARY))"�μ��� �޿����",
            COUNT(*)"�μ��� �ο�"            
FROM EMPLOYEE
--WHERE
GROUP BY DEPT_CODE
--HAVING
ORDER BY DEPT_CODE ASC;

--[EMPLOYEE] ���̺��� �μ��ڵ� �׷캰, ���ʽ��� ���޹޴� ��� ���� ��ȸ�ϰ� �μ��ڵ� ������ ����
--BONUS�÷��� ���� �����Ѵٸ�, �� ���� 1�� ī����.
--���ʽ��� ���޹޴� ����� ���� �μ��� ����.
SELECT NVL(DEPT_CODE,'����'), COUNT(BONUS), COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE
--HAVING BONUS IS NOT NULL
ORDER BY 1  ASC;




--@�ǽ�����
--EMPLOYEE ���̺��� ������ J1�� �����ϰ�, ���޺� ����� �� ��ձ޿��� ����ϼ���.

SELECT JOB_CODE,
            ROUND(AVG(SALARY)),
            COUNT(JOB_CODE)
FROM EMPLOYEE
WHERE JOB_CODE != 'J1'     -- <> �� != �� ���� ��
GROUP BY JOB_CODE;



--EMPLOYEE���̺��� ������ J1�� �����ϰ�,  �Ի�⵵�� �ο����� ��ȸ�ؼ�, �Ի�� �������� �������� �����ϼ���.

SELECT EXTRACT(YEAR FROM HIRE_DATE)"�Ի�⵵", 
            COUNT(*)"�Ի� �ο�"
FROM EMPLOYEE
--JOIN
WHERE JOB_CODE <> 'J1'
GROUP BY EXTRACT(YEAR FROM HIRE_DATE)
--HAVING
ORDER BY 1 ASC;


--[EMPLOYEE] ���̺��� EMP_NO�� 8��° �ڸ��� 1, 3 �̸� '��', 2, 4 �̸� '��'�� ����� ��ȸ�ϰ�,
-- ������ �޿��� ���(����ó��), �޿��� �հ�, �ο����� ��ȸ�� �� �ο����� ���������� ���� �Ͻÿ�

SELECT
           DECODE( SUBSTR(EMP_NO,8,1) , 1,'��',2,'��',3,'��',4,'��','�ܱ���')"����",
            FLOOR(AVG(SALARY))"�޿����",
            SUM(SALARY),
            COUNT(*)
FROM EMPLOYEE
GROUP BY  DECODE( SUBSTR(EMP_NO,8,1) , 1,'��',2,'��',3,'��',4,'��','�ܱ���')
--GROUP BY  
ORDER BY 4 ASC;


--GROUP BY �ڿ��� �� ���� �÷��� ���°�?
-- 2�� �����ϴ�.

SELECT DEPT_CODE, JOB_CODE,COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY 1,2 ASC;

--@�ǽ�����
--�μ��� ���� �ο����� ���ϼ���.

SELECT NVL(DEPT_CODE,'����')"�μ�", 0
            DECODE(SUBSTR(EMP_NO,8,1), 1, '��', 2, '��', 3, '��', 4, '��', '�ܱ���')"����",
            COUNT(*)"�ο�"

FROM EMPLOYEE
GROUP BY DEPT_CODE, DECODE(SUBSTR(EMP_NO,8,1), 1, '��', 2, '��', 3, '��', 4, '��', '�ܱ���')
ORDER BY 1;


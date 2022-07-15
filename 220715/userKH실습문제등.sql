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


--�μ��� �޿� ����� 3,000,000��(��������) �̻���  �μ��鿡 ���ؼ� �μ���, �޿������ ����ϼ���.
-- �μ����� �׷��� ������, �׷캰 �޿������ ������, ������ ������.

SELECT DEPT_CODE,
            FLOOR( AVG( SALARY) )
FROM EMPLOYEE
GROUP BY DEPT_CODE;
--HAVING FLOOR(AVG(SALARY) >= 3000000;


--HAVING �� 
--�׷��Լҷ� ���� ���ؿ� �׷쿡 ���� ������ ������ ���� HAVING���� �����
-- WHERE���� ��� �Ұ�.


--@�ǽ�����
--�μ��� �ο��� 5���� ���� �μ��� �ο����� ����ϼ���.

SELECT DEPT_CODE,
            COUNT(*)
FROM EMPLOYEE
--JOIN
--WHERE
GROUP BY DEPT_CODE
HAVING COUNT(*) > 5;
--ORDER BY


--�μ��� ���޺� �ο����� 3���̻��� ������ �μ��ڵ�, �����ڵ�, �ο����� ����ϼ���.

SELECT DEPT_CODE,
            JOB_CODE,
            COUNT(*)
FROM EMPLOYEE
--JOIN
--WHERE
GROUP BY DEPT_CODE, JOB_CODE
HAVING COUNT(*) >= 3;
--ORDER BY


DESC EMPLOYEE;
--�Ŵ����� �����ϴ� ����� 2���̻��� �Ŵ������̵�� �����ϴ� ������� ����ϼ���.
SELECT MANAGER_ID, COUNT(*)
FROM EMPLOYEE
--JOIN
--WHERE MANAGER_ID IS NOT NULL
GROUP BY MANAGER_ID
HAVING COUNT(*) >= 2 AND MANAGER_ID IS NOT NULL
ORDER BY 1;


-- ROLLUP �� CUBE
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP( DEPT_CODE, JOB_CODE)
ORDER BY 1;

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE( DEPT_CODE, JOB_CODE)
ORDER BY 1;


SELECT 
    DEPT_CODE,
    JOB_CODE,
    SUM(SALARY),
    CASE WHEN GROUPING(DEPT_CODE) = 0 AND GROUPING(JOB_CODE) = 1 THEN '�μ����հ�'
        WHEN GROUPING(DEPT_CODE) = 1 AND GROUPING(JOB_CODE) = 0 THEN '���޺��հ�'
        WHEN GROUPING(DEPT_CODE) = 1 AND GROUPING(JOB_CODE) = 1 THEN '���հ�'
        ELSE '�׷캰�հ�'  -- �Ѵ� 0
    END AS "����"
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1;


--���տ�����. UNION [ALL], UNION ALL, INTERSECT, MINUS
--������, ������, ������ �� ������ ���̺��� ������ �� �� �ֵ��� ����� ���� ��
--��ŷ�� �� �������� �����ؼ� �����͸� �̾ƿ´ٰ���.
--UNION �� ����
--1. �÷��� ������ ���ƾ� �Ѵ�.
--2. �÷��� ������Ÿ���� ���ƾ� �Ѵ�.

SELECT EMP_NAME, EMP_ID FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE
WHERE SALARY >= 2400000
ORDER BY 1;

--�����ͺ��̽� ������ �� JOIN
--�� �� �̻��� ���̺��� �������� ������ �ִ� �����͵��� 
--���� �з��Ͽ� ���ο� ������ ���̺��� �̿��Ͽ� �����
--> ���� ���̺��� ���ڵ带 �����Ͽ� �ϳ��� ���� ǥ����.


--SELECT EMP_NAME, DEPT_TITLE   CASE WHEN THEN DECODE
--FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
--WHERE
--GROUP BY HAVING
--ORDER BY ASC DESC

--UNION UNION ALL MINUS INTERSECT

SELECT * 
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE EMP_ID > 210;

-- JOIN ����
-- SELECT FROM JOIN ���̺�� ON �Ű��÷� = �Ű��÷�
--> ANSI ǥ�� ���� ( ��� DBMS������ ��� ����)
--> ORACLE ���� ���� (����Ŭ DBMS������ ��� ����)
SELECT * 
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;


--���޸��� ������ּ���.
SELECT * FROM EMPLOYEE E
JOIN JOB J ON J.JOB_CODE = E.JOB_CODE;

SELECT EMP_NAME, JOB_NAME FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);

--������ ����
--JOIN�� �ΰ��� �÷��� ���ؼ� ���� �����͸� �����Ծ���
-- �װ��� INNER JOIN ! INNER JOIN�� ����Ʈ
SELECT * FROM EMPLOYEE
INNER JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

--�� ���� �÷� ���� ������ �� ���� �����͵� ����� ������ ������ �ִ�.
-- OUTER JOIN !! LEFT RIGHT FULL  // �Ű� Į���� ���� ���� ��쵵 ���  
SELECT * FROM EMPLOYEE
FULL OUTER JOIN DEPARTMENT ON DEPT_CODE  = DEPT_ID;



--��������  .. ü�ν����� ����.
SELECT * FROM EMPLOYEE
INNER JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
INNER JOIN JOB USING(JOB_CODE)
ORDER BY JOB_CODE;

--JOIN�� �̿��Ͽ� �μ��� �� �ٹ����� ����غ���.
SELECT DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;


--@���νǽ�����_kh
--1. 2020�� 12�� 25���� ���� �������� ��ȸ�Ͻÿ�.
SELECT TO_CHAR(TO_DATE(221225),'DY') FROM DUAL;


--2. �ֹι�ȣ�� 1970��� ���̸鼭 ������ �����̰�, ���� ������ �������� �����, �ֹι�ȣ, �μ���, ���޸��� ��ȸ�Ͻÿ�.
SELECT EMP_NAME,EMP_NO,DEPT_TITLE,JOB_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
WHERE EMP_NO LIKE '7%-2%' AND EMP_NAME LIKE '��%';
    



--3. �̸��� '��'�ڰ� ���� �������� ���, �����, �μ����� ��ȸ�Ͻÿ�.
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE EMP_NAME LIKE '%��%';



--5. �ؿܿ����ο� �ٹ��ϴ� �����, ���޸�, �μ��ڵ�, �μ����� ��ȸ�Ͻÿ�.
SELECT EMP_NAME, JOB_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE E 
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
JOIN JOB USING(JOB_CODE)
WHERE DEPT_TITLE LIKE '%�ؿܿ���%';

;
--6. ���ʽ�����Ʈ�� �޴� �������� �����, ���ʽ�����Ʈ, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.
SELECT EMP_NAME, BONUS, DEPT_TITLE,LOCAL_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE
WHERE BONUS IS NOT NULL;

--7. �μ��ڵ尡 D2�� �������� �����, ���޸�, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.

SELECT EMP_NAME,JOB_NAME,DEPT_TITLE,LOCAL_NAME
FROM EMPLOYEE E
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
JOIN LOCATION L ON  D.LOCATION_ID = L.LOCAL_CODE
WHERE DEPT_CODE = 'D2';


--8. �޿�������̺��� �ִ�޿�(MAX_SAL)���� ���� �޴� �������� �����, ���޸�, �޿�, ������ ��ȸ�Ͻÿ�.
-- (������̺�� �޿�������̺��� SAL_LEVEL�÷��������� ������ ��)

SELECT EMP_NAME,JOB_NAME, SALARY, SALARY*12, MAX_SAL
FROM EMPLOYEE
JOIN SAL_GRADE USING(SAL_LEVEL)
JOIN JOB USING(JOB_CODE);
WHERE SALARY > MAX_SAL;



--9. �ѱ�(KO)�� �Ϻ�(JP)�� �ٹ��ϴ� �������� �����, �μ���, ������, �������� ��ȸ�Ͻÿ�.

SELECT EMP_NAME"�����",
    DEPT_TITLE"�μ���",
    LOCAL_NAME"������",
    NATIONAL_CODE"������"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE
JOIN NATIONAL N USING(NATIONAL_CODE)
WHERE NATIONAL_CODE IN('KO','JP');


--10. ���ʽ�����Ʈ�� ���� ������ �߿��� ������ ����� ����� �������� �����, ���޸�, �޿��� ��ȸ�Ͻÿ�. ��, join�� IN ����� ��
SELECT EMP_NAME"�����",
    JOB_NAME"���޸�",
    SALARY"�޿�",
    NVL(BONUS,0)"���ʽ�����Ʈ"
FROM EMPLOYEE 
JOIN JOB USING(JOB_CODE)
WHERE BONUS IS NULL AND JOB_NAME IN('����','���');

--11. �������� ������ ����� ������ ���� ��ȸ�Ͻÿ�.
SELECT DECODE(ENT_YN,'N','����','Y','����'),
    COUNT(*)
FROM EMPLOYEE
GROUP BY ENT_YN;
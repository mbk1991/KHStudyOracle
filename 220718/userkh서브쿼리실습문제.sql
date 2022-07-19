-- �������� �ǽ� ����
--����1
--��������ο� ���� ������� ����� �̸�,�μ��ڵ�,�޿��� ����Ͻÿ�
--���1.
SELECT EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE
WHERE DEPT_CODE = ( SELECT DEPT_ID FROM DEPARTMENT WHERE DEPT_TITLE = '���������');
--���2.


--����2
--��������ο� ���� ����� �� ���� ������ ���� ����� �̸�,�μ��ڵ�,�޿��� ����Ͻÿ�
--��������� ���� �ƽ��� ���������� ����غ���
SELECT MAX(SALARY) FROM EMPLOYEE E
JOIN DEPARTMENT D ON  E.DEPT_CODE = D.DEPT_ID
WHERE DEPT_TITLE ='���������';  -- �̰��� ����������

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE E
JOIN DEPARTMENT D ON  E.DEPT_CODE = D.DEPT_ID
WHERE DEPT_TITLE ='���������') AND DEPT_CODE ='D8';
--�̷��� �ϸ� �ٸ� �μ��� �޿��� ���� ����� ���� ��� ���� ��ȸ�� �ȴ�.
--WHERE�� AND DEPT_CODE='D8'�� �߰��ϴ� ���� �ҿ����� ����.

--��������� ����Ѵٸ� ��� �ؾ��ұ�?
--�μ��̸��� JOIN�� �ƴ� ���������� ����Ϸ��� ��� �ؾ��ұ�?

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE E
WHERE NOT EXISTS ( SELECT 1 FROM EMPLOYEE M JOIN DEPARTMENT D ON M.DEPT_CODE = D.DEPT_ID
               WHERE DEPT_TITLE != '���������' AND E.SALARY < M.SALARY );






--����3
--�Ŵ����� �ִ� ����߿� ������ ��ü��� ����� �Ѱ� 
--���,�̸�,�Ŵ��� �̸�,����(������������)�� ���Ͻÿ�
 --* ��, JOIN�� �̿��Ͻÿ�

SELECT EMP_NO, EMP_NAME
FROM EMPLOYEE;

SELECT EMP_NAME
FROM EMPLOYEE
WHERE MANAGER_ID = 200;

SELECT
 ;

--����4
--�μ� �� �� ���޸��� �޿� ����� ���� ���� ������ �̸�, �����ڵ�, �޿�, �޿���� ��ȸ






--����5
--�μ��� ��� �޿��� 2200000 �̻��� �μ���, ��� �޿� ��ȸ
--��, ��� �޿��� �Ҽ��� ����

SELECT DEPT_TITLE, FLOOR(AVG(SALARY))
FROM DEPARTMENT JOIN EMPLOYEE ON DEPT_ID = DEPT_CODE
GROUP BY DEPT_TITLE
HAVING FLOOR(AVG(SALARY)) >= 2200000;

SELECT DEPT_TITLE "�μ���", (SELECT FLOOR(AVG(SALARY)) FROM EMPLOYEE WHERE DEPT_CODE = DEPT_ID)"��ձ޿�"
FROM DEPARTMENT D 
WHERE  (SELECT FLOOR(AVG(SALARY)) FROM EMPLOYEE WHERE DEPT_CODE = DEPT_ID)>= 2200000;



--����6
--������ ���� ��պ��� ���� �޴� ���ڻ����
--�����,�����ڵ�,�μ��ڵ�,������ �̸� ������������ ��ȸ�Ͻÿ�
--���� ��� => (�޿�+(�޿�*���ʽ�))*12    
-- �����,���޸�,�μ���,������ EMPLOYEE ���̺��� ���� ����� ������ 
-- ���޺� ����

SELECT DISTINCT DEPT_CODE, (SELECT AVG(SALARY) FROM EMPLOYEE M WHERE E.DEPT_CODE = M.DEPT_CODE)
FROM EMPLOYEE E;


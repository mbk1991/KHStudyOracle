-- TOP N �ǽ����� Ǯ���
-- TOP N �м��� ���� PL/SQL�� ������
-- '�޿�' / '���ʽ�' / '�Ի���' Ű�����Է�.
-- ������ 1��~5�� ������ ����ϴ� PL/SQL�� ������.
--TOP N �м��� ���� �Լ��� ����� �ʾ����� ã�ƺ��鼭 ������.

SET SERVEROUTPUT ON;

SELECT * 
FROM (SELECT EMP_NAME, SALARY FROM EMPLOYEE
      ORDER BY 2 DESC)
WHERE ROWNUM < 6;

SELECT *
FROM (SELECT EMP_NAME, NVL(BONUS,0) FROM EMPLOYEE
      ORDER BY 2 DESC)
WHERE ROWNUM < 6;

SELECT *

0--SQL���������̵� ����

-- # 220720
--1.SELECT��

--# DISTINCT �ɼǰ� ����Ʈ�� ALL �ɼ�
SELECT * FROM PLAYER;
DESC PLAYER;
SELECT * FROM ALL_CONSTRAINTS WHERE TABLE_NAME = 'PLAYER';
SELECT ALL POSITION FROM PLAYER;
SELECT DISTINCT POSITION FROM PLAYER;

--# ALIAS �˸��ƽ� , Į����(���̺�)�� ��Ī �ο��ϱ�
-- AS, " " (�����ο��ȣ�� ���� �� Ư�����ڸ� �����ϰ� ��ҹ��� �������ʿ��Ѱ��
--AS�� ������ �����ϳ� ������ ���鿡�� ����ϴ� ���� �ٶ����ϴ�.

--#��������� *,/, +,-
SELECT PLAYER_NAME,HEIGHT - WEIGHT "Ű���� �����Ը� �� ��"
FROM PLAYER;
--�������� Ű�͸����Է� BMI�����ϱ�
SELECT PLAYER_NAME AS ������, ROUND(WEIGHT / (HEIGHT/100)*(HEIGHT/100),2)
    AS BMI������ FROM PLAYER;
--������, Ű, ������ ���
SELECT PLAYER_NAME, HEIGHT, WEIGHT
FROM PLAYER;

--2.�Լ�
-- �Լ��� �з� : �����Լ�, ��������� �Լ�
-- �����Լ��� �з� : ������ �Լ�(�Է°��� �� ��), �������Լ�(�Է°��� ������)
-- �Լ��� M:1�� ����. �Է��� �ƹ��� ���Ƶ� ����� �ϳ��� �Ǵ� Ư��.
-- # ������ �Լ�
--   ������ �Լ��� ���� :������,������,��¥��,��ȯ��,NULL����
-- # ������ �Լ��� Ư¡
--   1) SELECT, WHERE, ORDER BY ������ ����� �� �ִ�.
--   2) �� ��鿡 ���������� �ۿ��� ������ ������ �����ϰ� ����� �����Ѵ�.
--   3) �ϳ� �̻��� ���ڸ� ���� �� ������ ���,����,ǥ������ ���ڷ� ����� �� �ִ�.
--   4) �Լ��� ��ø�� �����ϴ�( �Լ��� ���ڷ� �Լ��� ����ϴ� ��)

-- 'SQL Expert'��� ������ �������� ���̸� ���ϴ� �Լ�
SELECT LENGTH('SQL Expert') FROM DUAL;

--# DUAL���̺��� Ư��
--  1) SYS �������� �����̸� ��� ������� ������ �����ϴ�
--  2) SELECT ~ FROM ������ ���߱� ���� ������ DUMMY�̴�
--  3) DUMMY��� ���ڿ� Į���� �ִ�.

-- �������̺��� CONCAT���ڿ� �Լ��� �̿��� �౸������ ������ �߰��Ѵ�.
SELECT CONCAT (PLAYER_NAME,' �౸����') FROM PLAYER;

--������ȣ�� ��ȭ��ȣ�� ��ģ ���ڿ��� ���� ���ϱ�
SELECT LENGTH( DDD || TEL ) FROM STADIUM;


--5.GROUP BY, HAVING��
-- �����Լ� : ���� ����� �׷��� �𿩼� �׷�� �� �ϳ��� ����� ��ȯ.
-- �׷�� �ϳ��� ���.
-- #�����Լ��� Ư��
--    1)���� ����� �׷��� �� �׷�� �� �ϳ��� ����� �����ִ� �Լ�
--    2)GROUP BY���� ����� �ұ׷�ȭ�Ѵ�.
--    3)SELECT��, HAVING��, ORDER BY ���� ����� �� �ִ�.

--�����Լ��� GROUP BY ���� ���� �������� ���̺� ��ü�� �ϳ��� �׷��� �Ǵ� 
--��쿡�� GROUP BY������ �ܵ� ����� �����ϴ�.
SELECT COUNT(*) AS ��ü���,
       COUNT(HEIGHT) AS Ű�Ǽ�,
       MAX(HEIGHT) AS �ִ�Ű, 
       MIN(HEIGHT) AS �ּ�Ű,
       ROUND(AVG(HEIGHT))
       AS ���Ű
FROM PLAYER;

--# GROUP BY ���� HAVING ���� Ư��
-- 1)GROUP BY ���� �ұ׷� ������ ���� �� SELECT���� �����Լ��� ����Ѵ�.
-- 2)�����Լ��� NULL���� �����ϰ� �����Ѵ�.
-- 3)GROUP BY ���� ALIAS����� �Ұ��ϴ�
-- 4)�����Լ��� WHERE���� �� �� ����. WHERE���� ���� �����Ͽ� ����� �����ϱ� ����
-- 5)HAVING ���� GROUP BY ���� ������ ������ �� �ִ�.

--�����Ǻ� ���Ű
SELECT POSITION AS ������, AVG(HEIGHT)
FROM PLAYER
GROUP BY POSITION;

--ALIAS�� ORDER BY�������� ��Ȱ���� �����ϳ� GROUP BY �������� �Ұ�.
--�����Ǻ� �ִ�Ű, �ּ�Ű, ���Ű
SELECT POSITION,COUNT(*), COUNT(HEIGHT), MAX(HEIGHT), MIN(HEIGHT),AVG(HEIGHT)
FROM PLAYER
GROUP BY POSITION;

--���Ű 180 �̻�
SELECT POSITION, AVG(HEIGHT)
FROM PLAYER
GROUP BY POSITION
HAVING AVG(HEIGHT) >= 180;

--�Ｚ�������� FC������ �ο���
--GROUP BY, HAVING ���
SELECT TEAM_ID, COUNT(*)
FROM PLAYER
GROUP BY TEAM_ID
HAVING TEAM_ID IN('K09','K02');

--GROUP BY, WHERE ���
SELECT TEAM_ID, COUNT(*)
FROM PLAYER
WHERE TEAM_ID IN ('K09','K02')
GROUP BY TEAM_ID;

--����� ������ �����ϸ� WHERE������ GROUP BY�� ������� ���̴� ����
-- �ڿ� Ȱ�� ���鿡�� ȿ�����̴�.
-- HAVING ���ٴ� WHERE.

--�����Ǻ� ���Ű �ִ�Ű�� 190CM �̻��� ����
SELECT POSITION, AVG(HEIGHT)
FROM PLAYER
GROUP BY POSITION
HAVING MAX(HEIGHT) >= 190 ;

--# CASE ǥ���� �̿��� ���� ������ ����. SIMPLE CASE EXPRESSION!
SELECT ENAME AS �����, DEPTNO AS �μ���ȣ
      ,EXTRACT(MONTH FROM HIREDATE) AS �Ի��, SAL AS �޿�
FROM EMP;
--�ʿ��� ������ �߷��� �������� �ζ��κ�� ����Ѵ�.

--���� �Ի����� ��ձ޿�
SELECT DEPTNO,

    AVG( CASE MONTH WHEN 1  THEN SAL END) "M01",
    AVG(CASE MONTH WHEN 2  THEN SAL END) "M02",
    AVG(CASE MONTH WHEN 3  THEN SAL END) "M03",
    AVG(CASE MONTH WHEN 4  THEN SAL END) "M04",
    AVG(CASE MONTH WHEN 5  THEN SAL END) "M05",
    AVG(CASE MONTH WHEN 6  THEN SAL END) "M06",
    AVG(CASE MONTH WHEN 7  THEN SAL END) "M07",
    AVG(CASE MONTH WHEN 8  THEN SAL END) "M08",
    AVG(CASE MONTH WHEN 9  THEN SAL END) "M09",
    AVG(CASE MONTH WHEN 10 THEN SAL END) "M10",
    AVG(CASE MONTH WHEN 11 THEN SAL END) "M11",
    AVG(CASE MONTH WHEN 12 THEN SAL END) "M12"
    
FROM (SELECT ENAME,DEPTNO,EXTRACT(MONTH FROM HIREDATE)AS MONTH,SAL 
        FROM EMP)
GROUP BY DEPTNO;

--CASE���� ���� ������ ���� �� ������ �׷��� �ʴٰ� ��.
--�����ڵ��� ������ �ϳ��� SQL�������� ����Ͻ����� �䱸������ ó���� �� �ֵ��� ����ؾ��Ѵ�.
--SIMPLE CASE EXPRESSION


--# �����Լ��� NULLó��
-- ������ �Լ� �ӿ��� NVL�� ����ϴ� �� ����.
--NULL�� ����Ʈ�� �Ҵ�Ǵ� ���. 
--  1)DECODE �Լ����� �׹�° ���ڸ� �������� ���� ���
--  2)CASE������ ELSE���� �����ϴ� ���
-- SUM(NVL(SAL,0)) ���� ��� ������ NULL�� �����Լ����� ���ܵǴµ� ���� 0���� ��ȯ����
-- ������ �Ǽ���ŭ ������ �Ͼ���Ͽ� �ý��� �ڿ��� �����ϰ� �ȴ�.

--���� �����Ǻ� �ο����� ���� ��ü�ο����� ���ϴ� SQL��, �����Ͱ� ���°�� 0���� ǥ��.
SELECT TEAM_ID,
  SUM( CASE POSITION WHEN 'DF' THEN 1 END) "DF",
  SUM( CASE POSITION WHEN 'FW' THEN 1 END) "FW",
  SUM( CASE POSITION WHEN 'GK' THEN 1 END) "GK",
  SUM( CASE POSITION WHEN 'MF' THEN 1 END) "MF",
  COUNT(*)"SUM" 
FROM PLAYER
GROUP BY TEAM_ID
ORDER BY 1 ASC;

--CASEǥ���� �̿��Ͽ� �����͸� ǥ���ϴ� ���.
-- ��ü �������� �����Ǻ� ���Ű �� ��ü ���Ű�� ����غ���


SELECT ROUND(AVG(DF),2)"DF���Ű",
       ROUND(AVG(FW),2)"FW���Ű",
       ROUND(AVG(GK),2)"GK���Ű",
       ROUND(AVG(MF),2)"MF���Ű",
       ROUND(AVG(SUM),2)"��ü���Ű"
FROM
(SELECT CASE POSITION WHEN 'DF' THEN HEIGHT END"DF"
     , CASE POSITION WHEN 'FW' THEN HEIGHT END"FW"
     , CASE POSITION WHEN 'GK' THEN HEIGHT END"GK"
     , CASE POSITION WHEN 'MF' THEN HEIGHT END"MF"
     , HEIGHT "SUM"
FROM PLAYER);


-- ���翡���� �ζ��κ並 ������ �ʰ� Į�� ��θ� ���� ����ó���ع����� ������� �ذ��Ѵ�.
-- ��� ���� ����ó���Ѵٸ� �ζ��κ並 �����ʿ䰡 ���� ��!!

SELECT ROUND(AVG(CASE POSITION WHEN 'DF' THEN HEIGHT END),2)"DF"
     , ROUND(AVG(CASE POSITION WHEN 'FW' THEN HEIGHT END),2)"FW"
     , ROUND(AVG(CASE POSITION WHEN 'GK' THEN HEIGHT END),2)"GK"
     , ROUND(AVG(CASE POSITION WHEN 'MF' THEN HEIGHT END),2)"MF"
     , ROUND(AVG(HEIGHT),2) "SUM"
FROM PLAYER;

--6. ����
-- ORDER BY ���� �����͸� �����ϴ� ��. �÷��� ������ ALIAS�� �̿��� ������ �����ϴ�.
-- ORDER BY ���� SELECT ���� �������� ��ġ�ϸ� ����Ʈ�� ASC�̸� DESC ���� �����ϴ�.

--����̸� ��������
SELECT PLAYER_NAME, POSITION, BACK_NO
FROM PLAYER
ORDER BY 1 DESC;

SELECT PLAYER_NAME, POSITION "������", BACK_NO
FROM PLAYER
ORDER BY ������ DESC;
--NULL���� ���� ū ������ ����Ѵ�.

--# ORDER BY�� Ư¡
-- 1) ����Ʈ�� ��������
-- 2) ���������� ���ڴ� ���� ����������, ��¥�� ����������
-- 3) ����Ŭ���� NULL���� ū ������ ����
-- ���������� �������� ����  �������κ��ٴ� Į�����̳� ALIAS����� �ǰ�!!

--�̸�,������,��ѹ�,  ��ѹ���������, ������ , ���� ���� ��������.
SELECT PLAYER_NAME"�����̸�",POSITION"������", BACK_NO"���ȣ"
FROM PLAYER
WHERE BACK_NO IS NOT NULL
ORDER BY ���ȣ DESC, ������ DESC, �����̸� DESC;

--DEPT���̺������� �μ���,����,�μ���ȣ,�������� ����
SELECT * 
FROM DEPT
ORDER BY DNAME, LOC, DEPTNO DESC;


--4.SELECT���� ���� ����.
-- 1)���� ��� ���̺��� �����Ѵ� FROM
-- 2)���� ��� �����Ͱ� �ƴ� ���� �����Ѵ� WHERE
-- 3)����� �ұ׷�ȭ�Ѵ� GROUP BY
-- 4)�׷��ε� ���� ���ǿ� �´� �͸� ����Ѵ� HAVING
-- 5)������ ���� ���, ����Ѵ� SELECT
-- 6)�����͸� �����Ѵ�.

-- SELECT�� ���� �÷��� ORDER BY�� ����� �� �ִ�!
-- �ζ��� �信 ���ǵ� SELECT Į���� ���� ������ ����� �� �ִ�. ���� �� �Ұ�.

SELECT EMPNO
FROM (SELECT EMPNO,ENAME FROM EMP ORDER BY MGR);

--GROUP BY���� ����ϸ� �׷��� ���ؿ� ���� Į���� �����Լ��� ���� �� �ִ� ������ ������
--Į������ ������ ���� ����� �ٸ� ���� �����ʹ� �������� �ʴ´�. SELECT ���̳� ORDER BY������
--���������͸� ����ϴ� ��� ������ �߻��Ѵ�. 
--GROUP BY ���� �� �׷��α��� Į���� ������ �����͸� ��� ����!!!
--GROUP BY �� �����Լ��� �Բ� �����!!!

-- 7.JOIN
-- ����: �� �� �̻��� ���̺����  ������ �����͸� ����ϴ� ��. 
-- ������ �����ͺ��̽��� ���� ū �������� �ٽɱ��!!!
-- PK�� FK ���� ������ ���� �Ϲ����� ���� �� �ƴ϶� PK,FK���谡 ��� ������ ������ ����������
-- ������ ������ �� �ִ�.
-- 3���� ���̺��� ���� �� Ư�� 2���� ���̺� ���� ���� ó���ǰ� ������ �����
--�߰������Ϳ� ������ ���̺��� ���� ���ʷ� ������ �ȴ�. 4�� �̻��� ��쿡�� 
-- 2���� ���εǰ� �� ���� �߰� ���εǰ� �� �ٸ� �� ���� �߰� ���εǴ� ������ ����ȴ�.
-- (((A JOIN D) JOIN C) JOIN B) 

--EQUI JOIN � JOIN
-- �� ���� ���̺� ���� Į�� ������ ���� ��Ȯ�ϰ� ��ġ�ϴ� ��� ���Ǵ� ���.
--��κ� PK �� FK�� ���踦 ������� �Ѵ�.
--JOIN�� ������ WHERE���� = �����ڷ� ���. (�������� ���)
--FROM ���� ON�� USING �� �̿��ϴ� ��� (ANSI/ISO SQL ǥ�ع��)

--�÷��� �տ��� ���̺��(�Ǵ� ALIAS)�� �ٿ��� ����ϴ� ���� ����.
-- �������� ������������ ���̴� �����.
--INNER JOIN : ���� ���ǿ� �´� �����͸� ����Ѵ�.

SELECT PLAYER.PLAYER_NAME, PLAYER.BACK_NO, PLAYER.TEAM_ID
    ,TEAM.TEAM_NAME, TEAM.REGION_NAME
FROM PLAYER, TEAM
WHERE TEAM.TEAM_ID = PLAYER.TEAM_ID;

--FROM���� �˸��ƽ��� ����Ͽ� ���߻��꼺�� ���̰� �Ǽ��� �����Ѵ�.

SELECT P.PLAYER_NAME,
       P.BACK_NO,
       P.TEAM_ID,
       T.TEAM_NAME,
       T.REGION_NAME,
       P.POSITION
FROM PLAYER P, TEAM T
WHERE P.TEAM_ID = T.TEAM_ID AND
        POSITION = 'GK'
ORDER BY BACK_NO ASC;

--FROM���� ALIAS�� ������ ��� SELECT���̳� WHERE �������� ALIAS�� ����ؾ� �Ѵ�.
--�������� �ϰ��� ���鿡�� SELECT�� �˸��ƽ��� �� �����ִ� ���� ����.
--�Ҽ����� ���뱸�� ������ �������� �Բ� ���
SELECT T.TEAM_NAME, S.STADIUM_NAME
FROM TEAM T JOIN STADIUM S ON T.STADIUM_ID = S.STADIUM_ID;



SELECT PLAYER_NAME, NATION
       ,(SELECT ROUND(AVG(HEIGHT),1) FROM PLAYER P2
         WHERE P1.NATION = P2.NATION)"���Ű"
FROM PLAYER P1;

--NON EQUI JOIN
--������: �� ���̺� ���� ������ �������踦 ������ ������ Į�������� ���� ��ġ���� �ʴ� ���
--            ����ϴ� �����̴�.
-- �� ���̺��� PK-FK �������踦 ���ų� �������� ���� ���� �����ϸ� '='�����ڷ� JOIN�� �Ѵ�.
--�� ���̺� �÷����� ��Ȯ�ϰ� ��ġ���� �ʴ� ���  EQUI������ �Ұ��ϸ� �� �������� �õ��غ� �� �ִ�. 
-- ������ �𵨿� ���� �������� �Ұ��� ��쵵 ����.
--�������� BETWEEN, �񱳿����� ������ ������ �Ѵ�.

--# 220721
CREATE TABLE SALGRADE(
    GRADE NUMBER PRIMARY KEY,
    LOSAL NUMBER,
    HISAL NUMBER);
INSERT INTO SALGRADE VALUES
(1,700,1200);
INSERT INTO SALGRADE VALUES
(2,1201,1400);
INSERT INTO SALGRADE VALUES
(3,1401,2000);
INSERT INTO SALGRADE VALUES
(4,2001,3000);
INSERT INTO SALGRADE VALUES
(5,3001,9999);

SELECT * FROM SALGRADE;
COMMIT;

SELECT  A.ENAME, A.JOB, A.SAL, B.GRADE
FROM EMP A, SALGRADE B
WHERE A.SAL BETWEEN B.LOSAL AND B.HISAL;

SELECT ENAME, SAL, GRADE
FROM EMP E  JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL;


SELECT A.PLAYER_NAME AS ������,
       A.POSITION AS ������,
       B.REGION_NAME AS ������,
       B.TEAM_NAME AS ����,
       C.STADIUM_NAME AS �����
FROM PLAYER A, TEAM B, STADIUM C
WHERE A.TEAM_ID = B.TEAM_ID AND
        B.STADIUM_ID = C.STADIUM_ID
ORDER BY ������ ASC;

--JOIN ����� ���� ��鸸  ��ȯ�ϴ� INNER����. (����Ʈ) JOIN�� ������ ����� ������� ���ܵȴ�.
--OUTER JOIN -JOIN ����� ������ ��鵵 ����� ���Եȴ�. ����(��Ī)���� �ʴ� �κ��� NULLó����.
--���̺�1�� ���̺�2�� ������ �� ���̺� 2�� ������ �����Ͱ� ��� ���̺�1�� ��� �����͸� ǥ���ϰ� ���� ���.
/*
    �ƿ��������� ����Ŭ ����
    FROM TABLE1, TABLE2
    WHERE TABLE1.Į����(+) = TABLE2.Į����
���⼭ ������ ���� �� ���ô� RIGHT OUTER �����̶�� ��. (+)���� ���� NULLó���ǰ� �ٸ����� �����Ͱ� ��� ǥ�õȴ�.
*/

SELECT * 
FROM STADIUM S, TEAM T
WHERE S.STADIUM_ID = T.STADIUM_ID(+)
ORDER BY HOMETEAM_ID ASC;

--DEPT��EMP�� �����ϵ� ����� ���� �μ������� ���� ����ϵ���
SELECT *
FROM DEPT D LEFT JOIN EMP E ON  D.DEPTNO = E.DEPTNO;

--������ �ʿ��� ������ ����ȭ�������� ����Ѵ�.
--���ʿ��� �������� ���ռ�(����� ���°�)�� Ȯ���ϰ� �̻�����(ANOMARY)�߻��� ���ϱ� ����
--���̺��� �����Ͽ� �����Ѵ�. ���̺� �ϳ��� ��� �����Ͱ� �ִ� ��� �������� ����� ���� �� ������
--�߰�, ����, �����ϴ� �۾��� �� ū ����� ����. �Ը� ū ���̺��� ���� ã�ƾ� �ϹǷ� ��ȸ�� �����ɸ�
--���̺��� �и��ϸ� �̷��� ������ �ؼ��� �� ������ ���̺��� �и��Ǿ��� ������  ���̺� ���� ������ �������谡 �ʿ��ϴ�.
--�̷��� ���踦 ���� �پ��� �����͸� ����ϴ� ���� �ٷ� ������ ���̴�.
--������ �����ͺ��̽��� ū ������ ������ �߸� ����ϸ� �ý��� �ڿ�����, ����ð� ������ ������ �ȴ�.

--8. ǥ������
--INNER JOIN
--NATURAL JOIN
--USING ������
--ON ������
--CROSS JOIN
--OUTER JOIN

--WHERE������ JOIN������ ǥ���ϴ� ������ -> FROM ������ ǥ���ϴ� ���. ON������, USINT������
--NATURAL������ �� ���̺� �� ������ �̸��� ���� ��� Į���鿡 ���� EQUI������ �����Ѵ�.
--NATURAL JOIN�� ��õǸ� ���� ������ ������ �� ����. �÷���� Ÿ���� ��� ���� �� �����ϴ�.


--INNER���ΰ� NATURAL������ ���� �� ����
CREATE TABLE DEPT_TEMP AS SELECT * FROM DEPT;
UPDATE DEPT_TEMP
SET DNAME = 'CONSULTING'
WHERE DNAME = 'RESEARCH';
UPDATE DEPT_TEMP
SET DNAME = 'MARKETING'
WHERE DNAME = 'SALES';

SELECT * FROM DEPT;
SELECT * FROM DEPT_TEMP;

SELECT * FROM DEPT A NATURAL JOIN DEPT_TEMP B;
SELECT * FROM DEPT A JOIN DEPT_TEMP B 
ON A.DEPTNO = B.DEPTNO
AND A.DNAME = B.DNAME
AND A.LOC = B.LOC;

SELECT * FROM DEPT A INNER JOIN DEPT_TEMP B
USING(DNAME);

--USING �������� �̿��� �����(EQUI JOIN)�� �������ο��� ���εǴ� �÷���
--ALIAS�� ���̺���� �����Ͽ� ��Ī�� �� ����.

--CROSSJOIN M*N���� ���տ������� PRODUCT�� ����. ���� �� �ִ� ��� �������� ����
--�Ϲ������� �� ������� �ʴ´�.

--OUTER����
--�������� (+)����� ������ ���� ���Ҵ�.
--ANSI/ISO ��� �������� ����Ѵ�. USING��, ON��
--LEFT JOIN RIGHT JOIN FULL JOIN













































































































































































































































































































































































































































































































































































































































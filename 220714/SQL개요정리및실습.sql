--������ �켱����
--���� �����ڸ� ����ϴ� ��� �켱������ ����ؼ� ����ؾ���
-- ��� > ���� > �� > IS NULL, LIKE, IN ( NOT����)
--> BETWEEN AND < �� (NOT) > ��(AND) > �� (OR)
--�򰥸� ���� �Ұ�ȣ�� ����϶�

--������ ���� SYS, SYSTEM ����
--1. SYS : ���۰�����, �����ͺ��̽� ����/���� ���� ����
--�α��� �ɼ����� �ݵ�� SYSDBA�� ����
--�����͵�ųʸ��� �����ϰ� ����.
--2. SYSTEM: �Ϲݰ�����, �����ͺ��̽� ����/ ���� ���� ����.

--SQL ����
--SQL�� ����
-->������ ���Ǿ� : DDL (Data Definition Language)
-->������ ���۾� : DML (Data Manipulation Language)
-->������ ����� : DCL (Data Control Language)
-->Ʈ����� ����� : TCL (Transaction Control Language)

--DDL
--CREATE(��ü����), DROP(��ü����), ALTER(��ü ����)
--TRUNCATE(��ü �ʱ�ȭ)
-->�����ͺ��̽��� ������ �����ϰų� ����, �����ϱ� ���� ����ϴ� ���

--DML
--INSERT, UPDATE, DELETE, SELECT
-->�����͸� �����ϱ� ���� ����ϴ� ���

--DQL(Data Query Language)
--SELECT
-->�����͸� �˻�(����)�ϱ� ���� ����ϴ� ���

--DCL
--GRANT(���Ѻο�), REVOKE(��������)
-->������� �����̳� ������ ���� ���� ó���ϴ� ���

--TCL
--COMMIT, ROLLBACK
-->Ʈ����� ����ó�� �� �����ϰų� ����� �� ���Ǵ� ���


SHOW USER;
DESC EMPLOYEE;
INSERT INTO EMPLOYEE
VALUES('900','��ä��','901123-1234567','jang_ch@kh.or.kr','01000000000',
    'D1','JB','S3',4300000,0.2,'200',SYSDATE,NULL,'N');
SELECT * FROM EMPLOYEE;
ROLLBACK;
COMMIT;
DELETE FROM EMPLOYEE WHERE EMP_NAME LIKE '��ä%';



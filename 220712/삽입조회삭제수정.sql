--DB�� �ٷ�� ���ε�: �����ʹ� ��(���)�̴�. �ſ� �ΰ��ϹǷ� ��������.

--1. Oracle DBMS ���� �� �� ��ǻ���� port�� ������ ����ȴ�. 1521��Ʈ
--2. CLI �Ǵ� SQL�𺧷��۸� �̿��� �� �ִ�. (CMD sqlplus )
--3. ���� ��ġ �� ������(SYS, SYSTEM ��) ��й�ȣ�� �����Ѵ�.
--4. �������� �������� ����ڸ� �����Ѵ�.
--5. ���̺��� ����, ����, ����, ��ȸ �Ѵ�.

-- ������ ���� �� ����� �����ϴ� ���
CONN SYS SYSDBA
ALTER USER SYS IDENTIFIED BY khadmin;


--���̺� �� �����ϴ� ���
INSERT INTO LOVER(LOVER_NAME, LOVER_PWD, LOVER_AGE,LOVER_DATA)
VALUES('khuser01','pass01',33,SYSDATE);


--���̺��� ��ȸ�ϴ� ���
SELECT LOVER_NAME, LOVER_PWD, lover_age, LOVER_DATA
FROM LOVER
WHERE LOVER_NAME = 'khuser2';


--���̺��� �����͸� �����ϴ� ���(�� ����)
--DELETE �� ������ WHERE�� �Բ� �����
DELETE
FROM LOVER
WHERE LOVER_NAME = 'khuser3';

--���̺��� �����͸� �����ϴ� ���
UPDATE LOVER
SET LOVER_ID = null
WHERE LOVER_ID = 'khuser00';

UPDATE LOVER
SET LOVER_NAME = 'KHUSER01'
WHERE LOVER_NAME IS NULL;
--# Oracle Object
--1. View
--2. Sequence
--3. Index
--4. Trigger
--5. Role

--1. View (Stored View) -> �̸��� ���̰� ������.
--�ϳ� �̻��� ���̺��� ���ϴ� �����͸� �����Ͽ� ���ο� ���� ���̺��� ����� �ִ� ��.
--�ٸ� ���̺� �ִ� �����͸� ������ ���̸�, ������ ��ü�� �����ϰ� �ִ� ���� �ƴ�.
-->������ġ���� ���������� �������� �ʰ� �������̺�� �������
-->�������� ���� ���̺���� ��ũ����
-->���������� FROM�ڿ� ���� �ζ��� ���. �ζ��� ���� �䰡 �� ���.
--View�� ����� ���ؼ��� ������ �ʿ���. RESOURCE���� View�� ����� ������ ����.
--CREATE VIEW ��� ������ KH�� �ο��Ͽ��� ��. GRANT CREATE VIEW TO KH;
--��� �� ���°�?
--������ ������ �� ����, �����ְ� ���� ���� ������ ���� �� ���.
--

SELECT *
FROM(
SELECT EMP_NAME, EMP_NO, DECODE(SUBSTR(EMP_NO,8,1),'1','��','3','��','��')"����"
FROM EMPLOYEE);

CREATE VIEW EMP_GENDER
AS SELECT EMP_NAME, EMP_NO, DECODE(SUBSTR(EMP_NO,8,1),'1','��','3','��','��')"����"
FROM EMPLOYEE;

SELECT * FROM EMP_GENDER
WHERE ���� = '��';

--���̺��� �ƴ����� �ζ��� �信 �̸��� �ٿ��� ���� ���·� �����Ѵ�.
--�̴� ���̺�� �Ȱ��� ������ �� �� �ִ�.


--�並 ��ġ�� �������̺� �ٲ�� ��. ������ �ȵǴ� ���� ������ ����.
--**DML(INSERT,UPDATE,DELETE) ��ɾ�� ������ �Ұ����� ���
--1. �� ���ǿ� ���Ե��� ���� �÷��� �����ϴ� ���. �����÷����� �����͸� �߰��� �� ����.
--2. INSERT�ÿ� �信 ���Ե��� ���� �÷� �߿� NOT NULL ���������� ������ ��� 
--3. ��� ǥ������ ���ǵ� ���. ������ �������ؼ� salary�� bonus�÷����� ������ ����.
--4. JOIN�� �̿��� ���� ���̺��� ������ ���
--5. DISTINCT�� ������ ���
--6. �׷��Լ��� GROUP BY ���� ������ ���

CREATE VIEW EMP_JOIN_INFO
AS SELECT EMP_NAME, DEPT_TITLE FROM EMPLOYEE LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
SELECT* FROM EMP_JOIN_INFO;

--#View �ɼ�
--1.OR REPLACE
--> ������ �䰡 �����ϸ� �並 ������.
CREATE OR REPLACE VIEW EMP_JOIN_INFO
AS SELECT EMP_NAME, DEPT_TITLE FROM EMPLOYEE LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
SELECT* FROM EMP_JOIN_INFO;

-->���̺��� ���̺��� DROP �� �ٽ� CREATE �ؾ� ��. VIEW�� ������ �� �ִ�.
--2. FORCE/NOFORCE
--> FORCE �ɼ��� �⺻ ���̺��� �������� �ʴ��� �並 ������. ���̺��� ���µ� �並 ������ ����.
--> NOFORCE�� �⺻���̺��� ������ �������� ����(����Ʈ). �� ������� ����.
CREATE FORCE VIEW EMP_VIEW
AS SELECT EMP_ID,EMP_NAME,SALARY FROM NONO;
SELECT * FROM EMP_VIEW;
--3. WITH CHECK OPTION
--WHERE���ǿ� ����� �÷��� ���� �������� ���ϰ� ��.
CREATE OR REPLACE VIEW EMP_VIEW_D5
AS SELECT EMP_ID, EMP_NAME,SALARY,DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' WITH CHECK OPTION;
--��������
--������ 250���� �̻��� ����μ� D2�� ����
UPDATE EMP_VIEW_D5 SET DEPT_CODE ='D2'
WHERE SALARY >= 2500000;


--4. WITH READ ONLY
--Ư���÷��� �ƴ϶� �ƿ� ����,����,�������� ���� ���ϰ� ��
--�信 ���� ��ȸ�� �����ϵ��� ��.

CREATE OR REPLACE VIEW EMP_VIEW_D5
AS SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' WITH READ ONLY;

UPDATE EMP_VIEW_D5 SET SALARY = SALARY + 500000;

--Data Dictionary
--1. USER_XXXX  // ���� ������ ���� ����, �ڽ��� ������ ��ü� ���� ���� ��ȸ����
--������ ��� ��ü���� ��Ÿ�����͵��� �����͵�ųʸ����� ������ ����.
--����ڰ� �ƴ� DB���� �ڵ�����/�������ִ� ���̸� USER �ڿ� ��ü���� �Ἥ ��ȸ��.

--2. ALL_XXXX  //��� ���̺� ���� ����,�ڽ��� ������ �����ϰų� ������ �ο����� 
--��ü � ���� ���� ��ȸ ����

--3. DBA_XXXX //�����ͺ��̽� �����ڸ� ������ ������ ��ü ���� ���� ��ȸ ���� 
  -->DBA�� ��� ������ �����ϹǷ� �ᱹ DB�� �ִ� ��� ��ü�� ���� ��ȸ����

--�ý����� �����ϴ� ���̺��� ����. �� ���̺��� �ʿ��� ������ ����ڰ� �� �� �ֵ���
--����� ���� �並 ������ ��ųʸ���� �Ѵ�.
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'EMPLOYEE';

SELECT * FROM DBA_TABLES;
--�Ϲݻ������ KH�� DBA_XXX�� ���� ������ ����.

--2. Sequence
--���������� ���� ���� �ڵ����� �����ϴ� ��ü��, �ڵ� ��ȣ �߻���(ä����)�� ������ ��.
--���������� �þ�� ������ EX)�Խñ� ��ȣ, ȸ�� ��ȣ

DESC SHOP_MEMBER;


--SEQUENCE ����
CREATE SEQUENCE SEQ_USER_NO
START WITH 1
INCREMENT BY 1
MAXVALUE 10000
CYCLE -- MAXVALUE���� ���� �� �ٽ� 1�� ���ư� ���̳� , NOCYCLE�� ������ �߻���Ŵ.
NOCACHE; --ĳ�ÿ� ������ ���� ������ ���̳� �� �� ���̳�.
--NOMAXVALUES

CREATE SEQUENCE SEQ_USER_NO_DEFAULT;  --�ɼǵ��� ���� ����
--START WITH 1
--INCREMENT BY 1
--NOMAXVALUE
--NOCYCLE
--NOCACHE

SELECT* FROM USER_SEQUENCES;
SELECT* FROM SEQ_USER_NO_DEFAULT;

INSERT INTO SHOP_MEMBER
VALUES(1, 'khuser01', 'pass01', '�Ͽ���','��', '01092928383', 'khuser01@iei.or.kr');
INSERT INTO SHOP_MEMBER
VALUES(2, 'khuser02', 'pass02', '�̿���', '01082830494', 'khuser02@iei.or.kr');
INSERT INTO SHOP_MEMBER
VALUES(3, 'khuser03', 'pass03', '�����', '01092983939', 'khuser03@iei.or.kr');
SELECT * FROM SHOP_MEMBER;

CREATE TABLE SEQUENCE_TEST(
USER_NUMBER NUMBER PRIMARY KEY,
USER_NAME VARCHAR2(10)
);

SELECT * FROM SEQUENCE_TEST;
INSERT INTO SEQUENCE_TEST VALUES(SEQ_USER_NO.NEXTVAL,'�Ͽ���');
INSERT INTO SEQUENCE_TEST VALUES(SEQ_USER_NO.NEXTVAL,'�̿���');
INSERT INTO SEQUENCE_TEST VALUES(SEQ_USER_NO.NEXTVAL,'�����');
INSERT INTO SEQUENCE_TEST VALUES(SEQ_USER_NO.NEXTVAL,'�����');
INSERT INTO SEQUENCE_TEST VALUES(SEQ_USER_NO.NEXTVAL,'������');
DELETE FROM SEQUENCE_TEST WHERE USER_NAME = '�����';

SELECT SEQ_USER_NO.CURRVAL FROM DUAL; -- �� ������ Ȯ�� ���
--INSERT ������ ������ �������� ���� ������

ROLLBACK;
SELECT SEQ_USER_NO.CURRVAL FROM DUAL;
--�ѹ��� �ص� ������ ���� ������ �ʴ´�.
ALTER SEQUENCE SEQ_USER_NO
INCREMENT BY 10;
-- �������� ������ ������ ���������� �ʱⰪ�� ������ �Ұ���.

SELECT * FROM SEQ_USER_NO;


-- ������ ����
CREATE SEQUENCE SEQ_USER_NO
START WITH 1    -- ��������
INCREMENT BY 1  -- ��������
NOMAXVALUE      -- ��������
NOCYCLE         -- ��������
NOCACHE;        -- ��������
-- CREATE SEQUENCE SEQ_USER_NO;
-- ������ Ȯ��
SELECT * FROM USER_SEQUENCES;
-- ������ �̿� ������ ����
INSERT INTO SHOP_MEMBER
VALUES(SEQ_USER_NO.NEXTVAL, 'khuser01', 'pass01', '01092928383', 'khuser01@iei.or.kr');
INSERT INTO SHOP_MEMBER
VALUES(SEQ_USER_NO.NEXTVAL, 'khuser02', 'pass02', '01082830494', 'khuser02@iei.or.kr');
INSERT INTO SHOP_MEMBER
VALUES(SEQ_USER_NO.NEXTVAL, 'khuser03', 'pass03', '01092983939', 'khuser03@iei.or.kr');
INSERT INTO SHOP_MEMBER
VALUES(SEQ_USER_NO.NEXTVAL, 'khuser04', 'pass04', '01092444939', 'khuser04@iei.or.kr');
-- ������ ���簪 ��ȸ
SELECT SEQ_USER_NO.CURRVAL FROM DUAL;
-- INSERT ������ ������ �������� ���� ������
-- �ش� �������� ���簪�� ��ȸ�ϱ� ���� CURRVAL�� ����ؾ���
-- ������ ����
ALTER SEQUENCE SEQ_USER_NO
INCREMENT BY 10;           -- ������ ������ ����
-- ������ ����
DROP SEQUENCE SEQ_USER_NO; -- �ʱⰪ�� ������ �ȵǱ� ������ �����ٰ� �ٽ� ��������

--##  ������ ���� ���� ##
--KH_MEMBER ���̺��� ����
CREATE TABLE KH_MEMBER(
 MEMBER_ID NUMBER,
 MEMER_NAME VARCHAR2(20),
 MEMBER_AGE NUMBER,
 MEMBER_JOIN_COM NUMBER
);

--�÷�
--MEMBER_ID	NUNBER
--MEMBER_NAME	VARCHAR2(20)
--MEMBER_AGE	NUMBER
--MEMBER_JOIN_COM	NUMBER

--�̶� �ش� ������� ������ INSERT �ؾ� ��
--ID ���� JOIN_COM�� SEQUENCE �� �̿��Ͽ� ������ �ְ��� ��

--ID���� 500 �� ���� �����Ͽ� 10�� �����Ͽ� ���� �ϰ��� ��
CREATE SEQUENCE ID_SEQUENCE
START WITH 500
MAXVALUE 10000
INCREMENT BY 10;

DROP SEQUENCE ID_SEQUENCE;

--JOIN_COM ���� 1������ �����Ͽ� 1�� �����Ͽ� ���� �ؾ� ��
--(ID ���� JOIN_COM ���� MAX�� 10000���� ����)
CREATE SEQUENCE JOIN_COM_SEQUENCE
START WITH 1
MAXVALUE 10000
INCREMENT BY 1;



--	MEMBER_ID	MEMBER_NAME	MEMBER_AGE	MEMBER_JOIN_COM	
--	500		     ȫ�浿		 20		     1
--	510		     �踻��	 	 30		     2
--	520		     �����		 40	         3
--	530	       	����		 24		     4

INSERT INTO KH_MEMBER 
VALUES(ID_SEQUENCE.NEXTVAL,'ȫ�浿','20',JOIN_COM_SEQUENCE.NEXTVAL);
INSERT INTO KH_MEMBER 
VALUES(ID_SEQUENCE.NEXTVAL,'�踻��','30',JOIN_COM_SEQUENCE.NEXTVAL);
INSERT INTO KH_MEMBER 
VALUES(ID_SEQUENCE.NEXTVAL,'�����','40',JOIN_COM_SEQUENCE.NEXTVAL);
INSERT INTO KH_MEMBER 
VALUES(ID_SEQUENCE.NEXTVAL,'����','24',JOIN_COM_SEQUENCE.NEXTVAL);

SELECT * FROM KH_MEMBER;


--NEXTVAL, CURRVAL �� ����� �� �ִ� ���
--���������� �ƴ� SELECT��
--INSERT���� SELECT��
--INSERT���� VALUES��
--UPDATE���� SET��
-- ** NEXTVAL, CURRVAL�� ����� �� ���� ���
-- VIEW�� SELECT��
-- DISTINCT Ű���尡 �ִ� SELECT��
-- GROUP BY, HAVING, ORDER BY���� �ִ� SELECT��
-- SELECT, DELETE, UPDATE�� ��������
-- CREATE TABLE, ALTER TABLE ����� DEFAULT ��


--# INDEX(����)
--�ε��� ������ �������� ������ ������ �˰� �־����. 
--������ ���Ұ� ����. �����͸� ������ ã�� �� �ְ� �Ѵ�.
--SQL��ɹ��� ó���ӵ��� ����Ű�� ���ؼ� (((((�÷�)))))�� ���� �����ϴ� ����Ŭ ��ü!!!!!
--�÷����Ѵ�.
--KEY-VALUE���·� ������ �Ǹ� KEY���� �ε����� ���� �÷���, VALUE���� ���� ����� �ּҰ��� �����.
-- *����: �˻��ӵ��� �������� �ý��ۿ� �ɸ��� ���ϸ� �ٿ��� �ý��� ��ü ������ ����ų �� ����
-- *����: 1.�ε����� ���� �߰� ���� ������ �ʿ��ϰ�, �ε����� �����ϴµ� �ð��� �ɸ�
--        2.�������� �����۾�(INSERT/UPDATE/DELETE)�� ���� �Ͼ�� ���̺� INDEX ���� ��
--          ������ ���� ���ϰ� �߻��� �� ����.
--* � Į���� �ε����� ����� ������?
--�����Ͱ��� �ߺ��� ���� ���� ������ �����Ͱ��� ������ �÷��� ����� ���� ���� ����.
--���õ�(SELECTIVITY)�� ���� �÷��� ��
--�����ȣ, �ֹι�ȣ,�����

--ȿ������ �ε��� ��� ��
--WHERE���� ���� ���Ǵ� �÷��� �ε��� ����
-- ��ü ������ �߿��� 10%~ 15% �̳��� �����͸� �˻��ϴ� ���, �ߺ��� ���� ���� �÷��̾�� ��
-->�� �� �̻��� �÷� WHERE���̳� ����(JOIN)�������� ���� ���Ǵ� ���
-->�� �� �Էµ� �������� ������ ���� �Ͼ�� �ʴ� ���
-->�� ���̺� ����� ������ �뷮�� ����� Ŭ ���

--��ȿ������ �ε��� ��� ��
--�ߺ����� ���� �÷��� ���� �ε���
--NULL���� ���� �÷�
-->�ε����� ���� ������ ������ �ʹ� ������ ������ ��������.
--�ε����� ������ ������ ���Ͽ찡 �׿��� �� �� �� �ִ�. � ������ �˾ư��� �������� �����Ѵ�.

--#INDEX ���� ��ȸ
SELECT * FROM USER_INDEXES
WHERE TABLE_NAME = 'EMPLOYEE';
--�ѹ��� ������ �ʾ����� PK,UNQ�������� �÷��� �ڵ����� ������ �̸��� �ε����� ������

--#INDEX ����
--CREATE INDEX �ε����� ON ���̺��(�÷���1,...)
SELECT * FROM EMPLOYEE WHERE EMP_NAME = '������';
CREATE INDEX IDX_EMP_NAME ON EMPLOYEE(EMP_NAME);

--#INDEX ����
DROP INDEX IDX_EMP_NAME;

--5. ROLE
--> ����ڿ��� �������� ������ �ѹ��� �ο��� �� �ִ� ������ ���̽� ��ü
--> ����ڿ��� ������ �ο��� �� �� �� �� �ο��ϰ� �ȴٸ� ���� �ο� �� ȸ���� ����
-- ������ ������
--GRANT  CONNECT, RESOURCE TO KH;  ���⼭ CONNECT,RESOURCE�� ���� ������ ���ĳ��� ��.
--> ������ ��������.
--������� �ִ� ROLE�� ���, ������ ROLE�� ���� ���� �ִ�.
--������ ROLE�� ����� ������ ���Ѻο��� �غ�.
--���Ѱ� ���õ� ��ɾ�� �ݵ�� SYSTEM���� ����!!

-- ROLE --�ý��۰������� �����ؾ��ԡ�
SELECT * FROM ROLE_SYS_PRIVS
WHERE ROLE = 'DBA';

GRANT CONNECT, RESOURCE TO KH; -- ���� �ο��ߴ� ���� ROLE ��ü�� ���� ������ �ο��ߴ���

CREATE ROLE EMP_ROLE;
-- ������ ROLE��ü�� ����
GRANT SELECT ON KH.EMPLOYEE TO EMP_ROLE;
-- �ش� ROLE��ü�� ������ �ο��ϰ�
GRANT EMP_ROLE TO KHUSER;
-- ������ ROLE�� ����� ������ ���Ѻο��� �غ�.
REVOKE EMP_ROLE FROM KHUSER;
--�ý��۰������� �����ؾ��� ��

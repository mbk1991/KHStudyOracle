--TCL( Transaction Control Language)
--COMMIT, ROLLBACK;

SELECT * FROM EMPLOYEE;
CREATE TABLE EMP_COPY
AS SELECT EMP_ID,EMP_NAME,MANAGER_ID FROM EMPLOYEE;
SELECT* FROM EMP_COPY;

INSERT INTO EMP_COPY VALUES('100','�����','200');

--������� ���� ���� COMMIT
--Ŀ�� �� ���� ���� ��� ROLLBACK

COMMIT;
ROLLBACK;
INSERT INTO EMP_COPY VALUES('120','������','220');
SAVEPOINT savepoint1;
INSERT INTO EMP_COPY VALUES('130','�̽���','230');
ROLLBACK TO savepoint1;
--���̺�����Ʈ������ �ѹ��� �� �ֵ��� �ӽ� ���� ������ ����. �׳� �ѹ��� ������ ���̺�����Ʈ�� �����.
SELECT * FROM EMP_COPY;


--ROLLBACK  ����Ŀ�Ե� �������� �ǵ����� ��ɾ�.

-- ��������
--���̺� �ۼ� �� �� �÷��� ���� ��Ͽ� ���� ���������� ������ �� ����
--������ ���Ἲ�� ��Ű�� ���� ���ѵ� ����
--*������ ���Ἲ: �������� ��Ȯ���� �ϰ����� �����ϱ� ���� ��
/*
    1. NOT NULL(C) ->�ʼ��׸��� NULL�� �� �� ������ ��. IS NOT NULL
    2. UNIQUE(U) -> �ֹι�ȣ, �ڵ���, ���̵�, �̸��� �� �ߺ��� ������� ����. �÷� ������ ���ؾ� ��.
    3. PRIMARY KEY(�⺻Ű)(P) -> ���� �ĺ���, �ߺ� X NULL X
    4. FOREIGN KEY(�ܷ�Ű)(R) -> �� ���̺��� ������ �� ���� ����.
    5. CHECK(C) -> ����, ��ȥ����, ��������, �������� ��  Y/N , ��/��/ ���� ���� ����
    6. DEFAULT -> ��������,��������, ��¥ ��
*/

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM USER_CONSTRAINTS
WHERE TABLE_NAME ='EMPLOYEE';

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'EMPLOYEE';

CREATE TABLE USER_NOTNULL(
    USER_NO NUMBER NOT NULL,
    USER_ID VARCHAR2(20) NOT NULL,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);

INSERT INTO USER_NOTNULL VALUES(1,'khuser01','1234','ȫ�浿','��','019-1234-1234','hkd@naver.com');
SELECT * FROM USER_NOTNULL;

--UNIQUE��������
CREATE TABLE USER_UNIQUE(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
    );
    

CREATE TABLE USER_UNIQUE(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20), --UNIQUE,  --���������� �÷����� ���� 
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    UNIQUE(USER_ID) --���������� ���̺����� �����ߴ�. NOT NULL�� ���̺����� ����.
    );
    
INSERT INTO USER_UNIQUE 
VALUES(220,'khuser02','pass02','�̿���','��','010123456123','khuser02@iei.or.kr');

SELECT * FROM USER_UNIQUE;

INSERT INTO USER_UNIQUE 
VALUES(220,'khuser02','pass02','�̿���','��','010123456123','khuser02@iei.or.kr');

DROP TABLE USER_UNIQUE;

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME ='USER_UNIQUE';


--CHECK��������
CREATE TABLE USER_CHECK(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10) CHECK (GENDER IN ('��', '��')),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    GRADE_CODE NUMBER
);

INSERT INTO USER_CHECK
VALUES(1,'user01','pass01','�Ͽ���','����','01012312312345','user@naver.com',4);

--DEFAULT �ʱⰪ ����.

CREATE TABLE MEMBER_TBL(
    MEMBER_ID VARCHAR2(20) NOT NULL,
    MEMBER_PWD VARCHAR2(30) NOT NULL,
    ENROLL_DATE DATE DEFAULT SYSDATE
    );

INSERT INTO MEMBER_TBL
VALUES('khuser01','pass01','2022/07/18');
INSERT INTO MEMBER_TBL
VALUES('khuser02','pass01',DEFAULT);
INSERT INTO MEMBER_TBL
VALUES('khuser03','pass01',SYSDATE);
INSERT INTO MEMBER_TBL
VALUES('khuser04','pass01','123');

SELECT * FROM  MEMBER_TBL;

--��������
--Primary key(P) -> ���� �ĺ��� 
--���̺��� �� ���� ������ �����ϱ� ���� ���� �ĺ���(Identifier) ������ ��.
--NOT NULL UNIQUE �� �ǹ�. �� ���̺� �� �� ���� ���� ����
--�÷������� ���̺� �������� �Ѵ� ���� ������.
--���̺� �������� ���� �� �� �� �÷��� ������ �����ϴ�? ����Ű �� ���� ����� �ߺ��� �ؼҵǴ� ���.
CREATE TABLE USER_PRIMARYKEY(
    USER_NO NUMBER, --PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    PRIMARY KEY(USER_NO)
    );

INSERT INTO USER_PRIMARYKEY
VALUES(1,'khuser01','pass01','�Ͽ���','skq','01000000000','khuser01@naver.com');

INSERT INTO USER_PRIMARYKEY
VALUES(1,'khuser02','pass02','�Ͽ���','skq','01000000000','khuser01@naver.com');

--FOREIGN KEY(R) �ܷ�Ű
--���� ���Ἲ�� �����ϱ� ���� ��������, ������ �� ���� ���̺��� ���踦 ������ �ִ� ���� �ǹ�.
--������ �ٸ� ���̺��� �θ����̺��� �����ϴ� ���� ����� �� �ֵ��� ������ �Ŵ� ��
--�ڽ����̺� �ش� �÷��� ���� �����Ǵ� �θ����̺��� �÷� �� ���� �ϳ��� ��ġ�ϰų� NULL��
--���� �� ����.
--�θ�: SHOP_MEMBER, �ڽ�:SHOP_BUY ����� ���� �ִ��� �� �����
CREATE TABLE SHOP_MEMBER(
    USER_NO NUMBER UNIQUE,
    USER_ID VARCHAR2(20) PRIMARY KEY,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER CHAR(1),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(30)
);

CREATE TABLE SHOP_BUY( --ȸ���� ��ǰ�� �������� �� ����ϴ� ���̺�
    BUY_NO NUMBER CONSTRAINT PK_BUY_NO PRIMARY KEY,
    USER_ID VARCHAR2(20) REFERENCES SHOP_MEMBER(USER_ID) ON DELETE SET NULL,-- ����� �η� �ٲ��� --ON DELETE CASCADE �׳� �� ������.
    PRODEUC_NAME VARCHAR2(20),
    REG_DATE DATE DEFAULT SYSDATE
);
--USER_ID�� ���ؼ� SHOP_MEMBER�� ������ �Ǿ��ϴµ� USER_ID�� �����Ͱ� �ŷ��� �� ���ٸ�
--������ ���Ե�. MEMBER���̺��� USER_ID�� �ٸ� ���� ������ �� ����.



INSERT INTO SHOP_MEMBER
VALUES(1,'khuser01','pass01','�Ͽ���','M','01011111111','khuser01@iei.or.kr');
INSERT INTO SHOP_MEMBER
VALUES(2,'khuser02','pass01','�̿���','M','01022221111','khuser02@iei.or.kr');
INSERT INTO SHOP_MEMBER
VALUES(3,'khuser03','pass01','�����','M','01033331111','khuser03@iei.or.kr');
SELECT * FROM SHOP_MEMBER;
INSERT INTO SHOP_MEMBER
VALUES(4,'khuser04','pass01','�����','M','01044441111','khuser04@iei.or.kr');
SELECT * FROM SHOP_MEMBER;
COMMIT;

INSERT INTO SHOP_BUY
VALUES(1,'khuser01','�౸ȭ',DEFAULT);
INSERT INTO SHOP_BUY
VALUES(2,'khuser02','��ȭ',DEFAULT);
INSERT INTO SHOP_BUY
VALUES(3,'khuser03','����ȭ',DEFAULT);


SELECT * FROM SHOP_BUY;

INSERT INTO SHOP_BUY
VALUES(4,'khuser04','�Ǳ�ȭ',DEFAULT);

DELETE FROM SHOP_MEMBER
WHERE USER_ID = 'khuser04';

--Foreign key �������Ἲ�� ��ġ�� ���� �����Ѵ�.
--�θ����̺� �ִ� �͸� �ڽ����̺� ����� �� �ְ�
--�ڽ����̺� �����Ͱ� �ִµ� �θ����̺��� ���� �� ����.

--�����ÿ��� �ڽ��� ����� �θ� ��������. ���� ���� NULL�� �ٲٰ�
--�ٸ������ʹ� ������ �ʴ� ����� �ִ�.

-- ���̺��� ������ �ٲ� ���� ���̺��� ���� �� ������ؾ���.
DROP TABLE SHOP_BUY;

SELECT * FROM SHOP_BUY;

--ALTER�� �̿��� �������� �߰�,����,�̸����� �غ���
--�������� ���� ���� �� ���������� �߰�.

ALTER TABLE SHOP_MEMBER
DROP CONSTRAINT;

SELECT * FROM ALL_CONSTRAINTS WHERE TABLE_NAME = 'SHOP_MEMBER';

--ALTER�� �̿��� �������� �߰�, �������� ����, �������� �̸�����,
ADD CONSTRAINT PK_USER_ID PRIMARY KEY(USER_ID);
ALTER TABLE SHOP_MEMBER
ADD CONSTRAINT UNQ_USER_NO UNIQUE(USER_NO);
ALTER TABLE SHOP_MEMBER
MODIFY USER_PWD NOT NULL;


DROP TABLE SHOP_MEMBER;
DROP TABLE SHOP_BUY;

CREATE TABLE SHOP_BUY(
    BUY_NO NUMBER,  -- �����̸Ӹ�Ű
    USER_ID VARCHAR2(20), -- R
    PRODUCT_NAME VARCHAR2(50),
    REG_DATE DATE -- DEFAULT SYSDATE
);

ALTER TABLE SHOP_BUY
ADD CONSTRAINT PK_BUY_NO PRIMARY KEY(BUY_NO);

ALTER TABLE SHOP_BUY
DROP CONSTRAINT PK_BUY_NO;

SELECT * FROM ALL_CONSTRAINTS WHERE TABLE_NAME ='SHOP_BUY';

ALTER TABLE SHOP_BUY
ADD CONSTRAINT FK_USER_ID FOREIGN KEY(USER_ID) REFERENCES SHOP_MEMBER(USER_ID);

SELECT * FROM SHOP_MEMBER;

ALTER TABLE SHOP_BUY
MODIFY REG_DATE DEFAULT SYSDATE;

--�������� Ȱ��ȭ/ ��Ȱ��ȭ / �������� ON/OFF
ALTER TABLE SHOP_BUY ENABLE CONSTRAINT FK_USER_ID;
ALTER TABLE SHOP_BUY DISABLE CONSTRAINT FK_USER_ID;

























































































































































































































































































































































































































































































































































































































































































































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
    BUY_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) REFERENCES SHOP_MEMBER(USER_ID),
    PRODEUC_NAME VARCHAR2(20),
    REG_DATE DATE DEFAULT SYSDATE
);
--USER_ID�� ���ؼ� SHOP_MEMBER�� ������ �Ǿ��ϴµ� USER_ID�� �����Ͱ� �ŷ��� �� ���ٸ�
--������ ���Ե�. MEMBER���̺��� USER_ID�� �ٸ� ���� ������ �� ����.

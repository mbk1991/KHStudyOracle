--제약조건
--Primary key(P) -> 고유 식별자 
--테이블에서 한 행의 정보를 구분하기 위한 고유 식별자(Identifier) 역할을 함.
--NOT NULL UNIQUE 의 의미. 한 테이블 당 한 개만 설정 가능
--컬럼레벨과 테이블 레벨에서 둘다 지정 가능함.
--테이블 레벨에서 설정 시 두 개 컬럼에 설정이 가능하다? 복합키 두 개를 묶어야 중복이 해소되는 경우.
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
VALUES(1,'khuser01','pass01','일용자','skq','01000000000','khuser01@naver.com');

INSERT INTO USER_PRIMARYKEY
VALUES(1,'khuser02','pass02','일용자','skq','01000000000','khuser01@naver.com');

--FOREIGN KEY(R) 외래키
--참조 무결성을 유지하기 위한 제약조건, 참조는 두 개의 테이블이 관계를 가지고 있는 것을 의미.
--참조된 다른 테이블이 부모테이블이 제공하는 값만 사용할 수 있도록 제한을 거는 것
--자식테이블 해당 컬럼의 값은 참조되는 부모테이블의 컬럼 값 중의 하나와 일치하거나 NULL을
--가질 수 있음.
--부모: SHOP_MEMBER, 자식:SHOP_BUY 멤버가 누가 있는지 뭘 샀는지
CREATE TABLE SHOP_MEMBER(
    USER_NO NUMBER UNIQUE,
    USER_ID VARCHAR2(20) PRIMARY KEY,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER CHAR(1),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(30)
);

CREATE TABLE SHOP_BUY( --회원이 물품을 구매했을 때 기록하는 테이블
    BUY_NO NUMBER CONSTRAINT PK_BUY_NO PRIMARY KEY,
    USER_ID VARCHAR2(20) REFERENCES SHOP_MEMBER(USER_ID) ON DELETE SET NULL,-- 지우면 널로 바꾸자 --ON DELETE CASCADE 그냥 다 지우자.
    PRODEUC_NAME VARCHAR2(20),
    REG_DATE DATE DEFAULT SYSDATE
);
--USER_ID를 통해서 SHOP_MEMBER와 연결이 되야하는데 USER_ID의 데이터가 신뢰할 수 없다면
--에러가 나게됨. MEMBER테이블의 USER_ID와 다른 값은 존재할 수 없다.



INSERT INTO SHOP_MEMBER
VALUES(1,'khuser01','pass01','일용자','M','01011111111','khuser01@iei.or.kr');
INSERT INTO SHOP_MEMBER
VALUES(2,'khuser02','pass01','이용자','M','01022221111','khuser02@iei.or.kr');
INSERT INTO SHOP_MEMBER
VALUES(3,'khuser03','pass01','삼용자','M','01033331111','khuser03@iei.or.kr');
SELECT * FROM SHOP_MEMBER;
INSERT INTO SHOP_MEMBER
VALUES(4,'khuser04','pass01','사용자','M','01044441111','khuser04@iei.or.kr');
SELECT * FROM SHOP_MEMBER;
COMMIT;

INSERT INTO SHOP_BUY
VALUES(1,'khuser01','축구화',DEFAULT);
INSERT INTO SHOP_BUY
VALUES(2,'khuser02','농구화',DEFAULT);
INSERT INTO SHOP_BUY
VALUES(3,'khuser03','족구화',DEFAULT);


SELECT * FROM SHOP_BUY;

INSERT INTO SHOP_BUY
VALUES(4,'khuser04','피구화',DEFAULT);

DELETE FROM SHOP_MEMBER
WHERE USER_ID = 'khuser04';

--Foreign key 참조무결성을 해치는 경우는 금지한다.
--부모테이블에 있는 것만 자식테이블에 사용할 수 있고
--자식테이블에 데이터가 있는데 부모테이블에서 지울 수 없다.

--삭제시에는 자식을 지우고 부모를 지워야함. 참조 값을 NULL로 바꾸고
--다른데이터는 지우지 않는 방법이 있다.

-- 테이블의 설정을 바꿀 때는 테이블을 삭제 후 재생성해야함.
DROP TABLE SHOP_BUY;

SELECT * FROM SHOP_BUY;

--ALTER를 이용한 제약조건 추가,수정,이름변경 해보기
--제약조건 없이 만든 후 제약조건을 추가.

ALTER TABLE SHOP_MEMBER
DROP CONSTRAINT;

SELECT * FROM ALL_CONSTRAINTS WHERE TABLE_NAME = 'SHOP_MEMBER';

--ALTER를 이용한 제약조건 추가, 제약조건 삭제, 제약조건 이름변경,
ADD CONSTRAINT PK_USER_ID PRIMARY KEY(USER_ID);
ALTER TABLE SHOP_MEMBER
ADD CONSTRAINT UNQ_USER_NO UNIQUE(USER_NO);
ALTER TABLE SHOP_MEMBER
MODIFY USER_PWD NOT NULL;


DROP TABLE SHOP_MEMBER;
DROP TABLE SHOP_BUY;

CREATE TABLE SHOP_BUY(
    BUY_NO NUMBER,  -- 프라이머리키
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

--제약조건 활성화/ 비활성화 / 제약조건 ON/OFF
ALTER TABLE SHOP_BUY ENABLE CONSTRAINT FK_USER_ID;
ALTER TABLE SHOP_BUY DISABLE CONSTRAINT FK_USER_ID;

























































































































































































































































































































































































































































































































































































































































































































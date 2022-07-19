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
    BUY_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) REFERENCES SHOP_MEMBER(USER_ID),
    PRODEUC_NAME VARCHAR2(20),
    REG_DATE DATE DEFAULT SYSDATE
);
--USER_ID를 통해서 SHOP_MEMBER와 연결이 되야하는데 USER_ID의 데이터가 신뢰할 수 없다면
--에러가 나게됨. MEMBER테이블의 USER_ID와 다른 값은 존재할 수 없다.

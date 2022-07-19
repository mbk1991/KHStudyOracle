--# Oracle Object
--1. View
--2. Sequence
--3. Index
--4. Trigger
--5. Role

--1. View (Stored View) -> 이름을 붙이고 저장함.
--하나 이상의 테이블에서 원하는 데이터를 선택하여 새로운 가상 테이블을 만들어 주는 것.
--다른 테이블에 있는 데이터를 보여줄 뿐이며, 데이터 자체를 포함하고 있는 것은 아님.
-->저장장치내에 물리적으로 존재하지 않고 가상테이블로 만들어짐
-->물리적인 실제 테이블과의 링크개념
-->서브쿼리가 FROM뒤에 들어가면 인라인 뷰다. 인라인 뷰의 뷰가 이 뷰다.
--View를 만들기 위해서는 권한이 필요함. RESOURCE에는 View를 만드는 권한이 없음.
--CREATE VIEW 라는 권한을 KH에 부여하여야 함. GRANT CREATE VIEW TO KH;
--뷰는 왜 쓰는가?
--원래는 보안이 주 목적, 보여주고 싶지 않은 정보를 감출 때 사용.
--

SELECT *
FROM(
SELECT EMP_NAME, EMP_NO, DECODE(SUBSTR(EMP_NO,8,1),'1','남','3','남','여')"성별"
FROM EMPLOYEE);

CREATE VIEW EMP_GENDER
AS SELECT EMP_NAME, EMP_NO, DECODE(SUBSTR(EMP_NO,8,1),'1','남','3','남','여')"성별"
FROM EMPLOYEE;

SELECT * FROM EMP_GENDER
WHERE 성별 = '여';

--테이블은 아니지만 인라인 뷰에 이름을 붙여서 뷰라는 형태로 저장한다.
--이는 테이블과 똑같이 가져다 쓸 수 있다.


--뷰를 고치면 원본테이블도 바뀌게 됨. 조작이 안되는 경우는 다음과 같음.
--**DML(INSERT,UPDATE,DELETE) 명령어로 조작이 불가능한 경우
--1. 뷰 정의에 포함되지 않은 컬럼을 조작하는 경우. 가상컬럼에는 데이터를 추가할 수 없다.
--2. INSERT시에 뷰에 포함되지 않은 컬럼 중에 NOT NULL 제약조건이 지정된 경우 
--3. 산술 표현식을 정의된 경우. 연봉을 역추적해서 salary와 bonus컬럼값을 구하지 못함.
--4. JOIN을 이용해 여러 테이블을 연결한 경우
--5. DISTINCT를 포함한 경우
--6. 그룹함수나 GROUP BY 절을 포함한 경우

CREATE VIEW EMP_JOIN_INFO
AS SELECT EMP_NAME, DEPT_TITLE FROM EMPLOYEE LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
SELECT* FROM EMP_JOIN_INFO;

--#View 옵션
--1.OR REPLACE
--> 생성한 뷰가 존재하면 뷰를 갱신함.
CREATE OR REPLACE VIEW EMP_JOIN_INFO
AS SELECT EMP_NAME, DEPT_TITLE FROM EMPLOYEE LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
SELECT* FROM EMP_JOIN_INFO;

-->테이블은 테이블을 DROP 후 다시 CREATE 해야 함. VIEW는 갱신할 수 있다.
--2. FORCE/NOFORCE
--> FORCE 옵션은 기본 테이블이 존재하지 않더라도 뷰를 생성함. 테이블이 없는데 뷰를 강제로 만듦.
--> NOFORCE는 기본테이블이 없으면 생성하지 않음(디폴트). 잘 사용하지 않음.
CREATE FORCE VIEW EMP_VIEW
AS SELECT EMP_ID,EMP_NAME,SALARY FROM NONO;
SELECT * FROM EMP_VIEW;
--3. WITH CHECK OPTION
--WHERE조건에 사용한 컬럼의 값을 수정하지 못하게 함.
CREATE OR REPLACE VIEW EMP_VIEW_D5
AS SELECT EMP_ID, EMP_NAME,SALARY,DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' WITH CHECK OPTION;
--정보수정
--월급이 250만원 이상인 사원부서 D2로 변경
UPDATE EMP_VIEW_D5 SET DEPT_CODE ='D2'
WHERE SALARY >= 2500000;


--4. WITH READ ONLY
--특정컬럼이 아니라 아예 삽입,수정,삭제등을 하지 못하게 함
--뷰에 대해 조회만 가능하도록 함.

CREATE OR REPLACE VIEW EMP_VIEW_D5
AS SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' WITH READ ONLY;

UPDATE EMP_VIEW_D5 SET SALARY = SALARY + 500000;

--Data Dictionary
--1. USER_XXXX  // 접속 계정에 대한 정보, 자신이 소유한 객체등에 관한 정보 조회가능
--앞으로 배울 객체들의 메타데이터들이 데이터딕셔너리에서 관리될 것임.
--사용자가 아닌 DB에서 자동생성/관리해주는 것이며 USER 뒤에 객체명을 써서 조회함.

--2. ALL_XXXX  //모든 테이블에 대한 정보,자신의 계정이 소유하거나 권한을 부여받은 
--객체 등에 관한 정보 조회 가능

--3. DBA_XXXX //데이터베이스 관리자만 접근이 가능한 객체 등의 정보 조회 가능 
  -->DBA는 모든 접근이 가능하므로 결국 DB에 있는 모든 객체에 대한 조회가능

--시스템이 관리하는 테이블이 있음. 이 테이블에서 필요한 정보만 사용자가 볼 수 있도록
--만들어 놓은 뷰를 데이터 딕셔너리라고 한다.
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'EMPLOYEE';

SELECT * FROM DBA_TABLES;
--일반사용자인 KH는 DBA_XXX에 대한 권한이 없다.

--2. Sequence
--순차적으로 정수 값을 자동으로 생성하는 객체로, 자동 번호 발생기(채번기)의 역할을 함.
--순차적으로 늘어나는 정수값 EX)게시글 번호, 회원 번호

DESC SHOP_MEMBER;


--SEQUENCE 생성
CREATE SEQUENCE SEQ_USER_NO
START WITH 1
INCREMENT BY 1
MAXVALUE 10000
CYCLE -- MAXVALUE까지 갔을 때 다시 1로 돌아갈 것이냐 , NOCYCLE은 에러를 발생시킴.
NOCACHE; --캐시에 시퀀스 값을 관리할 것이냐 안 할 것이냐.
--NOMAXVALUES

CREATE SEQUENCE SEQ_USER_NO_DEFAULT;  --옵션들은 생략 가능
--START WITH 1
--INCREMENT BY 1
--NOMAXVALUE
--NOCYCLE
--NOCACHE

SELECT* FROM USER_SEQUENCES;
SELECT* FROM SEQ_USER_NO_DEFAULT;

INSERT INTO SHOP_MEMBER
VALUES(1, 'khuser01', 'pass01', '일용자','남', '01092928383', 'khuser01@iei.or.kr');
INSERT INTO SHOP_MEMBER
VALUES(2, 'khuser02', 'pass02', '이용자', '01082830494', 'khuser02@iei.or.kr');
INSERT INTO SHOP_MEMBER
VALUES(3, 'khuser03', 'pass03', '삼용자', '01092983939', 'khuser03@iei.or.kr');
SELECT * FROM SHOP_MEMBER;

CREATE TABLE SEQUENCE_TEST(
USER_NUMBER NUMBER PRIMARY KEY,
USER_NAME VARCHAR2(10)
);

SELECT * FROM SEQUENCE_TEST;
INSERT INTO SEQUENCE_TEST VALUES(SEQ_USER_NO.NEXTVAL,'일용자');
INSERT INTO SEQUENCE_TEST VALUES(SEQ_USER_NO.NEXTVAL,'이용자');
INSERT INTO SEQUENCE_TEST VALUES(SEQ_USER_NO.NEXTVAL,'삼용자');
INSERT INTO SEQUENCE_TEST VALUES(SEQ_USER_NO.NEXTVAL,'사용자');
INSERT INTO SEQUENCE_TEST VALUES(SEQ_USER_NO.NEXTVAL,'오용자');
DELETE FROM SEQUENCE_TEST WHERE USER_NAME = '사용자';

SELECT SEQ_USER_NO.CURRVAL FROM DUAL; -- 현 시퀀스 확인 방법
--INSERT 오류가 나더라도 시퀀스의 값은 증가함

ROLLBACK;
SELECT SEQ_USER_NO.CURRVAL FROM DUAL;
--롤백을 해도 시퀀스 값이 변하지 않는다.
ALTER SEQUENCE SEQ_USER_NO
INCREMENT BY 10;
-- 시퀀스는 증가폭 수정은 가능하지만 초기값은 수정이 불가함.

SELECT * FROM SEQ_USER_NO;


-- 시퀀스 생성
CREATE SEQUENCE SEQ_USER_NO
START WITH 1    -- 생략가능
INCREMENT BY 1  -- 생략가능
NOMAXVALUE      -- 생략가능
NOCYCLE         -- 생략가능
NOCACHE;        -- 생략가능
-- CREATE SEQUENCE SEQ_USER_NO;
-- 시퀀스 확인
SELECT * FROM USER_SEQUENCES;
-- 시퀀스 이용 데이터 삽입
INSERT INTO SHOP_MEMBER
VALUES(SEQ_USER_NO.NEXTVAL, 'khuser01', 'pass01', '01092928383', 'khuser01@iei.or.kr');
INSERT INTO SHOP_MEMBER
VALUES(SEQ_USER_NO.NEXTVAL, 'khuser02', 'pass02', '01082830494', 'khuser02@iei.or.kr');
INSERT INTO SHOP_MEMBER
VALUES(SEQ_USER_NO.NEXTVAL, 'khuser03', 'pass03', '01092983939', 'khuser03@iei.or.kr');
INSERT INTO SHOP_MEMBER
VALUES(SEQ_USER_NO.NEXTVAL, 'khuser04', 'pass04', '01092444939', 'khuser04@iei.or.kr');
-- 시퀀스 현재값 조회
SELECT SEQ_USER_NO.CURRVAL FROM DUAL;
-- INSERT 오류가 나더라도 시퀀스의 값은 증가함
-- 해당 시퀀스의 현재값을 조회하기 위해 CURRVAL을 사용해야함
-- 시퀀스 수정
ALTER SEQUENCE SEQ_USER_NO
INCREMENT BY 10;           -- 시퀀스 증가폭 수정
-- 시퀀스 삭제
DROP SEQUENCE SEQ_USER_NO; -- 초기값은 수정이 안되기 때문에 지웠다가 다시 만들어야함

--##  시퀀스 간단 예제 ##
--KH_MEMBER 테이블을 생성
CREATE TABLE KH_MEMBER(
 MEMBER_ID NUMBER,
 MEMER_NAME VARCHAR2(20),
 MEMBER_AGE NUMBER,
 MEMBER_JOIN_COM NUMBER
);

--컬럼
--MEMBER_ID	NUNBER
--MEMBER_NAME	VARCHAR2(20)
--MEMBER_AGE	NUMBER
--MEMBER_JOIN_COM	NUMBER

--이때 해당 사원들의 정보를 INSERT 해야 함
--ID 값과 JOIN_COM은 SEQUENCE 를 이용하여 정보를 넣고자 함

--ID값은 500 번 부터 시작하여 10씩 증가하여 저장 하고자 함
CREATE SEQUENCE ID_SEQUENCE
START WITH 500
MAXVALUE 10000
INCREMENT BY 10;

DROP SEQUENCE ID_SEQUENCE;

--JOIN_COM 값은 1번부터 시작하여 1씩 증가하여 저장 해야 함
--(ID 값과 JOIN_COM 값의 MAX는 10000으로 설정)
CREATE SEQUENCE JOIN_COM_SEQUENCE
START WITH 1
MAXVALUE 10000
INCREMENT BY 1;



--	MEMBER_ID	MEMBER_NAME	MEMBER_AGE	MEMBER_JOIN_COM	
--	500		     홍길동		 20		     1
--	510		     김말똥	 	 30		     2
--	520		     삼식이		 40	         3
--	530	       	고길똥		 24		     4

INSERT INTO KH_MEMBER 
VALUES(ID_SEQUENCE.NEXTVAL,'홍길동','20',JOIN_COM_SEQUENCE.NEXTVAL);
INSERT INTO KH_MEMBER 
VALUES(ID_SEQUENCE.NEXTVAL,'김말똥','30',JOIN_COM_SEQUENCE.NEXTVAL);
INSERT INTO KH_MEMBER 
VALUES(ID_SEQUENCE.NEXTVAL,'삼식이','40',JOIN_COM_SEQUENCE.NEXTVAL);
INSERT INTO KH_MEMBER 
VALUES(ID_SEQUENCE.NEXTVAL,'고길똥','24',JOIN_COM_SEQUENCE.NEXTVAL);

SELECT * FROM KH_MEMBER;


--NEXTVAL, CURRVAL 을 사용할 수 있는 경우
--서브쿼리가 아닌 SELECT절
--INSERT문의 SELECT절
--INSERT문의 VALUES절
--UPDATE문의 SET절
-- ** NEXTVAL, CURRVAL을 사용할 수 없는 경우
-- VIEW의 SELECT절
-- DISTINCT 키워드가 있는 SELECT절
-- GROUP BY, HAVING, ORDER BY절이 있는 SELECT문
-- SELECT, DELETE, UPDATE의 서브쿼리
-- CREATE TABLE, ALTER TABLE 명령의 DEFAULT 값


--# INDEX(색인)
--인덱스 설정을 직접하진 않으나 개념을 알고 있어야함. 
--목차의 역할과 같다. 데이터를 빠르게 찾을 수 있게 한다.
--SQL명령문의 처리속도를 향상시키기 위해서 (((((컬럼)))))에 대해 생성하는 오라클 객체!!!!!
--컬럼에한다.
--KEY-VALUE형태로 생성이 되며 KEY에는 인덱스로 만들 컬럼값, VALUE에는 행이 저장된 주소값이 저장됨.
-- *장점: 검색속도가 빨라지고 시스템에 걸리는 부하를 줄여서 시스템 전체 성능을 향상시킬 수 있음
-- *단점: 1.인덱스를 위한 추가 저장 공간이 필요하고, 인덱스를 생성하는데 시간이 걸림
--        2.데이터의 변경작업(INSERT/UPDATE/DELETE)가 자주 일어나는 테이블에 INDEX 생성 시
--          오히려 성능 저하가 발생할 수 있음.
--* 어떤 칼럼에 인덱스를 만들면 좋을까?
--데이터값이 중복된 것이 없는 고유한 데이터값을 가지는 컬럼에 만드는 것이 제일 좋다.
--선택도(SELECTIVITY)가 좋은 컬럼의 예
--사원번호, 주민번호,사원명

--효율적인 인덱스 사용 예
--WHERE절에 자주 사용되는 컬럼에 인덱스 생승
-- 전체 데이터 중에서 10%~ 15% 이내의 데이터를 검색하는 경우, 중복이 많지 않은 컬럼이어야 함
-->두 개 이상의 컬럼 WHERE절이나 조인(JOIN)조건으로 자주 사용되는 경우
-->한 번 입력된 데이터의 변경이 자주 일어나지 않는 경우
-->한 테이블에 저장된 데이터 용량이 상당히 클 경우

--비효율적인 인덱스 사용 예
--중복값이 많은 컬럼에 사용된 인덱스
--NULL값이 많은 컬럼
-->인덱스의 수는 제한이 없으나 너무 많으면 오히려 성능저하.
--인덱스는 경험의 축적과 노하우가 쌓여야 잘 알 수 있다. 어떤 것인지 알아가는 수준으로 생각한다.

--#INDEX 정보 조회
SELECT * FROM USER_INDEXES
WHERE TABLE_NAME = 'EMPLOYEE';
--한번도 만들지 않았으나 PK,UNQ제약조건 컬럼은 자동으로 동일한 이름의 인덱스를 생성함

--#INDEX 생성
--CREATE INDEX 인덱스명 ON 테이블명(컬럼명1,...)
SELECT * FROM EMPLOYEE WHERE EMP_NAME = '송종기';
CREATE INDEX IDX_EMP_NAME ON EMPLOYEE(EMP_NAME);

--#INDEX 삭제
DROP INDEX IDX_EMP_NAME;

--5. ROLE
--> 사용자에게 여러개의 권한을 한번에 부여할 수 있는 데이터 베이스 객체
--> 사용자에게 권한을 부여할 때 한 개 씩 부여하게 된다면 권한 부여 및 회수에 따른
-- 관리가 불편함
--GRANT  CONNECT, RESOURCE TO KH;  여기서 CONNECT,RESOURCE는 여러 권한을 뭉쳐놓은 것.
--> 관리가 쉬워진다.
--만들어져 있는 ROLE의 사용, 실제로 ROLE을 만들 수도 있다.
--나만의 ROLE을 사용자 계정에 권한부여를 해봄.
--권한과 관련된 명령어는 반드시 SYSTEM에서 수행!!

-- ROLE --시스템계정에서 실행해야함↓
SELECT * FROM ROLE_SYS_PRIVS
WHERE ROLE = 'DBA';

GRANT CONNECT, RESOURCE TO KH; -- 지금 부여했던 것은 ROLE 객체를 통해 권한을 부여했던것

CREATE ROLE EMP_ROLE;
-- 나만의 ROLE객체를 만들어서
GRANT SELECT ON KH.EMPLOYEE TO EMP_ROLE;
-- 해당 ROLE객체에 권한을 부여하고
GRANT EMP_ROLE TO KHUSER;
-- 나만의 ROLE을 사용자 계정에 권한부여를 해봄.
REVOKE EMP_ROLE FROM KHUSER;
--시스템계정에서 실행해야함 ↑

--DB를 다루는 마인드: 데이터는 돈(비용)이다. 매우 민감하므로 조심하자.

--1. Oracle DBMS 실행 시 내 컴퓨터의 port에 서버가 실행된다. 1521포트
--2. CLI 또는 SQL디벨로퍼를 이용할 수 있다. (CMD sqlplus )
--3. 최초 설치 시 관리자(SYS, SYSTEM 등) 비밀번호를 설정한다.
--4. 관리자의 권한으로 사용자를 생성한다.
--5. 테이블을 생성, 수정, 삭제, 조회 한다.

-- 관리자 접속 및 사용자 변경하는 방법
CONN SYS SYSDBA
ALTER USER SYS IDENTIFIED BY khadmin;


--테이블에 값 삽입하는 방법
INSERT INTO LOVER(LOVER_NAME, LOVER_PWD, LOVER_AGE,LOVER_DATA)
VALUES('khuser01','pass01',33,SYSDATE);


--테이블을 조회하는 방법
SELECT LOVER_NAME, LOVER_PWD, lover_age, LOVER_DATA
FROM LOVER
WHERE LOVER_NAME = 'khuser2';


--테이블에서 데이터를 삭제하는 방법(행 기준)
--DELETE 는 무조건 WHERE와 함께 써야함
DELETE
FROM LOVER
WHERE LOVER_NAME = 'khuser3';

--테이블에서 데이터를 수정하는 방법
UPDATE LOVER
SET LOVER_ID = null
WHERE LOVER_ID = 'khuser00';

UPDATE LOVER
SET LOVER_NAME = 'KHUSER01'
WHERE LOVER_NAME IS NULL;
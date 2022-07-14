--연산자 우선순위
--여러 연산자를 사용하는 경우 우선순위를 고려해서 사용해야함
-- 산술 > 연결 > 비교 > IS NULL, LIKE, IN ( NOT포함)
--> BETWEEN AND < 논리 (NOT) > 논리(AND) > 논리 (OR)
--헷갈릴 때는 소괄호를 사용하라

--관리자 계정 SYS, SYSTEM 차이
--1. SYS : 슈퍼관리자, 데이터베이스 생성/삭제 권한 있음
--로그인 옵션으로 반드시 SYSDBA로 지정
--데이터딕셔너리를 소유하고 있음.
--2. SYSTEM: 일반관리자, 데이터베이스 생성/ 삭제 권한 없음.

--SQL 개요
--SQL의 종류
-->데이터 정의어 : DDL (Data Definition Language)
-->데이터 조작어 : DML (Data Manipulation Language)
-->데이터 제어어 : DCL (Data Control Language)
-->트랜잭션 제어어 : TCL (Transaction Control Language)

--DDL
--CREATE(객체생성), DROP(객체삭제), ALTER(객체 수정)
--TRUNCATE(객체 초기화)
-->데이터베이스의 구조를 정의하거나 변경, 삭제하기 위해 사용하는 언어

--DML
--INSERT, UPDATE, DELETE, SELECT
-->데이터를 조작하기 위해 사용하는 언어

--DQL(Data Query Language)
--SELECT
-->데이터를 검색(추출)하기 위해 사용하는 언어

--DCL
--GRANT(권한부여), REVOKE(권한해제)
-->사용자의 권한이나 관리자 설정 등을 처리하는 언어

--TCL
--COMMIT, ROLLBACK
-->트랜잭션 종료처리 후 저장하거나 취소할 때 사용되는 언어


SHOW USER;
DESC EMPLOYEE;
INSERT INTO EMPLOYEE
VALUES('900','장채현','901123-1234567','jang_ch@kh.or.kr','01000000000',
    'D1','JB','S3',4300000,0.2,'200',SYSDATE,NULL,'N');
SELECT * FROM EMPLOYEE;
ROLLBACK;
COMMIT;
DELETE FROM EMPLOYEE WHERE EMP_NAME LIKE '장채%';



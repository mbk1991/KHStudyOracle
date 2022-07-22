--1.관리자 계정 접속
CONN SYS AS SYSDBA;
--2.사용자 계정 생성
CREATE USER USER1 IDENTIFIED BY PWD1234;
--2. 사용자 계정에 권한부여
GRANT RESOURCE, CONNECT TO USER1;
--3. 사용자 계정으로 전환하기
ALTER USER USER1 IDENTIFIED BY PWD1234;

--주요 사용자계정
/*
    1. SYS : 최고 관리자. 모든 권한
    2. SYSTEM : 유지보수 및 관리
    3. ANONYMOUS : HTTP를 통한  XML DB 접근용 계정
    3. HR : 샘플 계정
*/
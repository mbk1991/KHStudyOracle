--PL/SQL과 관련된 오라클 객체
-- Function, Procedure, Cursor, Package, Trigger, Job,...

-- PL/SQL의 유형
-- PL/SQL 유형은 3가지가 있음, 익명블록(Anonymous Block), 프로시저(Procedure), 함수(Function)
-- 익명블록 : 이름 없는 블록이라 불리며 간단한 block 수행시 사용됨
-- 프로시저 : 지정된 특정처리를 실행하는 서브프로그램의 한 유형으로 단독으로 실행되거나
-- 다른 프로시저나 다른 툴 등에 의해 호출되어 실행됨
-- 함수 : Procedure와 수행되는 결과가 유사하나 값 반환 여부에 따라 차이가 있음
-- 함수는 반환값이 있음.

-- 프로시져는 일련의 작업절차를 정리해서 저장해 둔 것
-- 여러 SQL문을 묶어서 미리 정의해두고 하나의 요청으로 실행 할 수 있음
-- 자주 사용되는 복잡한 작업들을 간단하게 미리 만들어 두면 쉽게 사용이 가능함
-- 자바로 다 해결할 수 있는 부분임.

SET SERVEROUTPUT ON;

--Stored Procedure
--예제
CREATE TABLE EMP_DUP AS SELECT * FROM EMPLOYEE;
SELECT * FROM EMP_DUP;

--EMP_DUP의 데이터를 모두 삭제하는 프로시져 생성.
CREATE PROCEDURE DEL_ALL_EMP
IS
BEGIN
    DELETE FROM EMP_DUP;
    COMMIT;
END;
/

EXECUTE DEL_ALL_EMP;
SELECT * FROM EMP_DUP;  --깔끔하게 지워짐

SELECT * FROM USER_PROCEDURES;
--DEVELOPER GUI환경에서 확인하거나 CLI로 확인할 수 있다.
--프로시저의 소스를 확인하는 데이터 딕셔너리
SELECT * FROM  USER_SOURCE
WHERE NAME = 'DEL_ALL_EMP';

SELECT *FROM USER_SOURCE;

--예제2. 매개변수 있는 프로시져 만들기 -- 에러 찾기..
--0/0       PL/SQL: Compilation unit analysis terminated
--1/37      PLS-00201: identifier 'EMP_DUM.EMP_ID' must be declared
INSERT INTO EMP_DUP (SELECT * FROM EMPLOYEE); --데이터를 다시 넣어줌
SELECT * FROM EMP_DUP;
COMMIT;

CREATE PROCEDURE PROC_DEL_EMP_ID(
    P_EMP_ID  EMPLOYEE.EMP_ID%TYPE
)
IS
BEGIN
    DELETE FROM EMP_DUP WHERE EMP_ID = P_EMP_ID;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE(P_EMP_ID || '번 사원을 삭제했습니다.');
END;
/

DROP PROCEDURE PROC_DEL_EMP_ID;

EXECUTE PROC_DEL_EMP_ID(&사원번호);


--예제3. 매개변수의 모드지정(IN,OUT,INOUT),바인드변수
--매개변수 IN: 데이터를 전달받을 때
--매개변수 OUT: 수행된 결과를 반환할 때
--매개변수INOUT: 데이터를 전달받고 수행된 결과를 반환할 때
--바인드 변수: 값을 받아 사용하는 변수

--셀렉트를 해주는 프로시저

CREATE PROCEDURE PROC_SELECT_EMP_ID(
    P_EMP_ID IN EMPLOYEE.EMP_ID%TYPE,
    P_EMP_NAME OUT EMPLOYEE.EMP_NAME%TYPE,
    P_SALARY OUT EMPLOYEE.SALARY%TYPE,
    P_BONUS OUT EMPLOYEE.BONUS%TYPE
)
IS
BEGIN
    SELECT EMP_NAME, SALARY, NVL(BONUS,0)
    INTO P_EMP_NAME, P_SALARY, P_BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = P_EMP_ID;
END;
/
SELECT * FROM USER_PROCEDURES;

EXECUTE PROC_SELECT_EMP_ID (&사원번호);
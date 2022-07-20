--PL/SQL
-->Procedural Language extension to SQL의 약자
-->오라클 자체에 내장되어 있는 절차적 언어로써, SQL의 단점을 보완하여
--SQL문장 내에서 변수의 정의, 조건처리, 반복처리 등을 지원함

--#PL/SQL 블록 문법
/*
    DECLARE
        [선언부]      - 선택
    BEGIN
        [실행부]      - 필수
    EXCEPTION
        [예외처리부]  -선택
    END;
    /



*/

--#기본설정
SET SERVEROUTPUT ON;  --시동걸기
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello PL/SQL'); 
END;
/

--# 변수 선언
-- 변수명 [CONSTANT] 자료형 (바이트크기) [NOT NULL] [:=초기값];
DECLARE
    EMPNO NUMBER := 1720;
    ENAME VARCHAR2(20) := '손예진';
BEGIN
    DBMS_OUTPUT.PUT_LINE('사번: ' || EMPNO);
    DBMS_OUTPUT.PUT_LINE('이름: ' || ENAME);
END;
/
-- # 변수의 종류
-- 일반(스칼라)변수, 상수, %TYPE, %ROWTYPE, 레코드(Record)

-- # 상수 : 일반변수와 유사하나 constant라는 키워드가 자료형 앞에 붙고
-- 선언 시에 값을 할당해주어야 함

DECLARE
    USER_NAME CONSTANT VARCHAR2(20) := '일용자';
    USER_NAME2 VARCHAR2(20) := '이용자';
BEGIN
    DBMS_OUTPUT.PUT_LINE('상수값 : ' || USER_NAME);
    DBMS_OUTPUT.PUT_LINE('변수값 : ' || USER_NAME2);
END;
/

-- PL/SQL에서 SELECT문
--> SQL에서 사용하는 명령어를 그대로 사용할 수 있으며 SELECT 쿼리 결과로 나온 값을
--변수에 할당하기 위해 사용함 .SELECT한 값을 변수에 넣고 변수를 사용하는 형태.

DECLARE
    VEMPNO EMPLOYEE.EMP_NO%TYPE;
    VENAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN
    SELECT EMP_NO, EMP_NAME
    INTO VEMPNO, VENAME
    FROM EMPLOYEE
    WHERE EMP_NAME = '송종기';
    DBMS_OUTPUT.PUT_LINE('주민등록번호: ' || VEMPNO);
    DBMS_OUTPUT.PUT_LINE('이름: ' ||VENAME);
END;
/

--예제 2)
--사원번호를 입력 받아서 사원의 사원번호, 이름, 급여, 입사일을 출력하시오
DECLARE
    VEMP_ID EMPLOYEE.EMP_ID%TYPE;
    VEMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    VSALARY EMPLOYEE.SALARY%TYPE;
    VHIRE_DATE EMPLOYEE.HIRE_DATE%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE
    INTO VEMP_ID,VEMP_NAME,VSALARY,VHIRE_DATE
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMP_ID';
    
    DBMS_OUTPUT.PUT_LINE('VEMP_ID:' || VEMP_ID);
    DBMS_OUTPUT.PUT_LINE('VEMP_NAME:' || VEMP_NAME);
    DBMS_OUTPUT.PUT_LINE('VSALARY: ' || VSALARY);
    DBMS_OUTPUT.PUT_LINE('VHIRE_DATE:' || VHIRE_DATE);
END;
/

--문제1)
--사원 번호를 입력 받아서 받은 사원의 사원번호,이름,부서코드,부서명을 출력하도록 하시오
DECLARE
    VEMP_ID EMPLOYEE.EMP_ID%TYPE;
    VEMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    VDEPT_CODE EMPLOYEE.DEPT_CODE%TYPE;
    VDEPT_TITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
    INTO VEMP_ID, VEMP_NAME, VDEPT_CODE, VDEPT_TITLE
    FROM EMPLOYEE JOIN DEPARTMENT ON ( DEPT_CODE = DEPT_ID)
    WHERE EMP_ID = '&EMP_ID';
    
    DBMS_OUTPUT.PUT_LINE('사원번호:' || VEMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름:' || VEMP_NAME);
    DBMS_OUTPUT.PUT_LINE('부서코드:' || VDEPT_CODE);
    DBMS_OUTPUT.PUT_LINE('부서명:' || VDEPT_TITLE);
    
END;
/


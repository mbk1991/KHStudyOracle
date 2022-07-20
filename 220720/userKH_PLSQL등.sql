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

--## 간단 실습 1 ##
-- 해당 사원의 사원번호를 입력시
-- 이름,부서코드,직급코드가 출력되도록 PL/SQL로 만들어 보시오 
DECLARE
    VEMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    VDEPT_CODE EMPLOYEE.DEPT_CODE%TYPE;
    VJOB_CODE EMPLOYEE.JOB_CODE%TYPE;
BEGIN
    SELECT EMP_NAME, DEPT_CODE,JOB_CODE
    INTO VEMP_NAME, VDEPT_CODE, VJOB_CODE
    FROM EMPLOYEE
    WHERE EMP_ID ='&EMP_ID';
    DBMS_OUTPUT.PUT_LINE('이름:' || VEMP_NAME);
    DBMS_OUTPUT.PUT_LINE('부서코드:' || VDEPT_CODE);
    DBMS_OUTPUT.PUT_LINE('직급코드:' || VJOB_CODE);
END;
/

--## 간단 실습 2 ##
-- 해당 사원의 사원번호를 입력시
-- 이름,부서명,직급명이 출력되도록 PL/SQL로 만들어 보시오

DECLARE
    VEMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    VDEPT_TITLE DEPARTMENT.DEPT_TITLE%TYPE;
    VJOB_NAME JOB.JOB_NAME%TYPE;
BEGIN
    SELECT EMP_NAME,DEPT_TITLE,JOB_NAME
    INTO VEMP_NAME,VDEPT_TITLE,VJOB_NAME
    FROM EMPLOYEE E LEFT JOIN DEPARTMENT D ON DEPT_ID = DEPT_CODE
                    LEFT JOIN JOB J ON E.JOB_CODE =  J.JOB_CODE
    WHERE EMP_ID = '&EMP_ID';
    
    DBMS_OUTPUT.PUT_LINE('이름 : ' || VEMP_NAME);
    DBMS_OUTPUT.PUT_LINE('부서명 : ' || VDEPT_TITLE);
    DBMS_OUTPUT.PUT_LINE('직급명 : ' || VJOB_NAME);
    
END;
/
--PL/SQL의 선택문
--모든 문장들은 기술한 순서대로 순차적으로 수행됨
-- 문장을 선택적으로 수행하려면 IF문을 사용하면ㄷ ㅚㅁ
--IF THEN END IF; 문

--예제) 사원번호를 가지고 사원의 사번,이름,급여,보너스율을 출력하고
--보너스율이 없으면 '보너스를 지급받지 않는 사원입니다'를 출력하시오

DECLARE
    VEMP_ID EMPLOYEE.EMP_ID%TYPE;
    VEMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    VSALARY EMPLOYEE.SALARY%TYPE;
    VBONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS,0)
    INTO VEMP_ID, VEMP_NAME, VSALARY, VBONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMP_ID';
    
    IF(VBONUS = 0)
    THEN DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다.');
    ELSE
    DBMS_OUTPUT.PUT_LINE('사번:' || VEMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름:' || VEMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여:' || VSALARY);
    DBMS_OUTPUT.PUT_LINE('보너스율:' || VBONUS*100 ||'%');
    END IF;
END;
/

--예시) 사원코드를 입력받았을 때 사번,이름,직급코드,직급명,소속 값을 출력하시오
--그때, 소속값은 J1,J2는 임원진, 그 외에는 일반직원으로 출력되게 하시오.

DECLARE
    VEMP_ID EMPLOYEE.EMP_ID%TYPE;
    VEMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    VJOB_CODE EMPLOYEE.JOB_CODE%TYPE;
    VJOB_NAME JOB.JOB_NAME%TYPE;
    ETEAM VARCHAR2(30);

BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
    INTO VEMP_ID, VEMP_NAME, VJOB_CODE, VJOB_NAME
    FROM EMPLOYEE LEFT JOIN JOB USING(JOB_CODE)
    WHERE EMP_ID = '&EMP_ID';
    
    IF(VJOB_CODE IN('J1','J2'))
    THEN ETEAM := '임직원';
    ELSE ETEAM := '일반직원';
    END IF;


    DBMS_OUTPUT.PUT_LINE('사번: ' ||VEMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름: ' ||VEMP_NAME);
    DBMS_OUTPUT.PUT_LINE('직급코드: ' ||VJOB_CODE);
    DBMS_OUTPUT.PUT_LINE('직급명: ' ||VJOB_NAME);
    DBMS_OUTPUT.PUT_LINE('소속: ' || ETEAM);
    
END;
/




--## 간단 실습 1 ##
-- 사원 번호를 가지고 해당 사원을 조회
-- 이때 사원명,부서명 을 출력하여라.
-- 만약 부서가 없다면 부서명을 출력하지 않고,
-- '부서가 없는 사원 입니다' 를 출력하고
-- 부서가 있다면 부서명을 출력하여라.

DECLARE
    VEMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    VDEPT_TITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
    SELECT EMP_NAME, DEPT_TITLE
    INTO VEMP_NAME, VDEPT_TITLE
    FROM EMPLOYEE LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    WHERE EMP_ID = '&사원번호';
    
     DBMS_OUTPUT.PUT_LINE('이름 : ' || VEMP_NAME);
    IF(VDEPT_TITLE IS NULL)
    THEN 
        DBMS_OUTPUT.PUT_LINE('부서가 없는 사원입니다.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('부서 : ' || VDEPT_TITLE);
    END IF;

END;
/


--IF
--IF THEN
--ELSIF THEN
--ELSE
--END IF;

--## 실습 문제 ##
--사번을 입력 받은 후 급여에 따라 등급을 나누어 출력하도록 하시오 
--그때 출력 값은 사번,이름,급여,급여등급을 출력하시오

--0만원 ~ 99만원 : F
--100만원 ~ 199만원 : E
--200만원 ~ 299만원 : D
--300만원 ~ 399만원 : C
--400만원 ~ 499만원 : B
--500만원 이상(그외) : A

--ex) 200
--사번 : 200
--이름 : 선동일
--급여 : 8000000
--등급 : A
DECLARE
    VEMP_ID EMPLOYEE.EMP_ID%TYPE;
    VEMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    VSALARY EMPLOYEE.SALARY%TYPE;
    SALGRADE VARCHAR2(2);
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO VEMP_ID, VEMP_NAME, VSALARY
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMP_ID';
    /*
    IF(VSALARY >=0 AND VSALARY <1000000) THEN SALGRADE := 'F';
    ELSIF(VSALARY >=1000000 AND VSALARY <2000000) THEN SALGRADE := 'E';
    ELSIF(VSALARY >=2000000 AND VSALARY <3000000) THEN SALGRADE := 'D';
    ELSIF(VSALARY >=3000000 AND VSALARY <4000000) THEN SALGRADE := 'C';
    ELSIF(VSALARY >=4000000 AND VSALARY <5000000) THEN SALGRADE := 'B';
    ELSE SALGRADE := 'A';
    END IF;
    */
    CASE FLOOR(VSALARY/1000000)
        WHEN 0 THEN SALGRADE := 'F';
        WHEN 1 THEN SALGRADE := 'E';
        WHEN 2 THEN SALGRADE := 'D';
        WHEN 3 THEN SALGRADE := 'C';
        WHEN 4 THEN SALGRADE := 'B';
        ELSE SALGRADE := 'A';
    END CASE;
    
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || VEMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || VEMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || VSALARY);
    DBMS_OUTPUT.PUT_LINE('급여등급 : ' || SALGRADE);
END;
/



--CASE 문
/*
    CASE 변수
        WHEN 값1 THEN 실행문;
        WHEN 값2 THEN 실행문;
        ELSE 실행문
    END CASE;

*/

-- 예시 ) 1~3까지의 수를 입력받고 1을 입력받으면 	'1을 입력하였습니다', 2를 입력 받으면 '2를 입력하였습니다',
-- 3을 입력받으면 '3을 입력하였습니다'를 출력하시오. 그외 숫자 입력시 잘못 입력하였습니다를 출력
DECLARE
    INPUTVALUE NUMBER;
BEGIN
    INPUTVALUE :='&INPUT';
    CASE INPUTVALUE
        WHEN 1 THEN DBMS_OUTPUT.PUT_LINE(INPUTVALUE || '을(를) 입력하였습니다.');
        WHEN 2 THEN DBMS_OUTPUT.PUT_LINE(INPUTVALUE || '을(를) 입력하였습니다.');
        WHEN 3 THEN DBMS_OUTPUT.PUT_LINE(INPUTVALUE || '을(를) 입력하였습니다.');
        ELSE DBMS_OUTPUT.PUT_LINE('잘못입력하셨습니다.');
    END CASE;
END;
/

--# PL/SQL 반복문
--BASIC LOOP : 조건없이 무한 반복
--LOOP
--END LOOP;

DECLARE 
    N NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        N := N+1;
        IF N > 5 THEN EXIT;
        END IF;
    END LOOP;
END;
/

--# FOR LOOP
-->카운트용 변수가 자동으로 선언됨, 따로 변수를 선언할 필요가 없음
--카운트 값은 자동으로 1씩 증가함. REVERSE를 사용하면 1씩 감소함

BEGIN
    FOR N IN  REVERSE 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/

--FOR LOOP문의 활용. 여러명의 데이터를 출력하기.
DECLARE
    VEMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    VSALARY EMPLOYEE.SALARY%TYPE;
BEGIN
    FOR N IN 0..4 LOOP
        SELECT EMP_NAME, SALARY
        INTO VEMP_NAME, VSALARY
        FROM EMPLOYEE
        WHERE EMP_ID = 200+N;
        
        DBMS_OUTPUT.PUT_LINE ( '이름 : ' || VEMP_NAME);
        DBMS_OUTPUT.PUT_LINE ( '급여 : ' || VSALARY);
          
    END LOOP;
END;
/


-- 예제) 1~10 까지 반복하여 TEST1 테이블에 데이터가 저장되게 하시오
-- TEST1(BUNHO, B_DATE)

CREATE TABLE TEST1(
    BUNHO NUMBER PRIMARY KEY,
    B_DATE DATE DEFAULT SYSDATE
);

DROP TABLE TEST1;


BEGIN
    FOR N IN 11..20 LOOP
    INSERT INTO TEST1 VALUES(N,SYSDATE);
    END LOOP;
END;
/
SELECT BUNHO, TO_CHAR(B_DATE,'YYYY"년" MM"월" DD"일" HH"시" MI"분"') FROM TEST1;
ROLLBACK;

--# WHILE LOOP
--제어 조건이 TRUE인 동안만 문장이 반복실행됨
--LOOP를 실행할 때 조건이 처음부터 FALSE이면 한번도 수행되지 않음
--EXIT절 없이도 조건절에 반복문 중지 조건을 기술할 수 있음
/*
    WHILE 반복시킬 조건문 LOOP
            (실행문)
    END LOOP;
*/

DECLARE
 N NUMBER := 1;
BEGIN
    WHILE N <= 5 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        N:=N+1;
    END LOOP;
END;
/

-- 실습문제
-- 사용자로부터 2~9사이의 수를 입력받아 구구단 출력하시오
DECLARE
    N NUMBER := 1;
    INPUT NUMBER := '&INPUT';
BEGIN
    IF INPUT BETWEEN 2 AND 9 THEN
        WHILE N <10 LOOP
            DBMS_OUTPUT.PUT_LINE(N * INPUT);
            N := N+1;
        END LOOP;
    ELSE DBMS_OUTPUT.PUT_LINE('2~9사이를 입력하세요.');
        INPUT := '&INPUT';
    END IF;
END;
/


-- 홀수단만 출력하기..

DECLARE
    N NUMBER := 1;
    INPUT NUMBER := '&INPUT';
BEGIN
     WHILE N <= INPUT LOOP
        IF(MOD(N,2) = 0) 
        THEN DBMS_OUTPUT.PUT_LINE(N);
        END IF;
        N := N+1;
     END LOOP;
END;
/


-- TOP N 분석을 위한 PL/SQL을 만들어라
-- '급여' / '보너스' / '입사일' 키워드입력.
-- 무조건 1위~5위 까지를 출력하는 PL/SQL을 만들어라.
--TOP N 분석을 위한 함수를 배우진 않았으나 찾아보면서 만들어보기.

DECLARE 
   -- VEMP_NAME EMPLOYEE.EMP_NAME%TYPE;
   -- VSALARY EMPLOYEE.SALARY%TYPE;
   -- VBONUS EMPLOYEE.BONUS%TYPE;
   -- VHIRE_DATE EMPLOYEE.HIRE_DATE%TYPE;
    KEYWORD NUMBER(1);
BEGIN
    KEYWORD := &키워드;
    CASE 
        WHEN 1 THEN DBMS_OUTPUT.PUT_LINE('급여랭킹');
                SELECT EMP_NAME, SALARY 
                INTO VEMP_NAME, VSALARY
                FROM (SELECT EMP_NAME, SALARY FROM EMPLOYEE 
                        ORDER BY 2 DESC)
                WHERE NUMS <=5;
              
            
        WHEN 2 THEN DBMS_OUTPUT.PUT_LINE('보너스랭킹');
        WHEN 3 THEN DBMS_OUTPUT.PUT_LINE('입사일랭킹');
        ELSE DBMS_OUTPUT.PUT_LINE('올바른 키워드를 입력하세요');
    END CASE;
END;
/

--# 예외처리
/*DECLARE
BEGIN
EXCEPTION
END;
*/
--#Exception의 종류
/*
    1.ACCESS_INTO_NULL
    2.CASE_NOT_FOUND
    3.COLLECTION_IS_NULL
    4.CURSOR.ALREADY_OPEN
    ...
    5.LOGIN_DENIED
    6.NO_DATA_FOUND
    등등...
*/
/*
    EXCEPTION
        WHEN 예외이름1 THEN 처리문장1
        WHEN 예외이름2 THEN 처리문장2
    END;
    /

*/
--NO_DATA_FOUND
--사원번호를 입력받아서 사원이름, 급여 이메일 출력
DECLARE
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    ESAL EMPLOYEE.SALARY%TYPE;
    EMAIL EMPLOYEE.EMAIL%TYPE;
BEGIN
    SELECT EMP_NAME, SALARY, EMAIL
    INTO ENAME, ESAL, EMAIL
    FROM  EMPLOYEE
    WHERE EMP_ID = &사원번호;
    DBMS_OUTPUT.PUT_LINE ( '이름:' || ENAME);
    DBMS_OUTPUT.PUT_LINE ( '급여:' || ESAL);
    DBMS_OUTPUT.PUT_LINE ( '이메일:' || EMAIL);
EXCEPTION
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('존재하지 않는 사원입니다.');
END;
/

--2. 사번이 200인 사원의 사번을 200번으로 바꾸려고 할 때
-- DUB_VAL_ON_INDEX
BEGIN
 --   INSERT INTO EMPLOYEE 
   -- VALUES(200,'일용자','888888-1111111','khuser01@iei.or.kr',
   --     '01000000000','D5','J3','S4',3000000,0.3,203,SYSDATE,DEFAULT,DEFAULT);
        
    UPDATE EMPLOYEE SET EMP_ID := &사원번호 WHERE EMP_ID = '200';
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('이미 존재하는 사번입니다.');
END;
/
--오라클 함수
SELECT SYSDATE FROM DUAL;
SELECT LENGTH ('HELLO') FROM DUAL;
SELECT LENGTH(EMAIL) FROM EMPLOYEE;

--문자열의 길이, 문자열의 바이트 길이
--LENGTH, LENGTHB

SELECT EMP_NAME, LENGTH(EMP_NAME),LENGTHB(EMP_NAME),
EMAIL,LENGTH(EMAIL),LENGTHB(EMAIL)
FROM EMPLOYEE;

--문자열의 위치
--INSTR, INSTRB
--INSTR(데이터,STR(찾으려는문자열),1(앞에서부터찾을지 뒤에서부터찾을지),1(N번째 찾은 값의 위치))
SELECT INSTR('Hello World Hi High','H',1,1)
,INSTR('Hello World Hi High','H',-1,1)
,INSTR('Hello World Hi High','H',-1,2)
FROM DUAL;

-- EMPLOYEE테이블에서 EMAIL 컬럼의 문자열 중 '@'의 위치를 구하시오
SELECT INSTR(EMAIL,'@',1,1)
FROM EMPLOYEE;

SELECT INSTR(EMAIL,'@')  -- 기본값은 생략가능
FROM EMPLOYEE;

--LPAD/RPAD
--LTRIM/RTRIM
--TRIM
SELECT EMAIL,RPAD(EMAIL, 20, '#'), LPAD(EMAIL,20,'#'),LPAD(EMAIL,10) FROM EMPLOYEE;

SELECT '             KH' FROM DUAL;
SELECT LTRIM('             KH',' ') FROM DUAL;
SELECT LTRIM('00001234', '1') FROM DUAL;
SELECT RTRIM('12340000', '0'),LTRIM('123KH123','123') FROM DUAL;

SELECT 'ACABACCKH', LTRIM('ACABACCKH','ACABACC')  --두번째 파라미터는 집합.'ABC'만 써도 결과는 같음
FROM DUAL;

SELECT TRIM(' KH   ') FROM DUAL;

SELECT LTRIM('45313456789','1345') FROM DUAL; --집합에 없는 값을 만나면 스탑
SELECT TRIM('    KH    '), TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL;
SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ'), TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ')
FROM DUAL;


-- 실습 문제 1
-- Hello KH Java 문자열을 Hello KH 가 출력되게 하여라.
SELECT RTRIM('Hello KH Java','Java ') FROM DUAL;



-- 실습 문제 2
-- Hello KH Java 문자열을 KH Java 가 출력되게 하여라.
SELECT LTRIM('Hello KH Java','Hello')
FROM DUAL;


-- 실습 문제 3 (TRIM으로 해보세요)
-- DEPARTMENT 테이블에서 DEPT_TITLE을 출력하여라
-- 이때, 마지막 부 글자를 빼고 출력되도록 하여라 / ex)회계관리부 -> 회계관리
SELECT DEPT_TITLE, RTRIM(DEPT_TITLE,'부')
FROM DEPARTMENT;


-- 실습 문제 4
-- 다음문자열에서 앞뒤 모든 숫자를 제거하세요.
-- '982341678934509hello89798739273402'
SELECT RTRIM(LTRIM('982341678934509hello89798739273402','0123456789'),'0123456789')
FROM DUAL;

--SUBSTR
--문자열 자르기

SELECT 'SHOW ME THE MONEY' FROM DUAL;
SELECT SUBSTR('SHOW ME THE MONEY',6) FROM DUAL;
SELECT SUBSTR('SHOW ME THE MONEY',6,2) FROM DUAL;
SELECT SUBSTR('SHOW ME THE MONEY',-2,1) FROM DUAL; --마이너스인덱스부터 갯수

-- 실습문제1
-- 사원명에서 성만 사전순으로 출력하세요
-- (성만 출력했으면 중복없이도 출력해보세요)

SELECT DISTINCT SUBSTR(EMP_NAME,1,1)  , PHONE
FROM EMPLOYEE
--ORDER BY SUBSTR(EMP_NAME,1,1) ASC;
ORDER BY 1 ASC;

-- 실습문제2
-- EMPLOYEE 테이블에서 남자만 사원번호,사원명, 주민번호, 연봉을 출력하세요
-- 단, 주민번호 뒤 6자리는 * 처리하세요.

SELECT EMP_ID"사원번호",
       EMP_NAME"사원명", 
       RPAD(SUBSTR(EMP_NO,1,8),14,'*')"주민번호", -- ||******* 연결연산자로해도된다.
       SALARY*12"연봉(원)"
FROM EMPLOYEE
--WHERE SUBSTR(EMP_NO,8,1) = '1';
--WHERE EMP_NO LIKE '______-1%';
WHERE EMP_NO LIKE '%-1%';

--REPLACE
SELECT REPLACE('KH HATE', 'HATE', 'LOVE') FROM DUAL;
SELECT REPLACE('KH@NAVER.COM','NAVER.COM','IEI.OR.KR') FROM DUAL;


-- 실습문제
-- EMPLOYEE 테이블의 모든 직원의 이름, 주민번호, EMAIL을 출력하시오
-- 단, 출력시 EMAIL의 주소를 kh.or.kr에서 iei.or.kr로 변경하여 출력하시오.
-- 단, id에 kh가 있으면 변경되지 않도록 하시오
SELECT  EMP_NAME"이름",
        EMP_NO"주민번호",
        EMAIL
FROM EMPLOYEE;

SELECT REPLACE( SUBSTR (EMAIL,INSTR(EMAIL,'@',1,1)) , 'kh', 'iei')
FROM EMPLOYEE;

SELECT SUBSTR(EMAIL, INSTR(EMAIL, '@',1,1)) FROM EMPLOYEE;
SELECT SUBSTR(EMAIL, 1, INSTR(EMAIL, '@',1,1)-1) FROM EMPLOYEE;
--합침
SELECT SUBSTR(EMAIL, 1, INSTR(EMAIL, '@',1,1)-1) ||
      REPLACE(SUBSTR(EMAIL, INSTR(EMAIL, '@',1,1)),'kh','iei')"Email"
FROM EMPLOYEE;
      
      
--숫자함수
--ABS, MOD, ROUND반올림, FLOOR버림, TRUNC소수자릿수버림, CEIL올림
SELECT ROUND(123.456, 2) , ROUND(123.456,1), ROUND(123.456,-1) FROM DUAL;
SELECT ROUND(123.456, 1) FROM DUAL;
SELECT TRUNC(123.456), TRUNC(123.456,2),  TRUNC(123.456,3) FROM DUAL;
SELECT CEIL(123.456) FROM DUAL;
SELECT FLOOR(123.456) FROM DUAL;

SELECT EMP_NAME, ROUND(SYSDATE - HIRE_DATE)
FROM EMPLOYEE;

SELECT EMP_NAME,
        ROUND(SYSDATE - HIRE_DATE),
        FLOOR(SYSDATE - HIRE_DATE),
        CEIL(SYSDATE - HIRE_DATE)
FROM EMPLOYEE;

--날짜 처리 함수
--SYSDATE, MONTHS_BETWEEN, ADD_MONTHS, NEXT_DAY, LAST_DAY, EXTRACT
SELECT SYSDATE FROM DUAL;
SELECT ROUND(MONTHS_BETWEEN('13/09/25','11/12/26')) FROM DUAL;

SELECT CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) "근무개월수"
FROM EMPLOYEE;

SELECT ADD_MONTHS(SYSDATE,3) FROM DUAL;

--NEXT_DAY
--지정 날짜를 기준으로 처음 맞이하는 요일의 날짜를 리턴
SELECT NEXT_DAY(SYSDATE,'월요일'), NEXT_DAY(SYSDATE,'월'),
       NEXT_DAY(SYSDATE,2)
FROM DUAL;

--LAST DAY  조회한 날짜의 마지막 날
SELECT LAST_DAY(SYSDATE) FROM DUAL;
SELECT LAST_DAY(HIRE_DATE) FROM EMPLOYEE;

/*
    만약에 자신이 오늘 군대에 간다고 합시다.
    군복무 기간은 1년 6개월이라고 가정하면
    1. 제대일자가 언제인지 구하고
    2. 제대일자까지 먹어야하는 짬밥의 그릇수를 구해보세요
    (단, 1일 3끼 무조건 먹는다고 가정합니다)
    테이블은 DUAL로 하세요.
*/

SELECT SYSDATE"입대일",
       ADD_MONTHS(SYSDATE,18) "제대일자",
      (ADD_MONTHS(SYSDATE,18)-SYSDATE) * 3 "짬밥수",
       MONTHS_BETWEEN(ADD_MONTHS(SYSDATE,18),SYSDATE)"군복무개월"
FROM DUAL;

SELECT SYSDATE - HIRE_DATE
FROM EMPLOYEE;

--EXTRACT
--날짜를 잘라서 추출해서 사용하고 싶을 때 사용
SELECT HIRE_DATE
FROM EMPLOYEE;

SELECT HIRE_DATE, 
    EXTRACT(YEAR FROM HIRE_DATE) "년도",
    EXTRACT(MONTH FROM HIRE_DATE)"월",
    EXTRACT(DAY FROM HIRE_DATE)"일"
FROM EMPLOYEE;


-- @ 실습문제 1
-- EMPLOYEE 테이블에서 사원의 이름,입사일,년차를 출력하여라. 
-- 단, 입사일은 YYYY년M월D일로 출력하도록 하여라.
-- 년차 출력은 소수점 일경우 올림으로 하여 출력하여라. (28.144 -> 29년차)
-- (출력시 정렬은 입사일 기준으로 오름차순)

SELECT EMP_NAME"이름",
       EXTRACT(YEAR FROM HIRE_DATE)||'년'||
       EXTRACT(MONTH FROM HIRE_DATE)||'월'||
       EXTRACT(DAY FROM HIRE_DATE)||'일'"입사일",
       ROUND(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12)"년차"
FROM EMPLOYEE;



-- @ 실습문제 2
-- 특별 보너스를 지급하기 위하여 자료가 필요하다
-- 입사일을 기점으로 다음달 1일 부터 6개월을 계산하여 
-- 출력하시오 (이름,입사일,기준일,기준일+6,기준달(월))
-- ex) 90년2월6일 입사 -> 90년3월1일 부터 계산
-- ex) 90년2월26일 입사 -> 90년3월1일 부터 계산
-- ex) 97년12월1일 입사 -> 98년1월1일 부터 계산
-- 출력시 입사일 기준으로 정렬하시오

SELECT EMP_NAME"이름",
       EMP_HIRE"입사일",
       "기준일",
       "기준일+6",
       "기준달(월)"
FROM EMPLOYEE;

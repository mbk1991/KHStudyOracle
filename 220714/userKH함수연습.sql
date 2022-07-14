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
       HIRE_DATE"입사일",
       LAST_DAY(HIRE_DATE)+1"기준일",
       ADD_MONTHS((LAST_DAY(HIRE_DATE)+1),6)"기준일+6",
       EXTRACT(MONTH FROM ADD_MONTHS((LAST_DAY(HIRE_DATE)+1),6))"기준월"
FROM EMPLOYEE
ORDER BY 2 ASC;


SELECT LAST_DAY(HIRE_DATE)+1
FROM EMPLOYEE;



-- 형변환 함수
-- 형식
-- YYYY:년도표현(4자리), YY:년도표현(2자리)
-- MONTH:월표시, MM:월을 숫자로 표시, MON:월을 한글로 표시
-- DD:일표현
-- D:요일표현(숫자로 1:일요일,...), DAY:요일표현, DY:요일 약어로 표현
-- HH,HH12:시간표현(12시간으로 표현), HH24(24시간으로 표현)
-- MI:분, SS:초
-- AM,PM:오전,오후표기
-- FM:월,일,시,분,초 앞의 0을 제거
SELECT
     TO_CHAR(SYSDATE, 'YYYY-MM-DD')"1",
     TO_CHAR(SYSDATE, 'YYYY.MM.DD')"2",
     TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')"3",
     TO_CHAR(SYSDATE, 'YYYY/MM/DD PM HH12"시"MI"분"SS"초"')"4",
     TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24"시"MI"분"SS"초"')"5"
FROM DUAL;

-- EMPLOYEE 테이블에서 사원명, 고용일(ex. 1990/02/06(화))로 출력하세요

SELECT EMP_NAME"사원명",
              TO_CHAR(HIRE_DATE,'YYYY/MM/DD"("DY")"')"고용일"
FROM EMPLOYEE;

--TO_DATE
--DATE 연산을 위한 형변환

SELECT  TO_DATE('20220714', 'YYYYMMDD') FROM DUAL;
SELECT TO_DATE('20220714150711','YYYYMMDDHH24MISS') FROM DUAL;

--TO_NUMBER
-- NUMBER 연산을 위한 형변환!
-- 숫자 형식
-- , (9,999) : 콤마형식으로 변환
-- . (99.99) : 소수점 형식으로 변환
-- 0:맨왼쪽에 0을 삽입, $:$통화로 표시, L:로컬통화로 표시(한국은 \)
-- 숫자 표시 단위를 쓸 때에는 충분히 크게 크기를 잡아야 함.

SELECT
        TO_NUMBER('90,000', '999,999,999'),
        TO_CHAR(90000, '000,000,000'),
        TO_CHAR(90000,'999,999,999')
FROM DUAL;

SELECT 
TO_NUMBER('1,000,000', '9,999,999') - TO_NUMBER('550,000', '9,999,999')
FROM DUAL;

--null일 때 0으로 바꾸기
--NVL, DECODE, CASE
SELECT BONUS*100 FROM EMPLOYEE;
SELECT NVL(BONUS, 0) *100 FROM EMPLOYEE;

--총수령액 연봉 + 보너스

SELECT SALARY * 12 +  SALARY* NVL(BONUS , 0) FROM EMPLOYEE;

--DECODE
--case를 한 줄로 쓸 수 있다!
--짝을 맞춰서 조건,대입값 ,조건,대입값,조건,대입값,ELSE값
SELECT EMP_NAME,
            DECODE(SUBSTR(EMP_NO,8,1), '1','남','2','여','없음') "성별"
FROM EMPLOYEE;
-- DECODE 는 비교문은 못 넣나?


--CASE

SELECT EMP_ID,  EMP_NAME,
CASE WHEN  SUBSTR(EMP_NO,8,1) = 1 THEN '남'
END
FROM EMPLOYEE;
--EMPLOYEE 테이블에서 남자는 남, 여자는 여라고 출력하시오.
SELECT EMP_ID, EMP_NAME,
            CASE  WHEN SUBSTR(EMP_NO,8,1) = 1 THEN '남'
                      WHEN SUBSTR(EMP_NO,8,1) = 2 THEN '여'
                      ELSE ' 없음'
                      END"성별"
FROM EMPLOYEE;


-- EMPLOYEE 테이블에서 남자는 남, 여자는 여라고 출력하시오

-- EMPLOYEE 테이블에서 출생년도 기준 60년대 생 직원에 대하여 
-- 65년이전 출생자는 60년생 초반, 65년 이후 출생자는 60년생 후반이라고 출력하시오

SELECT EMP_ID, EMP_NAME, EMP_NO,
            CASE WHEN SUBSTR(EMP_NO,2,1) < 5 THEN '60년대 초반'
                    ELSE '60년대 후반'
                    END "구분"
FROM EMPLOYEE
WHERE EMP_NO LIKE '6%';

-- 사원명과 직급코드에 따른 해당직급명을 출력하세요. (job테이블참조)
SELECT
            EMP_NAME"사원명",
            JOB_CODE"직급코드",
            DECODE(JOB_CODE,
                    'J1','대표',
                    'J2','부사장',
                    'J3','부장',
                    'J4','차장',
                    'J5','과장',
                    'J6','대리',
                    'J7','사원',
                    '인턴') "직급명"
FROM EMPLOYEE;

DESC EMPLOYEE;



-- 최종 실습 문제
-- 문제1. 
-- 입사일이 5년 이상, 10년 이하인 직원의 이름,주민번호,급여,입사일을 검색하여라

SELECT EMP_NAME"이름",
            EMP_NO"주민번호",
            SALARY"급여",
            HIRE_DATE"입사일"
FROM EMPLOYEE
WHERE ( SYSDATE-HIRE_DATE)/365 >= 5 AND ( SYSDATE-HIRE_DATE)/365 <= 10;

-- 문제2.
-- 재직중이 아닌 직원의 이름,부서코드, 고용일, 근무기간, 퇴직일을 검색하여라 
--(퇴사 여부 : ENT_YN)

SELECT EMP_NAME"이름",
            DEPT_CODE"부서코드",
            HIRE_DATE"고용일",
            ENT_DATE-HIRE_DATE"근무기간",
            ENT_DATE"퇴직일"
FROM EMPLOYEE
WHERE ENT_DATE IS NOT NULL;
            


-- 문제3.
-- 근속년수가 10년 이상인 직원들을 검색하여
-- 출력 결과는 이름,급여,근속년수(소수점X)를 근속년수가 오름차순으로 정렬하여 출력하여라
-- 단, 급여는 50% 인상된 급여로 출력되도록 하여라.

SELECT EMP_NAME"이름",
            SALARY * 1.5"급여",
            ROUND((SYSDATE-HIRE_DATE)/365) "근속년수"
FROM EMPLOYEE
WHERE ENT_DATE IS NULL AND (SYSDATE-HIRE_DATE) /365 >= 10
ORDER BY 3 ASC;


-- 문제4.
-- 입사일이 99/01/01 ~ 10/01/01 인 사람 중에서 급여가 2000000 원 이하인 사람의
-- 이름,주민번호,이메일,폰번호,급여를 검색 하시오

SELECT EMP_NAME"이름",EMP_NO"주민번호",EMAIL"이메일",PHONE"폰번호",SALARY"급여",HIRE_DATE"입사일"
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '990101' AND '100101' AND SALARY <= 2000000;

-- 문제5.
-- 급여가 2000000원 ~ 3000000원 인 여직원 중에서 4월 생일자를 검색하여 
-- 이름,주민번호,급여,부서코드를 주민번호 순으로(내림차순) 출력하여라
-- 단, 부서코드가 null인 사람은 부서코드가 '없음' 으로 출력 하여라.

SELECT EMP_NAME"이름",
            EMP_NO"주민번호",
            SALARY"급여",
            NVL(DEPT_CODE,'없음')"부서코드"
FROM  EMPLOYEE
WHERE SALARY BETWEEN 2000000 AND 3000000 AND 
            SUBSTR(EMP_NO,8,1) = 2 AND SUBSTR(EMP_NO,3,2) = '04'
ORDER BY 2 DESC;

-- 문제6.
-- 남자 사원 중 보너스가 없는 사원의 오늘까지 근무일을 측정하여 
-- 1000일 마다(소수점 제외) 
-- 급여의 10% 보너스를 계산하여 이름,특별 보너스 (계산 금액) 결과를 출력하여라.
-- 단, 이름 순으로 오름 차순 정렬하여 출력하여라.

SELECT EMP_NAME"이름",
             FLOOR((SYSDATE - HIRE_DATE) / 1000) /100 * SALARY "특별 보너스"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = 1 AND BONUS IS NULL;



-- @함수 최종실습문제
--1. 직원명과 이메일 , 이메일 길이를 출력하시오
--		  이름	    이메일		이메일길이
--	ex) 	홍길동 , hong@kh.or.kr   	  13

SELECT EMP_NAME"직원명",
            EMAIL"이메일",
            LENGTH(EMAIL)"이메일길이"
FROM EMPLOYEE;

--2. 직원의 이름과 이메일 주소중 아이디 부분만 출력하시오
--	ex) 노옹철	no_hc
--	ex) 정중하	jung_jh

SELECT EMP_NAME"이름",
            SUBSTR(EMAIL,1,INSTR(EMAIL,'@')-1)"아이디"
FROM EMPLOYEE;



--3. 60년대에 태어난 직원명과 년생, 보너스 값을 출력하시오. 그때 보너스 값이 null인 경우에는 0 이라고 출력 되게 만드시오
--	    직원명    년생      보너스
--	ex) 선동일	    1962	    0.3
--	ex) 송은희	    1963  	    0

SELECT EMP_NAME"이름",
         '19'||SUBSTR(EMP_NO,1,2)"년생",
         NVL(BONUS,0)"보너스"
FROM EMPLOYEE
WHERE EMP_NO LIKE '6%';


--4. '010' 핸드폰 번호를 쓰지 않는 사람의 수를 출력하시오 (뒤에 단위는 명을 붙이시오)
--	   인원
--	ex) 3명

--이건 못 하는 듯


--5. 직원명과 입사년월을 출력하시오 
--	단, 아래와 같이 출력되도록 만들어 보시오
--	    직원명		입사년월
--	ex) 전형돈		2012년 12월
--	ex) 전지연		1997년 3월

SELECT EMP_NAME "직원명",
            EXTRACT(YEAR FROM HIRE_DATE)||'년' ||
            EXTRACT(MONTH FROM HIRE_DATE)||'월' "입사년월"
FROM EMPLOYEE;


--6. 직원명과 주민번호를 조회하시오
--	단, 주민번호 9번째 자리부터 끝까지는 '*' 문자로 채워서출력 하시오
--	ex) 홍길동 771120-1******

SELECT EMP_NAME"직원명",
            RPAD(SUBSTR(EMP_NO,1,8),14,'*')
FROM EMPLOYEE;


--7. 직원명, 직급코드, 연봉(원) 조회
--  단, 연봉은 ￦57,000,000 으로 표시되게 함
--     연봉은 보너스포인트가 적용된 1년치 급여임

SELECT EMP_NAME"직원명",
            JOB_CODE"직급코드",
          TO_CHAR(SALARY*12 * (1+NVL(BONUS,0)),'L999,999,999')  "연봉"
FROM EMPLOYEE;


--8. 부서코드가 D5, D9인 직원들 중에서 2004년도에 입사한 직원중에 조회함.
--   사번 사원명 부서코드 입사일
SELECT EMP_ID"사번",
            EMP_NAME"사원명",
            DEPT_CODE"부서코드",
            HIRE_DATE"입사일"
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5','D9') AND EXTRACT(YEAR FROM  HIRE_DATE) = 2004;


--9. 직원명, 입사일, 오늘까지의 근무일수 조회 
--	* 주말도 포함 , 소수점 아래는 버림
SELECT EMP_NAME"직원명",
            HIRE_DATE"입사일",
            FLOOR(SYSDATE - HIRE_DATE) "오늘까지의 근무일수"
FROM EMPLOYEE;


--10. 직원명, 부서코드, 생년월일, 나이(만) 조회
--   단, 생년월일은 주민번호에서 추출해서, 
--   ㅇㅇㅇㅇ년 ㅇㅇ월 ㅇㅇ일로 출력되게 함.
--   나이는 주민번호에서 추출해서 날짜데이터로 변환한 다음, 계산함
--	* 주민번호가 이상한 사람들은 제외시키고 진행 하도록(200,201,214 번 제외)
--	* HINT : NOT IN 사용

SELECT EMP_NAME "직원명",
            DEPT_CODE "부서코드",
           TO_CHAR(TO_DATE(SUBSTR(EMP_NO,1,6)),'YYYY"년" MM"일" DD"일"')  "생년월일",
           ROUND((SYSDATE - TO_DATE(SUBSTR(EMP_NO,1,6))) / 365 ) "나이(만)"
FROM EMPLOYEE
WHERE EMP_ID NOT IN (200,201,214);


SELECT TO_CHAR(SYSDATE,'YYYY"년"MM"월"DD"일"') FROM DUAL;

--11. 사원명과, 부서명을 출력하세요.
--   부서코드가 D5이면 총무부, D6이면 기획부, D9이면 영업부로 처리하시오.(case 사용)
--   단, 부서코드가 D5, D6, D9 인 직원의 정보만 조회하고, 부서코드 기준으로 오름차순 정렬함.

SELECT EMP_NAME"사원명" ,
            DECODE(DEPT_CODE,'D5','총무부','D6','기획부','D9','영업부')  "부서명"
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5','D6','D9')
ORDER BY DEPT_CODE ASC;


SHOW USER;
--INSERT
INSERT INTO EMPLOYEE
VALUES('900',
    '장채현',
    '901123-2080503',
    'jang_ch@kh.or.kr',
    '01000000000',
    'D1',
    'J8',
    'S3',
    430000,
    0.2,
    '200',
    SYSDATE,
    NULL,
    'N');
    
    DESC DEPARTMENT;
    SELECT DEPT_ID, DEPT_TITLE FROM DEPARTMENT;
    UPDATE DEPARTMENT
    SET DEPT_TITLE = '전략기획팀'
    WHERE DEPT_ID = 'D9';
    
    DELETE
    FROM EMPLOYEE
    WHERE EMP_NAME = '장채현';
    
    --DQL SELECT 예제
    
    SELECT EMP_ID, EMP_NAME, SALARY
    FROM EMPLOYEE;
    
    --AS는 쌍따옴표를 사용하면 생략이 가능하다. 출력하는 칼럼의 이름을 설정함
    SELECT EMP_NAME, SALARY, SALARY * 12 AS "연봉", '원' "단위"
    FROM EMPLOYEE;

-- 1. JOB테이블에서 JOB_NAME의 정보만 출력되도록 하시오
SELECT JOB_NAME
FROM JOB;

-- 2. DEPARTMENT테이블의 내용 전체를 출력하는 SELECT문을 작성하시오

SELECT * FROM DEPARTMENT;


-- 3. EMPLOYEE 테이블에서 이름(EMP_NAME),이메일(EMAIL),
-- 전화번호(PHONE),고용일(HIRE_DATE)만 출력하시오

SELECT EMP_NAME,EMAIL,PHONE,HIRE_DATE FROM EMPLOYEE;

-- 4. EMPLOYEE 테이블에서 고용일(HIRE_DATE) 이름(EMP_NAME),월급(SALARY)를 출력하시오

SELECT HIRE_DATE, EMP_NAME, SALARY
FROM EMPLOYEE;

-- 5. EMPLOYEE 테이블에서 월급(SALARY)이 2,500,000원이상인 사람의 
-- EMP_NAME 과 SAL_LEVEL을 출력하시오 
-- (힌트 : >(크다) , <(작다) 를 이용)

SELECT EMP_NAME, SAL_LEVEL, SALARY
FROM EMPLOYEE
WHERE SALARY > 2500000;

-- 6. EMPLOYEE 테이블에서 월급(SALARY)이 350만원 이상이면서 
-- JOB_CODE가 'J3' 인 사람의 
-- 이름(EMP_NAME)과 전화번호(PHONE)를 출력하시오
-- (힌트 : AND(그리고) , OR (또는))

SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND JOB_CODE = 'J3';


-- 간단 실습 문제
--1. EMPLOYEE 테이블에서 이름,연봉, 총수령액(보너스포함), 
-- 실수령액(총 수령액-(월급*세금 3%*12))
--가 출력되도록 하시오

SELECT 
    EMP_NAME "이름",
    SALARY*12 "연봉",
    SALARY*(1+BONUS)"총수령액(보너스포함)",
    SALARY*12 - (SALARY*12*0.03)"실수령액"
FROM EMPLOYEE;

--2. EMPLOYEE 테이블에서 이름, 근무 일수를 출력해보시오 
--(SYSDATE를 사용하면 현재 시간 출력)
SELECT 
    EMP_NAME"이름",
    SYSDATE - HIRE_DATE"근무 일수"
FROM EMPLOYEE;

--3. EMPLOYEE 테이블에서 20년 이상 근속자의 이름,월급,보너스율를 출력하시오.
SELECT 
    EMP_NAME"이름",
    SALARY"월급",
    BONUS"보너스율"
FROM EMPLOYEE
WHERE (SYSDATE-HIRE_DATE)/365 > 20;



-- DISTINCT 
-- 컬럼에 포함된 중복 값을 한번씩만 표시하고자 할 때 사용
SELECT DISTINCT JOB_CODE FROM EMPLOYEE;

-- 논리연산자(AND, OR)
-- 부서코드가 D6이고 급여를 2,000,000보다 많이 받는 
-- 사원의 이름, 부서코드, 급여를 조회하시오.

SELECT EMP_NAME"이름",DEPT_CODE"부서코드",SALARY"급여"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' AND SALARY> 2000000;


-- 부서코드가 D5 또는 급여를 3,000,000보다 많이 받는 
-- 사원의 이름, 부서코드, 급여를 조회하시오

SELECT EMP_NAME"이름", DEPT_CODE"부서코드", SALARY"급여"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY> 3000000;


-- 연결 연산자(||)
-- 여러 컬럼을 하나의 컬럼인 것 처럼 연결하거나 컬럼과 리터럴 연결
SELECT EMP_NAME||DEPT_CODE, SALARY|| '원' "급여"
FROM EMPLOYEE;


-- 비교연산자 ( >, >=, <, <=, .... )
-- BETWEEN A AND B
-- 급여를 3500000원 이상 받고 6000000원 이하로 받는 직원의 이름과 급여
-- 조회하시오

SELECT EMP_NAME"이름", SALARY"급여"
FROM EMPLOYEE
--WHERE SALARY>=3500000 AND SALARY<=6000000;
WHERE SALARY BETWEEN 3500000 AND 6000000;


-- BETWEEN AND
-- EMPLOYEE 테이블에서 고용일이 90/01/01 ~ 01/01/01인 사원의
-- 전체 내용을 출력하시오

SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';


--비교 연산자(LIKE)
--비교하려는 값이 지정한 특정패턴을 만족시키면 TRUE를 리턴하는 연산자
--'%' 와 '_'를 와일드카드로 사용할 수 있음
--*와일드 카드: 아무 문자나 대체헤서 사용할 수 있는 것

SELECT EMP_NAME, SALARY
FROM EMPLOYEE
--WHERE EMP_NAME = '이오리' OR EMP_NAME = '이태림';
WHERE EMP_NAME LIKE '이%';

SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%이%';  -- 전이 있는 모든 경우가 다 검색됨.
    
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전__';   -- 전 다음 한 자리의 문자

-- 실습문제
--1. EMPLOYEE 테이블에서 이름 끝이 연으로 끝나는 사원의 이름을 출력하시오
SELECT EMP_NAME"이름" FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';


--2. EMPLOYEE 테이블에서 전화번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호를
--출력하시오

SELECT EMP_NAME"이름",PHONE"전화번호"
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';


--3. EMPLOYEE 테이블에서 메일주소의 's'가 들어가면서, DEPT_CODE가 D9 또는 D6이고
--고용일이 90/01/01 ~ 01/12/01이면서, 월급이 270만원이상인 사원의 전체 정보를 출력하시오

SELECT *
FROM EMPLOYEE
WHERE 
EMAIL LIKE '%s%' 
AND(DEPT_CODE = 'D9' OR DEPT_CODE = 'D6') 
AND HIRE_DATE BETWEEN '90/01/01' AND '01/12/01' 
AND SALARY >= 2700000;


--4. EMPLOYEE 테이블에서 EMAIL ID 중 @ 앞자리가 5자리인 직원을 조회한다면?
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '_____@%';


--5. EMPLOYEE 테이블에서 EMAIL ID 중 '_' 앞자리가 3자리인 직원을 조회한다면?
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '___!_%' ESCAPE '!';

--비교연산자 (IN)
-- 비교하려는 값 목록에 일치하는 값이 있으면 TRUE 를 반환하는 연산자
-- EMPOYEE 테이블에서 DEPT_CODE가 D9 또는 D6인 직원의 이름, 급여를 출력하시오.
-- OR를 대체할 수 있다.

SELECT EMP_NAME, SALARY, DEPT_CODE FROM EMPLOYEE
WHERE DEPT_CODE IN('D9','D6','D5','D1');

--비교연산자 (IS NULL/ IS NOT NULL)
--NULL 여부를 비교하는 연산자

SELECT BONUS, MANAGER_ID
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;
    
    
-- 1. 관리자(MANAGER_ID)도 없고 부서 배치(DEPT_CODE)도 받지 않은 
-- 직원의 이름 조회

SELECT EMP_NAME"이름"
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

-- 2. 부서배치를 받지 않았지만 보너스를 지급하는 직원 전체 정보 조회

SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

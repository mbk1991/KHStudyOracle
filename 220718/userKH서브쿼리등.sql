--서브쿼리
--하나의 SQL문 안에 포함되어 있는 또 다른 SQL문 (SELECT)
--알려지지 않은 조건에 근거한 값들을 검색하는 SELECT문장을 작성하는데 유용함
--중요) 서브쿼리는 반드시 소괄호로 묶어야 함
--서브쿼리는 연산자의 오른쪽에 위치해야 함
--서브쿼리 내에 ORDER BY 문법은 지원안됨!


--1. 단일행 서브쿼리
--ex) 급여 평균값 이상의 급여를 받는 사원을 검색하시오
SELECT AVG(SALARY) FROM EMPLOYEE;
-- 평균값을 직접 확인하여
SELECT * FROM EMPLOYEE
WHERE SALARY >= 3047662.60869565217391304347826086956522;
--직접 값을 넣으면 동적인 변화에 대응할 수 없음.
--직접 값을 넣은 자리에 쿼리문을 넣어줌
SELECT * FROM EMPLOYEE
WHERE SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEE);


--전지연 직원의 관리자 이름을 출력하여라.
SELECT MANAGER_ID FROM EMPLOYEE
WHERE EMP_NAME = '전지연';

SELECT EMP_NAME FROM EMPLOYEE
WHERE EMP_ID = (SELECT MANAGER_ID FROM EMPLOYEE
WHERE EMP_NAME = '전지연');

--@실습문제 
--1. 윤은해와 급여가 같은 사원들을 검색해서, 사원번호,사원이름, 급여를 출력하라.

SELECT SALARY FROM EMPLOYEE
WHERE EMP_NAME = '윤은해';

SELECT EMP_ID,EMP_NAME,SALARY FROM EMPLOYEE
WHERE SALARY = (SELECT SALARY FROM EMPLOYEE
WHERE EMP_NAME = '윤은해');



--2. employee 테이블에서 기본급여가 제일 많은 사람과 제일 적은 사람의 정보를 
-- 사번, 사원명, 기본급여를 나타내세요.

SELECT MAX(SALARY) FROM EMPLOYEE;
SELECT MIN(SALARY) FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, SALARY FROM EMPLOYEE
WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE) OR
      SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);



--3. D1, D2부서에 근무하는 사원들 중에서
--기본급여가 D5 부서 직원들의 '평균월급' 보다 많은 사람들만 
--부서번호, 사원번호, 사원명, 월급을 나타내세요.

SELECT AVG(SALARY) FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

SELECT DEPT_CODE, EMP_ID, EMP_NAME, SALARY FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE
WHERE DEPT_CODE = 'D5');


--2.다중행 서브쿼리
--서브쿼리의 조회 결과 값이 여러 개 일 때
--다중행 서브쿼리 앞에는 일반 비교연산자 사용불가!
--사용가능 연산자: IN / NOT IN, ANY, ALL, EXIST

--ex)송종기나 박나라가 속한 부서에 속한 사원들의 정보를 출력하시오.
SELECT DEPT_CODE FROM EMPLOYEE
WHERE EMP_NAME IN ('송종기','박나라');

SELECT * FROM EMPLOYEE
WHERE DEPT_CODE IN(SELECT DEPT_CODE FROM EMPLOYEE
WHERE EMP_NAME IN ('송종기','박나라'));

-- 2. 다중행 서브쿼리
--@실습문제
-- 차태현, 전지연 사원의 급여등급(emplyee테이블의 sal_level컬럼)과 
--같은 사원의 직급명, 사원명을 출력.

SELECT SAL_LEVEL FROM EMPLOYEE
WHERE EMP_NAME IN ('차태연','전지연');

SELECT JOB_CODE, EMP_NAME FROM EMPLOYEE
WHERE SAL_LEVEL IN(SELECT SAL_LEVEL FROM EMPLOYEE
WHERE EMP_NAME IN ('차태연','전지연'));

--@실습문제
--1.직급이 대표, 부사장이 아닌 모든 사원을 부서별로 출력. 
SELECT JOB_CODE FROM JOB
WHERE JOB_NAME IN('대표','부사장');

SELECT DEPT_CODE,COUNT(*) FROM EMPLOYEE
WHERE JOB_CODE NOT IN(SELECT JOB_CODE FROM JOB
WHERE JOB_NAME IN('대표','부사장'))
GROUP BY DEPT_CODE;

SELECT DEPT_TITLE, EMP_NAME FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE JOB_CODE NOT IN(SELECT JOB_CODE FROM JOB
WHERE JOB_NAME IN('대표','부사장'));


--2.Asia1지역에 근무하는 사원 정보출력, 부서코드, 사원명.(메인쿼리 조인금지)

SELECT DEPT_ID FROM LOCATION
JOIN DEPARTMENT ON LOCATION_ID = LOCAL_CODE
WHERE LOCAL_NAME = 'ASIA1';

SELECT DEPT_CODE,EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE IN(SELECT DEPT_ID FROM LOCATION
JOIN DEPARTMENT ON LOCATION_ID = LOCAL_CODE
WHERE LOCAL_NAME = 'ASIA1');

--서브쿼리 위치가 WHERE 뿐만 아니라 FROM 뒤에, SELECT 뒤에 올 수 있음.
--상관쿼리는 SELECT 뒤에 오는 것! 상관쿼리의 결과값이 1개인 것을 스칼라 쿼리라고 한다.
--인라인 뷰는 FROM뒤에 오는 것!

--3. 상관 서브쿼리(상호연관)
-->메인 쿼리의 값을 서브쿼리에 주고 서브쿼리를 수행한 다음 그결과를
--다시 메인쿼리로 반환해서 수행하는 쿼리 (일종의 루프문)
-->서브쿼리의 WHERE 수행을 위해서 메인쿼리가 먼저 수행되는 구조
-->메인쿼리 테이블의 레코드(행)에 따라 서브쿼리의 결과값도 바뀜
--메인쿼리에서 처리되는 각 행의 컬럼값에 따라 응답이 달라져야하는 경우에 유용

--3.1 EXISTS
--서브쿼리의 결과 중에서 만족하는 행이 하나라도 존재하면 참

SELECT * FROM EMPLOYEE WHERE DEPT_CODE = (SELECT DEPT_ID FROM DEPARTMENT);

SELECT * FROM EMPLOYEE
WHERE 1 = 2;  -- 아무것도 조회가 되지 않음. WHERE절이 참이면 SELECT가되고 거짓이면 SELECT가되지않음.

SELECT * FROM EMPLOYEE
WHERE EXISTS ( SELECT 1 FROM EMPLOYEE WHERE DEPT_CODE = 'D1');

--메인 쿼리에 서브쿼리가 영향을 주는 것. 서브쿼리의 값이 존재하면 메인쿼리의 값이 나오고
--서브쿼리의 값이 존재하지 않으면 메인쿼리의 값이 나오지 않음
--매 행마다 조건을체크, 행이 존재하면 참, 아니면 거짓

--ex) 부하직원이 한명이라도 있는 직원 출력
SELECT DISTINCT MANAGER_ID FROM EMPLOYEE;

SELECT EMP_NAME
FROM EMPLOYEE E
WHERE EXISTS (SELECT EMP_NAME FROM EMPLOYEE WHERE MANAGER_ID = E.EMP_ID);

--EX) DEPT_CODE 가 없는 사람 거르기
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE E
WHERE EXISTS(SELECT 1 FROM DEPARTMENT WHERE DEPT_ID = E.DEPT_CODE);


--@실습문제
--1. 심봉선 사원과 같은 부서의 사원의 부서코드, 사원명, 월평균급여를 조회.

SELECT DEPT_CODE, EMP_NAME, SALARY
FROM EMPLOYEE E
WHERE EXISTS(SELECT 1 FROM EMPLOYEE WHERE E.EMP_NAME = '심봉선');

SELECT DEPT_CODE, EMP_NAME
FROM EMPLOYEE E
--WHERE DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '심봉선');
WHERE EXISTS (SELECT 1 FROM EMPLOYEE M WHERE M.DEPT_CODE = E.DEPT_CODE AND M.EMP_NAME='대북혼');

SELECT DEPT_CODE, EMP_NAME
FROM EMPLOYEE E
--WHERE DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '심봉선');
WHERE EXISTS (SELECT 1 FROM EMPLOYEE M WHERE M.EMP_NAME='대북혼' AND M.DEPT_CODE = E.DEPT_CODE);

SELECT DEPT_CODE, EMP_NAME
FROM EMPLOYEE E
WHERE 1=1;


SELECT 1 FROM EMPLOYEE WHERE DEPT_CODE = 'D5' AND EMP_NAME ='대북혼';

SELECT 1 FROM EMPLOYEE WHERE EMP_NAME='심봉선';


--2. 가장많은 급여를 받는 사원을 exists 상관 서브쿼리를 이용해서 구하라.
--not exists (메인쿼리 행의 월급보다 많은 급여를 받는 사람이 존재하지 않으면 참)

SELECT * FROM EMPLOYEE
WHERE SALARY >= (SELECT MAX(SALARY) FROM EMPLOYEE);

SELECT * FROM EMPLOYEE E
WHERE NOT EXISTS (SELECT 1 FROM EMPLOYEE WHERE SALARY < E.SALARY);

--3. 직급이 J1, J2, J3이 아닌 사원중에서 자신의 부서별 평균급여보다 많은 급여를 받는 사원출력.
-- 부서코드, 사원명, 급여, 부서별 급여평균

SELECT E.DEPT_CODE , EMP_NAME, SALARY,AVG_SAL
FROM EMPLOYEE E JOIN (SELECT DEPT_CODE,ROUND(AVG(SALARY)) AVG_SAL  -- 하나의 테이블로 보고 조인을함.
                        FROM EMPLOYEE 
                        GROUP BY DEPT_CODE) A
ON E.DEPT_CODE = A.DEPT_CODE
WHERE JOB_CODE NOT IN ('J1','J2','J3') AND SALARY < AVG_SAL;

SELECT DEPT_CODE,ROUND(AVG(SALARY)) AVG_SAL  -- 하나의 테이블로 보고 조인을함.
FROM EMPLOYEE
GROUP BY DEPT_CODE;

--이를 상호연관쿼리 스칼라쿼리로 한다면

SELECT DEPT_CODE, EMP_NAME, SALARY, 
      (SELECT ROUND(AVG(SALARY)) FROM EMPLOYEE WHERE DEPT_CODE = E.DEPT_CODE)
FROM EMPLOYEE E
WHERE JOB_CODE NOT IN ('J1','J2','J3')AND SALARY > (SELECT ROUND(AVG(SALARY)) FROM EMPLOYEE WHERE DEPT_CODE = E.DEPT_CODE);

--4. 스칼라 서브쿼리
--결과값이 1개인 상관서브쿼리, SELECT문에서 사용됨
--4.1 스칼라 서브쿼리 -SELECT절 , WHERE절 ORDER BY절도 가능하긴하다.
--EX) 모든 사원의 사번, 이름, 관리자사번, 관리자명을 조회하세요!
SELECT E.EMP_NO, E.EMP_NAME,E.MANAGER_ID,
    ( SELECT EMP_NAME FROM EMPLOYEE M WHERE E.MANAGER_ID = M.EMP_ID) "관리자명"
FROM EMPLOYEE E;

--4.2 스칼라 서브쿼리 -WHERE절

--4.3 스칼라 서브쿼리 -ORDER BY절

--@실습문제
--1. 사원명, 부서명, 부서별 평균임금을 스칼라서브쿼리를 이용해서 출력.
SELECT EMP_NAME, 
    (SELECT DEPT_TITLE FROM DEPARTMENT D WHERE D.DEPT_ID = E.DEPT_CODE)"부서명", 
    (SELECT ROUND(AVG(SALARY)) FROM EMPLOYEE M WHERE M.DEPT_CODE = E.DEPT_CODE)"부서별 평균임금"
FROM EMPLOYEE E;

SELECT DEPT_TITLE FROM DEPARTMENT;

--2. 직급이 J1이 아닌 사원중에서 자신의 부서별 평균급여보다 적은 급여를 받는 사원출력.
-- 부서코드, 사원명, 급여, 부서별 급여평균
SELECT DEPT_CODE, EMP_NAME, SALARY, 
        (SELECT ROUND(AVG(SALARY)) FROM EMPLOYEE M WHERE M.DEPT_CODE = E.DEPT_CODE )"부서평균급여"
FROM EMPLOYEE E
WHERE JOB_CODE != 'J1' AND SALARY < (SELECT ROUND(AVG(SALARY)) FROM EMPLOYEE M WHERE M.DEPT_CODE = E.DEPT_CODE );
--WHERE EXISTS(SELECT 1 FROM EMPLOYEE WHERE JOB_CODE != 'J1' AND

-- 5.인라인 뷰  
--FROM절에 서브쿼리를 사용한 것을 인라인 뷰 ( INLINE_VIEW)라고 함
--EX) EMPLOYEE 테이블에서 여사원의 정보를 출력

SELECT * FROM EMPLOYEE WHERE SUBSTR(EMP_NO,8,1) = 2;

SELECT EMP_ID, EMP_NAME,DEPT_CODE,
    DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여','3','남','4','여')"성별"
FROM EMPLOYEE
WHERE  DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여','3','남','4','여') = '여';

SELECT *
FROM (SELECT EMP_ID, EMP_NAME,DEPT_CODE,
    DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여','3','남','4','여')"성별" FROM EMPLOYEE)
WHERE 성별 = '여';

--ROWNUM을 이용하여 랭킹 TOP5 구하기 , ROW넘으로 번호를 붙임
SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT EMP_NAME, SALARY FROM EMPLOYEE ORDER BY SALARY DESC)
WHERE ROWNUM < 6;
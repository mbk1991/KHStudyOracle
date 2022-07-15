-- 그룹함수    단일행 함수 다중행 함수  / 다중행함수는 다시 집계함수, 그룹함수, 윈도우 함수로 분류.
--SUM, AVG, COUNT, MAX, MIN
--여러개의 데이터값을 받아서 결과를 하나로 나타내는 함수.
SELECT *FROM TAB;

SELECT SALARY FROM EMPLOYEE;

SELECT ROUND(AVG(SALARY),2)"급여 평균" FROM EMPLOYEE;

SELECT SUM(SALARY) FROM EMPLOYEE;

SELECT COUNT(*) FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

SELECT MAX(SALARY) FROM EMPLOYEE;

SELECT MIN(SALARY) FROM EMPLOYEE;

SELECT DEPT_CODE,
            (AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;


--GROUB BY절
--별도의 그룹지정없이 사용한 그룹함수는 단 한 개의 결과값만 산출하기 때문에,
--그룹함수를 이용하여 여러개의 결과값을 산출하기 위해서는
--그룹함수가 적용될 그룹의 기준을 GROUP BY절에 기술하여 사용해야함
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) < 7000000;

SELECT JOB_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY 1 ASC;

--[EMPLOYEE] 테이블에서 부서코드 그룹별 급여의 합계, 그룹별 급여의 평균(정수처리), 인원수를 조회하고, 부서코드 순으로 정렬
SELECT DEPT_CODE,
            SUM(SALARY)"부서별 급여합계",
            FLOOR(AVG(SALARY))"부서별 급여평균",
            COUNT(*)"부서별 인원"            
FROM EMPLOYEE
--WHERE
GROUP BY DEPT_CODE
--HAVING
ORDER BY DEPT_CODE ASC;

--[EMPLOYEE] 테이블에서 부서코드 그룹별, 보너스를 지급받는 사원 수를 조회하고 부서코드 순으로 정렬
--BONUS컬럼의 값이 존재한다면, 그 행을 1로 카운팅.
--보너스를 지급받는 사원이 없는 부서도 있음.
SELECT NVL(DEPT_CODE,'인턴'), COUNT(BONUS), COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE
--HAVING BONUS IS NOT NULL
ORDER BY 1  ASC;




--@실습문제
--EMPLOYEE 테이블에서 직급이 J1을 제외하고, 직급별 사원수 및 평균급여를 출력하세요.

SELECT JOB_CODE,
            ROUND(AVG(SALARY)),
            COUNT(JOB_CODE)
FROM EMPLOYEE
WHERE JOB_CODE != 'J1'     -- <> 는 != 과 같은 것
GROUP BY JOB_CODE;



--EMPLOYEE테이블에서 직급이 J1을 제외하고,  입사년도별 인원수를 조회해서, 입사년 기준으로 오름차순 정렬하세요.

SELECT EXTRACT(YEAR FROM HIRE_DATE)"입사년도", 
            COUNT(*)"입사 인원"
FROM EMPLOYEE
--JOIN
WHERE JOB_CODE <> 'J1'
GROUP BY EXTRACT(YEAR FROM HIRE_DATE)
--HAVING
ORDER BY 1 ASC;


--[EMPLOYEE] 테이블에서 EMP_NO의 8번째 자리가 1, 3 이면 '남', 2, 4 이면 '여'로 결과를 조회하고,
-- 성별별 급여의 평균(정수처리), 급여의 합계, 인원수를 조회한 뒤 인원수로 내림차순을 정렬 하시오

SELECT
           DECODE( SUBSTR(EMP_NO,8,1) , 1,'남',2,'여',3,'남',4,'여','외국인')"성별",
            FLOOR(AVG(SALARY))"급여평균",
            SUM(SALARY),
            COUNT(*)
FROM EMPLOYEE
GROUP BY  DECODE( SUBSTR(EMP_NO,8,1) , 1,'남',2,'여',3,'남',4,'여','외국인')
--GROUP BY  
ORDER BY 4 ASC;


--GROUP BY 뒤에는 한 개의 컬럼만 오는가?
-- 2개 가능하다.

SELECT DEPT_CODE, JOB_CODE,COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY 1,2 ASC;

--@실습문제
--부서내 성별 인원수를 구하세요.

SELECT NVL(DEPT_CODE,'인턴')"부서", 0
            DECODE(SUBSTR(EMP_NO,8,1), 1, '남', 2, '여', 3, '남', 4, '여', '외국인')"성별",
            COUNT(*)"인원"

FROM EMPLOYEE
GROUP BY DEPT_CODE, DECODE(SUBSTR(EMP_NO,8,1), 1, '남', 2, '여', 3, '남', 4, '여', '외국인')
ORDER BY 1;


--부서별 급여 평균이 3,000,000원(버림적용) 이상인  부서들에 대해서 부서명, 급여평균을 출력하세요.
-- 부서별로 그룹을 나누고, 그룹별 급여평균을 구한후, 조건을 제시함.

SELECT DEPT_CODE,
            FLOOR( AVG( SALARY) )
FROM EMPLOYEE
GROUP BY DEPT_CODE;
--HAVING FLOOR(AVG(SALARY) >= 3000000;


--HAVING 절 
--그룹함소루 값을 구해올 그룹에 대해 조건을 설정할 때는 HAVING절에 기술함
-- WHERE절은 사용 불가.


--@실습문제
--부서별 인원이 5명보다 많은 부서와 인원수를 출력하세요.

SELECT DEPT_CODE,
            COUNT(*)
FROM EMPLOYEE
--JOIN
--WHERE
GROUP BY DEPT_CODE
HAVING COUNT(*) > 5;
--ORDER BY


--부서별 직급별 인원수가 3명이상인 직급의 부서코드, 직급코드, 인원수를 출력하세요.

SELECT DEPT_CODE,
            JOB_CODE,
            COUNT(*)
FROM EMPLOYEE
--JOIN
--WHERE
GROUP BY DEPT_CODE, JOB_CODE
HAVING COUNT(*) >= 3;
--ORDER BY


DESC EMPLOYEE;
--매니져가 관리하는 사원이 2명이상인 매니져아이디와 관리하는 사원수를 출력하세요.
SELECT MANAGER_ID, COUNT(*)
FROM EMPLOYEE
--JOIN
--WHERE MANAGER_ID IS NOT NULL
GROUP BY MANAGER_ID
HAVING COUNT(*) >= 2 AND MANAGER_ID IS NOT NULL
ORDER BY 1;


-- ROLLUP 과 CUBE
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP( DEPT_CODE, JOB_CODE)
ORDER BY 1;

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE( DEPT_CODE, JOB_CODE)
ORDER BY 1;


SELECT 
    DEPT_CODE,
    JOB_CODE,
    SUM(SALARY),
    CASE WHEN GROUPING(DEPT_CODE) = 0 AND GROUPING(JOB_CODE) = 1 THEN '부서별합계'
        WHEN GROUPING(DEPT_CODE) = 1 AND GROUPING(JOB_CODE) = 0 THEN '직급별합계'
        WHEN GROUPING(DEPT_CODE) = 1 AND GROUPING(JOB_CODE) = 1 THEN '총합계'
        ELSE '그룹별합계'  -- 둘다 0
    END AS "구분"
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1;


--집합연산자. UNION [ALL], UNION ALL, INTERSECT, MINUS
--합집합, 교집합, 차집합 등 집합을 테이블에서 연산을 할 수 있도록 만들어 놓은 것
--해킹할 때 쿼리문을 조작해서 데이터를 뽑아온다고함.
--UNION 할 때는
--1. 컬럼의 개수가 같아야 한다.
--2. 컬럼의 데이터타입이 같아야 한다.

SELECT EMP_NAME, EMP_ID FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE
WHERE SALARY >= 2400000
ORDER BY 1;

--데이터베이스 쿼리의 꽃 JOIN
--두 개 이상의 테이블에서 연관성을 가지고 있는 데이터들을 
--따로 분류하여 새로운 가상의 테이블을 이용하여 출력함
--> 여러 테이블의 레코드를 조합하여 하나의 열로 표현함.


--SELECT EMP_NAME, DEPT_TITLE   CASE WHEN THEN DECODE
--FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
--WHERE
--GROUP BY HAVING
--ORDER BY ASC DESC

--UNION UNION ALL MINUS INTERSECT

SELECT * 
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE EMP_ID > 210;

-- JOIN 사용법
-- SELECT FROM JOIN 테이블명 ON 매개컬럼 = 매개컬럼
--> ANSI 표준 구분 ( 어느 DBMS에서나 사용 가능)
--> ORACLE 전용 구문 (오라클 DBMS에서만 사용 가능)
SELECT * 
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;


--직급명을 출력해주세요.
SELECT * FROM EMPLOYEE E
JOIN JOB J ON J.JOB_CODE = E.JOB_CODE;

SELECT EMP_NAME, JOB_NAME FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);

--조인의 종류
--JOIN은 두개의 컬럼을 비교해서 같은 데이터만 가져왔었음
-- 그것은 INNER JOIN ! INNER JOIN이 디폴트
SELECT * FROM EMPLOYEE
INNER JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

--두 개의 컬럼 값을 비교했을 때 없는 데이터도 출력이 가능한 조인이 있다.
-- OUTER JOIN !! LEFT RIGHT FULL  // 매개 칼럼의 값이 없는 경우도 출력  
SELECT * FROM EMPLOYEE
FULL OUTER JOIN DEPARTMENT ON DEPT_CODE  = DEPT_ID;



--다중조인  .. 체인식으로 연결.
SELECT * FROM EMPLOYEE
INNER JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
INNER JOIN JOB USING(JOB_CODE)
ORDER BY JOB_CODE;

--JOIN을 이용하여 부서명 및 근무지역 출력해보기.
SELECT DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;


--@조인실습문제_kh
--1. 2020년 12월 25일이 무슨 요일인지 조회하시오.
SELECT TO_CHAR(TO_DATE(221225),'DY') FROM DUAL;


--2. 주민번호가 1970년대 생이면서 성별이 여자이고, 성이 전씨인 직원들의 사원명, 주민번호, 부서명, 직급명을 조회하시오.
SELECT EMP_NAME,EMP_NO,DEPT_TITLE,JOB_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
WHERE EMP_NO LIKE '7%-2%' AND EMP_NAME LIKE '전%';
    



--3. 이름에 '형'자가 들어가는 직원들의 사번, 사원명, 부서명을 조회하시오.
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE EMP_NAME LIKE '%형%';



--5. 해외영업부에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오.
SELECT EMP_NAME, JOB_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE E 
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
JOIN JOB USING(JOB_CODE)
WHERE DEPT_TITLE LIKE '%해외영업%';

;
--6. 보너스포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.
SELECT EMP_NAME, BONUS, DEPT_TITLE,LOCAL_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE
WHERE BONUS IS NOT NULL;

--7. 부서코드가 D2인 직원들의 사원명, 직급명, 부서명, 근무지역명을 조회하시오.

SELECT EMP_NAME,JOB_NAME,DEPT_TITLE,LOCAL_NAME
FROM EMPLOYEE E
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
JOIN LOCATION L ON  D.LOCATION_ID = L.LOCAL_CODE
WHERE DEPT_CODE = 'D2';


--8. 급여등급테이블의 최대급여(MAX_SAL)보다 많이 받는 직원들의 사원명, 직급명, 급여, 연봉을 조회하시오.
-- (사원테이블과 급여등급테이블을 SAL_LEVEL컬럼기준으로 조인할 것)

SELECT EMP_NAME,JOB_NAME, SALARY, SALARY*12, MAX_SAL
FROM EMPLOYEE
JOIN SAL_GRADE USING(SAL_LEVEL)
JOIN JOB USING(JOB_CODE);
WHERE SALARY > MAX_SAL;



--9. 한국(KO)과 일본(JP)에 근무하는 직원들의 사원명, 부서명, 지역명, 국가명을 조회하시오.

SELECT EMP_NAME"사원명",
    DEPT_TITLE"부서명",
    LOCAL_NAME"지역명",
    NATIONAL_CODE"국가명"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE
JOIN NATIONAL N USING(NATIONAL_CODE)
WHERE NATIONAL_CODE IN('KO','JP');


--10. 보너스포인트가 없는 직원들 중에서 직급이 차장과 사원인 직원들의 사원명, 직급명, 급여를 조회하시오. 단, join과 IN 사용할 것
SELECT EMP_NAME"사원명",
    JOB_NAME"직급명",
    SALARY"급여",
    NVL(BONUS,0)"보너스포인트"
FROM EMPLOYEE 
JOIN JOB USING(JOB_CODE)
WHERE BONUS IS NULL AND JOB_NAME IN('차장','사원');

--11. 재직중인 직원과 퇴사한 직원의 수를 조회하시오.
SELECT DECODE(ENT_YN,'N','재직','Y','퇴직'),
    COUNT(*)
FROM EMPLOYEE
GROUP BY ENT_YN;
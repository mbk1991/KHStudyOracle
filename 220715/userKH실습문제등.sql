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


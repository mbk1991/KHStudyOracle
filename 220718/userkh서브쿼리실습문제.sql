-- 서브쿼리 실습 문제
--문제1
--기술지원부에 속한 사람들의 사람의 이름,부서코드,급여를 출력하시오
--방법1.
SELECT EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE
WHERE DEPT_CODE = ( SELECT DEPT_ID FROM DEPARTMENT WHERE DEPT_TITLE = '기술지원부');
--방법2.


--문제2
--기술지원부에 속한 사람들 중 가장 연봉이 높은 사람의 이름,부서코드,급여를 출력하시오
--기술지원부 연봉 맥스를 서브쿼리로 사용해보기
SELECT MAX(SALARY) FROM EMPLOYEE E
JOIN DEPARTMENT D ON  E.DEPT_CODE = D.DEPT_ID
WHERE DEPT_TITLE ='기술지원부';  -- 이것을 서브쿼리로

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE E
JOIN DEPARTMENT D ON  E.DEPT_CODE = D.DEPT_ID
WHERE DEPT_TITLE ='기술지원부') AND DEPT_CODE ='D8';
--이렇게 하면 다른 부서에 급여가 같은 사람이 있을 경우 같이 조회가 된다.
--WHERE에 AND DEPT_CODE='D8'은 추가하는 것은 불완전해 보임.

--상관쿼리를 사용한다면 어떻게 해야할까?
--부서이름을 JOIN이 아닌 서브쿼리로 사용하려면 어떻게 해야할까?

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE E
WHERE NOT EXISTS ( SELECT 1 FROM EMPLOYEE M JOIN DEPARTMENT D ON M.DEPT_CODE = D.DEPT_ID
               WHERE DEPT_TITLE != '기술지원부' AND E.SALARY < M.SALARY );






--문제3
--매니저가 있는 사원중에 월급이 전체사원 평균을 넘고 
--사번,이름,매니저 이름,월급(만원단위부터)을 구하시오
 --* 단, JOIN을 이용하시오

SELECT EMP_NO, EMP_NAME
FROM EMPLOYEE;

SELECT EMP_NAME
FROM EMPLOYEE
WHERE MANAGER_ID = 200;

SELECT
 ;

--문제4
--부서 별 각 직급마다 급여 등급이 가장 높은 직원의 이름, 직급코드, 급여, 급여등급 조회






--문제5
--부서별 평균 급여가 2200000 이상인 부서명, 평균 급여 조회
--단, 평균 급여는 소수점 버림

SELECT DEPT_TITLE, FLOOR(AVG(SALARY))
FROM DEPARTMENT JOIN EMPLOYEE ON DEPT_ID = DEPT_CODE
GROUP BY DEPT_TITLE
HAVING FLOOR(AVG(SALARY)) >= 2200000;

SELECT DEPT_TITLE "부서명", (SELECT FLOOR(AVG(SALARY)) FROM EMPLOYEE WHERE DEPT_CODE = DEPT_ID)"평균급여"
FROM DEPARTMENT D 
WHERE  (SELECT FLOOR(AVG(SALARY)) FROM EMPLOYEE WHERE DEPT_CODE = DEPT_ID)>= 2200000;



--문제6
--직급의 연봉 평균보다 적게 받는 여자사원의
--사원명,직급코드,부서코드,연봉을 이름 오름차순으로 조회하시오
--연봉 계산 => (급여+(급여*보너스))*12    
-- 사원명,직급명,부서명,연봉은 EMPLOYEE 테이블을 통해 출력이 가능함 
-- 직급별 연봉

SELECT DISTINCT DEPT_CODE, (SELECT AVG(SALARY) FROM EMPLOYEE M WHERE E.DEPT_CODE = M.DEPT_CODE)
FROM EMPLOYEE E;


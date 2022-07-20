-- TOP N 실습문제 풀어보기
-- TOP N 분석을 위한 PL/SQL을 만들어라
-- '급여' / '보너스' / '입사일' 키워드입력.
-- 무조건 1위~5위 까지를 출력하는 PL/SQL을 만들어라.
--TOP N 분석을 위한 함수를 배우진 않았으나 찾아보면서 만들어보기.

SET SERVEROUTPUT ON;

SELECT * 
FROM (SELECT EMP_NAME, SALARY FROM EMPLOYEE
      ORDER BY 2 DESC)
WHERE ROWNUM < 6;

SELECT *
FROM (SELECT EMP_NAME, NVL(BONUS,0) FROM EMPLOYEE
      ORDER BY 2 DESC)
WHERE ROWNUM < 6;

SELECT *

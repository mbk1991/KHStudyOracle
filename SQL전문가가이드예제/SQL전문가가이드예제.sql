--SQL전문가가이드 예제

--1.SELECT문

--# DISTINCT 옵션과 디폴트인 ALL 옵션
SELECT * FROM PLAYER;
DESC PLAYER;
SELECT * FROM ALL_CONSTRAINTS WHERE TABLE_NAME = 'PLAYER';
SELECT ALL POSITION FROM PLAYER;
SELECT DISTINCT POSITION FROM PLAYER;

--# ALIAS 알리아스 , 칼럼명(레이블)에 별칭 부여하기
-- AS, " " (이중인용부호는 공백 및 특수문자를 포함하고 대소문자 구분이필요한경우
--AS는 생략이 가능하나 가독성 측면에서 사용하는 편이 바람직하다.

--#산술연산자 *,/, +,-
SELECT PLAYER_NAME,HEIGHT - WEIGHT "키에서 몸무게를 뺀 값"
FROM PLAYER;
--선수들의 키와몸무게로 BMI측정하기
SELECT PLAYER_NAME AS 선수명, ROUND(WEIGHT / (HEIGHT/100)*(HEIGHT/100),2)
    AS BMI비만지수 FROM PLAYER;
--선수명, 키, 몸무게 출력
SELECT PLAYER_NAME, HEIGHT, WEIGHT
FROM PLAYER;

--2.함수
-- 함수의 분류 : 내장함수, 사용자정의 함수
-- 내장함수의 분류 : 단일행 함수(입력값이 한 행), 다중행함수(입력값이 여러행)
-- 함수는 M:1의 관계. 입력이 아무리 많아도 출력은 하나만 되는 특성.
-- # 단일행 함수
--   단일행 함수의 종류 :문자형,숫자형,날짜형,변환형,NULL관련
-- # 단일행 함수의 특징
--   1) SELECT, WHERE, ORDER BY 절에서 사용할 수 있다.
--   2) 각 행들에 개별적으로 작용해 데이터 값들을 조작하고 결과를 리턴한다.
--   3) 하나 이상의 인자를 가질 수 있으며 상수,변수,표현식을 인자로 사용할 수 있다.
--   4) 함수의 중첩이 가능하다( 함수의 인자로 함수를 사용하는 것)

-- 'SQL Expert'라는 문자형 데이터의 길이를 구하는 함수
SELECT LENGTH('SQL Expert') FROM DUAL;

--# DUAL테이블의 특성
--  1) SYS 관리자의 소유이며 모든 사용자의 접근이 가능하다
--  2) SELECT ~ FROM 형식을 갖추기 위한 일종의 DUMMY이다
--  3) DUMMY라는 문자열 칼럼이 있다.

-- 선수테이블에서 CONCAT문자열 함수를 이용해 축구선수란 문구를 추가한다.
SELECT CONCAT (PLAYER_NAME,' 축구선수') FROM PLAYER;

--지역번호와 전화번호를 합친 문자열의 길이 구하기
SELECT LENGTH( DDD || TEL ) FROM STADIUM;


--5.GROUP BY, HAVING절
-- 집계함수 : 여러 행들의 그룹이 모여서 그룹당 단 하나의 결과를 반환.
-- 그룹당 하나의 결과.
-- #집계함수의 특성
--    1)여러 행들의 그룹이 모여 그룹당 단 하나의 결과를 돌려주는 함수
--    2)GROUP BY절은 행들을 소그룹화한다.
--    3)SELECT절, HAVING절, ORDER BY 절에 사용할 수 있다.

--집계함수는 GROUP BY 절과 같이 사용되지만 테이블 전체가 하나의 그룹이 되는 
--경우에는 GROUP BY절없이 단독 사용이 가능하다.
SELECT COUNT(*) AS 전체행수,
       COUNT(HEIGHT) AS 키건수,
       MAX(HEIGHT) AS 최대키, 
       MIN(HEIGHT) AS 최소키,
       ROUND(AVG(HEIGHT))
       AS 평균키
FROM PLAYER;

--# GROUP BY 절과 HAVING 절의 특성
-- 1)GROUP BY 절에 소그룹 기준을 정한 후 SELECT절에 집계함수를 사용한다.
-- 2)집계함수는 NULL값을 제외하고 수행한다.
-- 3)GROUP BY 절에 ALIAS사용은 불가하다
-- 4)집계함수는 WHERE절에 올 수 없다. WHERE절이 먼저 수행하여 행들을 제거하기 때문
-- 5)HAVING 절은 GROUP BY 절의 조건을 설정할 수 있다.

--포지션별 평균키
SELECT POSITION AS 포지션, AVG(HEIGHT)
FROM PLAYER
GROUP BY POSITION;

--ALIAS는 ORDER BY절에서는 재활용이 가능하나 GROUP BY 절에서는 불가.
--포지션별 최대키, 최소키, 평균키
SELECT POSITION,COUNT(*), COUNT(HEIGHT), MAX(HEIGHT), MIN(HEIGHT),AVG(HEIGHT)
FROM PLAYER
GROUP BY POSITION;

--평균키 180 이상
SELECT POSITION, AVG(HEIGHT)
FROM PLAYER
GROUP BY POSITION
HAVING AVG(HEIGHT) >= 180;

--삼성블루윙즈와 FC서울의 인원수
--GROUP BY, HAVING 사용
SELECT TEAM_ID, COUNT(*)
FROM PLAYER
GROUP BY TEAM_ID
HAVING TEAM_ID IN('K09','K02');

--GROUP BY, WHERE 사용
SELECT TEAM_ID, COUNT(*)
FROM PLAYER
WHERE TEAM_ID IN ('K09','K02')
GROUP BY TEAM_ID;

--결과가 같지만 가능하면 WHERE절에서 GROUP BY의 계산대상을 줄이는 것이
-- 자원 활용 측면에서 효율적이다.
-- HAVING 보다는 WHERE.

--포지션별 평균키 최대키가 190CM 이상인 선수
SELECT POSITION, AVG(HEIGHT)
FROM PLAYER
GROUP BY POSITION
HAVING MAX(HEIGHT) >= 190 ;

--# CASE 표현을 이용한 월별 데이터 집계. SIMPLE CASE EXPRESSION!
SELECT ENAME AS 사원명, DEPTNO AS 부서번호
      ,EXTRACT(MONTH FROM HIREDATE) AS 입사월, SAL AS 급여
FROM EMP;
--필요한 정보를 추려낸 쿼리문을 인라인뷰로 사용한다.

--월별 입사자의 평균급여
SELECT DEPTNO,

    AVG( CASE MONTH WHEN 1  THEN SAL END) "M01",
    AVG(CASE MONTH WHEN 2  THEN SAL END) "M02",
    AVG(CASE MONTH WHEN 3  THEN SAL END) "M03",
    AVG(CASE MONTH WHEN 4  THEN SAL END) "M04",
    AVG(CASE MONTH WHEN 5  THEN SAL END) "M05",
    AVG(CASE MONTH WHEN 6  THEN SAL END) "M06",
    AVG(CASE MONTH WHEN 7  THEN SAL END) "M07",
    AVG(CASE MONTH WHEN 8  THEN SAL END) "M08",
    AVG(CASE MONTH WHEN 9  THEN SAL END) "M09",
    AVG(CASE MONTH WHEN 10 THEN SAL END) "M10",
    AVG(CASE MONTH WHEN 11 THEN SAL END) "M11",
    AVG(CASE MONTH WHEN 12 THEN SAL END) "M12"
    
FROM (SELECT ENAME,DEPTNO,EXTRACT(MONTH FROM HIREDATE)AS MONTH,SAL 
        FROM EMP)
GROUP BY DEPTNO;

--CASE문이 많아 성능이 나쁠 것 같지만 그렇지 않다고 함.
--개발자들은 가능한 하나의 SQL문장으로 비즈니스적인 요구사항을 처리할 수 있도록 노력해야한다.
--SIMPLE CASE EXPRESSION


--# 집계함수와 NULL처리
-- 다중행 함수 속에서 NVL을 사용하는 것 지양.
--NULL이 디폴트로 할당되는 경우. 
--  1)DECODE 함수에서 네번째 인자를 설정하지 않은 경우
--  2)CASE문에서 ELSE절을 생략하는 경우
-- SUM(NVL(SAL,0)) 같은 경우 어차피 NULL은 집계함수에서 제외되는데 굳이 0으로 변환시켜
-- 데이터 건수만큼 연산이 일어나게하여 시스템 자원을 낭비하게 된다.

--팀별 포지션별 인원수와 팀별 전체인원수를 구하는 SQL문, 데이터가 없는경우 0으로 표시.
SELECT TEAM_ID,
  SUM( CASE POSITION WHEN 'DF' THEN 1 END) "DF",
  SUM( CASE POSITION WHEN 'FW' THEN 1 END) "FW",
  SUM( CASE POSITION WHEN 'GK' THEN 1 END) "GK",
  SUM( CASE POSITION WHEN 'MF' THEN 1 END) "MF",
  COUNT(*)"SUM" 
FROM PLAYER
GROUP BY TEAM_ID
ORDER BY 1 ASC;

--CASE표현을 이용하여 데이터를 표현하는 방법.
-- 전체 선수들의 포지션별 평균키 및 전체 평균키를 출력해보라


SELECT ROUND(AVG(DF),2)"DF평균키",
       ROUND(AVG(FW),2)"FW평균키",
       ROUND(AVG(GK),2)"GK평균키",
       ROUND(AVG(MF),2)"MF평균키",
       ROUND(AVG(SUM),2)"전체평균키"
FROM
(SELECT CASE POSITION WHEN 'DF' THEN HEIGHT END"DF"
     , CASE POSITION WHEN 'FW' THEN HEIGHT END"FW"
     , CASE POSITION WHEN 'GK' THEN HEIGHT END"GK"
     , CASE POSITION WHEN 'MF' THEN HEIGHT END"MF"
     , HEIGHT "SUM"
FROM PLAYER);


-- 교재에서는 인라인뷰를 만들지 않고 칼럼 모두를 전부 집계처리해버리는 방법으로 해결한다.
-- 모든 행을 집계처리한다면 인라인뷰를 만들필요가 없는 것!!

SELECT ROUND(AVG(CASE POSITION WHEN 'DF' THEN HEIGHT END),2)"DF"
     , ROUND(AVG(CASE POSITION WHEN 'FW' THEN HEIGHT END),2)"FW"
     , ROUND(AVG(CASE POSITION WHEN 'GK' THEN HEIGHT END),2)"GK"
     , ROUND(AVG(CASE POSITION WHEN 'MF' THEN HEIGHT END),2)"MF"
     , ROUND(AVG(HEIGHT),2) "SUM"
FROM PLAYER;

--6. 정렬
-- ORDER BY 절로 데이터를 정렬하는 것. 컬럼의 순서나 ALIAS를 이용한 정렬이 가능하다.
-- ORDER BY 절은 SELECT 가장 마지막에 위치하며 디폴트는 ASC이며 DESC 설정 가능하다.

--사람이름 내림차순
SELECT PLAYER_NAME, POSITION, BACK_NO
FROM PLAYER
ORDER BY 1 DESC;

SELECT PLAYER_NAME, POSITION "포지션", BACK_NO
FROM PLAYER
ORDER BY 포지션 DESC;
--NULL값은 가장 큰 값으로 취급한다.

--# ORDER BY의 특징
-- 1)

0--SQL전문가가이드 예제

-- # 220720
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
-- 1) 디폴트는 오름차순
-- 2) 오름차순시 숫자는 가장 작은값부터, 날짜는 빠른값부터
-- 3) 오라클에서 NULL값은 큰 값으로 간주
-- 유지보수와 가독성을 위해  정수매핑보다는 칼럼명이나 ALIAS사용을 권고!!

--이름,포지션,백넘버,  백넘버내림차순, 포지션 , 선수 복합 내림차순.
SELECT PLAYER_NAME"선수이름",POSITION"포지션", BACK_NO"등번호"
FROM PLAYER
WHERE BACK_NO IS NOT NULL
ORDER BY 등번호 DESC, 포지션 DESC, 선수이름 DESC;

--DEPT테이블정보를 부서명,지역,부서번호,내림차순 정렬
SELECT * 
FROM DEPT
ORDER BY DNAME, LOC, DEPTNO DESC;


--4.SELECT문장 실행 순서.
-- 1)발췌 대상 테이블을 참조한다 FROM
-- 2)발췌 대상 데이터가 아닌 것은 제거한다 WHERE
-- 3)행들을 소그룹화한다 GROUP BY
-- 4)그룹핑된 값의 조건에 맞는 것만 출력한다 HAVING
-- 5)데이터 값을 출력, 계산한다 SELECT
-- 6)데이터를 정렬한다.

-- SELECT에 없는 컬럼을 ORDER BY에 사용할 수 있다!
-- 인라인 뷰에 정의된 SELECT 칼럼을 메인 쿼리에 사용할 수 있다. 없는 건 불가.

SELECT EMPNO
FROM (SELECT EMPNO,ENAME FROM EMP ORDER BY MGR);

--GROUP BY절을 사용하면 그룹핑 기준에 사용된 칼럼과 집계함수에 사용될 수 있는 숫자형 데이터
--칼럼들의 집합을 따로 만들고 다른 개별 데이터는 저장하지 않는다. SELECT 절이나 ORDER BY절에서
--개별데이터를 사용하는 경우 에러가 발생한다. 
--GROUP BY 설정 시 그룹핑기준 칼럼과 숫자형 데이터만 사용 가능!!!
--GROUP BY 는 집계함수와 함께 써야함!!!

-- 7.JOIN
-- 조인: 두 개 이상의 테이블들을  연결해 데이터를 출력하는 것. 
-- 관계형 데이터베이스의 가장 큰 장점이자 핵심기능!!!
-- PK와 FK 값의 연관에 의한 일반적인 조인 뿐 아니라 PK,FK관계가 없어도 논리적인 값들의 연관만으로
-- 조인이 성립될 수 있다.
-- 3개의 테이블을 조인 시 특정 2개의 테이블만 먼저 조인 처리되고 조인의 결과인
--중간데이터와 나머지 테이블이 다음 차례로 조인이 된다. 4개 이상이 경우에도 
-- 2개가 조인되고 한 개가 추가 조인되고 또 다른 한 개가 추가 조인되는 식으로 진행된다.
-- (((A JOIN D) JOIN C) JOIN B) 

--EQUI JOIN 등가 JOIN
-- 두 개의 테이블 간의 칼럼 값들이 서로 정확하게 일치하는 경우 사용되는 방법.
--대부분 PK ↔ FK의 관계를 기반으로 한다.
--JOIN의 조건은 WHERE절에 = 연산자로 기술. (전통적인 방식)
--FROM 절의 ON절 USING 을 이용하는 방식 (ANSI/ISO SQL 표준방식)

--컬럼명 앞에는 테이블명(또는 ALIAS)를 붙여서 사용하는 것이 좋다.
-- 가독성과 유지보수성을 높이는 방법임.
--INNER JOIN : 조인 조건에 맞는 데이터만 출력한다.

SELECT PLAYER.PLAYER_NAME, PLAYER.BACK_NO, PLAYER.TEAM_ID
    ,TEAM.TEAM_NAME, TEAM.REGION_NAME
FROM PLAYER, TEAM
WHERE TEAM.TEAM_ID = PLAYER.TEAM_ID;

--FROM절에 알리아스를 사용하여 개발생산성을 높이고 실수를 방지한다.

SELECT P.PLAYER_NAME,
       P.BACK_NO,
       P.TEAM_ID,
       T.TEAM_NAME,
       T.REGION_NAME,
       P.POSITION
FROM PLAYER P, TEAM T
WHERE P.TEAM_ID = T.TEAM_ID AND
        POSITION = 'GK'
ORDER BY BACK_NO ASC;

--FROM절에 ALIAS를 설정한 경우 SELECT절이나 WHERE 절에서도 ALIAS로 사용해야 한다.
--가독성과 일관성 측면에서 SELECT에 알리아스를 다 적어주는 것이 좋다.
--소속팀의 전용구장 정보를 팀정보와 함께 출력
SELECT T.TEAM_NAME, S.STADIUM_NAME
FROM TEAM T JOIN STADIUM S ON T.STADIUM_ID = S.STADIUM_ID;



SELECT PLAYER_NAME, NATION
       ,(SELECT ROUND(AVG(HEIGHT),1) FROM PLAYER P2
         WHERE P1.NATION = P2.NATION)"평균키"
FROM PLAYER P1;

--NON EQUI JOIN
--비등가조인: 두 테이블 간의 논리적인 연관관계를 가지고 있으나 칼럼값들이 서로 일치하지 않는 경우
--            사용하는 조인이다.
-- 두 테이블이 PK-FK 연관관계를 같거나 논리적으로 같은 값이 존재하면 '='연산자로 JOIN을 한다.
--두 테이블간 컬럼값이 정확하게 일치하지 않는 경우  EQUI조인은 불가하며 비등가 조인으로 시도해볼 수 있다. 
-- 데이터 모델에 따라 비등가조인이 불가한 경우도 있음.
--비등가조인은 BETWEEN, 비교연산자 등으로 조인을 한다.

--# 220721
CREATE TABLE SALGRADE(
    GRADE NUMBER PRIMARY KEY,
    LOSAL NUMBER,
    HISAL NUMBER);
INSERT INTO SALGRADE VALUES
(1,700,1200);
INSERT INTO SALGRADE VALUES
(2,1201,1400);
INSERT INTO SALGRADE VALUES
(3,1401,2000);
INSERT INTO SALGRADE VALUES
(4,2001,3000);
INSERT INTO SALGRADE VALUES
(5,3001,9999);

SELECT * FROM SALGRADE;
COMMIT;

SELECT  A.ENAME, A.JOB, A.SAL, B.GRADE
FROM EMP A, SALGRADE B
WHERE A.SAL BETWEEN B.LOSAL AND B.HISAL;

SELECT ENAME, SAL, GRADE
FROM EMP E  JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL;


SELECT A.PLAYER_NAME AS 선수명,
       A.POSITION AS 포지션,
       B.REGION_NAME AS 연고지,
       B.TEAM_NAME AS 팀명,
       C.STADIUM_NAME AS 구장명
FROM PLAYER A, TEAM B, STADIUM C
WHERE A.TEAM_ID = B.TEAM_ID AND
        B.STADIUM_ID = C.STADIUM_ID
ORDER BY 선수명 ASC;

--JOIN 결과가 참인 행들만  반환하는 INNER조인. (디폴트) JOIN에 실패한 행들은 결과에서 제외된다.
--OUTER JOIN -JOIN 결과에 실패한 행들도 결과에 포함된다. 조인(매칭)되지 않는 부분은 NULL처리됨.
--테이블1과 테이블2를 조인할 때 테이블 2에 조인할 데이터가 없어도 테이블1의 모든 데이터를 표시하고 싶은 경우.
/*
    아우터조인의 오라클 문법
    FROM TABLE1, TABLE2
    WHERE TABLE1.칼럼명(+) = TABLE2.칼럼명
여기서 주의할 점은 이 예시는 RIGHT OUTER 조인이라는 것. (+)붙은 쪽이 NULL처리되고 다른쪽의 데이터가 모두 표시된다.
*/

SELECT * 
FROM STADIUM S, TEAM T
WHERE S.STADIUM_ID = T.STADIUM_ID(+)
ORDER BY HOMETEAM_ID ASC;

--DEPT와EMP를 조인하되 사원이 없는 부서정보도 같이 출력하도록
SELECT *
FROM DEPT D LEFT JOIN EMP E ON  D.DEPTNO = E.DEPTNO;

--조인이 필요한 이유는 정규화에서부터 출발한다.
--불필요한 데이터의 정합성(모순이 없는것)을 확보하고 이상현상(ANOMARY)발생을 피하기 위해
--테이블을 분할하여 생성한다. 테이블 하나에 모든 데이터가 있는 경우 데이터의 모순이 생길 수 있으며
--추가, 수정, 삭제하는 작업에 더 큰 노력이 들어간다. 규모가 큰 테이블에서 값을 찾아야 하므로 조회도 오래걸림
--테이블을 분리하면 이러한 문제를 해소할 수 있지만 테이블이 분리되었기 때문에  테이블 간의 논리적인 연관관계가 필요하다.
--이러한 관계를 통해 다양한 데이터를 출력하는 것이 바로 조인인 것이다.
--관계형 데이터베이스의 큰 장점인 조인을 잘못 기술하면 시스템 자원낭비, 응답시간 지연의 원인이 된다.

--8. 표준조인
--INNER JOIN
--NATURAL JOIN
--USING 조건절
--ON 조건절
--CROSS JOIN
--OUTER JOIN

--WHERE절에서 JOIN조건을 표기하는 전통방식 -> FROM 절에서 표기하는 방식. ON조건절, USINT조건절
--NATURAL조인은 두 테이블 간 동일한 이름을 갖는 모든 칼럼들에 대해 EQUI조인을 수행한다.
--NATURAL JOIN이 명시되면 조인 조건은 정의할 수 없다. 컬럼명과 타입이 모두 같을 때 가능하다.


--INNER조인과 NATURAL조인의 차이 비교 예제
CREATE TABLE DEPT_TEMP AS SELECT * FROM DEPT;
UPDATE DEPT_TEMP
SET DNAME = 'CONSULTING'
WHERE DNAME = 'RESEARCH';
UPDATE DEPT_TEMP
SET DNAME = 'MARKETING'
WHERE DNAME = 'SALES';

SELECT * FROM DEPT;
SELECT * FROM DEPT_TEMP;

SELECT * FROM DEPT A NATURAL JOIN DEPT_TEMP B;
SELECT * FROM DEPT A JOIN DEPT_TEMP B 
ON A.DEPTNO = B.DEPTNO
AND A.DNAME = B.DNAME
AND A.LOC = B.LOC;

SELECT * FROM DEPT A INNER JOIN DEPT_TEMP B
USING(DNAME);

--USING 조건절을 이용한 등가조인(EQUI JOIN)과 네츄럴조인에서 조인되는 컬럼을
--ALIAS나 테이블명을 구분하여 지칭할 수 없다.

--CROSSJOIN M*N으로 집합연산자의 PRODUCT의 개념. 생길 수 있는 모든 데이터의 조합
--일반적으로 잘 사용하지 않는다.

--OUTER조인
--전통방식인 (+)방식은 불편한 점이 많았다.
--ANSI/ISO 방식 문법으로 사용한다. USING절, ON절
--LEFT JOIN RIGHT JOIN FULL JOIN













































































































































































































































































































































































































































































































































































































































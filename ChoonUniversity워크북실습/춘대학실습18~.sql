--국어국문학과 총 평점이 가장 높은 학생의 이름과 학번을 표시하는 sql 문을 작성하시오.

SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME ='국어국문학과');


SELECT STUDENT_NO, STUDENT_NAME
FROM
(SELECT STUDENT_NO, STUDENT_NAME,
        (SELECT AVG(POINT) FROM TB_GRADE G WHERE S.STUDENT_NO = G.STUDENT_NO)
FROM TB_STUDENT S
WHERE S.DEPARTMENT_NO = (SELECT DEPARTMENT_NO FROM TB_DEPARTMENT
                        WHERE DEPARTMENT_NAME ='국어국문학과')
ORDER BY 3 DESC)
WHERE ROWNUM =1;

--19. 환경조경학과가 속한 같은계열 학과별 전공과목 평점 파악




SELECT DEPARTMENT_NAME"계열 학과명", ROUND(AVG(POINT),1)"전공평점"
FROM  TB_STUDENT S
JOIN TB_DEPARTMENT D USING(DEPARTMENT_NO)
JOIN TB_GRADE G USING(STUDENT_NO)
WHERE CATEGORY = (SELECT CATEGORY FROM TB_DEPARTMENT WHERE
                  DEPARTMENT_NAME = '환경조경학과')
GROUP BY DEPARTMENT_NAME
ORDER BY 1 ASC;
    




SELECT DEPARTMENT_NAME "계열 학과명",
       ROUND(AVG(POINT),1) "전공평점"
FROM TB_STUDENT S
JOIN TB_DEPARTMENT D ON  S.DEPARTMENT_NO = D.DEPARTMENT_NO
JOIN TB_GRADE G ON S.STUDENT_NO = G.STUDENT_NO
WHERE CATEGORY = (SELECT CATEGORY FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME = '환경조경학과')
GROUP BY DEPARTMENT_NAME
ORDER BY 1 ASC;


--DDL 
--1. 테이블 작성
CREATE TABME TB_CATEGORY(
    NAME VARCHAR2(10),
    USE_UN CHAR(1) DEFAULT VALUE 'Y'
    );
     

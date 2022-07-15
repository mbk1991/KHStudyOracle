--CHOON UNIVERSITY �ǽ����� Ǯ��
SELECT * FROM TAB;
DESC  TB_DEPARTMENT;

--1.�а� �̸��� �迭�� ǥ���Ͻÿ�
SELECT DEPARTMENT_NAME"�а���", CATEGORY"�迭"
FROM  TB_DEPARTMENT;

--2. �а��� �а� ���� ���
SELECT DEPARTMENT_NAME||'�� ������'||CAPACITY||'�� �Դϴ�'"�а��� ����"
FROM TB_DEPARTMENT;

--3. ������а� ���� ���л� ������а��� �а��ڵ�� 001
SELECT * FROM tb_department;

SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE ABSENCE_YN ='Y' AND DEPARTMENT_NO = '001'AND
            STUDENT_SSN LIKE '%-2%';
            
--4. ���� ��⿬ü�� �й����� ã��
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN('A513079','A513090','A513091','A513110','A513119')
ORDER BY 1 DESC;

--5.���������� 20�� �̻� 30�� ������ �а����� �а� �̸��� �迭�� ����Ͻÿ�.

SELECT DEPARTMENT_NAME,
    CATEGORY
FROM TB_DEPARTMENT
WHERE CAPACITY BETWEEN 20 AND 30;

--6.�а��� ���� ������ �˾Ƴ���
SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

--7. �а��� �����Ǿ� ���� ���� �л� ã��

SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;

--8. �������� �� �����ϴ� �����ȣ ��ȸ

SELECT CLASS_NO FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

--9 �� ������ �迭 ��ȸ
SELECT DISTINCT CATEGORY
FROM TB_DEPARTMENT
ORDER BY 1 ASC;

SELECT * FROM TB_STUDENT;

--10. 02�й� ���� ������ ����. �������� �й� �̸� �ֹι�ȣ ���
SELECT STUDENT_NO,
    STUDENT_NAME,
    STUDENT_SSN
FROM TB_STUDENT
WHERE STUDENT_ADDRESS LIKE '%���ֽ�%' AND ABSENCE_YN = 'N' 
    AND ENTRANCE_DATE BETWEEN '020101' AND '021231';
    
--�Լ�
--1. ������а� �й� �̸� ���г⵵ ���г⵵ �� ����
SELECT STUDENT_NO"�й�",
    STUDENT_NAME"�̸�",
    TO_CHAR(ENTRANCE_DATE, 'YYYY-MM-DD')"���г⵵"
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002'
ORDER BY 3 ASC;

--2. �̸��� �����ڰ� �ƴ� ����.
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE LENGTH(PROFESSOR_NAME) != 3;

--3.���� �������� �̸��� ����.
SELECT PROFESSOR_NAME"�����̸�",  -- 14�� �� �ڷ�?
   FLOOR((SYSDATE - TO_DATE('19'||SUBSTR(PROFESSOR_SSN,1,6),'YYYYMMDD'))/365) "����"
FROM TB_PROFESSOR
WHERE PROFESSOR_SSN LIKE '%-1%'  -- ��ҿ�?
ORDER BY 2 ASC;

--4. �������� ���� ������ �̸� ���
SELECT SUBSTR(PROFESSOR_NAME,2,LENGTH(PROFESSOR_NAME)) "�̸�"
FROM TB_PROFESSOR;

--5.����� ������ 19�������� ���� �ڡ�
SELECT STUDENT_NO,
    STUDENT_NAME
FROM TB_STUDENT

WHERE  (((ENTRANCE_DATE - TO_DATE(SUBSTR( STUDENT_SSN,1,6))) / 365)+1) > 20;

--6. 2020�� ũ���������� ���� �����ΰ�?
SELECT TO_CHAR(TO_DATE('20221225'),'DY') FROM DUAL;

--7. TO_DATE �Լ�
SELECT TO_DATE('99/10/11','YY/MM/DD'),
       TO_DATE('49/10/11','YY/MM/DD'),
       TO_DATE('99/10/11','RR/MM/DD'),
       TO_DATE('49/10/11','RR/MM/DD')
FROM DUAL;
--YY�� ���ô� , RR�� 00~49 / 50~99 �� ������ ����⵵�� �Է³⵵�� ������ ������ �ٸ��� ���� �Ǵ� ��������

--8. 2000��� ���� �л��� �й��� �̸�
SELECT STUDENT_NO "�й�",
        STUDENT_NAME"�̸�"
FROM TB_STUDENT
WHERE STUDENT_NO NOT LIKE 'A%';

--9. �й��� A517178�� �ѾƸ� �л��� ���� �� ������ ���ϴ� SQL 
SELECT ROUND(AVG(POINT),1) "����"
FROM TB_GRADE 
WHERE STUDENT_NO = 'A517178';

--10. �а��� �л��� "�а���ȣ" , "�л���(��)" �� ���·� ����� ����� ��� ���
SELECT DEPARTMENT_NO "�а���ȣ",
        COUNT(*)
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1 ASC;

--11. �������� �̹��� �л�
SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

--12.���� �⵵ �� ����
SELECT SUBSTR(TERM_NO,1,4)"�⵵",
       ROUND( AVG(POINT), 1 ) "�⵵ �� ����"
FROM TB_GRADE
WHERE STUDENT_NO ='A112113'
GROUP BY SUBSTR(TERM_NO,1,4);

--13. �а� �� ���л� �� �ľ�
SELECT DEPARTMENT_NO "�а��ڵ��",
       SUM(DECODE(ABSENCE_YN,'Y',1,'N',0)) "���л� ��"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1 ASC;

--14. �������� ã��
SELECT STUDENT_NAME "�����̸�",
       COUNT(*)"������ ��"
FROM TB_STUDENT
GROUP BY STUDENT_NAME HAVING  COUNT(*) >= 2;

--15.���� �б⺰ ���� �⵵�� �������� �� ����
SELECT  NVL(SUBSTR(TERM_NO,1,4),' ')"�⵵",
        NVL(SUBSTR(TERM_NO,5,2),' ') "�б�",
        ROUND(AVG(POINT),1) "����"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO,1,4) , SUBSTR(TERM_NO,5,2));

--ADDITIONAL SELECT - OPTION
SELECT STUDENT_NAME "�л� �̸�",
        STUDENT_ADDRESS "�ּ���"
FROM TB_STUDENT
ORDER BY 1 ASC;

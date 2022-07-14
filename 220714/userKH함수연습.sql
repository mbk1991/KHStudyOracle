--����Ŭ �Լ�
SELECT SYSDATE FROM DUAL;
SELECT LENGTH ('HELLO') FROM DUAL;
SELECT LENGTH(EMAIL) FROM EMPLOYEE;

--���ڿ��� ����, ���ڿ��� ����Ʈ ����
--LENGTH, LENGTHB

SELECT EMP_NAME, LENGTH(EMP_NAME),LENGTHB(EMP_NAME),
EMAIL,LENGTH(EMAIL),LENGTHB(EMAIL)
FROM EMPLOYEE;

--���ڿ��� ��ġ
--INSTR, INSTRB
--INSTR(������,STR(ã�����¹��ڿ�),1(�տ�������ã���� �ڿ�������ã����),1(N��° ã�� ���� ��ġ))
SELECT INSTR('Hello World Hi High','H',1,1)
,INSTR('Hello World Hi High','H',-1,1)
,INSTR('Hello World Hi High','H',-1,2)
FROM DUAL;

-- EMPLOYEE���̺��� EMAIL �÷��� ���ڿ� �� '@'�� ��ġ�� ���Ͻÿ�
SELECT INSTR(EMAIL,'@',1,1)
FROM EMPLOYEE;

SELECT INSTR(EMAIL,'@')  -- �⺻���� ��������
FROM EMPLOYEE;

--LPAD/RPAD
--LTRIM/RTRIM
--TRIM
SELECT EMAIL,RPAD(EMAIL, 20, '#'), LPAD(EMAIL,20,'#'),LPAD(EMAIL,10) FROM EMPLOYEE;

SELECT '             KH' FROM DUAL;
SELECT LTRIM('             KH',' ') FROM DUAL;
SELECT LTRIM('00001234', '1') FROM DUAL;
SELECT RTRIM('12340000', '0'),LTRIM('123KH123','123') FROM DUAL;

SELECT 'ACABACCKH', LTRIM('ACABACCKH','ACABACC')  --�ι�° �Ķ���ʹ� ����.'ABC'�� �ᵵ ����� ����
FROM DUAL;

SELECT TRIM(' KH   ') FROM DUAL;

SELECT LTRIM('45313456789','1345') FROM DUAL; --���տ� ���� ���� ������ ��ž
SELECT TRIM('    KH    '), TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL;
SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ'), TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ')
FROM DUAL;


-- �ǽ� ���� 1
-- Hello KH Java ���ڿ��� Hello KH �� ��µǰ� �Ͽ���.
SELECT RTRIM('Hello KH Java','Java ') FROM DUAL;



-- �ǽ� ���� 2
-- Hello KH Java ���ڿ��� KH Java �� ��µǰ� �Ͽ���.
SELECT LTRIM('Hello KH Java','Hello')
FROM DUAL;


-- �ǽ� ���� 3 (TRIM���� �غ�����)
-- DEPARTMENT ���̺��� DEPT_TITLE�� ����Ͽ���
-- �̶�, ������ �� ���ڸ� ���� ��µǵ��� �Ͽ��� / ex)ȸ������� -> ȸ�����
SELECT DEPT_TITLE, RTRIM(DEPT_TITLE,'��')
FROM DEPARTMENT;


-- �ǽ� ���� 4
-- �������ڿ����� �յ� ��� ���ڸ� �����ϼ���.
-- '982341678934509hello89798739273402'
SELECT RTRIM(LTRIM('982341678934509hello89798739273402','0123456789'),'0123456789')
FROM DUAL;

--SUBSTR
--���ڿ� �ڸ���

SELECT 'SHOW ME THE MONEY' FROM DUAL;
SELECT SUBSTR('SHOW ME THE MONEY',6) FROM DUAL;
SELECT SUBSTR('SHOW ME THE MONEY',6,2) FROM DUAL;
SELECT SUBSTR('SHOW ME THE MONEY',-2,1) FROM DUAL; --���̳ʽ��ε������� ����

-- �ǽ�����1
-- ������� ���� ���������� ����ϼ���
-- (���� ��������� �ߺ����̵� ����غ�����)

SELECT DISTINCT SUBSTR(EMP_NAME,1,1)  , PHONE
FROM EMPLOYEE
--ORDER BY SUBSTR(EMP_NAME,1,1) ASC;
ORDER BY 1 ASC;

-- �ǽ�����2
-- EMPLOYEE ���̺��� ���ڸ� �����ȣ,�����, �ֹι�ȣ, ������ ����ϼ���
-- ��, �ֹι�ȣ �� 6�ڸ��� * ó���ϼ���.

SELECT EMP_ID"�����ȣ",
       EMP_NAME"�����", 
       RPAD(SUBSTR(EMP_NO,1,8),14,'*')"�ֹι�ȣ", -- ||******* ���Ῥ���ڷ��ص��ȴ�.
       SALARY*12"����(��)"
FROM EMPLOYEE
--WHERE SUBSTR(EMP_NO,8,1) = '1';
--WHERE EMP_NO LIKE '______-1%';
WHERE EMP_NO LIKE '%-1%';

--REPLACE
SELECT REPLACE('KH HATE', 'HATE', 'LOVE') FROM DUAL;
SELECT REPLACE('KH@NAVER.COM','NAVER.COM','IEI.OR.KR') FROM DUAL;


-- �ǽ�����
-- EMPLOYEE ���̺��� ��� ������ �̸�, �ֹι�ȣ, EMAIL�� ����Ͻÿ�
-- ��, ��½� EMAIL�� �ּҸ� kh.or.kr���� iei.or.kr�� �����Ͽ� ����Ͻÿ�.
-- ��, id�� kh�� ������ ������� �ʵ��� �Ͻÿ�
SELECT  EMP_NAME"�̸�",
        EMP_NO"�ֹι�ȣ",
        EMAIL
FROM EMPLOYEE;

SELECT REPLACE( SUBSTR (EMAIL,INSTR(EMAIL,'@',1,1)) , 'kh', 'iei')
FROM EMPLOYEE;

SELECT SUBSTR(EMAIL, INSTR(EMAIL, '@',1,1)) FROM EMPLOYEE;
SELECT SUBSTR(EMAIL, 1, INSTR(EMAIL, '@',1,1)-1) FROM EMPLOYEE;
--��ħ
SELECT SUBSTR(EMAIL, 1, INSTR(EMAIL, '@',1,1)-1) ||
      REPLACE(SUBSTR(EMAIL, INSTR(EMAIL, '@',1,1)),'kh','iei')"Email"
FROM EMPLOYEE;
      
      
--�����Լ�
--ABS, MOD, ROUND�ݿø�, FLOOR����, TRUNC�Ҽ��ڸ�������, CEIL�ø�
SELECT ROUND(123.456, 2) , ROUND(123.456,1), ROUND(123.456,-1) FROM DUAL;
SELECT ROUND(123.456, 1) FROM DUAL;
SELECT TRUNC(123.456), TRUNC(123.456,2),  TRUNC(123.456,3) FROM DUAL;
SELECT CEIL(123.456) FROM DUAL;
SELECT FLOOR(123.456) FROM DUAL;

SELECT EMP_NAME, ROUND(SYSDATE - HIRE_DATE)
FROM EMPLOYEE;

SELECT EMP_NAME,
        ROUND(SYSDATE - HIRE_DATE),
        FLOOR(SYSDATE - HIRE_DATE),
        CEIL(SYSDATE - HIRE_DATE)
FROM EMPLOYEE;

--��¥ ó�� �Լ�
--SYSDATE, MONTHS_BETWEEN, ADD_MONTHS, NEXT_DAY, LAST_DAY, EXTRACT
SELECT SYSDATE FROM DUAL;
SELECT ROUND(MONTHS_BETWEEN('13/09/25','11/12/26')) FROM DUAL;

SELECT CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) "�ٹ�������"
FROM EMPLOYEE;

SELECT ADD_MONTHS(SYSDATE,3) FROM DUAL;

--NEXT_DAY
--���� ��¥�� �������� ó�� �����ϴ� ������ ��¥�� ����
SELECT NEXT_DAY(SYSDATE,'������'), NEXT_DAY(SYSDATE,'��'),
       NEXT_DAY(SYSDATE,2)
FROM DUAL;

--LAST DAY  ��ȸ�� ��¥�� ������ ��
SELECT LAST_DAY(SYSDATE) FROM DUAL;
SELECT LAST_DAY(HIRE_DATE) FROM EMPLOYEE;

/*
    ���࿡ �ڽ��� ���� ���뿡 ���ٰ� �սô�.
    ������ �Ⱓ�� 1�� 6�����̶�� �����ϸ�
    1. �������ڰ� �������� ���ϰ�
    2. �������ڱ��� �Ծ���ϴ� «���� �׸����� ���غ�����
    (��, 1�� 3�� ������ �Դ´ٰ� �����մϴ�)
    ���̺��� DUAL�� �ϼ���.
*/

SELECT SYSDATE"�Դ���",
       ADD_MONTHS(SYSDATE,18) "��������",
      (ADD_MONTHS(SYSDATE,18)-SYSDATE) * 3 "«���",
       MONTHS_BETWEEN(ADD_MONTHS(SYSDATE,18),SYSDATE)"����������"
FROM DUAL;

SELECT SYSDATE - HIRE_DATE
FROM EMPLOYEE;

--EXTRACT
--��¥�� �߶� �����ؼ� ����ϰ� ���� �� ���
SELECT HIRE_DATE
FROM EMPLOYEE;

SELECT HIRE_DATE, 
    EXTRACT(YEAR FROM HIRE_DATE) "�⵵",
    EXTRACT(MONTH FROM HIRE_DATE)"��",
    EXTRACT(DAY FROM HIRE_DATE)"��"
FROM EMPLOYEE;


-- @ �ǽ����� 1
-- EMPLOYEE ���̺��� ����� �̸�,�Ի���,������ ����Ͽ���. 
-- ��, �Ի����� YYYY��M��D�Ϸ� ����ϵ��� �Ͽ���.
-- ���� ����� �Ҽ��� �ϰ�� �ø����� �Ͽ� ����Ͽ���. (28.144 -> 29����)
-- (��½� ������ �Ի��� �������� ��������)

SELECT EMP_NAME"�̸�",
       EXTRACT(YEAR FROM HIRE_DATE)||'��'||
       EXTRACT(MONTH FROM HIRE_DATE)||'��'||
       EXTRACT(DAY FROM HIRE_DATE)||'��'"�Ի���",
       ROUND(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12)"����"
FROM EMPLOYEE;



-- @ �ǽ����� 2
-- Ư�� ���ʽ��� �����ϱ� ���Ͽ� �ڷᰡ �ʿ��ϴ�
-- �Ի����� �������� ������ 1�� ���� 6������ ����Ͽ� 
-- ����Ͻÿ� (�̸�,�Ի���,������,������+6,���ش�(��))
-- ex) 90��2��6�� �Ի� -> 90��3��1�� ���� ���
-- ex) 90��2��26�� �Ի� -> 90��3��1�� ���� ���
-- ex) 97��12��1�� �Ի� -> 98��1��1�� ���� ���
-- ��½� �Ի��� �������� �����Ͻÿ�

SELECT EMP_NAME"�̸�",
       HIRE_DATE"�Ի���",
       LAST_DAY(HIRE_DATE)+1"������",
       ADD_MONTHS((LAST_DAY(HIRE_DATE)+1),6)"������+6",
       EXTRACT(MONTH FROM ADD_MONTHS((LAST_DAY(HIRE_DATE)+1),6))"���ؿ�"
FROM EMPLOYEE
ORDER BY 2 ASC;


SELECT LAST_DAY(HIRE_DATE)+1
FROM EMPLOYEE;



-- ����ȯ �Լ�
-- ����
-- YYYY:�⵵ǥ��(4�ڸ�), YY:�⵵ǥ��(2�ڸ�)
-- MONTH:��ǥ��, MM:���� ���ڷ� ǥ��, MON:���� �ѱ۷� ǥ��
-- DD:��ǥ��
-- D:����ǥ��(���ڷ� 1:�Ͽ���,...), DAY:����ǥ��, DY:���� ���� ǥ��
-- HH,HH12:�ð�ǥ��(12�ð����� ǥ��), HH24(24�ð����� ǥ��)
-- MI:��, SS:��
-- AM,PM:����,����ǥ��
-- FM:��,��,��,��,�� ���� 0�� ����
SELECT
     TO_CHAR(SYSDATE, 'YYYY-MM-DD')"1",
     TO_CHAR(SYSDATE, 'YYYY.MM.DD')"2",
     TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')"3",
     TO_CHAR(SYSDATE, 'YYYY/MM/DD PM HH12"��"MI"��"SS"��"')"4",
     TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24"��"MI"��"SS"��"')"5"
FROM DUAL;

-- EMPLOYEE ���̺��� �����, �����(ex. 1990/02/06(ȭ))�� ����ϼ���

SELECT EMP_NAME"�����",
              TO_CHAR(HIRE_DATE,'YYYY/MM/DD"("DY")"')"�����"
FROM EMPLOYEE;

--TO_DATE
--DATE ������ ���� ����ȯ

SELECT  TO_DATE('20220714', 'YYYYMMDD') FROM DUAL;
SELECT TO_DATE('20220714150711','YYYYMMDDHH24MISS') FROM DUAL;

--TO_NUMBER
-- NUMBER ������ ���� ����ȯ!
-- ���� ����
-- , (9,999) : �޸��������� ��ȯ
-- . (99.99) : �Ҽ��� �������� ��ȯ
-- 0:�ǿ��ʿ� 0�� ����, $:$��ȭ�� ǥ��, L:������ȭ�� ǥ��(�ѱ��� \)
-- ���� ǥ�� ������ �� ������ ����� ũ�� ũ�⸦ ��ƾ� ��.

SELECT
        TO_NUMBER('90,000', '999,999,999'),
        TO_CHAR(90000, '000,000,000'),
        TO_CHAR(90000,'999,999,999')
FROM DUAL;

SELECT 
TO_NUMBER('1,000,000', '9,999,999') - TO_NUMBER('550,000', '9,999,999')
FROM DUAL;

--null�� �� 0���� �ٲٱ�
--NVL, DECODE, CASE
SELECT BONUS*100 FROM EMPLOYEE;
SELECT NVL(BONUS, 0) *100 FROM EMPLOYEE;

--�Ѽ��ɾ� ���� + ���ʽ�

SELECT SALARY * 12 +  SALARY* NVL(BONUS , 0) FROM EMPLOYEE;

--DECODE
--case�� �� �ٷ� �� �� �ִ�!
--¦�� ���缭 ����,���԰� ,����,���԰�,����,���԰�,ELSE��
SELECT EMP_NAME,
            DECODE(SUBSTR(EMP_NO,8,1), '1','��','2','��','����') "����"
FROM EMPLOYEE;
-- DECODE �� �񱳹��� �� �ֳ�?


--CASE

SELECT EMP_ID,  EMP_NAME,
CASE WHEN  SUBSTR(EMP_NO,8,1) = 1 THEN '��'
END
FROM EMPLOYEE;
--EMPLOYEE ���̺��� ���ڴ� ��, ���ڴ� ����� ����Ͻÿ�.
SELECT EMP_ID, EMP_NAME,
            CASE  WHEN SUBSTR(EMP_NO,8,1) = 1 THEN '��'
                      WHEN SUBSTR(EMP_NO,8,1) = 2 THEN '��'
                      ELSE ' ����'
                      END"����"
FROM EMPLOYEE;


-- EMPLOYEE ���̺��� ���ڴ� ��, ���ڴ� ����� ����Ͻÿ�

-- EMPLOYEE ���̺��� ����⵵ ���� 60��� �� ������ ���Ͽ� 
-- 65������ ����ڴ� 60��� �ʹ�, 65�� ���� ����ڴ� 60��� �Ĺ��̶�� ����Ͻÿ�

SELECT EMP_ID, EMP_NAME, EMP_NO,
            CASE WHEN SUBSTR(EMP_NO,2,1) < 5 THEN '60��� �ʹ�'
                    ELSE '60��� �Ĺ�'
                    END "����"
FROM EMPLOYEE
WHERE EMP_NO LIKE '6%';

-- ������ �����ڵ忡 ���� �ش����޸��� ����ϼ���. (job���̺�����)
SELECT
            EMP_NAME"�����",
            JOB_CODE"�����ڵ�",
            DECODE(JOB_CODE,
                    'J1','��ǥ',
                    'J2','�λ���',
                    'J3','����',
                    'J4','����',
                    'J5','����',
                    'J6','�븮',
                    'J7','���',
                    '����') "���޸�"
FROM EMPLOYEE;

DESC EMPLOYEE;



-- ���� �ǽ� ����
-- ����1. 
-- �Ի����� 5�� �̻�, 10�� ������ ������ �̸�,�ֹι�ȣ,�޿�,�Ի����� �˻��Ͽ���

SELECT EMP_NAME"�̸�",
            EMP_NO"�ֹι�ȣ",
            SALARY"�޿�",
            HIRE_DATE"�Ի���"
FROM EMPLOYEE
WHERE ( SYSDATE-HIRE_DATE)/365 >= 5 AND ( SYSDATE-HIRE_DATE)/365 <= 10;

-- ����2.
-- �������� �ƴ� ������ �̸�,�μ��ڵ�, �����, �ٹ��Ⱓ, �������� �˻��Ͽ��� 
--(��� ���� : ENT_YN)

SELECT EMP_NAME"�̸�",
            DEPT_CODE"�μ��ڵ�",
            HIRE_DATE"�����",
            ENT_DATE-HIRE_DATE"�ٹ��Ⱓ",
            ENT_DATE"������"
FROM EMPLOYEE
WHERE ENT_DATE IS NOT NULL;
            


-- ����3.
-- �ټӳ���� 10�� �̻��� �������� �˻��Ͽ�
-- ��� ����� �̸�,�޿�,�ټӳ��(�Ҽ���X)�� �ټӳ���� ������������ �����Ͽ� ����Ͽ���
-- ��, �޿��� 50% �λ�� �޿��� ��µǵ��� �Ͽ���.

SELECT EMP_NAME"�̸�",
            SALARY * 1.5"�޿�",
            ROUND((SYSDATE-HIRE_DATE)/365) "�ټӳ��"
FROM EMPLOYEE
WHERE ENT_DATE IS NULL AND (SYSDATE-HIRE_DATE) /365 >= 10
ORDER BY 3 ASC;


-- ����4.
-- �Ի����� 99/01/01 ~ 10/01/01 �� ��� �߿��� �޿��� 2000000 �� ������ �����
-- �̸�,�ֹι�ȣ,�̸���,����ȣ,�޿��� �˻� �Ͻÿ�

SELECT EMP_NAME"�̸�",EMP_NO"�ֹι�ȣ",EMAIL"�̸���",PHONE"����ȣ",SALARY"�޿�",HIRE_DATE"�Ի���"
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '990101' AND '100101' AND SALARY <= 2000000;

-- ����5.
-- �޿��� 2000000�� ~ 3000000�� �� ������ �߿��� 4�� �����ڸ� �˻��Ͽ� 
-- �̸�,�ֹι�ȣ,�޿�,�μ��ڵ带 �ֹι�ȣ ������(��������) ����Ͽ���
-- ��, �μ��ڵ尡 null�� ����� �μ��ڵ尡 '����' ���� ��� �Ͽ���.

SELECT EMP_NAME"�̸�",
            EMP_NO"�ֹι�ȣ",
            SALARY"�޿�",
            NVL(DEPT_CODE,'����')"�μ��ڵ�"
FROM  EMPLOYEE
WHERE SALARY BETWEEN 2000000 AND 3000000 AND 
            SUBSTR(EMP_NO,8,1) = 2 AND SUBSTR(EMP_NO,3,2) = '04'
ORDER BY 2 DESC;

-- ����6.
-- ���� ��� �� ���ʽ��� ���� ����� ���ñ��� �ٹ����� �����Ͽ� 
-- 1000�� ����(�Ҽ��� ����) 
-- �޿��� 10% ���ʽ��� ����Ͽ� �̸�,Ư�� ���ʽ� (��� �ݾ�) ����� ����Ͽ���.
-- ��, �̸� ������ ���� ���� �����Ͽ� ����Ͽ���.

SELECT EMP_NAME"�̸�",
             FLOOR((SYSDATE - HIRE_DATE) / 1000) /100 * SALARY "Ư�� ���ʽ�"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = 1 AND BONUS IS NULL;



-- @�Լ� �����ǽ�����
--1. ������� �̸��� , �̸��� ���̸� ����Ͻÿ�
--		  �̸�	    �̸���		�̸��ϱ���
--	ex) 	ȫ�浿 , hong@kh.or.kr   	  13

SELECT EMP_NAME"������",
            EMAIL"�̸���",
            LENGTH(EMAIL)"�̸��ϱ���"
FROM EMPLOYEE;

--2. ������ �̸��� �̸��� �ּ��� ���̵� �κи� ����Ͻÿ�
--	ex) ���ö	no_hc
--	ex) ������	jung_jh

SELECT EMP_NAME"�̸�",
            SUBSTR(EMAIL,1,INSTR(EMAIL,'@')-1)"���̵�"
FROM EMPLOYEE;



--3. 60��뿡 �¾ ������� ���, ���ʽ� ���� ����Ͻÿ�. �׶� ���ʽ� ���� null�� ��쿡�� 0 �̶�� ��� �ǰ� ����ÿ�
--	    ������    ���      ���ʽ�
--	ex) ������	    1962	    0.3
--	ex) ������	    1963  	    0

SELECT EMP_NAME"�̸�",
         '19'||SUBSTR(EMP_NO,1,2)"���",
         NVL(BONUS,0)"���ʽ�"
FROM EMPLOYEE
WHERE EMP_NO LIKE '6%';


--4. '010' �ڵ��� ��ȣ�� ���� �ʴ� ����� ���� ����Ͻÿ� (�ڿ� ������ ���� ���̽ÿ�)
--	   �ο�
--	ex) 3��

--�̰� �� �ϴ� ��


--5. ������� �Ի����� ����Ͻÿ� 
--	��, �Ʒ��� ���� ��µǵ��� ����� ���ÿ�
--	    ������		�Ի���
--	ex) ������		2012�� 12��
--	ex) ������		1997�� 3��

SELECT EMP_NAME "������",
            EXTRACT(YEAR FROM HIRE_DATE)||'��' ||
            EXTRACT(MONTH FROM HIRE_DATE)||'��' "�Ի���"
FROM EMPLOYEE;


--6. ������� �ֹι�ȣ�� ��ȸ�Ͻÿ�
--	��, �ֹι�ȣ 9��° �ڸ����� �������� '*' ���ڷ� ä������� �Ͻÿ�
--	ex) ȫ�浿 771120-1******

SELECT EMP_NAME"������",
            RPAD(SUBSTR(EMP_NO,1,8),14,'*')
FROM EMPLOYEE;


--7. ������, �����ڵ�, ����(��) ��ȸ
--  ��, ������ ��57,000,000 ���� ǥ�õǰ� ��
--     ������ ���ʽ�����Ʈ�� ����� 1��ġ �޿���

SELECT EMP_NAME"������",
            JOB_CODE"�����ڵ�",
          TO_CHAR(SALARY*12 * (1+NVL(BONUS,0)),'L999,999,999')  "����"
FROM EMPLOYEE;


--8. �μ��ڵ尡 D5, D9�� ������ �߿��� 2004�⵵�� �Ի��� �����߿� ��ȸ��.
--   ��� ����� �μ��ڵ� �Ի���
SELECT EMP_ID"���",
            EMP_NAME"�����",
            DEPT_CODE"�μ��ڵ�",
            HIRE_DATE"�Ի���"
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5','D9') AND EXTRACT(YEAR FROM  HIRE_DATE) = 2004;


--9. ������, �Ի���, ���ñ����� �ٹ��ϼ� ��ȸ 
--	* �ָ��� ���� , �Ҽ��� �Ʒ��� ����
SELECT EMP_NAME"������",
            HIRE_DATE"�Ի���",
            FLOOR(SYSDATE - HIRE_DATE) "���ñ����� �ٹ��ϼ�"
FROM EMPLOYEE;


--10. ������, �μ��ڵ�, �������, ����(��) ��ȸ
--   ��, ��������� �ֹι�ȣ���� �����ؼ�, 
--   ���������� ������ �����Ϸ� ��µǰ� ��.
--   ���̴� �ֹι�ȣ���� �����ؼ� ��¥�����ͷ� ��ȯ�� ����, �����
--	* �ֹι�ȣ�� �̻��� ������� ���ܽ�Ű�� ���� �ϵ���(200,201,214 �� ����)
--	* HINT : NOT IN ���

SELECT EMP_NAME "������",
            DEPT_CODE "�μ��ڵ�",
           TO_CHAR(TO_DATE(SUBSTR(EMP_NO,1,6)),'YYYY"��" MM"��" DD"��"')  "�������",
           ROUND((SYSDATE - TO_DATE(SUBSTR(EMP_NO,1,6))) / 365 ) "����(��)"
FROM EMPLOYEE
WHERE EMP_ID NOT IN (200,201,214);


SELECT TO_CHAR(SYSDATE,'YYYY"��"MM"��"DD"��"') FROM DUAL;

--11. ������, �μ����� ����ϼ���.
--   �μ��ڵ尡 D5�̸� �ѹ���, D6�̸� ��ȹ��, D9�̸� �����η� ó���Ͻÿ�.(case ���)
--   ��, �μ��ڵ尡 D5, D6, D9 �� ������ ������ ��ȸ�ϰ�, �μ��ڵ� �������� �������� ������.

SELECT EMP_NAME"�����" ,
            DECODE(DEPT_CODE,'D5','�ѹ���','D6','��ȹ��','D9','������')  "�μ���"
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5','D6','D9')
ORDER BY DEPT_CODE ASC;


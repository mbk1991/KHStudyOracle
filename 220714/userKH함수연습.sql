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
       EMP_HIRE"�Ի���",
       "������",
       "������+6",
       "���ش�(��)"
FROM EMPLOYEE;

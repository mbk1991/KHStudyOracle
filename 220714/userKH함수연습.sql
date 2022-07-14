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



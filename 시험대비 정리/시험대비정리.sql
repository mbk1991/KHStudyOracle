--1.������ ���� ����
CONN SYS AS SYSDBA;
--2.����� ���� ����
CREATE USER USER1 IDENTIFIED BY PWD1234;
--2. ����� ������ ���Ѻο�
GRANT RESOURCE, CONNECT TO USER1;
--3. ����� �������� ��ȯ�ϱ�
ALTER USER USER1 IDENTIFIED BY PWD1234;

--�ֿ� ����ڰ���
/*
    1. SYS : �ְ� ������. ��� ����
    2. SYSTEM : �������� �� ����
    3. ANONYMOUS : HTTP�� ����  XML DB ���ٿ� ����
    3. HR : ���� ����
*/
--CHOON UNIVERSITY �ǽ����� Ǯ��
SELECT * FROM TAB;
DESC  TB_DEPARTMENT;

--1.�а� �̸��� �迭�� ǥ���Ͻÿ�
SELECT DEPARTMENT_NAME"�а���", CATEGORY"�迭"
FROM  TB_DEPARTMENT;

--2. �а��� �а� ���� ���
SELECT DEPARTMENT_NAME||'�� ������'||CAPACITY||'�� �Դϴ�'"�а��� ����"
FROM TB_DEPARTMENT;


--다른사용자에의 테이블에 접근. 시스템이 권한을 주지 않으면 접근이 불가하다.
SELECT * FROM KHUSER.COFFEE;
INSERT INTO KHUSER.COFFEE VALUES('프렌치카페', 10000, '남양유업');
COMMIT;
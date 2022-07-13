CREATE TABLE COFFEE(
    PRODUCT_NAME VARCHAR2(20),
    PRICE NUMBER,
    COMPANY VARCHAR2(20)
);

--맥심커피, 30000, MAXIM
--카누커피, 50000, MAXIM
--네스카페, 30000, NESCAFE

INSERT INTO COFFEE
VALUES ('맥심커피', 30000, 'MAXIM');
INSERT INTO COFFEE
VALUES ('카누커피', 50000, 'MAXIM');
INSERT INTO COFFEE
VALUES ('네스카페', 30000, 'NESCAFE');

DESC COFFEE;

SELECT * 
FROM COFFEE
WHERE PRODUCT_NAME = '맥심커피';

COMMIT;

DELETE FROM COFFEE WHERE COMPANY = '남양유업';
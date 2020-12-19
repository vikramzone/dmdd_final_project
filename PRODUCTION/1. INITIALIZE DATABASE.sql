SET SERVEROUTPUT ON;
DECLARE
nCount NUMBER;
BEGIN
SELECT count(*) into nCount FROM user_tables where table_name = 'PEOPLE';
IF(nCount > 0)
THEN
    DBMS_OUTPUT.PUT_LINE('TABLE PEOPLE ALREADY EXISTS');
ELSE
    EXECUTE IMMEDIATE 'CREATE TABLE PEOPLE(
      USER_ID       NUMBER GENERATED BY DEFAULT AS IDENTITY,
      USERNAME      VARCHAR(16) UNIQUE NOT NULL,
      EMAIL         VARCHAR(60) UNIQUE NOT NULL,
      PASS_WORD     VARCHAR(15) NOT NULL,
      DATE_JOINED   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      FIRST_NAME    VARCHAR(45) NOT NULL,
      LAST_NAME     VARCHAR(45) NOT NULL,
      PHONE_NUMBER  NUMBER(10) NOT NULL,
      PRIMARY KEY(USER_ID))';    

END IF;
SELECT count(*) into nCount FROM user_tables where table_name = 'LISTING_CATEGORY';
IF(nCount > 0)
THEN
    dbms_output.put_line('TABLE LISTING_CATEGORY ALREADY EXISTS');
ELSE
    EXECUTE IMMEDIATE 'CREATE TABLE LISTING_CATEGORY(
      CATEGORY_ID       NUMBER GENERATED BY DEFAULT AS IDENTITY,
      CATEGORY_NAME     VARCHAR(255) UNIQUE NOT NULL,
      PRIMARY KEY(CATEGORY_ID)
    )';
    EXECUTE IMMEDIATE 'INSERT INTO LISTING_CATEGORY(CATEGORY_NAME) VALUES(''ELECTRONICS'')';
    EXECUTE IMMEDIATE 'INSERT INTO LISTING_CATEGORY(CATEGORY_NAME) VALUES(''CLOTHING'')';
    EXECUTE IMMEDIATE 'INSERT INTO LISTING_CATEGORY(CATEGORY_NAME) VALUES(''SPORTS'')';
    EXECUTE IMMEDIATE 'INSERT INTO LISTING_CATEGORY(CATEGORY_NAME) VALUES(''HOME'')';
    EXECUTE IMMEDIATE 'INSERT INTO LISTING_CATEGORY(CATEGORY_NAME) VALUES(''OTHERS'')';
    EXECUTE IMMEDIATE 'INSERT INTO LISTING_CATEGORY(CATEGORY_NAME) VALUES(''TRANSPORT'')';
    EXECUTE IMMEDIATE 'INSERT INTO LISTING_CATEGORY(CATEGORY_NAME) VALUES(''OUTDOOR'')';
    
END IF;
SELECT count(*) into nCount FROM user_tables where table_name = 'RENTAL_BASIS';
IF(nCount > 0)
THEN
    dbms_output.put_line('TABLE RENTAL_BASIS ALREADY EXISTS');
ELSE
    EXECUTE IMMEDIATE 'CREATE TABLE RENTAL_BASIS(
      BASIS_ID       NUMBER GENERATED BY DEFAULT AS IDENTITY,
      BASIS_NAME     VARCHAR(45) UNIQUE NOT NULL,
      PRIMARY KEY(BASIS_ID)
    )';
     EXECUTE IMMEDIATE 'INSERT INTO RENTAL_BASIS(BASIS_NAME) VALUES(''PER HOUR'')';
     EXECUTE IMMEDIATE 'INSERT INTO RENTAL_BASIS(BASIS_NAME) VALUES(''PER DAY'')';
     EXECUTE IMMEDIATE 'INSERT INTO RENTAL_BASIS(BASIS_NAME) VALUES(''PER WEEK'')';
     EXECUTE IMMEDIATE 'INSERT INTO RENTAL_BASIS(BASIS_NAME) VALUES(''PER MONTH'')';
     
END IF;
SELECT count(*) into nCount FROM user_tables where table_name = 'ADDRESS_COUNTRY';
IF(nCount > 0)
THEN
    dbms_output.put_line('TABLE ADDRESS_COUNTRY ALREADY EXISTS');
ELSE
    EXECUTE IMMEDIATE 'CREATE TABLE ADDRESS_COUNTRY(
      COUNTRY_ID       NUMBER GENERATED BY DEFAULT AS IDENTITY,
      COUNTRY_NAME     VARCHAR(60) UNIQUE NOT NULL,
      PRIMARY KEY(COUNTRY_ID)
    )';
    EXECUTE IMMEDIATE 'INSERT INTO ADDRESS_COUNTRY(COUNTRY_NAME) VALUES(''UNITED STATES'')';
    
END IF;
SELECT count(*) into nCount FROM user_tables where table_name = 'ADDRESS_STATE';
IF(nCount > 0)
THEN
    dbms_output.put_line('TABLE ADDRESS_STATE ALREADY EXISTS');
ELSE
    EXECUTE IMMEDIATE 'CREATE TABLE ADDRESS_STATE(
      STATE_ID       NUMBER GENERATED BY DEFAULT AS IDENTITY,
      STATE_NAME     VARCHAR(60) UNIQUE NOT NULL,
      COUNTRY_ID    REFERENCES ADDRESS_COUNTRY(COUNTRY_ID) ON DELETE CASCADE,
      PRIMARY KEY(STATE_ID)
    )';
    EXECUTE IMMEDIATE 'INSERT INTO ADDRESS_STATE(STATE_NAME,COUNTRY_ID) VALUES(''MASSACHUSETTS'',1)';
    EXECUTE IMMEDIATE 'INSERT INTO ADDRESS_STATE(STATE_NAME,COUNTRY_ID) VALUES(''NEW YORK'',1)';
    EXECUTE IMMEDIATE 'INSERT INTO ADDRESS_STATE(STATE_NAME,COUNTRY_ID) VALUES(''CALIFORNIA'',1)';
    EXECUTE IMMEDIATE 'INSERT INTO ADDRESS_STATE(STATE_NAME,COUNTRY_ID) VALUES(''VIRGINIA'',1)';
    
END IF;
SELECT count(*) into nCount FROM user_tables where table_name = 'ADDRESS_CITY';
IF(nCount > 0)
THEN
    dbms_output.put_line('TABLE ADDRESS_CITY ALREADY EXISTS');
ELSE
    EXECUTE IMMEDIATE 'CREATE TABLE ADDRESS_CITY(
      CITY_ID       NUMBER GENERATED BY DEFAULT AS IDENTITY,
      CITY_NAME     VARCHAR(60) UNIQUE NOT NULL,
      STATE_ID      REFERENCES ADDRESS_STATE(STATE_ID) ON DELETE CASCADE,
      PRIMARY KEY(CITY_ID)
    )';
    EXECUTE IMMEDIATE 'INSERT INTO ADDRESS_CITY(CITY_NAME,STATE_ID) VALUES(''NEW YORK CITY'',(SELECT STATE_ID FROM ADDRESS_STATE WHERE STATE_NAME=''NEW YORK''))';
    EXECUTE IMMEDIATE 'INSERT INTO ADDRESS_CITY(CITY_NAME,STATE_ID) VALUES(''BUFFALO'',(SELECT STATE_ID FROM ADDRESS_STATE WHERE STATE_NAME=''NEW YORK''))';
    EXECUTE IMMEDIATE 'INSERT INTO ADDRESS_CITY(CITY_NAME,STATE_ID) VALUES(''ROCHESTER'',(SELECT STATE_ID FROM ADDRESS_STATE WHERE STATE_NAME=''NEW YORK''))';
    EXECUTE IMMEDIATE 'INSERT INTO ADDRESS_CITY(CITY_NAME,STATE_ID) VALUES(''FAIRFAX'',(SELECT STATE_ID FROM ADDRESS_STATE WHERE STATE_NAME=''VIRGINIA''))';
    EXECUTE IMMEDIATE 'INSERT INTO ADDRESS_CITY(CITY_NAME,STATE_ID) VALUES(''BRISTOL'',(SELECT STATE_ID FROM ADDRESS_STATE WHERE STATE_NAME=''VIRGINIA''))';
    EXECUTE IMMEDIATE 'INSERT INTO ADDRESS_CITY(CITY_NAME,STATE_ID) VALUES(''SAN JOSE'',(SELECT STATE_ID FROM ADDRESS_STATE WHERE STATE_NAME=''CALIFORNIA''))';
    EXECUTE IMMEDIATE 'INSERT INTO ADDRESS_CITY(CITY_NAME,STATE_ID) VALUES(''SANTA CLARA'',(SELECT STATE_ID FROM ADDRESS_STATE WHERE STATE_NAME=''CALIFORNIA''))';
    EXECUTE IMMEDIATE 'INSERT INTO ADDRESS_CITY(CITY_NAME,STATE_ID) VALUES(''SAN FRANSISCO'',(SELECT STATE_ID FROM ADDRESS_STATE WHERE STATE_NAME=''CALIFORNIA''))';
    EXECUTE IMMEDIATE 'INSERT INTO ADDRESS_CITY(CITY_NAME,STATE_ID) VALUES(''LOS ANGELES'',(SELECT STATE_ID FROM ADDRESS_STATE WHERE STATE_NAME=''CALIFORNIA''))';
    EXECUTE IMMEDIATE 'INSERT INTO ADDRESS_CITY(CITY_NAME,STATE_ID) VALUES(''BOSTON'',(SELECT STATE_ID FROM ADDRESS_STATE WHERE STATE_NAME=''MASSACHUSETTS''))';
    EXECUTE IMMEDIATE 'INSERT INTO ADDRESS_CITY(CITY_NAME,STATE_ID) VALUES(''CAMBRIDGE'',(SELECT STATE_ID FROM ADDRESS_STATE WHERE STATE_NAME=''MASSACHUSETTS''))';
    
END IF;
SELECT count(*) into nCount FROM user_tables where table_name = 'USER_ADDRESS';
IF(nCount > 0)
THEN
    dbms_output.put_line('TABLE USER_ADDRESS ALREADY EXISTS');
ELSE
    EXECUTE IMMEDIATE 'CREATE TABLE USER_ADDRESS(
  ADDRESS_ID         NUMBER GENERATED BY DEFAULT AS IDENTITY,
  ADDRESS_LINE_1     VARCHAR(255) NOT NULL,
  ADDRESS_LINE_2     VARCHAR(255) NOT NULL,
  ZIP_CODE           NUMBER NOT NULL, 
  USER_ID            REFERENCES PEOPLE(USER_ID) ON DELETE CASCADE,
  CITY_ID            REFERENCES ADDRESS_CITY(CITY_ID) ON DELETE CASCADE,
  PRIMARY KEY(ADDRESS_ID)
)';
    
END IF;
SELECT count(*) into nCount FROM user_tables where table_name = 'LISTINGS';
IF(nCount > 0)
THEN
    dbms_output.put_line('TABLE LISTINGS ALREADY EXISTS');
ELSE
    EXECUTE IMMEDIATE 'CREATE TABLE LISTINGS(
  LISTING_ID        NUMBER GENERATED BY DEFAULT AS IDENTITY,
  TITLE             VARCHAR(32) NOT NULL,
  L_DESCRIPTION     VARCHAR(255) NOT NULL,
  DATE_POSTED       TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP,
  CONTACT_DETAILS   VARCHAR(45) NOT NULL,
  PRICE             NUMBER NOT NULL,
  RENTAL_BASIS_ID   REFERENCES RENTAL_BASIS(BASIS_ID) ON DELETE CASCADE,
  CATEGORY_ID       REFERENCES LISTING_CATEGORY(CATEGORY_ID) ON DELETE CASCADE,
  USER_ID           REFERENCES PEOPLE(USER_ID) ON DELETE CASCADE,
  ADDRESS_ID        REFERENCES USER_ADDRESS(ADDRESS_ID) ON DELETE CASCADE,
  START_DATE        TIMESTAMP(0),
  END_DATE          TIMESTAMP(0),
  PRIMARY KEY(LISTING_ID)
    )';
    
END IF;
SELECT count(*) into nCount FROM user_tables where table_name = 'CURRENT_STATUS';
IF(nCount > 0)
THEN
    dbms_output.put_line('TABLE CURRENT_STATUS ALREADY EXISTS');
ELSE
    EXECUTE IMMEDIATE 'CREATE TABLE CURRENT_STATUS(
  STATUS_ID            NUMBER GENERATED BY DEFAULT AS IDENTITY,
  STATUS        VARCHAR(255) NOT NULL,
  PRIMARY KEY(STATUS_ID)
)';
  EXECUTE IMMEDIATE 'INSERT INTO CURRENT_STATUS(STATUS) VALUES(''PENDING EMPLOYEE ASSIGNMENT'')';  
  EXECUTE IMMEDIATE 'INSERT INTO CURRENT_STATUS(STATUS) VALUES(''DELIVERY IN-TRANSIT'')';  
  EXECUTE IMMEDIATE 'INSERT INTO CURRENT_STATUS(STATUS) VALUES(''DELIVERED'')';  
  EXECUTE IMMEDIATE 'INSERT INTO CURRENT_STATUS(STATUS) VALUES(''PICKUP IN-TRANSIT'')';  
  EXECUTE IMMEDIATE 'INSERT INTO CURRENT_STATUS(STATUS) VALUES(''ORDER COMPLETE'')';  
  EXECUTE IMMEDIATE 'INSERT INTO CURRENT_STATUS(STATUS) VALUES(''DISPUTED'')';    

END IF;
SELECT count(*) into nCount FROM user_tables where table_name = 'DEAL_STATUS';
IF(nCount > 0)
THEN
    dbms_output.put_line('TABLE DEAL_STATUS ALREADY EXISTS');
ELSE
    EXECUTE IMMEDIATE 'CREATE TABLE DEAL_STATUS(
  STATUS_ID         NUMBER GENERATED BY DEFAULT AS IDENTITY,
  STATUS_NAME       VARCHAR(45) NOT NULL,
  PRIMARY KEY(STATUS_ID))';
    EXECUTE IMMEDIATE 'INSERT INTO DEAL_STATUS(STATUS_NAME) VALUES(''PENDING'')'; 
    EXECUTE IMMEDIATE 'INSERT INTO DEAL_STATUS(STATUS_NAME) VALUES(''APPROVED'')'; 
    EXECUTE IMMEDIATE 'INSERT INTO DEAL_STATUS(STATUS_NAME) VALUES(''REJECTED'')'; 
    
END IF;
SELECT count(*) into nCount FROM user_tables where table_name = 'DESIGNATION';
IF(nCount > 0)
THEN
    dbms_output.put_line('TABLE DESIGNATION ALREADY EXISTS');
ELSE
    EXECUTE IMMEDIATE 'CREATE TABLE DESIGNATION(
  DESIGNATION_ID    NUMBER GENERATED BY DEFAULT AS IDENTITY,
  DESIGNATION       VARCHAR(45) NOT NULL,
  PRIMARY KEY(DESIGNATION_ID)
)';
    EXECUTE IMMEDIATE 'INSERT INTO DESIGNATION(DESIGNATION) VALUES(''MANAGER'')';  
    EXECUTE IMMEDIATE 'INSERT INTO DESIGNATION(DESIGNATION) VALUES(''DELIVERY EXECUTIVE'')';  
    
END IF;
SELECT count(*) into nCount FROM user_tables where table_name = 'DEALS';
IF(nCount > 0)
THEN
    dbms_output.put_line('TABLE DEALS ALREADY EXISTS');
ELSE
    EXECUTE IMMEDIATE 'CREATE TABLE DEALS(
  DEALS_ID          NUMBER GENERATED BY DEFAULT AS IDENTITY,
  PRICE             NUMBER NOT NULL,
  STATUS_ID         REFERENCES DEAL_STATUS(STATUS_ID) ON DELETE CASCADE,
  LISTING_ID        REFERENCES LISTINGS(LISTING_ID) ON DELETE CASCADE,
  USER_ID           REFERENCES PEOPLE(USER_ID) ON DELETE CASCADE,
  CREATE_TIME       TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP,
  START_DATE        TIMESTAMP(0),
  END_DATE          TIMESTAMP(0),
  PRIMARY KEY(DEALS_ID)
)';

END IF;
SELECT count(*) into nCount FROM user_tables where table_name = 'EMPLOYEE';
IF(nCount > 0)
THEN
    dbms_output.put_line('TABLE EMPLOYEE ALREADY EXISTS');
ELSE
    EXECUTE IMMEDIATE 'CREATE TABLE EMPLOYEE(
  EMPLOYEE_ID       NUMBER GENERATED BY DEFAULT AS IDENTITY,
  PAY               NUMBER NOT NULL,
  EMAIL             VARCHAR(60) UNIQUE NOT NULL,
  PASS_WORD         VARCHAR(15) NOT NULL,
  DATE_JOINED       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FIRST_NAME        VARCHAR(45) NOT NULL,
  LAST_NAME         VARCHAR(45) NOT NULL,
  PHONE_NUMBER      NUMBER(10) NOT NULL,
  DESIGNATION_ID    REFERENCES DESIGNATION(DESIGNATION_ID) ON DELETE CASCADE,
  PRIMARY KEY(EMPLOYEE_ID))';
    
END IF;
SELECT count(*) into nCount FROM user_tables where table_name = 'EMPLOYEE_ADDRESS';
IF(nCount > 0)
THEN
    dbms_output.put_line('TABLE EMPLOYEE_ADDRESS ALREADY EXISTS');
ELSE
    EXECUTE IMMEDIATE 'CREATE TABLE EMPLOYEE_ADDRESS(
  ADDRESS_ID         NUMBER GENERATED BY DEFAULT AS IDENTITY,
  EMPLOYEE_ID        REFERENCES EMPLOYEE(EMPLOYEE_ID) ON DELETE CASCADE,
  ADDRESS_LINE_1     VARCHAR(255) NOT NULL,
  ADDRESS_LINE_2     VARCHAR(255) NOT NULL,
  ZIP_CODE           NUMBER NOT NULL, 
  CITY_ID            REFERENCES ADDRESS_CITY(CITY_ID) ON DELETE CASCADE,
  PRIMARY KEY(ADDRESS_ID))';
END IF;
SELECT count(*) into nCount FROM user_tables where table_name = 'ORDER_STATUS';
IF(nCount > 0)
THEN
    dbms_output.put_line('TABLE ORDER_STATUS ALREADY EXISTS');
ELSE
    EXECUTE IMMEDIATE 'CREATE TABLE ORDER_STATUS(
  ORDER_ID          NUMBER GENERATED BY DEFAULT AS IDENTITY,
  STATUS_ID         REFERENCES CURRENT_STATUS(STATUS_ID) ON DELETE CASCADE,
  DEALS_ID          REFERENCES DEALS(DEALS_ID) ON DELETE CASCADE,
  EMPLOYEE_ID       REFERENCES EMPLOYEE(EMPLOYEE_ID) ON DELETE CASCADE,
  START_CONDITION   VARCHAR(255),
  END_CONDITION     VARCHAR(255),
  COMMENTS          VARCHAR(255),
  PRIMARY KEY(ORDER_ID))';
  COMMIT;
END IF;  

SELECT count(*) into nCount FROM DBA_ROLES where ROLE ='DB_CUSTOMERS';
IF(nCount > 0)
THEN
    dbms_output.put_line('ROLE DB_CUSTOMERS ALREADY EXISTS');
ELSE
    EXECUTE IMMEDIATE'CREATE ROLE DB_CUSTOMERS';    
    EXECUTE IMMEDIATE'GRANT CREATE SESSION, CONNECT TO DB_CUSTOMERS';   
    EXECUTE IMMEDIATE'GRANT SELECT ON ADDRESS_COUNTRY TO DB_CUSTOMERS';
    EXECUTE IMMEDIATE'GRANT SELECT ON ADDRESS_STATE TO DB_CUSTOMERS';
    EXECUTE IMMEDIATE'GRANT SELECT ON ADDRESS_CITY TO DB_CUSTOMERS';
    EXECUTE IMMEDIATE'GRANT SELECT ON LISTINGS TO DB_CUSTOMERS';
    EXECUTE IMMEDIATE'GRANT SELECT ON LISTING_CATEGORY TO DB_CUSTOMERS';
    EXECUTE IMMEDIATE'GRANT SELECT ON RENTAL_BASIS TO DB_CUSTOMERS';
    EXECUTE IMMEDIATE'GRANT SELECT ON CURRENT_STATUS TO DB_CUSTOMERS';    
    EXECUTE IMMEDIATE'CREATE OR REPLACE PUBLIC SYNONYM ADDRESS_COUNTRY FOR project_admin.address_country';
    EXECUTE IMMEDIATE'CREATE OR REPLACE PUBLIC SYNONYM ADDRESS_CITY FOR project_admin.address_city';
    EXECUTE IMMEDIATE'CREATE OR REPLACE PUBLIC SYNONYM ADDRESS_STATE FOR project_admin.address_STATE';
    EXECUTE IMMEDIATE'CREATE OR REPLACE PUBLIC SYNONYM LISTINGS FOR project_admin.LISTINGS';
    EXECUTE IMMEDIATE'CREATE OR REPLACE PUBLIC SYNONYM LISTING_CATEGORY FOR project_admin.LISTING_CATEGORTY';
    EXECUTE IMMEDIATE'CREATE OR REPLACE PUBLIC SYNONYM RENTAL_BASIS FOR project_admin.RENTAL_BASIS';
    EXECUTE IMMEDIATE'CREATE OR REPLACE PUBLIC SYNONYM CURRENT_STATUS FOR project_admin.CURRENT_STATUS';
    COMMIT;
END IF;
SELECT count(*) into nCount FROM ALL_USERS where USERNAME ='NEW_CUSTOMER';
IF(nCount > 0)
THEN
    dbms_output.put_line('NEW_CUSTOMER USER ALREADY EXISTS');
ELSE
  EXECUTE IMMEDIATE'alter session set "_ORACLE_SCRIPT"=true';  
  EXECUTE IMMEDIATE'create user NEW_CUSTOMER identified by WELCOME';
  EXECUTE IMMEDIATE'GRANT CREATE SESSION,CONNECT TO NEW_CUSTOMER';
  
END IF;
EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line(dbms_utility.format_error_backtrace);
            dbms_output.put_line(SQLERRM);
            ROLLBACK;
            RAISE;
COMMIT;
END;
/

-------------------------------------------------------PROCEDURES----------------------------------------------------------------------------------------------

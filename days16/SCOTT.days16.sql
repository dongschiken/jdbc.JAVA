-- 1 %TYPE�� ����
-- 2 %ROWTYPE�� ����
-- 3 RECORD�� ����



-- TYPE�� ����
DECLARE
    vdeptno dept.deptno%TYPE;
    vdname dept.dname%TYPE;
    vempno emp.empno%TYPE;
    vename emp.ename%TYPE;
    vpay NUMBER;
BEGIN
    SELECT d.deptno, dname, empno, ename, sal + NVL(comm, 0) pay
        INTO vdeptno, vdname, vempno, vename, vpay
    FROM dept d JOIN emp e ON d.deptno = e.deptno
    WHERE empno = 7369;
--EXCEPTION
    
    DBMS_OUTPUT.PUT_LINE(vdeptno || ' ' || vdname || ' ' || vempno || ' ' || vename || ' ' || vpay );
END;

-- ROWTYPE�� ����
DECLARE
    vdrow dept%ROWTYPE;
    verow emp%ROWTYPE;
    vpay NUMBER;
BEGIN
    SELECT d.deptno, dname, empno, ename, sal + NVL(comm, 0) pay
        INTO vdrow.deptno, vdrow.dname, verow.empno, verow.ename, vpay
    FROM dept d JOIN emp e ON d.deptno = e.deptno
    WHERE empno = 7369;
--EXCEPTION
    
    DBMS_OUTPUT.PUT_LINE( vdrow.deptno || ' ' || vdrow.dname || ' ' || verow.empno || ' ' || verow.ename || ' ' || vpay );
END;


DECLARE 
    vdrow dept%ROWTYPE;
    verow emp%ROWTYPE;
    vpay NUMBER;
BEGIN
    SELECT d.deptno, dname, empno, ename, sal
        INTO vdrow.deptno, vdrow.dname, verow.empno, verow.ename, vpay
    FROM dept d JOIN emp e ON d.deptno = e.deptno
    WHERE empno = 7369;
    
    DBMS_OUTPUT.PUT_LINE(vdrow.deptno || ' ' || vdrow.dname || ' ' || verow.empno || ' ' || verow.ename || ' ' || vpay);
END;


-- RECORD�� ����
DECLARE
   -- '�μ���ȣ, �μ���, �����ȣ, �����, �޿�' ���ο� �ϳ��� �ڷ��� ����
   -- ����� ���� ����ü Ÿ�� ����
   TYPE emp_dept_type IS RECORD
   (
    dname dept.dname%TYPE,
    deptno dept.deptno%TYPE,
    empno emp.empno%TYPE,
    ename emp.ename%TYPE,
    pay NUMBER
    );
    vderow emp_dept_type;
BEGIN
    SELECT  dname, d.deptno, empno, ename, sal + NVL(comm, 0) pay
        INTO vderow
    FROM dept d JOIN emp e ON d.deptno = e.deptno
    WHERE empno = 7369;
--EXCEPTION
    
    DBMS_OUTPUT.PUT_LINE( vderow.deptno || ' ' || vderow.dname || ' ' || vderow.empno || ' ' || vderow.ename || ' ' || vderow.pay );
END;


-- 4��
DECLARE
   -- '�μ���ȣ, �μ���, �����ȣ, �����, �޿�' ���ο� �ϳ��� �ڷ��� ����
   -- ����� ���� ����ü Ÿ�� ����
   TYPE emp_dept_type IS RECORD
   (
    deptno dept.deptno%TYPE,
    dname dept.dname%TYPE,
    empno emp.empno%TYPE,
    ename emp.ename%TYPE,
    pay NUMBER
    );
    vderow emp_dept_type;
BEGIN
    SELECT d.deptno, dname, empno, ename, sal + NVL(comm, 0) pay
        INTO vderow
--        INTO vderow.deptno, vderow.dname, vderow.empno, vderow.ename, vderow.pay
    FROM dept d JOIN emp e ON d.deptno = e.deptno
    WHERE empno = 7369;
--EXCEPTION
    
    DBMS_OUTPUT.PUT_LINE( vderow.deptno || ' ' || vderow.dname || ' ' || vderow.empno || ' ' || vderow.ename || ' ' || vderow.pay );
END;

-- Ŀ�� (CURSOR)
1) Ŀ���� ? PL/SQL�� ������ȿ��� ����Ǵ� : SELECT�� �� ��ü�� �ǹ�(�������� ���� ������ �� �ִ� ����)
-- ������ Ŀ�� : SELECT���� �������� 1���� ���, FOR�� SELECT�� (�ڵ����� Ŀ���� �����ȴ�.)
-- ����� Ŀ�� : SELECT���� �������� �������� ���
    ��. CURSOR ���� - ������ SELECT�� �ۼ�
    ��. OPEN       - �ۼ��� SELECT���� ����Ǵ� ���� 
    ��. FETCH      - Ŀ���� ���� �������� ���ڵ带 �о�ͼ� ó��
       FETCH������ �ݺ����� �ݵ�� ���
       �̶��� Ŀ���� �Ӽ��� ��� 
       %ROWCOUNT
       %FOUND
       %NOTFOUND
       %ISOPEN
    ��. CLOSE      
-- ����) ;
-- ����� Ŀ�� + �͸����ν��� �ۼ�, �׽�Ʈ
DECLARE
   TYPE emp_dept_type IS RECORD
   (
    deptno dept.deptno%TYPE,
    dname dept.dname%TYPE,
    empno emp.empno%TYPE,
    ename emp.ename%TYPE,
    pay NUMBER
    );
    vderow emp_dept_type;
    -- 1) Ŀ�� ����
--    CURSOR Ŀ���� IS SELECT
    CURSOR emp_dept IS (
    SELECT d.deptno, dname, empno, ename, sal + NVL(comm, 0) pay
    FROM dept d JOIN emp e ON d.deptno = e.deptno
    );
BEGIN
   -- 2) Ŀ�� ����
   OPEN emp_dept;
   LOOP
    FETCH emp_dept INTO vderow;
    EXIT WHEN emp_dept%NOTFOUND;
    DBMS_OUTPUT.PUT( emp_dept%ROWCOUNT || ' : ' ); 
    DBMS_OUTPUT.PUT_LINE( vderow.deptno || ' ' || vderow.dname || ' ' || vderow.empno 
    || ' ' || vderow.ename || ' ' || vderow.pay );
   
   END LOOP;
   
   -- 4) Ŀ�� �ݱ�
   CLOSE emp_dept;

--EXCEPTION
END;

DECLARE
    TYPE emp_dept IS RECORD
    (
    deptno dept.deptno%TYPE,
    dname dept.dname%TYPE,
    empno emp.empno%TYPE,
    ename emp.ename%TYPE,
    sal NUMBER
    );
    vderow emp_dept;
    CURSOR emp_dept_cursor IS (
        SELECT deptno, dname, empno, ename, sal
        FROM dept d JOIN emp e ON d.deptno = e.deptno
        );
BEGIN
    
    OPEN emp_dept_cursor;
    LOOP
    FETCH emp_dept_cursor INTO vderow;
    EXIT WHEN emp_dept_cursor%NOTFOUND;
    
    DBMS_OUTPUT.PUT_LINE( vderow.deptno || ' ' || vderow.dname || ' ' || vderow.empno || ' ' || vderow.ename || ' ' || vderow.sal );
    END LOOP;
    
--EXCEPTION
END;



-- ��. �Ͻ��� Ŀ��
DECLARE
   TYPE emp_dept_type IS RECORD
   (
    deptno dept.deptno%TYPE,
    dname dept.dname%TYPE,
    empno emp.empno%TYPE,
    ename emp.ename%TYPE,
    pay NUMBER
    );
    vderow emp_dept_type;
    -- 1) Ŀ�� ����
--    CURSOR Ŀ���� IS SELECT
    CURSOR emp_dept IS (
    SELECT d.deptno, dname, empno, ename, sal + NVL(comm, 0) pay
    FROM dept d JOIN emp e ON d.deptno = e.deptno
    );
BEGIN
   -- 2) Ŀ�� ����
  FOR
    vderow IN REVERSE emp_dept
   LOOP
--    FETCH emp_dept INTO vderow;
--    EXIT WHEN emp_dept%NOTFOUND;
    DBMS_OUTPUT.PUT( emp_dept%ROWCOUNT || ' : ' ); 
    DBMS_OUTPUT.PUT_LINE( vderow.deptno || ' ' || vderow.dname || ' ' || vderow.empno 
    || ' ' || vderow.ename || ' ' || vderow.pay );
   
   END LOOP;  
   -- 4) Ŀ�� �ݱ�
--   CLOSE emp_dept;

--EXCEPTION
END;



-- ��. �Ͻ��� Ŀ��

BEGIN
   -- 2) Ŀ�� ����
   -- FOR������ ���Ǵ� vderow������ ���� ���ص� �ȴ�.
  FOR
    vderow IN  (
    SELECT d.deptno, dname, empno, ename, sal + NVL(comm, 0) pay
    FROM dept d JOIN emp e ON d.deptno = e.deptno
    )
   LOOP
--    DBMS_OUTPUT.PUT( vderow%ROWCOUNT || ' : ' ); 
    DBMS_OUTPUT.PUT_LINE( vderow.deptno || ' ' || vderow.dname || ' ' || vderow.empno 
    || ' ' || vderow.ename || ' ' || vderow.pay );
   
   END LOOP;
   

--EXCEPTION
END;


-- ���� ���ν��� ( STORED PROCEDURE )
CREATE OR REPLACE PROCEDURE ���ν�����
(
    �Ű�����( argument, parameter ),
    �Ű�����( argument, parameter ),
    p
)
IS
    v(����);
    v(����);
BEGIN
EXCEPTION
END;


-- ���� ���ν����� �����ϴ� 3���� ���
--1) EXECUTE ������ ����
--2) �͸����ν������� ȣ���ؼ� ����
--3) �� �ٸ� �������ν������� ȣ���ؼ� ����

CREATE TABLE tbl_emp
AS
(SELECT * FROM emp);

SELECT *
FROM tbl_emp;


DELETE FROM tbl_emp
WHERE empno = 9999;
-- �������� �����Ҷ� �Ű��������� ũ��� ������ �ʴ´�. pempno NUMBER
-- ������������ �Ű������� ";"�� ����´�.
CREATE OR REPLACE PROCEDURE up_deltblemp
(
--    pempno IN tbl_emp.empno%TYPE
    pempno tbl_emp.empno%TYPE
)
IS
BEGIN
    DELETE FROM tbl_emp
    WHERE empno = pempno;
    COMMIT;
--EXCEPTION
    -- ROLLBACK;
END;
--Procedure UP_DELTBLEMP��(��) �����ϵǾ����ϴ�.
-- UP_DELTBLEMP(���ν���) ���� ���
-- 1) EXECUTE ������ ����
--*Cause:    Usually a PL/SQL compilation error. : �Ű������� �޶�.
EXECUTE up_deltblemp(7369);
EXECUTE up_deltblemp(pempno=>7499);

-- 2) �͸� ���ν������� ȣ���ؼ� ����
BEGIN
    up_deltblemp(7566);
END;

-- 3) �Ǵٸ� ���ν��� ���� ȣ��
CREATE OR REPLACE PROCEDURE up_deltblemp_test
AS
BEGIN
    up_deltblemp(7521);
END up_deltblemp_test;

EXEC up_deltblemp_test;
--ROLLBACK;

-- ���� dept���̺� -> tbl_dept ���̺� ����

CREATE TABLE tbl_dept
AS (SELECT * FROM dept);

SELECT *
FROM tbl_dept;

-- ���� tbl_dept ���̺� deptno �÷��� �������� ����
ALTER TABLE tbl_dept
ADD CONSTRAINT PK_tbl_deptno PRIMARY KEY(deptno);

-- ����� Ŀ�� + tbl_dept ���̺��� SELECT ���� ���ν��� ����
-- ����
-- up_seltbldept
-- �Ű����� X, ������ ����� Ŀ�� ����
CREATE OR REPLACE PROCEDURE up_seltbldept
IS
   vdrow tbl_dept%ROWTYPE;
   CURSOR dcursor IS (
                         SELECT deptno, dname, loc
                         FROM tbl_dept
                       );
BEGIN 
   OPEN dcursor; 
   LOOP
     FETCH dcursor INTO vdrow; 
     EXIT WHEN dcursor%NOTFOUND;     
     DBMS_OUTPUT.PUT( dcursor%ROWCOUNT || ' : '  );
     DBMS_OUTPUT.PUT_LINE( vdrow.deptno || ', ' || vdrow.dname 
      || ', ' ||  vdrow.loc);  
   END LOOP; 
   CLOSE dcursor;
--EXCEPTION
END;

EXEC UP_SELTBLDEPT;

-- seq_deptno ������ ���� 50/ 10 / NOCYCLE / NO ĳ�� / 90

CREATE SEQUENCE seq_deptno INCREMENT BY 10 START WITH 50 MAXVALUE 90 NOCYCLE NOCACHE;

CREATE OR REPLACE PROCEDURE upinstbldept
(
    pdname IN tbl_dept.dname%TYPE := NULL,
    ploc   IN tbl_dept.loc%TYPE DEFAULT NULL
)
IS
--    vdeptno tbl_dept.deptno%TYPE;
BEGIN
--    SELECT seq_deptno.NEXTVAR
--    SELECT MAX(deptno)+10 INTO vdeptno
--    FROM tbl_dept;
    
--    vdeptno = vdpeptno + 10;
    INSERT INTO tbl_dept ( deptno, dname, loc )
    
    VALUES ( seq_deptno.NEXTVAL, pdname, ploc );
    COMMIT;
--EXCEPTION
END;

SELECT *
FROM tbl_dept;

-- ���� [ up_updtbldept ] �����ϰ����ϴ� �μ���ȣ ��������� dname, loc�� 
EXEC up_updtbldept( 50, 'X', 'Y' );
EXEC up_updtbldept( pdeptno => 50, pdname=> 'QC3' ); -- loc ���� ���ϰ� �״�� ����
EXEC up_updtbldept( pdeptno => 50, ploc=> 'SEOUL' ); -- �μ����� �������ϰ� �״�� ����

CREATE OR REPLACE PROCEDURE up_updtbldept
    
(
    pdeptno IN tbl_dept.deptno%TYPE DEFAULT NULL,
    pdname IN tbl_dept.dname%TYPE DEFAULT NULL,
    ploc   IN tbl_dept.loc%TYPE DEFAULT NULL
)
IS
BEGIN
    
    UPDATE tbl_dept
    SET dname = NVL(pdname, dname)
        , loc = CASE
                WHEN ploc IS NULL THEN loc
                ELSE ploc
                END
    WHERE deptno = pdeptno;
    COMMIT;
END;

-- Ǯ��) UP_SELTBLDEPT ��� �μ�


CREATE OR REPLACE PROCEDURE up_seltblemp
    (
    pdeptno tbl_emp.deptno%TYPE := NULL,
    
    )
IS
   verow tbl_emp%ROWTYPE;
   CURSOR ecursor IS (
                         SELECT *
                         FROM tbl_emp
                         WHERE deptno = NVL(pdeptno, 10)
                       );
BEGIN 
   OPEN ecursor; 
   LOOP
     FETCH ecursor INTO verow; 
     EXIT WHEN ecursor%NOTFOUND;     
     DBMS_OUTPUT.PUT( ecursor%ROWCOUNT || ' : '  );
     DBMS_OUTPUT.PUT_LINE( verow.deptno || ', ' || verow.ename 
      || ', ' ||  verow.hiredate);  
   END LOOP; 
   CLOSE ecursor;
--EXCEPTION
END;

-- ��. Ǯ�� (Ŀ�� �Ķ���͸� �̿��ϴ� ���)
CREATE OR REPLACE PROCEDURE up_seltblemp
    (
    pdeptno tbl_emp.deptno%TYPE := NULL
    
    )
IS
   verow tbl_emp%ROWTYPE;
   CURSOR ecursor IS (
                         SELECT *
                         FROM tbl_emp
                         WHERE deptno = NVL(pdeptno, 10)
                       );
BEGIN 
   OPEN ecursor; 
   LOOP
     FETCH ecursor INTO verow; 
     EXIT WHEN ecursor%NOTFOUND;     
     DBMS_OUTPUT.PUT( ecursor%ROWCOUNT || ' : '  );
     DBMS_OUTPUT.PUT_LINE( verow.deptno || ', ' || verow.ename 
      || ', ' ||  verow.hiredate);  
   END LOOP; 
   CLOSE ecursor;
--EXCEPTION
END;

-- 3�� FOR���� ����ϴ� ���ν���
CREATE OR REPLACE PROCEDURE up_seltblemp
    (
    pdeptno tbl_emp.deptno%TYPE := NULL
    
    )
IS
BEGIN 
    FOR verow IN (
                    SELECT *
                    FROM tbl_emp
                    WHERE deptno = NVL(Pdeptno, 10)
                    )
                    
    LOOP
    DBMS_OUTPUT.PUT_LINE( verow.deptno || ', ' || verow.ename 
    || ', ' ||  verow.hiredate); 
    END LOOP;
--EXCEPTION
END;

-- ���� tbl_dept���̺��� ���ڵ带 �����ϴ� up_deltbldept ����
���ν����� �ۼ�, 50, 60, 70, 80

CREATE OR REPLACE PROCEDURE up_deltbldept
    ( 
    pdeptno tbl_dept.deptno%TYPE := NULL
    )
IS
BEGIN
    DELETE tbl_dept
    WHERE deptno = pdeptno;
--EXCEPTION;
END;
EXEC up_deltbldept(80);
SELECT *
FROM tbl_dept;

EXEC up_updtbldept;
EXEC up_seltblemp(50);
EXEC up_updtbldept( pdname => 'QC');
EXEC UPINSTBLDEPT( ploc => 'SEOUL');
EXEC UPINSTBLDEPT;


-- ���� ���ν���
-- �Է¿� �Ű����� IN
-- ��¿� �Ű����� OUT
-- ����¿� �Ű����� INOUT

SELECT num, name, ssn -- 770221-1*****
FROM insa
WHERE num = 1001;

CREATE OR REPLACE PROCEDURE up_selinsa
(
   pnum IN insa.num%TYPE 
   , pname OUT insa.name%TYPE
   , prrn OUT VARCHAR2
)
IS
    vname insa.name%TYPE;
    vssn insa.ssn%TYPE;
BEGIN
    
    SELECT name, ssn  INTO vname, vssn -- 770221-1*****
    FROM insa
    WHERE num = 1001;
    
    pname := vname;
    prrn := SUBSTR(vssn, 1, 8) || '******';
--EXCEPTION
END;
-- Procedure UP_SELINSA��(��) �����ϵǾ����ϴ�.
DECLARE 
    vname insa.name%TYPE;
    vrrn VARCHAR2(14);
BEGIN
    -- 1001���� �Է¿�
    -- vname, vrr�� ��¿� �Ű������� ���� ���
    up_selinsa(1001, vname, vrrn);
    DBMS_OUTPUT.PUT_LINE( vname || ' ' || vrrn );
--EXCEPTION
END;

-- ��) �ֹε�Ϲ�ȣ 14�ڸ��� �Է¿� �Ű�������
-- ���ڸ� 6�ڸ��� ��¿� �Ű������� ���
CREATE OR REPLACE PROCEDURE up_rrn
(
    prrn IN OUT VARCHAR2 
)
IS
BEGIN
    prrn := SUBSTR(prrn, 1, 6);
--EXCEPTION
END;

DECLARE
    vrrn VARCHAR2(14) := '761230-1700001';
BEGIN
    up_rrn( vrrn );
    DBMS_OUTPUT.PUT_LINE(vrrn) ;
END;


CREATE OR REPLACE PROCEDURE �������ν�����
(
    P �Ķ����,
    P �Ķ����
)
RETURN ���� �ڷ���
IS 
    v ������;
    v ������;
BEGIN
    
    
    RETURN(���ϰ�); 
    
EXCEPTION
END

-- ���� �Լ� ( Stored Function )
CREATE OR REPLACE PROCEDURE 

-- ���� 1) �����Լ� ( �ֹε�� ��ȣ�� �Ű������� ����/���� ���ڿ� ��ȯ�ϴ� �Լ� )
SELECT num, name, ssn
    , DECODE(MOD(SUBSTR(ssn, -7, 1),2), 1, '����', '����') GENDER--�ֹε�Ϲ�ȣ�� ����ؼ� ���� ���
    , UF_GENDER(ssn) gender
    , SCOTT.UF_AGE(ssn, 0) ������
    , SCOTT.UF_AGE(ssn, 1) ���³���
FROM insa;

-- up ���� ���� ���ν���
-- uf ���� ���� �Լ�
-- �Լ� ���� ��밡��
CREATE OR REPLACE FUNCTION uf_gender

(
    prrn IN VARCHAR2 
)

RETURN VARCHAR2

IS
    vgender VARCHAR2(2 CHAR);
BEGIN
    IF MOD(SUBSTR( prrn, -7, 1),2) = 1 THEN vgender := '����' ;
    ELSE vgender := '����' ;
    END IF;
    RETURN (vgender);

--EXCEPTION

END;


CREATE OR REPLACE FUNCTION uf_age

(
    prrn IN VARCHAR2
)

RETURN NUMBER

IS
    vage NUMBER(3);
BEGIN
       vage := TO_CHAR(SYSDATE, 'YYYY') -  CASE 
                                    WHEN SUBSTR(prrn, 8, 1) IN (1, 2, 5, 6) THEN 1900 
                                    WHEN SUBSTR(prrn, 8, 1) IN (3, 4, 7, 9) THEN 2000
                                    ELSE 1800 + CASE 
                                    END + SUBSTR(prrn,1, 2)
                                                SIGN( TO_DATE(SUBSTR(prrn, 3, 4), 'MMDD') - TRUNC(SYSDATE) )
                                                WHEN 1 THEN -1
                                                ELSE 0
                                                END;
    RETURN (vage);
--EXCEPTION
END;



CREATE OR REPLACE FUNCTION uf_age
(
    prrn IN VARCHAR2
    , ptype IN NUMBER -- 1(���³���) 0(������)
)
RETURN NUMBER
IS
    �� NUMBER(4); -- ���س⵵
    �� NUMBER(4); -- ���ϳ⵵
    �� NUMBER(1); -- �������� ���� -1, 0, 1
    vcounting_age NUMBER(3); -- ���³���
    vamerican_age NUMBER(3); -- �� ����
    
BEGIN
    --������ ��� : ���س⵵ - ���ϳ⵵ + ���Ͼ����� ( -1 ) ����
    --���� ����   : ���س⵵ - ���ϳ⵵ + 1;
     �� := TO_CHAR(SYSDATE, 'YYYY');
     �� := CASE 
            WHEN SUBSTR(prrn, 8, 1) IN (1, 2, 5, 6) THEN 1900 
            WHEN SUBSTR(prrn, 8, 1) IN (3, 4, 7, 9) THEN 2000
            ELSE 1800
          END + SUBSTR(prrn, 1, 2);
     �� := SIGN( TO_DATE(SUBSTR(prrn, 3, 4), 'MMDD') - TRUNC(SYSDATE) );
     
     vcounting_age := ��-��+1;
--     vamerican_age := vcounting_age-1 + DECODE( ��, 1, -1, 0);
     vamerican_age := vcounting_age-1 + CASE ��
                                        WHEN 1 THEN-1
                                        ELSE 0
                                        END ;
     IF ptype = 1 THEN RETURN vcounting_age;
     ELSE RETURN vamerican_age;
     END IF;
--EXCEPTION

END;

-- �ֹε�Ϲ�ȣ -> 1998.01.20(ȭ����)

CREATE OR REPLACE FUNCTION uf_birth
(
    prrn VARCHAR2
)   
RETURN VARCHAR2

IS
    vcentry NUMBER(2); -- 19, 20 ����
    vbirth VARCHAR2(20); -- 1998.01.20(ȭ)
BEGIN
    vbirth := SUBSTR( prrn, 1, 6 );
    vcentry := CASE 
               WHEN SUBSTR( prrn, -7, 1 ) IN( 1, 2, 5, 6 ) THEN 19
               WHEN SUBSTR( prrn, -7, 1 ) IN(3, 4, 7, 8 ) THEN 20
               ELSE 18
               END;
    vbirth := vcentry || vbirth;
    vbirth := TO_CHAR(TO_DATE( vbirth, 'YYYYMMDD'), 'YYYY.MM.DD(DY)');
    RETURN vbirth;
--EXCEPTINO
END;
-- Function UF_BIRTH��(��) �����ϵǾ����ϴ�.
SELECT name, ssn
    , SCOTT.UF_BIRTH( ssn )
FROM insa;

SELECT POWER(2,3), POWER(2,-3)
    , SCOTT.UF_POWER(2,10)
    , SCOTT.UF_POWER(2,-3)
FROM dual;


CREATE OR REPLACE FUNCTION uf_power
(
    pnum1 NUMBER,
    pnum2 NUMBER
)
RETURN NUMBER
IS
    vnum1 NUMBER;
    vnum2 NUMBER;
BEGIN
    
    vnum1 := pnum1;
    vnum2 := ABS(pnum2);
        FOR i IN 1..vnum2-1
        LOOP
        vnum1 := vnum1 * pnum1;
    END LOOP;
    IF pnum2 < 0 
    THEN RETURN 1/vnum1;
    ELSE RETURN vnum1;
    END IF;
--EXCEPTION
END;


SELECT t.name, t.ssn
        , t.���س⵵ - t.���ϳ⵵ + CASE ����üũ
                                    WHEN 1 THEN -1
                                    ELSE 0
                                  END E
FROM(
    SELECT name, ssn
        , TO_CHAR(SYSDATE, 'YYYY') ���س⵵ 
    --    , SUBSTR(ssn, 8, 1)  ����
    --    , SUBSTR(ssn, 1, 2)  ���ϳ⵵
        , CASE 
            WHEN SUBSTR(ssn, 8, 1) IN (1, 2, 5, 6) THEN 1900 
            WHEN SUBSTR(ssn, 8, 1) IN (3, 4, 7, 9) THEN 2000
            ELSE 1800
          END + SUBSTR(ssn, 1, 2) ���ϳ⵵
        , SIGN( TO_DATE(SUBSTR(ssn, 3, 4), 'MMDD') - TRUNC(SYSDATE) ) ����üũ
    FROM insa
    ) t;


-- IN/OUT ����¿� �Ķ����(�Ű�����)
-- �����Լ� ( Stored Function )
-- ����
-- �ּ�ó��
-- ��� ����� ���� ��ȸ
-- ���� ���� �� ���� �ڵ��ϸ� ������, ���������� ����??
-- keyword�� �빮�ڷ� �ԷµǴ°��� ����ȴ�.
-- ���̺��, �÷����� �ҹ��� ����� ����ȴ�.
-- �������� ���ؼ� tabŰ �Ǵ� �ٸ��� ����� ����ȴ�.
SELECT   * 
FROM     all_users; -- Ctrl + Enter �Ǵ� f5 : ������ ����

select * 
fRom ALL_users;    

-- �����߿� ����� ������ ����, ����, ���� --
-- 1) SCOTT ���� ���� Ȯ��

SELECT *
FROM all_users;

-- 2) SCOTT ������ ����
CREATE USER SCOTT IDENTIFIED BY tiger;


-- 3) SCOTT ������ ��й�ȣ�� 1234�� ����
-- ALTER USER SCOTT IDENTIFIED BY 1234;

DROP USER SCOTT CASCADE;

-- 4)�ְ������ ������ SCOTT ������ CREATE SESSION �����ͺ��̽��� ���� �ý��� ������ �ο��Ѵ�.
--GRANT CREATE SESSION TO SCOTT;
-- student_role�� ROLE�� ����� SCOTT�� �� ROLE�� �Ѱܼ� �ý��� ������ �ο��ѹ��
GRANT CREATE SESSION TO student_role;
GRANT student_role TO SCOTT;

GRANT CONNECT, RESOURCE TO SCOTT;

-- CREATE USER, DROP USER, ALTER USER;
-- CREATE TABLESPACE, DROP TABLESPACE, ALTER TABLESPACE;
-- CREATE ROLE, DROP ROLE, ALTER ROLE;

-- ���� : ����Ŭ ��ġ�ÿ� �̸� ���ǵ� ��(role)�� Ȯ���ϴ� ���� �ۼ��Ͻÿ� (32���� �⺻ role ��ȸ��)
SELECT *
FROM dba_roles;


SELECT grantee,privilege 
FROM DBA_SYS_PRIVS 
WHERE grantee = 'CONNECT'; 

-- C:\oraclexe\app\oracle\product\11.2.0\server\rdbms\admin  // SCOTT ��������
SP2-0157: unable to CONNECT to ORACLE after 3 attempts, exiting SQL*Plus

C:\Users\user>sqlplus sys/ss123$@localhost:1521/XE AS SYSDBA

SQL*Plus: Release 11.2.0.2.0 Production on ȭ 2�� 13 15:24:21 2024

Copyright (c) 1982, 2014, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Express Edition Release 11.2.0.2.0 - 64bit Production

-- SCOTT���� �����ϱ� ���� ��й�ȣ tiger�� �ٲٰ� cmdâ���� SYS�� �α��� �� �Ŀ� 
-- ���� ����� �Ἥ SCOTT���� �ٽ� �� �α���
--SQL> C:\oraclexe\app\oracle\product\11.2.0\server\rdbms\admin\scott.sql
--SP2-0024: Nothing to change.
--SQL> @C:\oraclexe\app\oracle\product\11.2.0\server\rdbms\admin\scott.sql
--SQL> SHOW USER
--USER is "SCOTT"
--SQL> SHOW USER
--USER is "SCOTT"
--SQL>

-- ���� sys�� �ƴ϶� SCOTT���� ���� �Ŀ� SCOTT.SQL �����ؼ� ������� ���̺� Ȯ��
SELECT *
FROM tabs;

SELECT *
FROM dba_tables;

-- �����͸� ������ �ִ� ����
SELECT COUNT(*) -- 2551��
SELECT *
FROM dictionary;

CREATE USER madang IDENTIFIED BY madang DEFAULT TABLESPACE users TEMPORARY
TABLESPACE temp PROFILE DEFAULT;
GRANT CONNECT, RESOURCE TO madang;
GRANT CREATE VIEW, CREATE SYNONYM TO madang;
GRANT UNLIMITED TABLESPACE TO madang;


SELECT *
FROM dba_users;

--CREATE USER SCOTT IDENTIFIED BY tiger;

ALTER USER HR IDENTIFIED BY lion;

-- HR ���� Ȯ�� --
-- 1) HR ������ ��й�ȣ�� lion���� �����ϰ� ����
-- 2) HR ������ �ҿ��ϰ� �ִ� ���̺� ����� ��ȸ...
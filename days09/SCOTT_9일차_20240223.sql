-- SCOTT
-- ����Ŭ �ڷ���
-- CHAR �������� 2000byte
-- N + CHAR �������� 2000byte
-- VAR + CHAR2 �������� 4000byte
-- N + VAR + CHAR2 �������� 4000byte
-- LONG 2GB



-- 1) NUMBER [(p)[,s]]
--  p(���е�) : 1~38 ��ü �ڸ��� (�Ҽ��� ���Ͽ����� .0012 ���� 00�� ��ü �ڸ����� �Ⱥ��� ������ ��ü �ڸ����� 2���� �ȴ�. )
--  s(�Ը�)   : -84~127 �Ҽ��� ���� �ڸ���
DESC dept;

INSERT INTO dept (deptno, dname, loc) VALUES ( 100, 'QC', '����' );
INSERT INTO dept (deptno, dname, loc) VALUES ( -20, 'QC', '����' );
ROLLBACK;

DEPTNO NUMBER(2) == NUMBER(2,0) == 2�ڸ� ���� ==> -99 ~ 99 ����
KOR    NUMBER(3) == NUMBER(3,0) == 3�ڸ� ���� ==> -999 ~ 999 ����

SELECT *
FROM dept;



-- ���� ������ �����ϰ� �߻��ؼ� ����
INSERT INTO �������̺� ( kor, eng, mat)
VALUES (SYS.dbms_random.value(0,100), SYS.dbms_random.value(0,100), SYS.dbms_random.value(0,100) );

SELECT *
FROM  tbl_score;

-- �й�(PK), �л���, ����, ����, ����, ����, ���, ���
CREATE TABLE tbl_score
(
     no     NUMBER(2,0) PRIMARY KEY NOT NULL  -- PRIMARY KEY ==> NOT NULL�� UK(���ϼ� ��������)�� ���� �����ȴ�.
    ,name   VARCHAR2(30) NOT NULL  
    ,kor    NUMBER(3)
    ,eng    NUMBER(3)
    ,mat    NUMBER(3)
    ,tot    NUMBER(3)
    ,avg    NUMBER(5,2)
    ,rk     NUMBER(2)

);


INSERT INTO tbl_score ( no, name, kor, eng, mat ) VALUES ( 1, 'ȫ�浿', 90, 87, 88.89 );
--INSERT INTO tbl_score ( no, name, kor, eng, mat ) VALUES ( 2, '������', 990, -88, 65 );
INSERT INTO tbl_score ( no, name, kor, eng, mat ) VALUES ( 2, '������', 99, 88, 65 );
--INSERT INTO tbl_score ( no, name, kor, eng, mat ) VALUES ( 3, '�躴��', 1999, 68, 82 ); --  value larger than specified precision allowed for this column
INSERT INTO tbl_score ( no, name, kor, eng, mat ) VALUES ( 3, '�躴��', 19, 68, 82 );
COMMIT;
ROLLBACK;
DESC tbl_score;


UPDATE tbl_score
SET eng = 0
WHERE no = 2;
INSERT INTO tbl_score ( no, name, kor, eng, mat ) VALUES ( 2, '������', 99, 88, 65 );

UPDATE tbl_score
SET tot = kor + eng + mat, avg = (kor+eng+mat)/3, rk = 1;

UPDATE tbl_score p
SET p.rk = ( SELECT COUNT(*)+1 FROM tbl_score c WHERE c.tot > p.tot );



-- FLOAT(P) ���� �ڷ���, ���������� NUMBER ó��


-- ��¥ �ڷ���
1) DATE      : 7����Ʈ, ��������, �� ���� ����
2) TIMESTAMP : �⺻�� 6 ����Ʈ( �� �Ʒ� 6�ڸ� ���� ) 0 ~ 9 ����Ʈ ����


-- ���� ������ �ڷ�     ???.png (�̹���)�� 101010101010101010 ���� �����͸� �����ϰ� ������
1) RAW(SIZE)  2000byte ���� ����
2) LONG RAW   2GB ���� ����


B + FILE    Binary �����͸� �ܺο� file���·� (264 -1����Ʈ)���� ���� 
B + LOB    Binary �����͸� 4GB���� ���� (4GB= (232 -1����Ʈ)) 
C + LOB    Character �����͸� 4GB���� ���� 
NC + LOB    Unicode �����͸� 4GB���� ���� 

-- �����Լ� COUNT()�� single�� ���� ����Ϸ��� COUNT() OVER() ����ϸ� �ȴ�
SELECT buseo, name, basicpay
--    , COUNT(*) OVER(ORDER BY basicpay ASC)
    , COUNT(*) OVER(PARTITION BY buseo ORDER BY basicpay ASC) "1"
    , SUM(basicpay) OVER(ORDER BY basicpay ASC) "2"
    , (SELECT COUNT(*) FROM insa) "3"
    , SUM(basicpay) OVER(PARTITION BY buseo ORDER BY basicpay ASC) "4"
    , AVG(basicpay) OVER(ORDER BY basicpay ASC) "5"
    , AVG(basicpay) OVER(PARTITION BY buseo ORDER BY basicpay ASC) "6"
FROM insa;



-- �� ������ �޿� ���
SELECT city, name, basicpay
--    , AVG(basicpay)
    , ROUND(AVG(basicpay) OVER( PARTITION BY city ORDER BY city ASC),2) "1"
    , basicpay - ROUND(AVG(basicpay) OVER( PARTITION BY city ORDER BY city ASC),2) "2"
FROM insa;



-- [ ���̺� ����, ����, ���� ] + ���̺� ���ڵ� �߰�, ����, ���� 

1) ���̺� ? : ������ �����
2) DB �𵨸� -> ���̺� ����
 ��) �Խ����� �Խñ��� �����ϱ� ���� ���̺� ����
    ��. ���̺�� : tbl_board
    ��. ���� �÷���  ������ �÷���     �ڷ���
        �۹�ȣ (PK)    seq            NUMBER P38 S127        NOT NULL
        �ۼ���         wirter         VARCHAR2(20)           NOT NULL
        ��й�ȣ       password       VARCHAR2(15)           NOT NULL
        ����          title          VARCHAR2(100)          NOT NULL
        ����          contente        CLOB
        �ۼ���         regdate         DATE                 DEFAULT SYSDATE
        ��ȸ��         readno          NUMBER(100000000)    DEFAULT 0
        
        
        
        
        
�����������ġ�
    CREATE [GLOBAL TEMPORARY] TABLE [schema.] table
      ( 
        ���̸�  ������Ÿ�� [DEFAULT ǥ����] [��������] 
       [,���̸�  ������Ÿ�� [DEFAULT ǥ����] [��������] ] 
       [,...]  
      ); 


ex)
-- TEMPORARY : �ӽ�
--CREATE GLOBAL TEMPORARY TABLE tbl_board
--(
--
--    seq          NUMBER       NOT NULL PRIMARY KEY
--    ,writer      VARCHAR(20)  NOT NULL
--    ,passwd      VARCHAR(10)  NOT NULL
--    ,title       VARCHAR(100) NOT NULL
--    ,content     CLOB
--    ,regdate     DATE         DEFAULT SYSDATE
--
--);


CREATE TABLE tbl_board
(

    seq          NUMBER       NOT NULL PRIMARY KEY
    ,writer      VARCHAR(20)  NOT NULL
    ,passwd      VARCHAR(10)  NOT NULL
    ,title       VARCHAR(100) NOT NULL
    ,content     CLOB
    ,regdate     DATE         DEFAULT SYSDATE

);

DESC tbl_board;


-- ���̺� ���� : CREATE TABLE (DDL)
-- ���̺� ���� : DROP TABLE (DDL)
-- ���̺� ���� : ALTER TABLE (DDL)
--? alter table ... add �÷�, �������� �߰�
--? alter table ... modify �÷� ����
--? alter table ... drop[constraint] �������� ���� 
--? alter table ... drop column �÷� ����

SELECT *
FROM tbl_board;

ROLLBACK;
INSERT INTO tbl_board (seq, writer, passwd, title, content, regdate)
VALUES (1, 'ȫ�浿', '1234', 'test-1', 'test-1', SYSDATE);

INSERT INTO tbl_board (seq, writer, passwd, title, content, regdate)
VALUES (2, '�Ǹ���', '1234', 'test-2', 'test-2', SYSDATE);

INSERT INTO tbl_board 
VALUES (3, '�迵��', '1234', 'test-3', 'test-3', SYSDATE);

INSERT INTO tbl_board (seq, writer, passwd, title, content)
VALUES (4, '�̵���', '1234', 'test-4', 'test-4');

INSERT INTO tbl_board (seq, writer, passwd, title, content, regdate )
VALUES (5, '�̽���', '1234', 'test-5', 'test-5', null);
COMMIT;

-- ���������̸��� �����ؼ� ���������� ������ �� �ְ�
-- ���������̸��� �������� ������ SYS_XXXX �̸����� �ڵ� �ο��ȴ�,
-- �������� �̸� : SCOTT.SYS_C007034
SELECT *
--FROM tabs;
FROM user_constraints
WHERE table_name LIKE '%BOARD%';

ALTER TABLE tbl_board
ADD readed NUMBER DEFAULT 0; -- ���� �÷��� �߰��� ��� () ���� �����ϴ�.
ADD()


INSERT INTO tbl_board ( writer, seq, passwd, title)
VALUES                ('�̻���' , (SELECT NVL(MAX(seq),0)+1 FROM tbl_board), '1234', 'test-6');
COMMIT;


-- content�� null�� ��� " �������"

UPDATE tbl_board
SET content = '�������'
WHERE content IS NULL;



-- �Խ����� �ۼ��� ( writer NOT NULL VARCHAR2(20) -> VARCHAR(40) )
DESC tbl_board;

-- ���̺� ����
-- ���̺� �����Ҷ��� ���������� ������ �� ����.(NOT NULL�� ���������̶� ���� �Ұ���)
-- ���� -> ���� �߰��ϸ� �����ϴ� ��ó�� �ȴ�.
--ALTER TABLE tbl_board
--MODIFY ( WRITER NOT NULL VARCHAR(40) );
ALTER TABLE tbl_board
MODIFY ( WRITER VARCHAR(40) );


-- �÷����� ���� ( title -> subject )
-- ���������� ������ �Ұ��� �ϰ� ��Ī(alias)�� �༭ �����Ѱ� ó�� ��� �����ϴ�. 
SELECT title AS subject , content
FROM tbl_board;

-- �÷����� �����ϴ� ��� RENAME COLUMN ���
ALTER TABLE tbl_board
RENAME COLUMN title TO subject;

-- �÷� �߰�
ALTER TABLE tbl_board
ADD bigo VARCHAR2(100);


DESC tbl_board;

SELECT *
FROM tabs;

-- �÷� ����
ALTER TABLE tbl_board
DROP COLUMN bigo;

-- ���̺��� �̸��� tbl_board -> tbl_test�� ����
RENAME tbl_board TO tbl_test;


DROP TABLE tbl_test;


-- ���̺� �����ϴ� ���
--subquery�� �̿��� ���̺� ����
--���� ���̺� ���ϴ� �����Ͱ� �̹� ������ ��� subquery�� �̿��Ͽ� ���̺��� �����Ѵٸ� ���̺� ������ ������ �Է��� ���ÿ� �� �� �ִ�.
--�����ġ�
--	CREATE TABLE ���̺�� [�÷��� (,�÷���),...]
--	AS subquery;
--? �ٸ� ���̺� �����ϴ� Ư�� �÷��� ���� �̿��� ���̺��� �����ϰ� ���� �� ���
--? Subquery�� ��������� table�� ������
--? �÷����� ����� ��� subquery�� �÷����� ���̺��� �÷����� �����ؾ� �Ѵ�.
--? �÷��� ������� ���� ���, �÷����� subquery�� �÷���� ���� �ȴ�.
--? subquery�� �̿��� ���̺��� ������ �� CREATE TABLE ���̺�� �ڿ� �÷����� ����� �ִ� ���� ����

-- ��) emp ���̺��� �̿��ؼ� 30�� �μ������� empno, ename, hiredate, job�� ���ο� ���̺� ����

CREATE TABLE tbl_emp30 (no, name, hdate, job, pay)
AS 
(
    SELECT empno, ename, hiredate, job, sal + NVL(comm,0) pay
    FROM emp
    WHERE deptno = 30
);

DESC tbl_emp30;

SELECT *
FROM user_constraints
WHERE table_name LIKE '%EMP%';


-- ��) ���� ���̺� -> ���ο� ���̺� ���� + ���ڵ� X ���� ���̺��� ������ ����
CREATE TABLE tbl_emp20
AS
    (
        SELECT *
        FROM emp
        WHERE 1 = 0
    );
    
SELECT *
FROM tbl_emp20;

DROP TABLE tbl_empgrade;
SELECT *
FROM salgrade;

SELECT *
FROM emp;
-- ���� emp, dept, salgrade ���̺��� �̿��ؼ�
-- deptno, dname, empno, ename, hiredate, pay, grede �÷��� ���� ���ο� ���̺� ����

CREATE TABLE tbl_empgrade
AS
    (
    SELECT d.deptno, dname, empno, ename, hiredate, sal + NVL(comm, 0) pay
        , s.losal || ' - ' || s.hisal sal_grade , grade
    FROM dept d ,emp e , salgrade s 
    WHERE d.deptno = e.deptno  AND e.sal BETWEEN s.losal AND s.hisal
    );


SELECT d.deptno, dname, empno, ename, hiredate, sal + NVL(comm, 0) pay
    , s.losal || ' - ' || s.hisal , grade
FROM dept d JOIN emp e ON d.deptno = e.deptno 
            JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal;
            
            
SELECT d.deptno, dname, empno, ename, hiredate, sal + NVL(comm, 0) pay
    , s.losal || ' - ' || s.hisal , grade
FROM dept d ,emp e , salgrade s 
WHERE d.deptno = e.deptno  AND e.sal BETWEEN s.losal AND s.hisal
            

SELECT *
FROM tbl_empgrade;

DROP TABLE tbl_empgrade;
PURGE RECYCLEBIN -- ������ ���� ���

-- ���̺� ���� + ���� ����( ������ ���� )
DROP TABLE tbl_empgrade PURGE; -- ���� ���̺� ����


-- [ MultiTable INSERT�� ] 4���� ���� 
-- 1) UNCONDITIONAL INSERT ALL    : ������ ���� INSERT ALL 
CREATE TABLE tbl_dept10 AS ( SELECT * FROM dept WHERE 1 = 0); -- WHERE���� ������ �Ǵ°� �ָ� INSERT�Ҷ� ���̺��� ���� �������� �ʴ´�.
CREATE TABLE tbl_dept20 AS ( SELECT * FROM dept WHERE 1 = 0);
CREATE TABLE tbl_dept30 AS ( SELECT * FROM dept WHERE 1 = 0);
CREATE TABLE tbl_dept40 AS ( SELECT * FROM dept WHERE 1 = 0);


--  ��� ���̺� INSERT �ϰ������ ���������� �Բ� �ָ� ��� ���̺� �������� ���� �����ϰ� �ִ´�.
INSERT ALL
INTO tbl_dept10 VALUES (deptno, dname, loc)
INTO tbl_dept20 VALUES (deptno, dname, loc)
INTO tbl_dept30 VALUES (deptno, dname, loc)
INTO tbl_dept40 VALUES (deptno, dname, loc)
SELECT deptno, dname, loc
FROM dept;


SELECT *
FROM tbl_dept40;

-- 2) CONDITIONAL INSERT ALL      : ������ �ִ� INSERT ALL

CREATE TABLE tbl_emp10 AS ( SELECT * FROM emp WHERE 1 = 0 );

CREATE TABLE tbl_emp20 AS ( SELECT * FROM emp WHERE 1 = 0 );

CREATE TABLE tbl_emp30 AS ( SELECT * FROM emp WHERE 1 = 0 );

CREATE TABLE tbl_emp40 AS ( SELECT * FROM emp WHERE 1 = 0 );


INSERT ALL
    WHEN deptno = 10 THEN
        INTO tbl_emp10 VALUES(empno, ename, job, mgr, hiredate, sal, comm, deptno)
    WHEN deptno = 10 THEN
        INTO tbl_emp20 VALUES(empno, ename, job, mgr, hiredate, sal, comm, deptno)
    WHEN deptno = 10 THEN
        INTO tbl_emp30 VALUES(empno, ename, job, mgr, hiredate, sal, comm, deptno)
    WHEN deptno = 10 THEN
        INTO tbl_emp40 VALUES(empno, ename, job, mgr, hiredate, sal, comm, deptno)
SELECT * FROM emp;

SELECT * FROM tbl_emp10;

-- 3) CONDITIONAL FIRST INSERT    : ������ �ִ� INSERT ALL

INSERT FIRST
    WHEN deptno = 10 THEN
        INTO tbl_emp10 VALUES()
    WHEN job = 'CLERK' THEN
        INTO tbl_emp_clerk VALUES()
    ELSE ������
        INTO tbl_else VALUES()
SELECT * FROM emp;

SELECT * FROM emp
WHERE deptno = 10 AND job = 'CLERK';

-- 4) PIVOTING INSERT             
CREATE TABLE sales(
employee_id        NUMBER(6),       -- �ǸŸ� �� ��� �ѹ�
week_id            NUMBER(2),       -- �Ǹ��� ��
sales_mon          number(8,2),     -- ������ �Ǹ� ����
sales_tue          number(8,2),     
sales_wed          number(8,2),
sales_thu          number(8,2),
sales_fri          number(8,2));    -- �ݿ��� �Ǹ� ����


insert into sales values(1101,4,100,150,80,60,120);
insert into sales values(1102,5,300,300,230,120,150);
COMMIT;
SELECT *
FROM sales;

-- 

create table sales_data(
employee_id        number(6),
week_id            number(2),
sales              number(8,2));

-- PIVOT INSERT�� // ���η� �Ǿ��ִ� ������ ���η� �ٲ㼭 �ֱ�
INSERT ALL
    INTO sales_data VALUES( employee_id, week_id, sales_mon )
    INTO sales_data VALUES( employee_id, week_id, sales_tue )
    INTO sales_data VALUES( employee_id, week_id, sales_wed )
    INTO sales_data VALUES( employee_id, week_id, sales_thu )
    INTO sales_data VALUES( employee_id, week_id, sales_fri )
SELECT employee_id, week_id, sales_mon , sales_tue , sales_wed , sales_thu , sales_fri  
FROM sales;

SELECT *
FROM sales_data;

DROP TABLE sales; -- ���̺� ��ü�� ����
DELETE FROM sales_data; -- ���̺� ���� ��� ���ڵ�(����) ����
SELECT * FROM sales_data;

TRUNCATE TABLE sales_date; -- ���̺� ���� ��� ���ڵ� ����
-- �ѹ��� �� ���� sql���� TRUNCATE ==> �ڵ����� COMMIT�� �ȴ�.

DROP TABLE sales_data PURGE;
COMMIT;


-- ���� 


SYS.dbms_random.value(0,101)
[����1] insa ���̺��� num, name �÷����� �����ؼ� 
      ���ο� tbl_score ���̺� ����
      (  num <= 1005 )
      
CREATE TABLE tbl_score AS (SELECT num, name FROM insa WHERE num <= 1005);

[����2] tbl_score ���̺�   kor,eng,mat,tot,avg,grade, rank �÷� �߰�
( ����   ��,��,��,������ �⺻�� 0 )
(       grade ���  char(1 char) )

ALTER TABLE tbl_score 
ADD (    
    
    kor     NUMBER(3) default 0
    ,eng    NUMBER(3) default 0
    ,mat    NUMBER(3) default 0
    ,tot    NUMBER(3) default 0
    ,avg    NUMBER(5,2)
    ,rk     NUMBER(2) 
    ,grade  CHAR(1 char) 
)
   

[����3] 1001~1005 
  5�� �л��� kor,eng,mat������ ������ ������ ����(UPDATE)�ϴ� ���� �ۼ�.
  UPDATE tbl_score
  SET  kor = TRUNC(SYS.dbms_random.value(0,101))
      ,eng = TRUNC(SYS.dbms_random.value(0,101))
      ,mat = TRUNC(SYS.dbms_random.value(0,101));
      
[����4] 1005 �л��� k,e,m  -> 1001 �л��� ������ ���� (UPDATE) �ϴ� ���� �ۼ�.

UPDATE tbl_score
SET kor = (SELECT kor FROM tbl_score WHERE num = 1001)
    ,eng = (SELECT eng FROM tbl_score WHERE num = 1001)
    ,mat = (SELECT mat FROM tbl_score WHERE num = 1001)
WHERE num = 1005;
COMMIT;
ROLLBACK;


[����5] ��� �л��� ����, ����� ����...
     ( ���� : ����� �Ҽ��� 2�ڸ� )

UPDATE tbl_score
SET tot = kor + eng + mat
    ,avg = (kor+eng+mat)/3
    ,rk = 1;

SELECT *
FROM SALGRADE;

[����6] ���(grade) CHAR(1 char)  'A','B','c', 'D', 'F'
--  90 �̻� A
--  80 �̻� B
--  0~59   F  

INSERT ALL
    WHEN avg >= 90 THEN
         INTO tbl_score (grade) VALUES( 'A' )
    WHEN avg >= 80 THEN
         INTO tbl_score (grade) VALUES( 'B' )
    WHEN avg >= 70 THEN
         INTO tbl_score (grade) VALUES( 'C' )
    WHEN avg >= 60 THEN
         INTO tbl_score (grade) VALUES( 'D' )
    WHEN avg >= 0 THEN
         INTO tbl_score (grade) VALUES( 'E' )
SELECT * FROM tbl_score ;


SELECT avg, DECODE ( TRUNC(avg/10), 10, 'A', 9, 'A', 8, 'B', 7, 'C', 6, 'D', 'F')
FROM tbl_score;


UPDATE tbl_score
SET grade = DECODE ( TRUNC(avg/10), 10, 'A', 9, 'A', 8, 'B', 7, 'C', 6, 'D', 'F')


[����7] tbl_score ���̺��� ��� ó��.. ( UPDATE) 

UPDATE tbl_score s
--SET s.rk = (SELECT COUNT(*)+1 FROM tbl_score c WHERE c.avg > s.avg);
SET rk = (
            SELECT t.r
            FROM (
            
                SELECT num, tot, RANK() OVER(ORDER BY tot DESC) r
                FROM tbl_score
                
            ) t
            WHERE t.num = s.num
         );

SELECT empno, ename, sal
    , ROW_NUMBER() OVER( ORDER BY sal DESC ) rn_rank
    , RANK() OVER(ORDER BY sal DESC ) r_rank
    , DENSE_RANK() OVER(ORDER BY sal DESC ) r_rank
FROM emp;

COMMIT;
SELECT * 
FROM tbl_score;

ROLLBACK;
UPDATE tbl_score
SET eng = CASE
            WHEN eng+30 >= 100 THEN 100
            ELSE eng+30
          END; 
          
          
-- [ ���� ] 1001 ~ 1005 �л� �߿� ���л��鸸 5���� ����...

UPDATE tbl_score
SET kor = kor+5
WHERE num = ANY ( (SELECT num FROM insa WHERE MOD(SUBSTR(ssn, 8, 1),2) = 1) );
WHERE num IN( (SELECT num FROM insa WHERE MOD(SUBSTR(ssn, 8, 1),2) = 1) );





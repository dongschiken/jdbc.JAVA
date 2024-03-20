-- SCOTT
create table tbl_emp(
    id number primary key, 
    name varchar2(10) not null,
    salary  number,
    bonus number default 100
    );
-- Table TBL_EMP��(��) �����Ǿ����ϴ�.

insert into tbl_emp(id,name,salary) values(1001,'jijoe',150);
insert into tbl_emp(id,name,salary) values(1002,'cho',130);
insert into tbl_emp(id,name,salary) values(1003,'kim',140);
COMMIT;
select * 
from tbl_emp;


create table tbl_bonus
    (id number
    , bonus number default 100
    );
    
    
insert into tbl_bonus(id)
 (select e.id from tbl_emp e);
 
select * from tbl_bonus;

INSERT INTO tbl_bonus VALUES(1004, 50);
COMMIT;

MERGE INTO tbl_bonus b 
USING (SELECT id, salary FROM tbl_emp) e
ON (b.id = e.id) 
WHEN MATCHED THEN  --- ��ġ�ϸ� UPDATE
    UPDATE SET b.bonus = b.bonus + e.salary * 0.01
WHEN NOT MATCHED THEN --- ��ġ���� ������ INSERT
    INSERT (b.id, b.bonus) VALUES(e.id, e.salary * 0.01)
;



CREATE TABLE tbl_merge1
    ( id NUMBER PRIMARY KEY
    , name VARCHAR2(20)
    , pay NUMBER
    , sudang NUMBER
    );

CREATE TABLE tbl_merge2
    ( id NUMBER PRIMARY KEY
    , sudang NUMBER
    );

INSERT INTO tbl_merge1 VALUES( 1, 'a', 100, 10);
INSERT INTO tbl_merge1 VALUES( 2, 'b', 150, 20);
INSERT INTO tbl_merge1 VALUES( 3, 'c', 130, 0);

INSERT INTO tbl_merge2 VALUES( 2, 5);
INSERT INTO tbl_merge2 VALUES( 3, 10);
INSERT INTO tbl_merge2 VALUES( 4, 20);

COMMIT;

SELECT *
--FROM tbl_merge1;
FROM tbl_merge2;

-- MERGE : tbl_merge1 ( �ҽ� ) -> tbl_merge2 ( Ÿ�� ) ����
--              1                      INSERT
--              2, 3                   UPDATE
ROLLBACK;
MERGE INTO tbl_merge2 t2
USING (SELECT id, pay, sudang FROM tbl_merge1) t1
ON (t1.id = t2.id)
WHEN MATCHED THEN
    UPDATE SET t2.sudang = t2.sudang + t1.sudang
WHEN NOT MATCHED THEN
    INSERT (t2.id, t2.sudang) VALUES ( t1.id, t1.sudang)
    


-- ���� ����( CONSTRAINT )
-- SCOTT �� �����ϰ� �ִ� ���̺� ��ȸ
SELECT *
FROM user_tables;

-- SCOTT�� �����ϰ� �ִ� �������� ��ȸ
SELECT *
FROM user_constraints
WHERE table_name  =  UPPER('emp');

-- ���������� ���̺� INSERT / UPDATE / DELETE �Ҷ��� ��Ģ���� ��� -> ������ ���Ἲ(�ùٸ� �����Ͱ� ������)�� ���ؼ�
INSERT INTO dept VALUES( 10, 'QC', 'SEOUL' ); <- -- ��ü ���Ἲ�� ����

UPDATE emp
SET deptno = 90
WHERE empno = 7369; <- --integrity constraint (SCOTT.FK_DEPTNO) violated - parent key not found : ���� ���Ἲ ����

tbl_score
    kor  0~100 ���� ��������

INSERT INTO tbl_score kor VALUES  ( 111 ) <- --������ ���Ἲ

-- ���������� �����ϴ� �ñ⿡ ����
    ��. CREATE TABLE �� : ���̺� ���� + �������� �߰� / ����
        1. IN-LINE ��������     (= �÷� ���� ) �������� ���� ���
            - NOT NULL �������� ����
            - �ϳ��� �÷��� ���������� ������ ��
        2. OUT-OF-LINE �������� (= ���̺� ����) �������� ���� ���   
            - �ΰ� �̻��� �÷��� ���������� ������ ��...
            [ ��� �޿� ���� ���̺� ]
            �޿� ���� ��¥ + ȸ�� ID ==> PK�� ����(����Ű)  2024/01/25+7369 
            ������ �߰��ؼ� ����Ű ���� ������ PK�� ����ϰ� �ϴ� ���( �� ����ȭ )
            ���� �޿� ���� ��¥, ȸ�� ID, �޿��� ...
             1   2024/01/25     7369    3000000
             2   2024/01/25     7666    3000000
             3   2024/01/25     8223    3000000
            .
            .
             4   2024/02/25     7369    3000000
             5   2024/02/25     7666    3000000
             6   2024/02/25     8223    3000000
    ��. ALTER TABLE �� : ���̺� ���� + �������� �߰� / ����;
    

SELECT *
FROM emp
WHERE ename = 'KING';

UPDATE emp
SET deptno = NULL
WHERE empno = 7839;
COMMIT;


-- PK : �ش� �÷� ���� �ݵ�� �����ؾ� �ϰ� �����ؾ� �Ѵ�.( NOT NULL + UK �������� ��ģ ����)
-- FK : �ش� �÷����� �����Ǵ� ���̺��� �÷� �� ���� �ϳ��� ��ġ�ϰ� NULL�� ����
-- UK : ���ϼ� �������� (���̺� ������ �ش� �÷����� �׻� �����ؾ��Ѵ�. .. �ֹε�Ϲ�ȣ, ��ȭ��ȣ ���)

-- �ǽ�) CREATE TABLE������ COLUMN LEVEL ������� �������� �����ϴ� ��
DROP TABLE tbl_constraint1;
CREATE TABLE tbl_constraint1
(
--    empno NUMBER(4) NOT NULL PRIMARY KEY  �������Ǹ� ������� ������ SYS_XXXXXX�� �⺻�� ������.
--    empno NUMBER(4) NOT NULL CONSTRAINT ��������_���̺��_�÷��� PRIMARY KEY
    empno NUMBER(4) NOT NULL CONSTRAINT PK_tblconstraint1_empno PRIMARY KEY
    , ename VARCHAR2(20) NOT NULL                           --����     dept���̺�(deptno) // FK : �ܷ�Ű(����Ű), ����Ű
    , deptno NUMBER(2) CONSTRAINT FK_tblconstraint1_deptno REFERENCES dept(deptno)
    , email VARCHAR2(150) CONSTRAINT UK_tblconstraint1_email UNIQUE
    , kor NUMBER(3) CONSTRAINT CK_tblconstraint1_kor CHECK( kor BETWEEN 0 AND 100 ) -- CHECK : ���������� 0������ 100����������(��ȿ�� �˻�)
    , city VARCHAR2(20) CONSTRAINT CK_tblconstraint1_city CHECK( city IN ('����', '�뱸', '����'))
);

-- ���������� ��Ȱ��ȭ / Ȱ��ȭ
-- city �÷��� ���� �뱸 ���� üũ�������� -> �λ��� �߰��ϰ� ���� ��

ALTER TABLE tbl_constraint1
DISABLE CONSTRAINT CK_TBLCONSTRAINT1_CITY; -- �������� �� Ȱ��ȭ
ENABLE CONSTRAINT CK_TBLCONSTRAINT1_CITY;  -- �������� Ȱ��ȭ



-- ���������� ����
SELECT *
FROM user_constraints
WHERE table_name LIKE '%CONSTR%';

ALTER TABLE tbl_constraint1
DROP PRIMARY KEY;

-- �������� �̸����� ����
ALTER TABLE tbl_constraint1
DROP CONSTRAINT 'PK_TBLCONSTRAINT1_EMPNO';
CASCADE �ɼ� �߰� : FK�� ���� ����

-- �������� �̸����� ����
ALTER TABLE tbl_constraint1
DROP CONSTRAINT 'CK_TBLCONSTRAINT1_CITY';

ALTER TABLE tbl_constraint1
DROP UNIQUE(email);



-- �ǽ�) CREATE TABLE ������ TABLE LEVEL ������� �������� �����ϴ� ��
CREATE TABLE tbl_constraint2
(
--    empno NUMBER(4) NOT NULL PRIMARY KEY  �������Ǹ� ������� ������ SYS_XXXXXX�� �⺻�� ������.
--    empno NUMBER(4) NOT NULL CONSTRAINT ��������_���̺��_�÷��� PRIMARY KEY
    empno NUMBER(4) NOT NULL 
    , ename VARCHAR2(20) NOT NULL                           --����     dept���̺�(deptno) // FK : �ܷ�Ű(����Ű), ����Ű
    , deptno NUMBER(2) 
    , email VARCHAR2(150)
    , kor NUMBER(3)
    , city VARCHAR2(20) 
    
--    , CONSTRAINT PK_tblconstraint1_empno PRIMARY KEY(empno,ename) -- ����Ű�� PK���� // ����Ű�� TABLE LEVEL������ ���� �����ϴ�.
    , CONSTRAINT PK_tblconstraint2_empno PRIMARY KEY(empno) -- NOT NULL�� COLUMN LEVEL������ ���������ϴ�. 
    , CONSTRAINT FK_tblconstraint2_deptno FOREIGN KEY(deptno) REFERENCES dept(deptno) 
    , CONSTRAINT UK_tblconstraint2_email UNIQUE(email)
    , CONSTRAINT CK_tblconstraint2_kor CHECK( kor BETWEEN 0 AND 100 ) -- kor�� ��õǾ� �־ ���� �̸����� ���� �ʾƵ� �ȴ�.
    , CONSTRAINT CK_tblconstraint2_city CHECK( city IN ('����', '�뱸', '����')) -- city�� ��õǾ� �־ ���� �̸����� ���� �ʾƵ� �ȴ�.
);


DROP TABLE tbl_constraint1;
DROP TABLE tbl_constraint2;


-- �ǽ� 3) ALTER TABLE ������ �������� �����ϴ� ��
CREATE TABLE tbl_constraint3
(
    empno NUMBER(4) 
    , ename VARCHAR2(20)
    , deptno NUMBER(2)
    

);
-- Table TBL_CONSTRAINT3��(��) �����Ǿ����ϴ�.

1) empno �÷��� PK �������� �߰�..
-- ALTER TABLE ����ؼ� �������� �߰� ����
ALTER TABLE ���̺��
ADD [CONSTRAINT �������Ǹ�] ��������Ÿ�� (�÷���);

ALTER TABLE tbl_constraint3
ADD CONSTRAINT PK_tblconstraint3_empno PRIMARY KEY(empno);

2) deptno �÷��� FK �������� �߰�..
ALTER TABLE tbl_constraint3
ADD CONSTRAINT FK_tblconstraint3_deptno FOREIGN KEY(deptno) REFERENCES dept(deptno);

DROP TABLE tbl_constraint3;



3) ON DELETE CASCADE / ON DELETE SET NULL �ǽ�
CREATE TABLE tbl_emp
AS 
    (
    SELECT * FROM emp
    );


CREATE TABLE tbl_dept
AS 
    (
    SELECT * FROM dept
    );

DROP TABLE tbl_dept;

SELECT *
FROM tbl_emp;

ALTER TABLE tbl_emp
ADD CONSTRAINT PK_tblemp_empno PRIMARY KEY(empno);

ALTER TABLE tbl_dept
ADD CONSTRAINT PK_tbldept_deptno PRIMARY KEY(deptno);


ALTER TABLE tbl_emp
ADD CONSTRAINT FK_tblemp_deptno FOREIGN KEY(deptno) REFERENCES tbl_dept(deptno)
ON DELETE CASCADE;

SELECT *
FROM tbl_dept;

SELECT *
FROM tbl_emp;

DELETE FROM tbl_dept
WHERE deptno = 30;

DROP TABLE tbl_dept;
DROP TABLE tbl_score;


ALTER TABLE tbl_emp
ADD CONSTRAINT pk_tblemp_deptno FOREIGN KEY(deptno)
                                REFERENCES tbl_dept(deptno)
                                ON DELETE SET NULL;
                                

-- JOIN(����)����
CREATE TABLE book(
       b_id     VARCHAR2(10)    NOT NULL PRIMARY KEY   -- åID
      ,title      VARCHAR2(100) NOT NULL  -- å ����
      ,c_name  VARCHAR2(100)    NOT NULL     -- c �̸�
     -- ,  price  NUMBER(7) NOT NULL
 );
-- Table BOOK��(��) �����Ǿ����ϴ�.
INSERT INTO book (b_id, title, c_name) VALUES ('a-1', '�����ͺ��̽�', '����');
INSERT INTO book (b_id, title, c_name) VALUES ('a-2', '�����ͺ��̽�', '���');
INSERT INTO book (b_id, title, c_name) VALUES ('b-1', '�ü��', '�λ�');
INSERT INTO book (b_id, title, c_name) VALUES ('b-2', '�ü��', '��õ');
INSERT INTO book (b_id, title, c_name) VALUES ('c-1', '����', '���');
INSERT INTO book (b_id, title, c_name) VALUES ('d-1', '����', '�뱸');
INSERT INTO book (b_id, title, c_name) VALUES ('e-1', '�Ŀ�����Ʈ', '�λ�');
INSERT INTO book (b_id, title, c_name) VALUES ('f-1', '������', '��õ');
INSERT INTO book (b_id, title, c_name) VALUES ('f-2', '������', '����');

COMMIT;

SELECT *
FROM book;



-- �ܰ����̺�( å�� ���� )
CREATE TABLE danga(
       b_id  VARCHAR2(10)  NOT NULL  -- PK , FK   (�ĺ����� ***)
      ,price  NUMBER(7) NOT NULL    -- å ����
      
      ,CONSTRAINT PK_dangga_id PRIMARY KEY(b_id)
      ,CONSTRAINT FK_dangga_id FOREIGN KEY (b_id)
              REFERENCES book(b_id)
              ON DELETE CASCADE
);
-- Table DANGA��(��) �����Ǿ����ϴ�.
-- book  - b_id(PK), title, c_name
-- danga - b_id(PK,FK), price 
 
INSERT INTO danga (b_id, price) VALUES ('a-1', 300);
INSERT INTO danga (b_id, price) VALUES ('a-2', 500);
INSERT INTO danga (b_id, price) VALUES ('b-1', 450);
INSERT INTO danga (b_id, price) VALUES ('b-2', 440);
INSERT INTO danga (b_id, price) VALUES ('c-1', 320);
INSERT INTO danga (b_id, price) VALUES ('d-1', 321);
INSERT INTO danga (b_id, price) VALUES ('e-1', 250);
INSERT INTO danga (b_id, price) VALUES ('f-1', 510);
INSERT INTO danga (b_id, price) VALUES ('f-2', 400);

COMMIT; 

SELECT *
FROM danga; 



-- å�� ���� �������̺�
 CREATE TABLE au_book(
       id   number(5)  NOT NULL PRIMARY KEY
      ,b_id VARCHAR2(10)  NOT NULL  CONSTRAINT FK_AUBOOK_BID
            REFERENCES book(b_id) ON DELETE CASCADE
      ,name VARCHAR2(20)  NOT NULL
);

INSERT INTO au_book (id, b_id, name) VALUES (1, 'a-1', '���Ȱ�');
INSERT INTO au_book (id, b_id, name) VALUES (2, 'b-1', '�տ���');
INSERT INTO au_book (id, b_id, name) VALUES (3, 'a-1', '�����');
INSERT INTO au_book (id, b_id, name) VALUES (4, 'b-1', '������');
INSERT INTO au_book (id, b_id, name) VALUES (5, 'c-1', '������');
INSERT INTO au_book (id, b_id, name) VALUES (6, 'd-1', '���ϴ�');
INSERT INTO au_book (id, b_id, name) VALUES (7, 'a-1', '�ɽ���');
INSERT INTO au_book (id, b_id, name) VALUES (8, 'd-1', '��÷');
INSERT INTO au_book (id, b_id, name) VALUES (9, 'e-1', '���ѳ�');
INSERT INTO au_book (id, b_id, name) VALUES (10, 'f-1', '������');
INSERT INTO au_book (id, b_id, name) VALUES (11, 'f-2', '�̿���');

COMMIT;

SELECT * 
FROM au_book;


-- ���ǻ翡�� ����(��)���� å�� �Ǹ��ϴ� ����
 CREATE TABLE gogaek(
      g_id       NUMBER(5) NOT NULL PRIMARY KEY 
      ,g_name   VARCHAR2(20) NOT NULL
      ,g_tel      VARCHAR2(20)
);

 INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (1, '�츮����', '111-1111');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (2, '���ü���', '111-1111');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (3, '��������', '333-3333');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (4, '���Ｍ��', '444-4444');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (5, '��������', '555-5555');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (6, '��������', '666-6666');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (7, '���ϼ���', '777-7777');

COMMIT;

SELECT *
FROM gogaek;



--  �Ǹ� ���̺�
 CREATE TABLE panm����ai(
       id         ��������������(5) NOT NULL PRIMARY KEY
      ,g_id       
      
      (5) NOT NULL CONSTRAINT FK_PANMAI_GID  -- � ��������
                     REFERENCES gogaek(g_id) ON DELETE CASCADE
      ,b_id       VARCHAR2(10)  NOT NULL CONSTRAINT FK_PANMAI_BID   -- � å��
                     REFERENCES book(b_id) ON DELETE CASCADE
      ,p_date     DATE DEFAULT SYSDATE      -- ���ϳ� �Ǹ�
      ,p_su       NUMBER(5)  NOT NULL -- ����(���)
);

INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (1, 1, 'a-1', '2000-10-10', 10);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (2, 2, 'a-1', '2000-03-04', 20);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (3, 1, 'b-1', DEFAULT, 13);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (4, 4, 'c-1', '2000-07-07', 5);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (5, 4, 'd-1', DEFAULT, 31);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (6, 6, 'f-1', DEFAULT, 21);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (7, 7, 'a-1', DEFAULT, 26);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (8, 6, 'a-1', DEFAULT, 17);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (9, 6, 'b-1', DEFAULT, 5);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (10, 7, 'a-2', '2000-10-10', 15);

COMMIT;

SELECT *
FROM panmai;   


-- EQUI JOIN

-- ���� : åID, å ����, ���ǻ�, �ܰ� �÷� ���
-- book : b_id, title, c_name
-- danga : b_id(PK,FK), [ price ]  
--  ��. ����Ŭ���� natural join �̶�� �θ���.
    SELECT book.b_id, title, c_name, price
    FROM book, danga
    WHERE book.b_id = danga.b_id; -- ���� ���� -> equi ����
    
--  ��. ��Ī ����ؼ� equi ����
    SELECT b.b_id, title, c_name, price
    FROM book b, danga d
    WHERE b.b_id = d.b_id; -- ���� ���� -> equi ����
    
--  ��. JOIN - ON
    SELECT b.b_id, title, c_name, price
    FROM book b JOIN danga d ON b.b_id = d.b_id;

--  ��. USING�� ���  :   b.b_id, book.b_id(�̷����� ��� �Ұ�)
    SELECT b_id, title, c_name, price
    FROM book JOIN danga USING(b_id);
    
--  ��. NATURAL JOIN ==> ON b.b_id = d.b_id; �� ���������� ���ԵǾ� �ִ�.
    SELECT b_id, title, c_name, price
    FROM book NATURAL JOIN danga;
    
--  ���� :�Ǹűݾ� ���

-- BOOK : å ID, å ����
-- DANGA : å ID, �ܰ�
-- GOGAEK : ������
-- PANMA : �Ǹż���, �Ǹ� ���� * �ܰ�

SELECT *
FROM panmai;

SELECT *
FROM book;

SELECT *
FROM gogaek;

SELECT *
FROM danga;


1) ���� ��, �� ��� ����ؼ� Ǯ��

SELECT book.b_id, title, price, g_name, p_su, p_su*price �Ǹűݾ�
FROM panmai, book, danga, gogaek
WHERE panmai.b_id = danga.b_id AND panmai.g_id = gogaek.g_id AND danga.b_id = book.b_id
ORDER BY panmai.b_id;

SELECT b.b_id, title, price, g_name, p_su, p_su*price �Ǹűݾ�
FROM panmai p , book b , danga d , gogaek g
WHERE p.b_id = d.b_id AND p.g_id = g.g_id AND d.b_id = b.b_id
ORDER BY p.b_id;


2) JOIN-ON ���� Ǯ��
SELECT b.b_id, title, price, g_name, p_su, p_su*price �Ǹűݾ�
FROM panmai p JOIN book b   ON p.b_id = b.b_id 
              JOIN gogaek g ON p.g_id = g.g_id
              JOIN danga d  ON d.b_id = b.b_id;

              
3) USING�� ����ؼ� Ǯ��
SELECT b_id, title, price, g_name, p_su, p_su*price �Ǹűݾ�
FROM panmai   JOIN book    USING(b_id)
              JOIN gogaek  USING(g_id)
              JOIN danga   USING(b_id);
              
              
              
-- NONE EQUI JOIN ����
-- ������ ���� X
-- BETWEEN A AND B

SELECT ename, sal, grade, losal || ' ~ ' || hisal lo_hi
FROM emp e, salgrade s
WHERE e.sal BETWEEN s.losal AND s.hisal;

SELECT ename, sal, grade, losal || ' ~ ' || hisal lo_hi
FROM emp e JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal;


SELECT *
FROM emp;
SELECT *
FROM dept;

SELECT d.deptno, ename, hiredate
FROM emp e LEFT OUTER JOIN dept d ON e.deptno = d.deptno;

SELECT d.deptno, ename, hiredate
FROM emp e, dept d 
WHERE e.deptno(+) = d.deptno;

SELECT d.deptno, ename, hiredate
FROM emp e RIGHT OUTER JOIN dept d ON e.deptno = d.deptno;

SELECT d.deptno, ename, hiredate
FROM emp e , dept d 
WHERE e.deptno = d.deptno(+);

SELECT d.deptno, ename, hiredate
FROM emp e ,dept d 
WHERE e.deptno(+) = d.deptno(+);


-- SELT JOIN
-- �����ȣ, �����, �Ի�����, ���ӻ�� �����ȣ, ���ӻ���� �����
SELECT m.empno, m.ename, m.hiredate, m.mgr, e.ename
FROM emp e,  emp m 
WHERE e.empno = m.mgr;


SELECT m.empno, m.ename, m.hiredate, m.mgr, e.ename
FROM emp e JOIN emp m ON e.empno = m.mgr;




-- CROSS JOIN
SELECT e.*, d.*
FROM emp e, dept d;



 ����) åID, å����, �Ǹż���, �ܰ�, ������(��), �Ǹűݾ�(�Ǹż���*�ܰ�) ��� 
 
 SELECT b.b_id, title, p_su, price, price*p_su "�Ǹűݾ�"
 FROM book b , panmai p , danga d , gogaek g
 WHERE b.b_id = p.b_id AND d.b_id = p.b_id AND g.g_id = p.g_id;
 
 
 ����) ���ǵ� å���� ���� �� ����� �ǸŵǾ����� ��ȸ     
      (    åID, å����, ���ǸűǼ�, �ܰ� �÷� ���   )
 
  
       
 SELECT b.b_id, title, SUM(p_su), price
 FROM book b , panmai p , danga d , gogaek g
 WHERE b.b_id = p.b_id AND d.b_id = p.b_id AND g.g_id = p.g_id
 GROUP BY b.b_id, title, price;
   
    
 ����) �ǸűǼ��� ���� ���� å ���� ��ȸ 
 WITH s AS(
 SELECT b.b_id, title, SUM(p_su), RANK() OVER(ORDER BY SUM(p_su) DESC) "P_RANK", price
 FROM book b , panmai p , danga d , gogaek g
 WHERE b.b_id = p.b_id AND d.b_id = p.b_id AND g.g_id = p.g_id
 GROUP BY b.b_id, title, price
          ) 
 SELECT s.*
 FROM s
 WHERE s.p_rank = 1;
 
 ����) ���� �ǸűǼ��� ���� ���� å(������ ��������)
      (  åID, å����, ���� )
WITH t AS (      
         SELECT b.b_id, title, SUM(p_su) P_SU
            , RANK() OVER(ORDER BY SUM(p_su) DESC) rank
         FROM book b , panmai p , danga d , gogaek g
         WHERE b.b_id = p.b_id 
                                AND d.b_id = p.b_id 
                                AND g.g_id = p.g_id 
                                AND TO_CHAR(p_date, 'YYYY') = 2024 
         GROUP BY b.b_id, title, price
         ORDER BY p_su DESC
            )
SELECT t.*
FROM t
WHERE t.rank = 1;


 ����) book ���̺��� �ǸŰ� �� ���� ���� å�� ���� ��ȸ

 SELECT b.b_id, title, price
 FROM book b, danga d
 WHERE  d.b_id = b.b_id AND b.b_id != ALL (
 
                             SELECT b.b_id
                             FROM book b , panmai p , danga d , gogaek g
                             WHERE b.b_id = p.b_id AND d.b_id = p.b_id AND g.g_id = p.g_id
                             GROUP BY b.b_id, title, price
                             
                                            );
  

                


SELECT *
FROM book;
-- �Ǹ� X å
-- b-2, e-1, f-2

-- �Ǹŵ� å 
--a-1, b-1, c-1, d-1, f-1, a-2
SELECT *
FROM panmai;

 ����) book ���̺��� �ǸŰ� �� ���� �ִ� å�� ���� ��ȸ
      ( b_id, title, price  �÷� ��� )
      
 SELECT b.b_id, title, price
 FROM book b, danga d
 WHERE  d.b_id = b.b_id AND b.b_id = ANY (
 
                                 SELECT b.b_id
                                 FROM book b , panmai p , danga d , gogaek g
                                 WHERE b.b_id = p.b_id AND d.b_id = p.b_id AND g.g_id = p.g_id
                                 GROUP BY b.b_id, title, price
                                        );
 
 ����) ���� �Ǹ� �ݾ� ��� (���ڵ�, ����, �Ǹűݾ�)
 
 SELECT g.g_id, g_name, SUM(p_su * price) "�Ǹűݾ�"
 FROM gogaek g JOIN panmai p ON g.g_id = p.g_id
               JOIN danga  d ON d.b_id = p.b_id
 GROUP BY g.g_id, g_name;
 
 
 
 ����) �⵵, ���� �Ǹ� ��Ȳ ���ϱ�  
    SELECT 
    TO_CHAR(p_date, 'YYYY') "�⵵�� �Ǹ�"
    ,  TO_CHAR(p_date, 'MM') "���� �Ǹ�"
    , SUM(p_su*price)
    FROM book b , panmai p , danga d , gogaek g
    WHERE b.b_id = p.b_id AND d.b_id = p.b_id AND g.g_id = p.g_id
    GROUP BY  TO_CHAR(p_date, 'YYYY'), TO_CHAR(p_date, 'MM') ;
    
 
SELECT *
FROM panmai;


-- ����) ������ �⵵�� �Ǹ���Ȳ ���ϱ�
    SELECT 
    g.g_id
    , g_name
    , TO_CHAR(p_date, 'YYYY') "�⵵"
    , SUM(p_su*price) "�Ǹ� �ݾ�"
    , SUM(p_su) "���Ǹ� ��Ȳ"
    FROM book b , panmai p , danga d , gogaek g
    WHERE b.b_id = p.b_id AND d.b_id = p.b_id AND g.g_id = p.g_id
    GROUP BY g.g_id, g_name, TO_CHAR(p_date, 'YYYY')
    ORDER BY g_name ;
    

-- ����) å�� ���Ǹűݾ��� 15000�� �̻� �ȸ� å�� ������ ��ȸ
--      ( åID, ����, �ܰ�, ���ǸűǼ�, ���Ǹűݾ� )
WITH t AS 
    (
     SELECT b.b_id, title, SUM(p_su) "���ǸűǼ�" ,SUM(p_su*price) "���Ǹűݾ�", price
     FROM book b , panmai p , danga d , gogaek g
     WHERE b.b_id = p.b_id AND d.b_id = p.b_id AND g.g_id = p.g_id
     GROUP BY b.b_id, title, price
   )
SELECT t.*
FROM t
WHERE t.���Ǹűݾ� >= 15000;

SELECT b.b_id, title, SUM(p_su) "���ǸűǼ�" ,SUM(p_su*price) "���Ǹűݾ�", price
FROM book b , panmai p , danga d , gogaek g
WHERE b.b_id = p.b_id AND d.b_id = p.b_id AND g.g_id = p.g_id
GROUP BY b.b_id, title, price
HAVING SUM(p_su*price) >= 15000;

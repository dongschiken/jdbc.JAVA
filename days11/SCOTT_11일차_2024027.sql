-- ������ ����
--������ �����ͺ��̽��� 2���� ���̺� ������ ���� ��� �����͸� �����Ѵ�.
--������, �ǹ������� ����� ������, ������ ����ó�� �������� ������ ������ ���� ����ϰ� �ִ�.
--���� ������� ������ ������ ���̺����� �������� �����͸� �����Ͽ� ��ȸ�� �� �ִ� ����� �ʿ��ϴ�.
--���̺��� ����� �������� ���� �������� ������ ��ü�� �����ϱ�� ��ƴ�. ������, 
--������ �����ͺ��̽������� �����Ͱ��� �θ�-�ڽ� ���踦 ǥ���� �� �ִ� �÷��� �����Ͽ� �������� ���踦 ǥ���� �� �ִ�.


-- ���θ� ����Ʈ ���� : ��з� / �ߺз� / �Һз�
-- 1�� ���̺� (��������)�� ���� ����
-- 3�� ���̺� ���� ����


SELECT 	[LEVEL] {*,�÷��� [alias],...}
FROM	���̺��
WHERE	����
START WITH ����(��������)
CONNECT BY [PRIOR �÷�1��  �񱳿�����  �÷�2��]
		�Ǵ� 
		   [�÷�1�� �񱳿����� PRIOR �÷�2��]
           

SELECT LEVEL
FROM dual
CONNECT BY LEVEL <= 31;


SELECT mgr, empno
    , LPAD( ' ' , (LEVEL-1)*3) || ename ename
    , LEVEL
FROM emp
START WITH mgr IS NULL
--CONNECT BY PRIOR mgr = empno;
CONNECT BY PRIOR empno = mgr;



������ mgr=7698�� BLAKE�� �޴����� �� empno�� ������ ���̴�.
SELECT mgr,empno,ename,LEVEL
FROM emp
WHERE mgr = 7698
START WITH mgr IS NULL
CONNECT BY PRIOR empno=mgr;


create table tbl_test(
deptno number(3) not null primary key,
dname varchar2(24) not null,
college number(3),
loc varchar2(10));

    DEPTNO DNAME                   COLLEGE LOC
---------- -------------------- ---------- ----------
       101 ��ǻ�Ͱ��а�                100 1ȣ��
       102 ��Ƽ�̵���а�              100 2ȣ��
       201 ���ڰ��а�                  200 3ȣ��
       202 �����а�                  200 4ȣ��
       100 �����̵���к�               10
       200 ��īƮ�δн��к�             10
        10 ��������

SELECT *
FROM tbl_test;

INSERT INTO tbl_test VALUES(101, '��ǻ�Ͱ��а�', 100, '1ȣ��');
INSERT INTO tbl_test VALUES(102, '��Ƽ�̵���а�', 100, '2ȣ��');
INSERT INTO tbl_test VALUES(201, '���ڰ��а�', 200, '3ȣ��');
INSERT INTO tbl_test VALUES(202, '�����а�', 200, '4ȣ��');
INSERT INTO tbl_test VALUES(100, '�����̵���к�', 10, null);
INSERT INTO tbl_test VALUES(200, '��īƮ�δн��к�', 10, null);
INSERT INTO tbl_test VALUES(10, '��������', null, null);

SELECT deptno, dname, college, level
FROM tbl_test
START WITH  college IS NULL
CONNECT BY PRIOR deptno = college;


SELECT deptno, dname, college, level
FROM tbl_test
START WITH dname = '��������'
CONNECT BY PRIOR deptno = college;

SELECT deptno, dname, college, DECODE(level, 1, '�к�', '�а�') 
FROM tbl_test
START WITH dname = '�����̵���к�'
CONNECT BY PRIOR deptno = college;

DROP TABLE tbl_test PURGE;


SELECT LPAD( '��', (LEVEL-1)*3) || dname
FROM tbl_test
START WITH college IS NULL
CONNECT BY PRIOR deptno = college AND dname != '�����̵���к�';


-- 1. START WITH ��
-- 2. CONNECT BY �� : ������ ������ � ������ ����Ǵ����� ����ϴ� ����
-- PRIOR ������ :
-- 3. CONNECT_BY_ROOT : ������ �������� �ֻ��� �ο�(��)�� ��ȯ�ϴ� ������
-- 4. CONNECT_BY_ISLEAF : CONNECT BY ���ǿ� ���ǵ� ���迡 ���� �ش� ���� ������ �ڽ����̸� 1, �׷��� ������ 0���� ��ȯ
-- 5. SYS_CONNECT_BY_PATH(column, char) : ��Ʈ ��忡�� �����ؼ� �ڽ��� ����� ���� ��θ� ��ȯ�ϴ� �Լ�
-- 6. CONNECT_BY_ISCYCLE : ����(�ݺ�) �˰��� �ǻ��÷� 1 / 0 ���

--SELECT e.empno
----    , LPAD(' ', 3*(LEVEL-1)) || e.ename
----    , LEVEL
--    , d.dname, d.deptno
--FROM emp e, dept d
--WHERE e.deptno = d.deptno
--START WITH e.mgr IS NULL
--CONNECT BY PRIOR e.empno = e.mgr
--ORDER SIBLINGS BY e.deptno;


-- CONNECT BY ROOT
SELECT e.empno,
    LPAD(' ', 3*(LEVEL-1)) || e.ename
    , LEVEL
    , e.deptno
    , CONNECT_BY_ROOT ename
FROM emp e
START WITH e.mgr IS NULL
CONNECT BY PRIOR e.empno = e.mgr;


-- CONNECT_BY_ISLEAF
SELECT e.empno,
    LPAD(' ', 3*(LEVEL-1)) || e.ename
    , LEVEL
    , e.deptno
    , CONNECT_BY_ROOT ename
    , CONNECT_BY_ISLEAF ename2
FROM emp e
START WITH e.mgr IS NULL
CONNECT BY PRIOR e.empno = e.mgr;

-- SYS_CONNECT_BY_PATH(ename, '/')
SELECT e.empno,
    LPAD(' ', 3*(LEVEL-1)) || e.ename
    , LEVEL
    , e.deptno
    , CONNECT_BY_ROOT ename
    , CONNECT_BY_ISLEAF ename2
    , SYS_CONNECT_BY_PATH(ename, '/')
FROM emp e
START WITH e.mgr IS NULL
CONNECT BY PRIOR e.empno = e.mgr;

-- VIEW(��)
FROM user_tables;
FROM ���̺� �Ǵ� ��

-- CREATE OR REPLACE�� �׻� ����ϴ� ����(�䰡 ������ ���� �並 ����� �ٽ� �����, ������ �並 ���Ӱ� �����.)
CREATE OR REPLACE [FORCE | NOFORCE] VIEW ���̸�
		[(alias[,alias]...]
AS subquery
[WITH CHECK OPTION]
[WITH READ ONLY];

OR REPLACE ���� �̸��� �䰡 ���� ��� �����ϰ� �ٽ� ���� 
FORCE �⺻ ���̺��� ������ ������� �並 ���� 
NOFORCE �⺻ ���̺��� ���� ���� �並 ���� 
ALIAS �⺻ ���̺��� �÷��̸��� �ٸ��� ������ ���� �÷��� �ο� 
WITH CHECK OPTION �信 ���� access�� �� �ִ� ��(row)���� ����, ���� ���� 
WITH READ ONLY DML �۾��� ����(���� �д� �͸� ����) 


-- F10Ű ������ OPTIMIZER �� �� �ִ�.
SELECT b.b_id, title, price, g.g_id
FROM book b JOIN danga d ON b.b_id = d.b_id
            JOIN panmai P ON p.b_id = b.b_id
            JOIN gogaek g ON g.g_id = p.g_id;

-- AS ���� ( ) ���� ORDER BY �� ��밡�� 
-- �� ���� -> ���ȼ�, ����, ����
CREATE OR REPLACE VIEW panView
AS 

        SELECT b.b_id, title, price, g.g_id, g_name, p_date, p_su
        FROM book b JOIN danga d ON b.b_id = d.b_id
                    JOIN panmai P ON p.b_id = b.b_id
                    JOIN gogaek g ON g.g_id = p.g_id
        ORDER BY p_date DESC;


SELECT *
FROM panView;
--ORDER BY p_date DESC;

SELECT *
FROM user_sys_privs;

SELECT TEXT
FROM user_views;


DROP TABLE tbl_test;


SELECT *
FROM tabs;

-- �� ��� ��ȸ tab
SELECT *
FROM tab
WHERE tabtype = 'VIEW';


-- �� ��� -> DML �۾� [�ǽ�]
--    - �ܼ���  O (���  O)
--    - ���պ�  X (���� ���  X)


SELECT ANIMAL_ID, NAME
FROM ANIMAL_OUTS
WHERE NAME NOT IN (
        SELECT DISTINCT NAME
        FROM ANIMAL_OUTS
        WHERE NAME  IN  (
                SELECT NAME
                FROM ANIMAL_INS
                  )
                  )
ORDER BY ANIMAL_ID ASC;
   

SELECT SUM(p_su)
FROM panView;



CREATE TABLE testa (
   aid     NUMBER                  PRIMARY KEY
    ,name   VARCHAR2(20) NOT NULL
    ,tel    VARCHAR2(20) NOT NULL
    ,memo   VARCHAR2(100)
);
--Table TESTA��(��) �����Ǿ����ϴ�.
CREATE TABLE testb (
    bid NUMBER PRIMARY KEY
    ,aid NUMBER CONSTRAINT fk_testb_aid 
            REFERENCES testa(aid)
            ON DELETE CASCADE
    ,score NUMBER(3)
);
--Table TESTB��(��) �����Ǿ����ϴ�.


INSERT INTO testa (aid, NAME, tel) VALUES (1, 'a', '1');
INSERT INTO testa (aid, name, tel) VALUES (2, 'b', '2');
INSERT INTO testa (aid, name, tel) VALUES (3, 'c', '3');
INSERT INTO testa (aid, name, tel) VALUES (4, 'd', '4');

INSERT INTO testb (bid, aid, score) VALUES (1, 1, 80);
INSERT INTO testb (bid, aid, score) VALUES (2, 2, 70);
INSERT INTO testb (bid, aid, score) VALUES (3, 3, 90);
INSERT INTO testb (bid, aid, score) VALUES (4, 4, 100);

COMMIT;
SELECT *
FROM testa;
--FROM testb;
-- 1. �� ����(�ܼ���)
CREATE OR REPLACE VIEW aView
AS 
    SELECT aid, name, tel --, memo
    FROM testa;
-- View AVIEW��(��) �����Ǿ����ϴ�.

-- 2. DML ���� ( INSERT )
INSERT INTO testa (aid, name, memo) VALUES ( 5, 'f', '5');
INSERT INTO testa (aid, name, tel) VALUES ( 5, 'f', '5');
COMMIT;

SELECT * FROM testa;


-- testa, testb ���պ����, DML �׽�Ʈ
CREATE OR REPLACE VIEW abView
AS
    SELECT 
        a.aid, name, tel
        , bid, score
    FROM testa a JOIN testb b ON a.aid = b.bid;
-- View ABVIEW��(��) �����Ǿ����ϴ�.

SELECT *
FROM abView;

-- ���պ並 ����ؼ� INSERT X
INSERT INTO abView (aid, name, tel, bid, score)
VALUES (10, 'x', 55, 20, 70);
-- SQL ����: ORA-01776: cannot modify more than one base table through a join view
-- ���ÿ� �ΰ��� ���̺� ������ �÷������� INSERT �� �� ����.

-- ���պ並 ����ؼ� UPDATE : �� ���̺��� ���븸 ������ ���� �����ϴ�.
UPDATE abView
SET score = 99
WHERE bid = 1;
ROLLBACK;


-- ���պ� ����ؼ� DELETE 
DELETE FROM abView
WHERE aid = 1;

SELECT * FROM testa;
SELECT * FROM testb;


DELETE FROM aView
WHERE aid = 5;
COMMIT;

UPDATE aView
SET tel = '44'
WHERE aid = '4';

-- WITH CHECK OPTION ���� ����ϸ� �並 ���� ���� ���Ἲ(reference integrity)�� �˻��� �� �ְ� DB ���������� constraint ������ �����ϴ�.
-- ������ 90�� �̻��� �� ����
CREATE OR REPLACE VIEW bView
AS
    SELECT bid, aid, score
    FROM testb
    WHERE score >= 90
    WITH CHECK OPTION CONSTRAINT CK_bView_score;

SELECT bid, aid, score
FROM testb;

SELECT bid, aid, score
FROM bView;

-- 3�� ������ -> 70������ ����
--  ORA-01402: view WITH CHECK OPTION where-clause violation 
-- CHECK OPTION(90�� �̻�)�� ����Ǵ� �� 70���� ������Ʈ �Ϸ��ؼ� ����
UPDATE bView
SET score = 98
WHERE bid = 3;

-- �� : ����

DROP VIEW bView;
DROP VIEW abView;
DROP TABLE testa;
DROP TABLE testb;


-- ���� : �⵵, ��, �Ǹűݾ���(�⵵�� ��), (�⵵ , �� ��������) 
-- 
-- gogaek : ���ڵ� ,����
-- panmai : �⵵, ��, ����
-- book : price(����)

CREATE OR REPLACE VIEW gogaekView
AS 
    SELECT g.g_id, g_name
            , TO_CHAR(p_date, 'YYYY') �⵵
            , TO_CHAR(p_date, 'MM') ��
            , SUM(price*p_su) ����
    FROM PANMAI p JOIN gogaek g ON p.g_id = g.g_id
                  JOIN book b ON b.b_id = p.b_id
                  JOIN danga d ON d.b_id = b.b_id
    GROUP BY  g.g_id, g_name, TO_CHAR(p_date, 'YYYY'),  TO_CHAR(p_date, 'MM')
    ORDER BY �⵵ ASC, �� ASC;


SELECT *
FROM gogaekView;

DROP VIEW gogaekView

-- DB�𵨸� ���� + PL/SQL �ۼ�
 1) ������ ���̽�(DataBase) : ���� ���õ� �������� ����(����)
 2) DB�𵨸� ? : ���Ǽ��迡 �������� ���μ����� ���������� DBȭ ��Ű�� ���� 
 // ex) ��Ÿ�������� ���� �ֹ�( ���Ǽ����� ���� ���μ��� ) -> ����(��ǰ) �˻� -> �ֹ� -> ���� -> ��� -> ��ǰ�Ⱦ�
 3) DB�𵨸� ����
    ��. ���� ���μ��� �ľ� ( �䱸 �м��� �ۼ� ) 
    ��. ������ DB �𵨸�(ERD �ۼ�)
    ��. ���� DB �𵨸�(��Ű��, ����ȭ)
    ��. ������ DB �𵨸�(�� ����ȭ, �ε���, DBMS--����Ŭ, MYSQL..._, Ÿ��, ũ�� ���ϱ� ���)
    ��. ���� ���μ����� ��ġ�ϴ��� ����
    
 4) DB�𵨸� ����
 - ���� ���μ��� �м�(�䱸 �м��� �ۼ�(����)) : ������ ���� �����Ϳ� ���ؼ� ������ ���� ���� �ۼ��ϱ�
  ��. ���� �о߿� ���� �⺻ ���İ� ��� �ʿ�.
  ��. ���Ի���� ���忡�� ���� ��ü�� ���μ��� �ľ�, �м�
  ��. ȸ�翡�� ����ϴ� ��� ���� ����(����, ��ǥ, ����)�� �����ϰ� �м�
  ��. ����ڿ��� ���ͺ�, �������� ��� �䱸���� ���� ����
  ��. ����� ���� ó���ϴ� DB �м�
  ��. ��׶��� ���μ��� �ľ�
  ��. ����ڿ��� �䱸 �м�
  ���...
  
 - ������ DB �𵨸�(ERD �ۼ�)
  ��. DB �𵨸��� �Կ� �־� ���� ���� �ؾ��� ���� ����ڰ� �ʿ���ϴ� �����Ͱ� �������� �ľ��ϰ�, � �����͸� DB�� �����ؾߵǴ��� ����� �м�
  ��. �����м�, ����� �䱸 �м����� ���ؼ� ������ ���� ������ �������� ������� ������ �� �ִ� ��Ȯ�� ���·� ǥ���ϴ� �ܰ踦 "������ DB�𵨸�"�̶�� �Ѵ�.
  ��. ��Ȯ�� ���·� ǥ���ϴ� ��� -> ERD(Entity Relation Diagram) ��ü ���� ���̾�׷�
  ��. ��ü(Entity)���� �Ӽ�(Attribute)�� �̾Ƴ��� ��ü�� ���� ���踦 �����ؾ��Ѵ�.
  ��ü - ���簢��
  - ��ü(Entity) ���� ������ ���� �����ͷ� �����Ǿ������� ���, �繰, ���, ���...���� "��ü"��� �Ѵ�.
  - �����ϰ��� �ϴ� ������ ����, ����, ������ ���� �����ͷ� �����Ǿ������� �׸��� �ľ��ϴ� ���� �ſ� �߿��ϴ�.
  - ��ü�� �л�, ����, ��� ���� ���������� �����ϴ� ���� OR �а�, ���� ��� ���� ���������� �����ϴ� ���� �Ѵ� �����ϴ�.
  - ��ü�� ���̺�� ���ǵȴ�. ( ��ü == ���̺� )
  - ��ü�� �ν��Ͻ��� �Ҹ��� �������� ��ü���� �����̴�.
    ex) ����(��ü) : ����Ŭ, �ڹ�, jsp..����� �ν��Ͻ��� ���� == ��ü
        �а�(��ü) : �İ�, ���ڰ�, ���� ��� �ν��Ͻ��� ����
  - ��ü�� �ľ��ϴ� ��� ( ���� �߿� )
    ex) �п������� �л����� �����¿� �������� ���񺰷� �����ϱ⸦ ���ϰ� �ִ�.
        - ��ü : �п�, �л�, ������, ����, ����
                - �л��Ӽ� : �й�, �̸�, �ּ�, ����ó, �а� ���
                    - �����¼Ӽ� : ��ᳯ¥, �⼮�ð�, ��ǽð� 
        
  �Ӽ� - Ÿ����
  - �Ӽ�(Attribute) : ������ �ʿ䰡 �ִ� ��ü�� ���� ����, �� �Ӽ��� ��ü�� ����, �з�, ����, ����, Ư¡, Ư�� ��� ���� �׸��� �ǹ��Ѵ�.
  - �Ӽ� ���� �� ���� �߿��� �κ��� ������ ������ Ȱ�� ���⿡ �´� �Ӽ��� ������ �ʿ�
  - �Ӽ��� ������ 10�� ���ܰ� ����.
  - �Ӽ��� �÷����� ���ǵȴ�.
  - �Ӽ��� ����
    1. ���� �Ӽ� : ���� ���� �ִ� �Ӽ� ( ex - ��� ��ü : �����ȣ �Ӽ�, ����� �Ӽ�, �ֹε�Ϲ�ȣ �Ӽ�, �Ի����� �Ӽ� ���)
    2. ���� �Ӽ� : ���� �Ӽ����� ����ؼ� ����� �� �ִ� �Ӽ� ( ex - ���ʼӼ� �ֹε�Ϲ�ȣ���� ����, ����, ���� ��� ������ �� �� �ִ�.) �Ǹűݾ� �Ӽ� = �ܰ� * �Ǹż���
    3. ���� �Ӽ� : �����δ� �������� ������ �ý����� ȿ������ ���ؼ� �����ڰ� ���Ƿ� �ο��ϴ� �Ӽ�
  - �Ӽ� ������ ���� : �Ӽ��� ������ �ִ� ������ ����, �������� ����, �������� �� Ư���� ������ ��. (ex - ����(E) - ����(A) �Ӽ��� ���� 0~100 ����) kor NUMBER(3) default 0 CHECK( kor BETWEEN 0 AND 100 )
  - ������ ������ ���� ���� �� ��ü�� DB�� ������ �� ���Ǵ� ���⹰ �̴�.
  - ������ ���Ἲ
  - �ĺ���( Identifier ) : ��ǥ���� �Ӽ�, 
        1) �� ��ü ������ ������ �ν��Ͻ��� ������ �� �ִ� ������ ���� �Ӽ� �Ǵ� �Ӽ� �׷��� �ĺ��� ��� �Ѵ�.( PK�� ����� �ǹ� )
        2) �ĺ��ڰ� ������ �����͸� ����, ������ �� ������ �߻��Ѵ�.
        3) �ĺ����� ���� 
            ��. �ĺ���( Candiate Key ) : ��ü�� ������ �ν��Ͻ��� ������ �� �ִ� �Ӽ� 
                  ex) �л���ü(Enti)  �ֹι�ȣ, �й�, �̸���, ��ȭ��ȣ ��� �Ӽ�(�л� �Ѹ� �Ѹ�)�� �������� ���� ���
                        �ν��Ͻ� - ȫ�浿 
                        �ν��Ͻ� - ��浿
            ��. �⺻Ű( Primary Key )
                 �ĺ�Ű �߿� ��ǥ���� ���� ������ �ĺ�Ű�� �⺻Ű�� �����Ѵ�.
                 �������� ȿ����, Ȱ�뵵, ����(ũ��) ����� �ľ��ؼ� �ĺ��� �߿� �ϳ��� �⺻Ű�� ����
            ��. ��üŰ( Alternate Key )
                 �ĺ�Ű - �⺻Ű = ������ �ĺ�Ű�� ��üŰ��� �Ѵ�.
                 INDEX(�ε���)�� Ȱ��ȴ�.
            ��. ����Ű( Composite Key )
            ��. �븮Ű( Surrogate Key )
                 �й��� �⺻Ű�� ������ڰ� ���� ������ 
                 �ĺ��ڰ� �ʹ� ��ų� �������� ����Ű�� �����Ǿ� �ִ� ��� ���������� �߰��� �ĺ���(�ΰ�Ű)
                 �������� 30��... (�й� -> ����(�Ϸù�ȣ) 1~30) ==> �� ����ȭ �۾��� ���Ѵ�. // ����, ȿ������ ���̰ڴ�.
  
  ��ü���� - ������
    - ������ �������� �ٶ� ��ü�� ���� ���� ����..
        ex) �μ� ��ü(E)       <�Ҽ� ����>    ��� ��ü(E)
            �μ� ��ȣ �Ӽ�(�ĺ���)            ��� ��ȣ �Ӽ�(�ĺ���)
            �μ��� �Ӽ�                      �����
            ������ �Ӽ�                      �Ի� ����
            
           
           ��ǰ(E) �Ǽ�< �ֹ� ���� >�Ǽ� ��(E)
           
           ���� ǥ�� 
           - �� ��ü���� �Ǽ����� �����ϰ� ���踦 �ο��Ѥ�.
           - ���� ���� ǥ�� ( �μ� 1  :  N ��� ) // 1�� ��(N) ����
                           1 : 1 ����( 1 �� 1  )
                           N : M ����( �� �� �� )  ��ǰN0 < �ֹ� > 0M�� ���� -- 0�� �Ǵ� N�� // 0�� �Ǵ� M��
           - ���ü��� ǥ�� 
  ����(��ũ) - �Ǽ�
  �ĺ��� - �������(�ۿ� ����)
  
  
    - ���� DB �𵨸� ( ��Ű��, ����ȭ )
      1) ������ �𵨸��� �����(ERD)�� -> �����̼� ��Ű�� ����(��ȯ)
      2) �θ����̺�� �ڽ����̺� ����
        - ������ ������ �� 
            - ex) �μ�(dept)  < �ҼӰ��� >  ���(emp)     ���������� �θ� �ڽİ��谡 �̷������.
            - ex) ��(cos)   < �ҼӰ��� >  ��ǰ          �ֹ��ϴ� ���迡 ���� �θ� �ڽ� ���谡 �̷�� ����. (�� - �θ� // ��ǰ - �ڽ�)
      3) �⺻Ű(PK)�� �ܷ�Ű(FK)
        dept(deptno PK)
        emp (deptno FK)
      4) �ĺ� ����� �� �ĺ� ����
        �ĺ� ����(�Ǽ�) : �θ����̺��� PK�� �ڽ� ���̺��� PK�� ���̵Ǵ� ��
        �� �ĺ� ����(����) : �θ����̺��� PK�� �ڽ� ���̺��� FK�� ���̵Ǵ� ��
      5) ERD -> 5���� ��Ģ(���η�) -> �����̼� ��Ű�� ����(��ȯ) + �̻����� �߻� ->  ����ȭ ���� // ��Ģ 1~5�� ������� �����ؾ��Ѵ�.
      ��Ģ 1. : ��� ��ü(E)�� �����̼�(TABLE)�� ��ȯ�Ѵ�.  ��ƼƼ�� �״�� ���̺��, �Ӽ��� �״�� �÷�����, �ĺ��ڴ� �⺻Ű�� �ٲٴ� �۾��� ���� ó���� �ؾ��� �۾�
      ��Ģ 2. : �ٴ�� ����� �����̼�(���̺�)���� ��ȯ�Ѵ�. 
      ��Ģ 3. : �ϴ�� ����� �ܷ�Ű�� ǥ���Ѵ�.
      ��Ģ 4. : �ϴ��� ����� �ܷ�Ű�� ǥ���Ѵ�. 
      ��Ģ 5. : ���߰��� ������ �Ӽ��� �����̼�(���̺�)���� ��ȯ�Ѵ�. // ���׶�� 2�� ������ ���
      
      
      
      
      

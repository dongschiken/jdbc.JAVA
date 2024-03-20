-- 1) ������ ����ϴ� ����
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
    ) t
;

-- ����Ŭ���� ������ ������ �������� dbms_random ��Ű��(���� ���õ� PL/SQL(���ν���, �Լ�)���� ����

SELECT 
--    SYS.dbms_random.value+1       -- 0.0 ~  < 1 �Ǽ�
--    SYS.dbms_random.value(0, 100) -- 0.0 ~  < 100 �Ǽ�
--      SYS.dbms_random.string('L', 5) --�ҹ��� 5��
--      SYS.dbms_random.string('U', 5) --�빮�� 5��
--      SYS.dbms_random.string('A', 5) -- ���ĺ� 5��
--      SYS.dbms_random.string('X', 5) -- �빮�� + ���� 5��
      SYS.dbms_random.string('P', 5) -- �빮�� + ���� + Ư������
FROM dual;



SELECT
    CEIL(SYS.dbms_random.value(0, 100)) "��������"
  , CEIL(SYS.dbms_random.value(0.1, 45)) "�ζǹ�ȣ"
FROM dual;



-- [ pivot ���� ] 
-- ������ �ǹ� : ���� �߽����� ȸ����Ų��.
-- ������� ���� / ���� ȸ��
-- ����Ŭ 11g�������� �����ϴ� �Լ� // ��� ���� ������ �Լ�
-- �ǹ� ����
SELECT * 
FROM (�ǹ� ��� ����������)
PIVOT (�׷��Լ�(�����÷�) FOR �ǹ��÷� IN(�ǹ��÷� �� AS ��Ī...));

-- [ 1 ] ���� �� job���� ����� ��ȸ
SELECT job, COUNT(*) count
FROM emp
GROUP BY ROLLUP(job);

-- [ 2 ] �ǹ� �Լ� ����ؼ� 1�� ������ ���� ���� �ٲٱ�
SELECT *
FROM (
    SELECT job
    FROM emp
    )
PIVOT(COUNT(job) FOR job IN('CLERK', 'SALESMAN', 'MANAGER', 'ANALYST', 'PRESIDENT' ) );


-- [ 3 ] �ǹ� �Լ� ������� �ʰ� ��� ���� �ٲ㼭 ���
SELECT 
     COUNT(DECODE(job, 'CLERK', 'O')) "CLERK"
    ,COUNT(DECODE(job, 'SALESMAN', 'O')) "SALESMAN"
    ,COUNT(DECODE(job, 'MANAGER', 'O')) "MANAGER"
    ,COUNT(DECODE(job, 'ANALYST', 'O')) "ANALYST"
    ,COUNT(DECODE(job, 'PRESIDENT', 'O')) "PRESIDENT"
FROM emp;


-- [ 4 ] ���� �Ի��� ����� ���� �ľ�
SELECT *
FROM (
    SELECT TO_CHAR(hiredate, 'MM') month
    FROM emp
    )
PIVOT(COUNT(month) FOR month IN('12' AS "12��",'11' AS "11��" ,'09' AS "9��",'06' AS "6��" ,'05' AS "5��" ,'04' AS "4��" ,'02' AS "2��" ,'01' AS "1��"));


-- [ 5 ] �⵵�� ���� �Ի��� ����� ���� �ľ�
SELECT *
FROM (
    SELECT
    TO_CHAR(hiredate, 'YYYY') year    
   ,TO_CHAR(hiredate, 'MM') month
    FROM emp
    )
PIVOT(COUNT(month) FOR month IN('12' AS "12��",'11' AS "11��" ,'09' AS "9��",'06' AS "6��" ,'05' AS "5��" ,'04' AS "4��" ,'02' AS "2��" ,'01' AS "1��"));


-- [ 6 ] emp ���̺��� �� �μ���, job�� ������� ��ȸ
FROM 
SELECT *
FROM (
    SELECT 
        d.deptno
        ,dname
        ,job
    FROM emp e RIGHT JOIN dept d ON e.deptno = d.deptno
    )
PIVOT( COUNT(job) FOR job IN ('CLERK', 'SALESMAN', 'MANAGER', 'ANALYST', 'PRESIDENT' ) ) 
ORDER BY deptno ASC;



-- �� �μ��� ������ sal�� ���� ���ϱ�
SELECT *
FROM 
    (  
    SELECT job, deptno, sal
    FROM emp
    )
PIVOT( SUM(sal) FOR deptno IN( '10', '20', '30'));



-- 
SELECT *
FROM 
    (  
    SELECT job, deptno, sal, ename
    FROM emp
    )
PIVOT( SUM(sal) AS �հ�, MAX(sal) �ְ��, MAX(ename) AS �ְ��� FOR deptno IN( '10', '20', '30'));




-- 
SELECT 
    d.deptno
    ,dname
    ,job
FROM emp e, dept d
--WHERE e.deptno (+)= d.deptno;  --(+)��ȣ�� �ǹ� RIGHT OUTER JOIN�� �ϰڴٴ� �ǹ�
WHERE e.deptno = d.deptno(+) ;   --(+)��ȣ�� �ǹ� LEFT OUTER JOIN�� �ϰڴٴ� �ǹ�
FROM emp e RIGHT JOIN dept d ON e.deptno = d.deptno



-- ���� emp ���̺��� sal�� ���� 20%�� �ش��ϴ� ����� ������ ��ȸ

--TRUNC(2.8)
SELECT t.ename, t.empno
FROM (
    SELECT ename, empno,
        RANK() OVER(ORDER BY sal DESC) rank
    FROM emp
    ) t
WHERE t.rank <= (SELECT COUNT(*) FROM emp)*0.2;


-- ���� emp ���� �� ����� �޿��� ��ü�޿��� �� %�� �Ǵ� �� ��ȸ.
--       ( %   �Ҽ��� 3�ڸ����� �ݿø��ϼ��� )
--            ������ �Ҽ��� 2�ڸ������� ���.. 7.00%,  3.50%     


SELECT ename, sal
    , (SELECT SUM(sal) sal FROM emp) TOTAL_PAY
    , TO_CHAR(ROUND(sal/(SELECT SUM(sal) sal FROM emp)*100,2), '999.00') || '%' "sum_sal%"
FROM emp;


SELECT *
FROM insa;
--     [�ѻ����]      [���ڻ����]      [���ڻ����] [��������� �ѱ޿���]  [��������� �ѱ޿���] [����-max(�޿�)] [����-max(�޿�)]
------------ ---------- ---------- ---------- ---------- ---------- ----------
--        60                31              29           51961200                41430400                  2650000          2550000

WITH t AS
    (
    SELECT (SELECT COUNT(*) FROM insa) cnt
        , ssn
        ,  DECODE(MOD(SUBSTR(ssn, 8, 1),2), 0, 'O') "����"
        ,  DECODE(MOD(SUBSTR(ssn, 8, 1),2), 1, 'O') "����"
        , basicpay
    FROM insa
    )
SELECT t.cnt "�ѻ����"
        , COUNT(t."����") "���ڻ����" 
        , COUNT(t."����") "���ڻ����"
        , SUM(DECODE(t."����", 'O' , basicpay)) "������� �ѱ޿���"
        , SUM(DECODE(t."����", 'O' , basicpay)) "������� �ѱ޿���"
        , MAX(DECODE(t."����", 'O' , basicpay)) "���� �޿� MAX"
        , MAX(DECODE(t."����", 'O' , basicpay)) "���� �޿� MAX"
FROM t
GROUP BY t.cnt;


-- ���� -- [����] ����(RANK) �Լ� ����ؼ� Ǯ�� 
--   emp ���� �� �μ��� �ְ�޿��� �޴� ����� ���� ���
--   
--    DEPTNO ENAME             PAY DEPTNO_RANK
------------ ---------- ---------- -----------
--        10 KING             5000           1
--        20 FORD             3000           1
--        30 BLAKE            2850           1


WITH t AS 
    (
    SELECT deptno
        , MAX(sal+NVL(comm,0)) max_pay
    FROM emp
    GROUP BY deptno
    )
SELECT t.*
FROM t;


-- ���� -- [����] ����(RANK) �Լ� ����ؼ� Ǯ�� 
--   emp ���� �� �μ��� �ְ�޿��� �޴� ����� ���� ���
SELECT t.deptno, e.ename, t.max_pay, 1 deptno_rank
FROM 
    (
    SELECT deptno
        , MAX(sal+NVL(comm,0)) max_pay
    FROM emp
    GROUP BY deptno
    ) t , emp e
WHERE t.deptno = e.deptno AND t.max_pay = (e.sal+NVL(e.comm, 0))
ORDER BY e.deptno ASC;



-- ���� -- [����] ����(RANK) �Լ� ����ؼ� Ǯ�� 
--   emp ���� �� �μ��� �ְ�޿��� �޴� ����� ���� ���
SELECT t.deptno, t.ename, t.pay, t.pay_rank1, t.pay_rank2
FROM (
    SELECT deptno, ename
        , sal + NVL(comm, 0) pay
        , RANK() OVER(ORDER BY sal +NVL(comm, 0) DESC) pay_rank1
        , RANK() OVER(PARTITION BY deptno ORDER BY sal +NVL(comm, 0) DESC) pay_rank2
    FROM emp
    ORDER BY deptno
    ) t
WHERE t.pay_rank2 = 1
ORDER BY deptno;


-- ���� emp ���̺��� �� �μ��� �����, �μ� �ѱ޿���, �μ� ��ձ޿�
WITH s AS(
    SELECT d.deptno, t."�μ�����", t."�ѱ޿���", t. "���"
    FROM (
    SELECT deptno
        , COUNT(deptno) "�μ�����"
        , SUM(sal+NVL(comm,0))  "�ѱ޿���"
        , ROUND(AVG(sal+NVL(comm,0)),2) "���"
    FROM emp
    GROUP BY deptno
        ) t RIGHT OUTER JOIN dept d ON t.deptno = d.deptno
    )
SELECT
     s.deptno
    , NVL(s."���", 0) "���"
    , NVL(s."�μ�����", 0) "�μ�����"
    , NVL(s."�ѱ޿���", 0) "�ѱ޿���"
FROM s
ORDER BY s.deptno;



SELECT d.deptno
    , COUNT(*) �μ�����
    , NVL(SUM(sal+NVL(comm,0)),0)  "�ѱ޿���"
    , NVL(ROUND(AVG(sal+NVL(comm,0)),2),0) "���"
FROM emp e, dept d
WHERE e.deptno(+) = d.deptno
GROUP BY d.deptno
ORDER BY d.deptno ASC;
--FROM emp e RIGHT OUTER JOIN dept d ON e.deptno = d.deptno
--GROUP BY d.deptno
--ORDER BY d.deptno ASC;


SELECT buseo, city, COUNT(*)
FROM insa
GROUP BY buseo, city
ORDER BY buseo;

SELECT t.city, t.buseo
FROM (
    SELECT DISTINCT city
        , buseo
    FROM insa
    ORDER BY city ASC
    ) t PARTITION BY(buseo) LEFT OUTER JOIN insa i  ON i.buseo = t.buseo
GROUP BY t.buseo, t.city
ORDER BY t.buseo;



WITH c AS 
    (
    SELECT DISTINCT city
    FROM insa
    )
SELECT buseo, c.city, COUNT(NUM)
FROM insa i PARTITION BY(buseo) RIGHT OUTER JOIN c  ON i.city = c.city
GROUP BY buseo, c.city
ORDER BY buseo, c.city;


-- ���� 


SELECT (SELECT COUNT(*) FROM insa) "�ѻ����" , COUNT(buseo) "�μ������"
       , COUNT(DECODE(MOD(SUBSTR(ssn, 8, 1), 2), 1, '����')) "���� �����"
       , COUNT(DECODE(MOD(SUBSTR(ssn, 8, 1), 2), 0, '����')) "���� �����"
       , 
FROM insa
GROUP BY buseo;




SELECT s.*
    , ROUND(s.�μ������/s.�ѻ���� * 100, 2) || '%' " ��/��%"
    , ROUND(s.�����ο���/s.�ѻ���� * 100, 2) || '%' " ��/��%"
    , ROUND(s.�����ο���/s.�μ������ * 100, 2) || '%' " ��/��%"
FROM (
SELECT t.buseo
    , (SELECT COUNT(*) FROM insa) "�ѻ����"
    , t.gender ����
    , COUNT(t.gender) "�����ο���"
    , (SELECT COUNT(*) FROM insa WHERE buseo = t.buseo) "�μ������"
FROM (
SELECT buseo, name, ssn
    , DECODE(MOD(SUBSTR(ssn, 8, 1),2), 1, 'M', 'F') gender
FROM insa   
    ) t
GROUP BY buseo, gender
ORDER BY buseo, gender
    ) s;
    
-- ���� SMS ������ȣ ������ 6�ڸ� ���� �߻�
SELECT CEIL(SYS.dbms_random.value(1, 6))
    , TRUNC(SYS.dbms_random.value(100000, 1000000)) SMS6�ڸ�
    , TRUNC(SYS.dbms_random.value(LPAD(10000, 6, 0), 1000000)) SMS6�ڸ�
    , TO_CHAR(TRUNC(SYS.dbms_random.value(10000, 1000000)), '099999') SMS6�ڸ�
FROM dual;


-- ���� LISTAGG �Լ�S
SELECT d.deptno, NVL(t.list, '�������') list
FROM (
    SELECT LISTAGG(ename, '/') WITHIN GROUP(ORDER BY ename) list
    , deptno
    FROM emp
    GROUP BY deptno
    ) t RIGHT OUTER JOIN dept d ON d.deptno = t.deptno
ORDER BY d.deptno


-- LISTAGG �Լ� �⺻ ����
SELECT LISTAGG(����÷�, '���й���') WITHIN GROUP (ORDER BY ���ı����÷�) 
FROM TABLE�� ;

SELECT
    d.deptno
    ,NVL(LISTAGG(ename, '/') WITHIN GROUP(ORDER BY ename),0) list
FROM emp e RIGHT JOIN dept d ON e.deptno = d.deptno
GROUP BY d.deptno;


-- ���� emp ���̺��� 30�� �μ��� �ְ�, ���� sal�� �޴� ����� ���� ��ȸ
SELECT deptno, ename,
    (SELECT MAX(sal) max FROM emp WHERE deptno = 30)
    ,(SELECT MIN(sal) min FROM emp WHERE deptno = 30)
FROM emp
WHERE deptno = 30 ;


SELECT e.ename, e.sal
FROM (
    SELECT deptno
        , MAX(sal) max
        , MIN(sal) min
    FROM emp
    WHERE deptno = 30
    GROUP BY deptno
    HAVING deptno = 30
    ) t  RIGHT OUTER JOIN emp e ON t.deptno = e.deptno
WHERE e.sal = t.max OR e.sal = t.min AND e.deptno = 30;


SELECT t.*
FROM (
    SELECT deptno, ename, hiredate, sal,
        RANK() OVER(PARTITION BY deptno ORDER BY sal ASC) min
        ,RANK() OVER(PARTITION BY deptno ORDER BY sal DESC) max
    FROM emp
    WHERE deptno = 30
    ) t
WHERE t.max = 1 or t.min = 1;
--        ,RANK() OVER(PARTITION BY deptno ORDER BY ename DESC) max
--    , t.max
-- ����� �÷� : deptno, ename, hiredate, sal




-- ������ ���� emp ���̺��� ������� ���� ���� �μ���� �����, ������� ���� ���� �μ���� �����
SELECT DISTINCT t.*
FROM (
    SELECT  
         MAX(COUNT(*)) "���帹�� �μ�"
        , MIN(COUNT(*)) "�������� �μ�"
    FROM emp
    GROUP BY deptno
    ) t , emp e
ORDER BY deptno ASC;


-- ������ ���� emp ���̺��� ������� ���� ���� �μ���� �����, ������� ���� ���� �μ���� �����
-- �߿��� ���� �ٽ� Ǯ���
-- MAX, MIN�� ���� �Ѱ��� GROUP BY������ ����� �� ���� ������ ����
-- �׳� COUNT�� �س��� ���Ŀ� ������ �������� ó���ؾ��Ѵ�.
WITH t AS (
        SELECT d.deptno, dname, COUNT(empno) cnt
        FROM emp e RIGHT JOIN dept d ON d.deptno = e.deptno
        GROUP BY d.deptno, dname
    )
SELECT dname, cnt
FROM t
WHERE cnt IN ( (SELECT MAX(cnt) FROM t) , (SELECT MIN(cnt) FROM t))
ORDER BY cnt;


-- WITH �� ����
WITH a AS (
        SELECT d.deptno, dname, COUNT(empno) cnt
        FROM emp e RIGHT JOIN dept d ON d.deptno = e.deptno
        GROUP BY d.deptno, dname
    ) 
    , b AS (
    SELECT MIN(cnt) mincnt, MAX(cnt) maxcnt
    FROM a
    )
SELECT a.dname, a.cnt
FROM a, b 
WHERE a.cnt IN (b.mincnt, b.maxcnt)
ORDER BY cnt;



SELECT t.deptno, t.cnt
FROM (
SELECT d.deptno, COUNT(empno) cnt
    , RANK() OVER(ORDER BY COUNT(empno) ASC) cnt_rank
FROM dept d LEFT JOIN emp e ON e.deptno = d.deptno
GROUP BY d.deptno
    ) t
WHERE t.cnt_rank  IN (1, 5);




-- �м��Լ� : FIRST, LAST
-- �����Լ� (COUNT, SUM, AVG, MAX, MIN)��� ���� ����Ͽ� �־��� �׷쿡 ���� ���������� ������ �Ű� ����� �����ϴ� �Լ�
-- ������ �ϱ��ϱ�
WITH a AS (
        SELECT d.deptno, dname, COUNT(empno) cnt
        FROM emp e RIGHT JOIN dept d ON d.deptno = e.deptno
        GROUP BY d.deptno, dname
    ) 
SELECT MAX(cnt)
    , MAX(dname) KEEP(DENSE_RANK LAST ORDER BY cnt ASC) max_dname
    , MIN(cnt)
    , MIN(dname) KEEP(DENSE_RANK FIRST ORDER BY cnt ASC) min_dname
FROM a;



-- �м��Լ� �߿� CUME_DIST() : �־��� �׷쿡 ���� ������� ���� ������ ���� ��ȯ
                        -- ��������(����) 0 < ? <= 1

SELECT deptno, ename, sal
    , CUME_DIST() OVER(PARTITION BY deptno ORDER BY sal ASC) dept_dist
    , CUME_DIST() OVER(ORDER BY sal ASC) dept_dist
FROM emp ;


-- �м��Լ� �߿� PERCENT_RANK() : �ش� �׷� ���� ����� ����
--                      0 < ? <=1
-- ����� ����? : �׷� �ȿ��� �ش� ���� ������ ���� ���� ����
SELECT deptno, ename, sal
    , PERCENT_RANK() OVER(ORDER BY sal) PERCENT
    , PERCENT_RANK() OVER(PARTITION BY deptno ORDER BY sal) PERCENT -- �� �μ������� sal ����
FROM emp;


SELECT d.dname, t.cnt
FROM(
SELECT dname, COUNT(*) cnt
FROM emp e RIGHT JOIN dept d ON e.deptno = d.deptno
GROUP BY dname
)t RIGHT JOIN dept d ON t.dname = d.dname
WHERE t.cnt = (SELECT MAX(cnt) FROM t); 


-- NTILE(expr) NŸ�� : ��Ƽ�� ���� expr�� ��õ� ��ŭ ������ ����� ��ȯ�ϴ� �Լ�
-- �����ϴ� ���� ��Ŷ �̶�� �Ѵ�
SELECT deptno, ename, sal
    , NTILE(4) OVER(ORDER BY sal) ntiles
FROM emp;



SELECT buseo, name, basicpay
    , NTILE(2) OVER(PARTITION BY buseo ORDER BY basicpay) ntiles
FROM insa;


-- WIDTH_BUCKET(expr, minvalue, maxvalue, numbuckets) == NTILE() // �� �Լ��� ������ �м��Լ�
-- �� �Լ��� ������ : �ִ밪, �ּҰ��� ���� ����

SELECT deptno, ename, sal
    , NTILE(4) OVER(ORDER BY sal) ntiles
    , WIDTH_BUCKET(sal, 0, 5000, 4) widthbuckets
FROM emp;


-- �Լ�(�÷���) ������ ���� ��ġ (offset) , ���� ������ �⺻��(default_value)
-- LAG() expr, offset, default_value
-- LAG() : �־��� �׷�� ������ ���� �ٸ� �࿡ �ִ� ���� ������ �� ����ϴ� �Լ�, ���� ���� (�տ� ��)
-- LEAD() expr, offset, default_value
-- LEAD() : �־��� �׷�� ������ ���� �ٸ� �࿡ �ִ� ���� ������ �� ����ϴ� �Լ�, ���� ���� (�ڿ� ��)


SELECT deptno, ename, hiredate, sal
    , LAG(sal, 1, 0)OVER(ORDER BY hiredate) pre_sal
--    , LAG(sal, 2, -1)OVER(ORDER BY hiredate) pre_sal
    , LEAD(sal, 1, -1) OVER(ORDER BY hiredate) next_sal
    , LEAD(sal, 1, -1) OVER(ORDER BY hiredate) next_sal
FROM emp
WHERE deptno = 30;




-------------------------------------------------------------------------------- �Լ� ��
-- ����Ŭ �ڷ���(Data Type) --
1) CHAR : ����(��) �����ϴ� �ڷ���
-- CHAR[SIZE BYTE | CHAR]

CHAR(3 CHAR) : 3 ���ڸ� �����ϴ� �ڷ��� // 'ABC' , '������'
CHAR(3 BYTE) : 3 ����Ʈ�� ���ڸ� �����ϴ� �ڷ��� // 'abc' , '��'  // �ѱ��� 3����Ʈ�� �����⶧���� �ѱ��ڸ� �� �� �ִ�.
CHAR(3) == CHAR(3, BYTE)
--CHAR == CHAR(1) == CHAR(1 BYTE)
--���� ������ ���� �ڷ��� : ����ϴ� �� - �ֹε�Ϲ�ȣ(14�ڸ�), �����ȣ(5�ڸ�) ��� ���ڿ��� ���̰� �׻� ����(������) ���� ������ �� ���ȴ�.
CHAR(14)
1����Ʈ ~ 2000����Ʈ ���� ���� ����

-- DDL
CREATE TABLE tbl_char
(
    aa CHAR
    , bb CHAR(3)
    , cc CHAR(3 CHAR)
);
-- Table TBL_CHAR��(��) �����Ǿ����ϴ�.

DROP TABLE tbl_char ;
-- Table TBL_CHAR��(��) �����Ǿ����ϴ�.

SELECT *
FROM tabs
WHERE table_name LIKE '%CHAR%';

DESC tbl_char
-- ���ο� ���ڵ带 �߰�(���� �߰�)
 INSERT INTO tbl_char (aa, bb, cc) VALUES('a','aaa','aaa');
 INSERT INTO tbl_char (aa, bb, cc) VALUES('a','��','�츮');
 -- SQL ����: ORA-12899: value too large for column "SCOTT"."TBL_CHAR"."BB" (actual: 6, maximum: 3) ���� �ʹ� ũ�� ���� �������� 3�ε� 6�� ���� ���ͼ� ���� ����
 INSERT INTO tbl_char (aa, bb, cc) VALUES('a','�츮','�츮');
COMMIT;

SELECT VSIZE('��'), VSIZE('a')
FROM dual;

SELECT *
FROM tbl_char;



2) NCHAR : 
NCHAR[size] == N + CHAR[size] -- N�� �����ڵ�


CREATE TABLE tbl_nchar
(
    aa CHAR(3)
    , bb CHAR(3 CHAR)
    , cc NCHAR(3)
);
-- Table TBL_NCHAR��(��) �����Ǿ����ϴ�.

INSERT INTO tbl_nchar (aa, bb, cc) VALUES('ȫ','�浿','ȫ�浿');
INSERT INTO tbl_nchar (aa, bb, cc) VALUES('ȫ�浿','ȫ�浿','ȫ�浿');
COMMIT;

SELECT *
FROM tbl_nchar;

DROP TABLE tbl_nchar ;
--Table TBL_NCHAR��(��) �����Ǿ����ϴ�.


char(5 byte)    [a][b][c][][]
varchar2(5 byte)[a][b][c] ���� ����
varchar2 = varchar2(1) == varchar2(1 byte) | 4000byte


4) NVARCHAR2(size)
-- ���� ����
NVARCHAR2 == NVARCHAR2(1) == '��' , 'a'
4000 byte ���� ���� ����
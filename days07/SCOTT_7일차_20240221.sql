-- SCOTT

-- 1 insa ���̺��� �� �μ��� ��� �� ��ȸ


DESC insa;

SELECT DISTINCT buseo
FROM insa;

SELECT COUNT(*)
FROM insa
WHERE buseo LIKE '�ѹ���'
UNION
SELECT COUNT(*)
FROM insa
WHERE buseo LIKE '������'
UNION
SELECT COUNT(*)
FROM insa
WHERE buseo LIKE '���ߺ�'
UNION
SELECT COUNT(*)
FROM insa
WHERE buseo LIKE '��ȹ��'
UNION
SELECT COUNT(*)
FROM insa
WHERE buseo LIKE '�λ��'
UNION
SELECT COUNT(*)
FROM insa
WHERE buseo LIKE '�����'
UNION
SELECT COUNT(*)
FROM insa
WHERE buseo LIKE 'ȫ����';


SELECT buseo, COUNT(*) CNT
FROM insa
GROUP BY buseo;


-- [2] ���� : emp ���̺��� �޿��� ����(rank)
WITH t AS
    (
    SELECT ename, deptno, empno, sal+NVL(comm, 0)
    ,RANK() OVER(ORDER BY sal+NVL(comm, 0) DESC) rank
    FROM emp 
    )
SELECT t.*
FROM t
WHERE rank <= 3;


SELECT e.*
FROM (
    SELECT ename, deptno, empno, sal+NVL(comm, 0)
    ,RANK() OVER(ORDER BY sal+NVL(comm, 0) DESC) rank
    FROM emp 
    ) e
WHERE rank BETWEEN 3 AND 5;
WHERE rank <= 3;


SELECT 
    (SELECT COUNT(*)+1 FROM emp c WHERE c.sal+NVL(comm, 0) > p.sal+NVL(p.comm, 0)) pay_rank
    , p.*
FROM emp p
ORDER BY pay_rank;

-- TOP N ���
SELECT ROWNUM ,e.*
FROM (
    SELECT *
    FROM emp
    ORDER BY sal+NVL(comm, 0) DESC
)e
WHERE ROWNUM <= 3;

-- [3] insa ���̺��� ���ڻ����, ���ڻ���� ��ȸ
SELECT DECODE(MOD(SUBSTR(ssn, 8, 1),2), 1, '���ڻ����', 0, '���ڻ����') GENDER
    , COUNT(*) CNT
FROM insa
GROUP BY MOD(SUBSTR(ssn, 8, 1),2)
UNION
SELECT '��ü�����',COUNT(*)
FROM insa;

-- [4] emp ���̺� �� �μ��� ��� �� ��ȸ
SELECT e.deptno, ename, dname, hiredate
FROM dept d JOIN emp e ON d.deptno = e.deptno;


SELECT d.dname, COUNT(*)
FROM dept d JOIN emp e ON e.deptno = d.deptno
GROUP BY d.dname
--ORDER BY dname  ORA-00933: SQL command not properly ended : ������ ���� // ORDER BY���� �׻� UNION�� �������� �;��Ѵ�.
UNION ALL
SELECT 'OPERATIONS', COUNT(*)
FROM emp 
WHERE deptno = 40;



SELECT dname, COUNT(empno)
FROM  dept d LEFT OUTER JOIN emp e  ON d.deptno = e.deptno
GROUP BY dname;

SELECT COUNT(*)
    , COUNT(empno)
    , COUNT(comm)
    , COUNT(hiredate)
FROM emp;


-- [3] insa ���̺��� ���ڻ����, ���ڻ���� ��ȸ
-- DECODE�� 1�� �ƴ� ����� NULL�� ó���ǰ� COUNT���� NULL���� ���ܵǴϱ� ������ ����� ���´�.
SELECT COUNT(*)
    , COUNT( DECODE ( MOD( SUBSTR ( ssn, 8, 1), 2), 1, '����') ) "���� �����"
    , COUNT( DECODE ( MOD( SUBSTR ( ssn, 8, 1), 2), 0, '����') ) "���� �����"
FROM insa;



SELECT COUNT(*)
    , COUNT( DECODE ( deptno, 10, 'o') ) "10�� �����"
    , COUNT( DECODE ( deptno, 20, 'o') ) "20�� �����"
    , COUNT( DECODE ( deptno, 30, 'o') ) "30�� �����"
    , COUNT( DECODE ( deptno, 40, 'o') ) "40�� �����"
FROM emp;

-- [5] ���� : insa ���̺��� ���� ��, ���� ��, ������ ������ ���

WITH t AS(
    SELECT TO_CHAR(SUBSTR(ssn, 3, 4), 'MMDD') ssn
    FROM insa
    )
SELECT t.*
FROM t;

SELECT SYSDATE
    , TO_CHAR( SYSDATE, 'MMDD')
FROM dual;


UPDATE insa
SET ssn = SUBSTR(ssn, 1, 2) || TO_CHAR( SYSDATE, 'MMDD') || SUBSTR(ssn, 7)
WHERE num IN (1001, 1002);
COMMIT;

SELECT num, name, ssn
    , SIGN(TO_DATE(SUBSTR (ssn, 3, 4), 'MMDD') - TRUNC(SYSDATE)) s
    , DECODE(SIGN(TO_DATE(SUBSTR (ssn, 3, 4), 'MMDD') - TRUNC(SYSDATE)), 1, '������', 0, '���û���', '������') r
    , CASE SIGN(TO_DATE(SUBSTR (ssn, 3, 4), 'MMDD') - TRUNC(SYSDATE)) WHEN 1 THEN '������'
        WHEN 0 THEN '����'
        ELSE '������'
        END c
    , CASE 
        WHEN SIGN(TO_DATE(SUBSTR (ssn, 3, 4), 'MMDD') - TRUNC(SYSDATE)) > 0 THEN '������'
        WHEN SIGN(TO_DATE(SUBSTR (ssn, 3, 4), 'MMDD') - TRUNC(SYSDATE)) = 0 THEN '����'
        ELSE '������'
        END ��Ī1
FROM insa;


-- [5-2] emp ���̺��� 10�� �μ��� sal 10%�λ�, 20�� �μ���, 15%d�λ�, �׿� 5%�λ�

WITH t AS
    (
    SELECT ename, empno, deptno, sal, comm, sal + NVL(comm, 0) pay
    FROM emp
    )   
SELECT t.ename, t.empno, t.deptno, t.pay
    , CASE t.deptno
        WHEN 10 THEN t.pay*1.1
        WHEN 20 THEN t.pay*1.15
        ELSE t.pay*1.05
        END s
    , DECODE( deptno, 10, t.pay*1.1, 20, t.pay*1.15, t.pay*1.05) r
    , t.sal * DECODE( deptno, 10, 1.1, 20, 1.15, 1.05) t
FROM t;


-- [����] insa ���̺��� �ѻ����, �����������, ���û���, ���� ���� �����


    
SELECT 
     COUNT(DECODE(SIGN(TO_DATE(SUBSTR(ssn, 3, 4), 'MMDD') - TRUNC(SYSDATE)), 0, '����')) "������ ���"
     ,COUNT(DECODE(SIGN(TO_DATE(SUBSTR(ssn, 3, 4), 'MMDD') - TRUNC(SYSDATE)), 1, '������')) "������ ���"
     ,COUNT(DECODE(SIGN(TO_DATE(SUBSTR(ssn, 3, 4), 'MMDD') - TRUNC(SYSDATE)), -1, '������')) "������ ���"
     ,COUNT(ssn) "�ѻ�� ��"
FROM insa;


SELECT COUNT(*)
    , COUNT( DECODE(s, 1, 'o')) "������ �����"
    , COUNT( DECODE(s, 0, 'o')) "���ϻ����"
    , COUNT( DECODE(s, -1, 'o')) "������ �����"
FROM (
    SELECT num, name, ssn
        , SIGN( TO_DATE( SUBSTR( ssn, 3, 4) , 'MMDD') - TRUNC(SYSDATE)) S
        FROM insa
    ) t;
    
    
    
SELECT
    CASE S
        WHEN 1 THEN '������'
        WHEN 0 THEN '����'
        ELSE '������'
    END ����üũ
    , COUNT(*) �����
FROM (
    SELECT num, name, ssn
        , SIGN( TO_DATE( SUBSTR( ssn, 3, 4) , 'MMDD') - TRUNC(SYSDATE)) S
        FROM insa
    ) t
GROUP BY s;


-- [����] emp ���̺��� ��� pay ���� ���ų� ���� ������� �޿����� ���

WITH a AS 
    (
    SELECT TO_CHAR(AVG(sal + NVL(comm, 0)), '9999.00') AVG_PAY
    FROM emp
    )
    , b AS
    (
    SELECT empno, ename, sal + NVL(comm, 0) pay
    FROM emp
    )
SELECT SUM(a.AVG_PAY) -- ��� �޿����� ���� �޴� ������� �޿���
FROM a, b
WHERE b.pay > a.AVG_PAY; 


SELECT 
    SUM (DECODE ( SIGN ( pay - avg_pay )  , 1 , pay )) s
    , SUM (
        CASE
            WHEN  pay - avg_pay > 0 THEN pay
            ELSE NULL
        END 
        ) e
FROM (
    SELECT empno, ename, sal + NVL(comm, 0) pay
        , (SELECT ROUND( AVG(sal+NVL(comm, 0)), 2) FROM emp) avg_pay
        FROM emp
    );

-- [����] emp , dept ���̺��� ����ؼ�
-- �μ����� �������� �ʴ� �μ��� �μ���ȣ�� �μ��� ���


SELECT dname, d.deptno 
FROM emp e RIGHT OUTER JOIN dept d ON d.deptno = e.deptno
--FROM emp e INNER JOIN dept d ON d.deptno = e.deptno -- JOIN�� �ƹ��͵� ���ָ� INNER JOIN�� default��
WHERE e.deptno IS NULL;


SELECT t.*
FROM (
    SELECT  dname , d.deptno ,COUNT(empno) cnt
    FROM emp e RIGHT OUTER JOIN dept d ON d.deptno = e.deptno
    GROUP BY d.deptno , dname
    ORDER BY d.deptno ASC
    ) t
WHERE t.cnt = 0;


WITH t AS   (
    SELECT deptno
    FROM dept
    MINUS
    SELECT DISTINCT deptno
    FROM emp
    )
SELECT dname, d.deptno
FROM t JOIN dept d ON d.deptno = t.deptno;

SELECT *
FROM dept d JOIN (
    SELECT deptno
    FROM dept
    MINUS
    SELECT DISTINCT deptno
    FROM emp
    ) t ON t.deptno = d.deptno;

SELECT p.deptno, p.dname
FROM dept p
WHERE NOT EXISTS ( SELECT empno FROM emp WHERE deptno = p.deptno) ;
WHERE ( SELECT COUNT(*) FROM emp WHERE deptno = p.deptno) = 0 ;


--WITH
--SELECT 
--FROM
--WHERE
--GROUP BY
--HAVING
--ORDER BY

SELECT d.deptno, d.dname, COUNT(empno) cnt
FROM dept d LEFT OUTER JOIN emp e ON d.deptno = e.deptno
 -- WHERE cnt = 0  -- ORA-00904: "CNT": invalid identifier
GROUP BY d.deptno, d.dname
HAVING COUNT(empno) = 0
ORDER BY d.deptno;

-- [����] insa ���̺��� �� �μ��� ���ڻ������ �ľ��ؼ� 5�� �̻��� �μ� ���� ���
-- ������ 7
-- �ѹ��� 5





SELECT buseo, COUNT(*) cnt
FROM insa
WHERE MOD(SUBSTR (ssn, 8, 1) , 2) = 0
GROUP BY buseo
HAVING COUNT(*) >= 5
ORDER BY cnt DESC;



SELECT *
FROM insa;


-- emp ���̺��� �μ���, job�� ����� �޿� ������ ��ȸ

SELECT deptno , job , SUM(sal + NVL(comm, 0)) deptno_pay_sum
    , COUNT(*) cnt
    , AVG(sal + NVL(comm, 0))
    , MAX(sal + NVL(comm, 0))
FROM emp
GROUP BY deptno, job
ORDER BY deptno, deptno_pay_sum;


-- ( �ϱ� ) PARTITION OUTER JOIN ����
-- PARTITION BY(deptno) : �μ������� ��Ƽ�� ������ ��� �μ��� ���� �������� ���
WITH t AS (
            SELECT DISTINCT job
            FROM emp
          )
SELECT deptno, t.job, NVL(SUM(sal+NVL(comm, 0)),0) pay_sum
FROM t LEFT OUTER JOIN emp e PARTITION BY(deptno) ON t.job = e.job
GROUP BY deptno, t.job
ORDER BY deptno;


SELECT deptno, COUNT(*)
FROM emp
GROUP BY deptno

SELECT job, COUNT(*)
FROM emp
GROUP BY job;

-- GROUPING SETS ��
SELECT deptno, job, COUNT(*)
FROM emp
GROUP BY GROUPING SETS(deptno, job);

SELECT ename
FROM emp
WHERE deptno = 10;

SELECT ename
FROM emp
WHERE deptno = 20;

SELECT ename
FROM emp
WHERE deptno = 30;

-- [ LISTAGG �Լ� ]
-- �ϱ� �صα�
SELECT d.deptno, COUNT(ename)
    , NVL(LISTAGG(ename, ',') WITHIN GROUP ( ORDER BY ename ), '����� �����ϴ�') "SAWON"
FROM dept d LEFT JOIN emp e ON d.deptno = e.deptno
GROUP BY d.deptno;

SELECT ename, sal
    , CASE 
        WHEN sal BETWEEN 700 AND 1200 THEN 1
        WHEN sal BETWEEN 1201 AND 1400 THEN 2
        WHEN sal BETWEEN 1401 AND 2000 THEN 3
        WHEN sal BETWEEN 2001 AND 3000 THEN 4
        WHEN sal BETWEEN 3001 AND 9999 THEN 5
      END grade
FROM emp;

SELECT *
FROM salgrade;

SELECT ename, sal, grade, losal ||'~'|| hisal
FROM emp , salgrade 
WHERE sal BETWEEN losal AND hisal;
-- NON EQUL JOIN + INNER JOIN ( �� �� �ش��ϴ� JOIN����)
SELECT ename, sal, grade, losal || '~' || hisal
FROM emp  JOIN salgrade ON sal BETWEEN losal AND hisal;


SELECT *
FROM insa
WHERE REGEXP_LIKE(ssn, '^7\d12*-\d*');
WHERE ssn LIKE '7%' ;



-- ���� �Լ� 
-- 1) RANK() : �������� 2���̻� ���� ��� ����� ���� �� ��������� �� ��� ��ŭ +�Ǿ ��µȴ�. 9 9 11
-- 2) DENSE_RANK() : ���� ���� 2�� �̻� ������� ����� ���� �� ��������� �׳� ��µȴ�. 9 9 10
-- 3) PERCENT_RANK() 
-- 4) ROW_NUMBER() : �������� 2�� �̻� �־ ����� �ٸ��� ���´� 9 10 11
-- 5) FIRST()/LAST()

-- [����] emp ���̺��� sal ���� �Űܺ���,

SELECT empno, ename, sal
    , RANK() OVER( ORDER BY sal DESC) r_rank
    , DENSE_RANK() OVER(ORDER BY sal DESC) d_rank
    , ROW_NUMBER()  OVER(ORDER BY sal DESC) rn_rank
    , PERCENT_RANK() OVER(ORDER BY sal DESC) p_rank
FROM emp;

-- partition by ���� ����ϸ� �� �μ����� ��� �Ű��ش�.
SELECT empno, ename, sal
    , RANK() OVER( PARTITION BY deptno ORDER BY sal DESC) r_rank
    , DENSE_RANK() OVER( PARTITION BY deptno ORDER BY sal DESC) d_rank
    , ROW_NUMBER()  OVER( PARTITION BY deptno ORDER BY sal DESC) rn_rank
    , PERCENT_RANK() OVER( PARTITION BY deptno ORDER BY sal DESC) p_rank
FROM emp;

-- [ ���� ] emp ���̺���
-- �� ����� �޿��� ��ü ����, �μ��� ������ ���,

SELECT deptno, empno, ename, sal
    , DENSE_RANK() OVER( ORDER BY sal DESC) all_rank
    , DENSE_RANK() OVER( PARTITION BY deptno ORDER BY sal DESC) dept_rank
FROM emp
ORDER BY deptno;

-- ROLLUP / CUBE ������
-- insa ���̺��� 
-- ���� ����� : 31��
-- ���� ����� : 29��
-- ��ü ����� : 60��

WITH t AS
    (
    SELECT MOD(SUBSTR(ssn, 8, 1),2) GENDER FROM insa
    )
SELECT 
      COUNT(DECODE( t.GENDER , 1 , 'O')) "���ڻ����"
    , COUNT(DECODE( t.GENDER , 0 , 'O')) "���ڻ����"
    , COUNT(t.GENDER) "��ü�����"
FROM t;

SELECT
     DECODE(MOD(SUBSTR(ssn, 8, 1),2), 1 , '����' ,'����') GENDER 
    , COUNT(DECODE( MOD(SUBSTR(ssn, 8, 1),2), 1, '���ڻ����', '���ڻ����')) �����
FROM insa t
GROUP BY MOD(SUBSTR(ssn, 8, 1),2)
UNION 
SELECT DISTINCT '��ü', (SELECT COUNT(*) FROM insa)
FROM insa;



SELECT
     DECODE( MOD(SUBSTR(ssn, 8, 1),2), 1, '����', 0, '����', '��ü')||'�����' GENDER
    , COUNT(*) "�����"
FROM insa
GROUP BY CUBE(MOD(SUBSTR(ssn, 8, 1),2));
GROUP BY ROLLUP(MOD(SUBSTR(ssn, 8, 1),2));


-- ����

SELECT buseo, jikwi
    , COUNT(*) cnt
    , SUM ( basicpay)
FROM insa
GROUP BY buseo, ROLLUP(jikwi)
--GROUP BY ROLLUP(buseo, jikwi)
--GROUP BY CUBE(buseo, jikwi)
ORDER BY buseo;


-- emp ���̺��� ���� ���� �Ի��� ����� ���� �ʰ� �Ի��� ����� ����


SELECT  
      MAX(hiredate) max
    , MIN(hiredate) min
    , MIN(hiredate) - MAX(hiredate)  "DATE"
FROM emp;



SELECT ename, hiredate 
FROM emp
ORDER BY hiredate DESC;


-- ���� insa ���̺��� �� ������� �� ���̸� ����ؼ� ���
-- 1) ������ = ���س⵵ - ���ϳ⵵ (���� ������ x -1)
--         ��. ���� �������� ����
--         ��. 981012-xxxxxxx
--              12 1900, 34 2000, 89 1800



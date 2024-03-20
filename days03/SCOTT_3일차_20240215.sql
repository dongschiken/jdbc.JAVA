-- SCOTT

SELECT DISTINCT buseo
FROM insa
ORDER BY buseo ASC;

SELECT sal + NVL(comm, 0) PAY
FROM emp
WHERE sal + NVL(comm, 0) BETWEEN 2000 AND 4000
ORDER BY PAY DESC;


SELECT ename, empno, NVL( ''||mgr, 'ceo') mgr
FROM emp
WHERE mgr IS NULL;

-- insa ���̺��� �����, �ֹε�Ϲ�ȣ, ���� �⵵, ���� ��, ���� ��, ���� ���

SELECT name, ssn, SUBSTR( ssn, 8, 1) gender
     , SUBSTR ( ssn, 1, 2) year
     , SUBSTR ( ssn, 3, 2) month
     , SUBSTR ( ssn, 5, 2) "DATE"
FROM insa;
--WHERE SUBSTR( ssn, 8, 1) = '1'

-- ����
--SELECT name, CONCAT(SUBSTR( ssn, 1, 8), '******') rrn
SELECT name, SUBSTR( ssn, 1, 8) || '******' rrn
FROM insa
WHERE TO_NUMBER(SUBSTR(ssn, 1,2)) BETWEEN  70  AND  79
--WHERE SUBSTR(ssn, 1,1) = '7'
ORDER BY ssn ASC;

-- TO_DATE�ϰ� 'YY' ���̱�
 select name, substr(ssn,0,8) || '******' rrn,
 TO_DATE(SUBSTR(ssn, 0, 2), 'YY')
 from insa
 where extract (year from to_date(substr(ssn,0,6)) ) between 1970 and 1979 ;


-- �������� �ƴ� ����� ���
SELECT *
FROM insa
--WHERE city != '����' AND city != '���' AND city != '��õ'
--WHERE NOT ( city = '����' OR city = '���' OR city = '��õ' )
WHERE city NOT IN ('����', '��õ', '���' )
ORDER BY city;

-- �Ի����ڰ� 81�⵵�� ����� ���� ���
-- ����Ŭ�� �񱳿����ڴ� ����, ����, ��¥�� ��� ���� �� �ִ�.
-- 1�� Ǯ��
SELECT *
FROM emp
WHERE hiredate BETWEEN '81/01/01' AND '81/12/31';


-- 2�� Ǯ��
SELECT ename, EXTRACT( year FROM hiredate )
FROM emp
--WHERE TO_CHAR( hiredate, 'YYYY') = '1981';
WHERE EXTRACT( YEAR FROM hiredate ) = '1981';




-- 3�� Ǯ��
SELECT 'abcdefg'
    , SUBSTR ( 'abcdefg', 1, 2) -- 1�� ù ��° ���� ab
    , SUBSTR ( 'abcdefg', 0, 2) -- 0�� ù ��° ���� ab
    , SUBSTR ( 'abcdefg', 3)    -- 3��° ���� ������ cdefg
    , SUBSTR ( 'abcdefg', -5, 3)   -- �ڿ������� �ټ� ��° ���� 3�� cde
    , SUBSTR ( 'abcdefg', -1, 1)   -- �ڿ��� ù ��° ���� 1�� g
FROM dual;

SELECT ename, EXTRACT( year FROM hiredate ) year
FROM emp
WHERE SUBSTR ( hiredate, 1, 2) = '81';

-- ���� ��¥�� ��/��/�� ��� : DATE( �� ) , TIMESTAMP( ���� ������ + �ð��� ���� )
-- dual�� ��¥�� 1���� ������� �ӽ� ���̺�
-- SYSDATE�� ()�� ������ �Լ��̴�. (�ڹٶ� �ٸ���)
SELECT SYSDATE, CURRENT_TIMESTAMP  
    , EXTRACT( YEAR from SYSDATE )  -- ���� ���·� ���        2024
    , TO_CHAR( SYSDATE, 'YYYY')     -- ���ڿ� ���·� ��¥ ��� '2024'
    , TO_CHAR( SYSDATE, 'YY')
    , TO_CHAR( SYSDATE, 'YEAR')
FROM dual;


SELECT NVL(TO_CHAR(mgr), 'CEO') mgr
FROM emp
WHERE mgr IS NULL;


SELECT num, name, tel, NVL2(tel, 'O', 'X') telOX
FROM insa;


SELECT num, name, NVL2(tel, 'O', 'X') tel
FROM insa;


SELECT empno, ename, sal, NVL(comm, 0) comm, sal + NVL(comm, 0) pay
FROM emp;

SELECT DISTINCT buseo
FROM insa
ORDER BY buseo ASC;

SELECT deptno, ename, sal, comm, sal + NVL(comm, 0) pay
FROM emp
WHERE deptno = 30 AND comm IS NULL
ORDER BY pay DESC;


SELECT ename, empno, sal, comm, sal + NVL(comm, 0) pay, deptno
FROM emp
WHERE sal + NVL(comm, 0) >= 1000 AND sal + NVL(comm, 0) <= 3000 AND deptno != 30
ORDER BY ename ASC;


SELECT *
--FROM user_sys_privs; -- �ý��� ���� = UNLIMITED TABLESPACE
FROM user_role_privs; -- ������ ������ �ִ� role = CONNECT, RESOURCE


SELECT ename, empno, sal, comm, sal + NVL(comm, 0) pay, deptno,
NVL2(comm, sal+comm, sal+0) pay2
FROM emp
--WHERE sal + NVL(comm, 0) >= 1000 AND sal + NVL(comm, 0) <= 3000 AND deptno != 30
WHERE sal + NVL(comm, 0) BETWEEN 1000 AND 3000 AND deptno != 30
ORDER BY ename ASC;    


SELECT ename, empno, sal, comm, sal + NVL(comm, 0) pay, deptno
FROM emp
WHERE sal + NVL(comm, 0) BETWEEN 1000 AND 3000 AND deptno != 30
ORDER BY ename ASC;   

-- ����������?? SELECT(����)�� �ȿ� �Ǵٸ� SELECT(����)���� �ִ� ��츦 ���������� �Ѵ�.
-- WHERE�������� ���� ������ ������ NESTED ����������
-- FROM�� �ڿ� ���� ������ ������ INLINE VIEW��� �Ѵ�.
? ���� ���Ǵ� query�� ����ϱ� ���� with ���� �̸� query block���� ������ �� ����Ѵ�.
? �������������� sub query�� ���� ����� ����� ���� main query�� ����Ǳ� ������ ������������ ������ ���ϵȴ�.
? With ���� ���� ���������� ���� ���� �����ϰ� ����� �� �ְ� �Ѵ�.
? WITH ���� ���� ���� sub query�� �ϳ��� main query���� ���� �� ����� ���⼺�� ���� �����ϰ� �����Ͽ� ��������ν� ������������ �߻��� �� �ִ� �������� ������ ������ �� �ִ�.
? ����, �ϳ��� main query�� ���ǵ� sub query�� with ���� �Բ� �����ϰ�, ������ sub query�� ���ǵ� �� sub query�� ����� �ζ��� ���� �̸��� ����ڰ� ������ �����Ѵ�. ���� ���� sub query�� ���ȴٸ� ������� �����ϸ� �ȴ�.
? sub query�� ������ ������, ������ ����� main query���� �ۼ��ϴµ�, �ʿ��� sub query�� �ζ��� ���� �̸����� ���ο� sub query�� �ۼ��Ͽ� ����Ѵ�. 
�����ġ�
    WITH  query1�̸� AS (subquery1),
          query2�̸� AS (subquery2), ...

?? with�� �ӿ� �ݵ�� select ���� �־�� ��
?? query��� ������ ���̺���� �����ϰ� ���Ǵ� ���, ���� ������ �켱��
?? �ϳ��� with���� ���� ���� query block ����� �����ϴ�.
?? with���� �ҷ��� ����ϴ� body ���������� block���� �켱�ǹǷ� ���̺���� ����� �� ����.
?? with�� ���� �� �ٸ� with���� ������ �� ����.
?? set operator�� ����� ���������� ����� �� ����.

-- �׽�Ƽ�� ���� ������
-- WITH�� ������ �������� ��Ī�� temp�� �ΰ� FROM ���� temp�� �����ͼ� t��� ��Ī���� ���ڴ�.
WITH temp AS 
    ( 
    SELECT deptno, ename, sal + NVL(comm, 0) pay
    FROM emp
    )
SELECT t.*
FROM temp t
WHERE t.pay BETWEEN 1000 AND 3000 AND t.deptno != 30
ORDER BY ename ASC;


-- �ζ��� ��
Inline view�� view�� �̿��ϴµ�, create�� ��Ű�� �ʰ� �ٷ� SQL�ȿ� ����Ͽ� ����ϴ� �����̴�.
������ view�� create�Ͽ� ������, ���� ����Ͽ��� ȿ�밡ġ�� �ִµ�,
 Ư�� DML(data manipulation language: select,insert,delete,update)����
 �ѹ��� ���� �ٽ� ���� ���� ���� ���� ��츦 ������ ����. 
�ѹ��� ������ �並 ����� ���´ٸ� �䰡 ��������
  ������� �䰡 � ������ �ϱ� ���� ������ ������ �����ϰ� ����ؾ� ���߿� ����� �� �ִ�. 
�䰡 �ʹ� �������ٸ� �װ� ���� ������ �ȴٴ� ���̴�. 
�̷��� ��ȸ������ ���̴� �並 SQL������ ���Խ��Ѽ� ���ϰ� ������ڴ� �ǵ����� inline view�� ����Ѵ�.
view�ȿ��� �� �ٸ� view�� �ʿ�� �ϴ� ��쵵 ���������̴�.
 �� ���� ��ø�� �Ͼ�� �װ��� ��� create ��Ű�鼭 � view���� � view�� �̿��ϴ����� �˾Ƴ��� �͵� ���� ���� ���̱� �����̴�.
 ������ inline view�� ����� �����̴�.

-- �ζ��� �� ����������
-- FROM�� �ڿ� ���� �������� t�� �ΰڴ�.
SELECT t.*
FROM   
    ( 
    SELECT deptno, ename, sal + NVL(comm, 0) pay
    FROM emp
    ) t
WHERE t.pay BETWEEN 1000 AND 3000 AND t.deptno != 30
ORDER BY ename ASC;


SELECT num, name, NVL2(tel, 'O', 'X') tel
FROM insa
WHERE buseo = '���ߺ�';

-- ���� : insa ���̺��� 

SELECT name, ssn
FROM insa
WHERE ssn LIKE '7%';
-- 7�� �����ϴ� SSN ���

SELECT name, ssn
FROM insa
--WHERE ssn LIKE '7_12%'; -- 70��� ���̸鼭 12�� ������ �����
WHERE ssn LIKE '__12%';
--WHERE EXTRACT( MONTH FROM TO_DATE( SUBSTR (ssn, 3, 2 ), 'MM')) = 12;
--WHERE SUBSTR( ssn, 3, 2) = 12;


-- ���� : insa ���̺��� �达 ���� ���� ��� ��� ���

SELECT name, ssn
FROM insa
WHERE name NOT LIKE '��%'
--WHERE name LIKE '_��_'    => ��� ���ڰ� '��'�̸� ���
--WHERE name LIKE '%��_'  => �ڿ��� 2��° ���ڰ� '��'�̸� ���
--WHERE name LIKE '%��%'  => �̸��ӿ� '��'�̶�� ���ڰ� ������ ���� ���
ORDER BY ssn ASC;



��ŵ��� ����, �λ�, �뱸 �̸鼭 ��ȭ��ȣ�� 5 �Ǵ� 7�� ���Ե� �ڷ� ����ϵ� �μ����� ������ �δ� ��µ��� �ʵ�����. (�̸�, ��ŵ�, �μ���, ��ȭ��ȣ)

DESC insa;
--  SUBSTR(buseo, 1, LENGTH(buseo)- 1) => �μ��� ���� ã�ƿͼ� ������ �ѱ��� ��� X
SELECT name, city, SUBSTR(buseo, 1, LENGTH(buseo)- 1) buseo, tel
FROM insa
WHERE city IN ('����', '�λ�', '�뱸') AND tel LIKE '%5%' OR tel LIKE '%7%';

-- �������� : ���� ���ϴ� ��� ������ ���̸� �ø��� ���̴� ����

-- LIKE �������� ESCAPE �ɼ� ����
-- dept ���̺� ���� Ȯ��

DESC dept;

SELECT deptno,dname, loc
FROM dept;
-- SQL 5���� : DQL, DDL, DML(INSERT, DELETE, UPDATE) + COMMIT ROLLBACK, TCL, DCL
-- DML(INSERT) ����ؼ� dept �μ� �ϳ� �߰�


INSERT INTO ���̺�� [( �÷���, �÷���...)] VALUES (��...);
COMMIT;


INSERT INTO dept VALUES ( 60, '�ѱ�_����', 'COREA' );
-- deptno�� PK�� 50�� �̹� �־ �� �� ����.
-- ORA-00001: unique constraint (SCOTT.PK_DEPT) violated : ���ϼ� ���� ���� ����ȴ�.
-- 1 �� ��(��) ���ԵǾ����ϴ�.



SELECT *
FROM dept;

-- dept ���̺��� �μ����� ������ �˻� �ϴµ� �μ��� _�� �ִ� �μ� ������ ��ȸ

SELECT *
FROM dept
WHERE dname LIKE '%\%%' ESCAPE '\';
-- \�� ���� ���ϵ�ī��� ���ڷ� ����ϰڴ� ==> ESCAPE '\';

-- UPDATE
UPDATE [��Ű��].���̺��
SET �÷�=��, �÷�=��
[WHERE ������;] -- ���� WHERE���� ���ָ� ��� ���ڵ�(��) ����

-- LOC�� ���� 'XXX'�� ������Ʈ �ϰ� �ٽ� ROLLBACK
--UPDATE SCOTT.dept
--SET loc = 'XXX';
--ROLLBACK;

UPDATE SCOTT.dept
SET LOC = 'COREA', dname = '�ѱ۳���'
WHERE deptno = 60;
ROLLBACK;


-- ���� : 30�� �μ���, ������ -> 60�� �μ���, ���������� UPDATE
-- ����� ��ȣ�� ��� ���� ����� �κ�
UPDATE dept 
SET (dname, loc) = (SELECT dname, loc FROM dept WHERE deptno = 30)
WHERE deptno = 60;
COMMIT;

SELECT *
FROM dept;


-- DELETE
DELETE FROM [��Ű��.]���̺��
[WHERE ������] WHERE ������ ��� ���ڵ� ����

DELETE FROM dept ;
-- ORA-02292: integrity constraint (SCOTT.FK_DEPTNO) violated - child record found : ���Ἲ �������ǿ� ����ȴ�.

DELETE FROM dept
WHERE deptno IN (50, 60);

-- ���� : emp ���̺��� sal�� 10%�� �λ��ؼ� ���ο� sal�� �����ϼ���

UPDATE SCOTT.emp
SET sal = (sal + sal/10);
--SET sal = sal * 1.1;

SELECT sal
FROM emp;


-- LIKE ������ : %��_ ���ϵ�ī�常 ��밡���ϴ�.
-- REGEXP_LIKE �Լ� : ����ǥ���� ���� ��밡��
-- ���� : insa���̺��� ���� �达, �̾� �� ��� ��ȸ

SELECT *
FROM insa
WHERE REGEXP_LIKE (ssn, '^7[0-9]12');
WHERE REGEXP_LIKE (name, '^[^����]');-- �� �Ǵ� �̷� �̸��� �������� �ʴ� ���
WHERE REGEXP_LIKE (name, '[����]$'); -- �� �Ǵ� �ڷ� ������ ���
WHERE REGEXP_LIKE (name, '^(��|��)');
WHERE REGEXP_LIKE (name, '^[����]');
WHERE name LIKE '��%' OR name LIKE '��%';
WHERE SUBSTR(name, 1, 1) IN ( '��', '��');
WHERE SUBSTR(name, 1, 1) = '��' OR SUBSTR(name, 1, 1) = '��';


-- 70��� ���� ����� ��ȸ
-- ����Ŭ ������ ���ϴ� �Լ� MOD()
SELECT *
FROM insa
--WHERE REGEXP_LIKE( ssn , '7[0-9]12') AND SUBSTR(ssn, 8,1) = 1; -- �ֹε�� ��ȣ�� 1, 3, 5, 7, 9�϶� ����
--WHERE ssn LIKE '7%' AND MOD(SUBSTR(ssn, 8, 1), 2) = 1;
WHERE REGEXP_LIKE(ssn, '^7\d{5}-[13579]');
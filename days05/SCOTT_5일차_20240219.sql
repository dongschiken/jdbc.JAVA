-- SCOTT

-- ������
-- ������
-- ���ߺ� �̸鼭 ��õ�� ������� �ľ�

--[SET] ���� �����ڸ� ����� �� ������ ��
-- "expression must have same datatype as corresponding expression" : ������ ������ �ڷ����� �������Ѵ�.(�� Į���� ���Ҷ� �ڷ����� �ٸ��� ������ �߻�)
-- ORA-01789: query block has incorrect number of result columns : ���� ������ ����Ҷ� ���� SELECT Į�� ���� , ���� SELECT Į�� ���� �޶� �߻��ϴ� ����
SELECT name, city, buseo
FROM insa
WHERE buseo = '���ߺ�'
UNION ALL
SELECT name, city --, jikwi--basicpay
FROM insa
WHERE city = '��õ';

--[4]�� Ǯ�� (������ ������ ���) UNION : 17 , UNION ALL : 23
SELECT name, city, buseo
FROM insa
WHERE buseo = '���ߺ�'
--UNION
UNION ALL
SELECT name, city, buseo
FROM insa
WHERE city = '��õ';

--[3]�� Ǯ�� (������ ������ ���) MINUS : 9
SELECT name, city, buseo
FROM insa
WHERE buseo = '���ߺ�'
MINUS
SELECT name, city, buseo
FROM insa
WHERE city = '��õ'
MINUS
SELECT name, city, buseo
FROM insa
WHERE buseo = '���ߺ�';

--[2]�� Ǯ�� (������ ������ ���) INTERSECT : 6
SELECT name, city, buseo
FROM insa
WHERE buseo = '���ߺ�'
INTERSECT
SELECT name, city, buseo
FROM insa
WHERE city = '��õ';

--[1]�� Ǯ��
SELECT *
FROM insa
WHERE buseo = '���ߺ�' AND city = '��õ';



-- insa ���̺��� ������� + emp ���̺��� ��� ���� ��� ���
SELECT buseo, num, name, ibsadate, basicpay, sudang
FROM insa
UNION ALL
SELECT TO_CHAR(deptno), empno, ename, hiredate, sal, comm
FROM emp;


-- ������ ���� ������
-- PRIOR, CONNECT, BY_ROOT

-- ���� ������ ||

-- ��� ������ 
-- +  -  /  *  
-- ������ ���ϴ� �����ڴ� X
-- ������ ���ϴ� �Լ��� 
-- MOD(5, 3) 
-- REMAINDER(5, 3)


SELECT --10/0 -- ORA-01476: divisor is equal to zero
       --'A'/2 -- ORA-01722: invalid number
       MOD(10/0) -- ORA-00909: invalid number of arguments
FROM dual;

-- ����Ŭ �Լ�
-- 1. ������ �������� �����ϰ� ���ְ� �������� ���� �����ϴµ� ���Ǵ� ��
-- 2. ���� : ������ �Լ�, ������ �Լ�
-- ������ �Լ� : �ϳ��� ���ڵ� ���� �Ѱ��� ������� ó���Ǵ� �Լ�
-- ������ �Լ� : �������� ���ڵ尡 ���� �Ѱ��� ������� ó���Ǵ� �Լ�

-- �����Լ��� �Ϲ� ���ڵ�� �Բ� ����� �� ����. => GROUP BY�� ����ϸ� �����Լ��� �Ϲ� ���ڵ� �Բ� ����� �� �ִ�.
-- ���� �Լ�
-- 1) ROUND(number) ���ڰ��� Ư�� ��ġ���� �ݿø��Ͽ� �����Ѵ�. 
SELECT 3.141592
    , ROUND(3.141592)  -- Ư����ġ index���ָ� �Ҽ��� ù��° �ڸ����� �ݿø�
    , ROUND(3.141592, 0) -- 0�� �ָ� ���� ���� ���¿� ����
    , ROUND(3.141592, 2) -- �Ҽ��� 3��° �ڸ����� �ݿø�
    , ROUND(1234.5678, 2) d
    , ROUND(1234.5678, -1) e
    , ROUND(1234.5678, -2) f
    , ROUND(1234.5678, -3) g
FROM dual;

-- ORA-00937: not a single-group group function
--SELECT emp.*
--    , sal + NVL(comm, 0) pay
--    , COUNT(*)  �����
--FROM emp

SELECT emp.*, (SELECT COUNT(*) FROM emp) cnt
            , (SELECT SUM(sal + NVL(comm, 0)) FROM emp)total_pay
            -- ��� �޿� ����ؼ� �Ҽ��� 2�ڸ����� ���
            , (SELECT ROUND(AVG(sal + NVL(comm, 0)),2) FROM emp) AVG_PAY
FROM emp;

SELECT COUNT(*) -- NULL���� ������ ������ COUNT�Ѵ�.
    , COUNT(empno)  --12
    , COUNT(deptno) --12
    , COUNT(sal)    --12
    , COUNT(hiredate) 
    , COUNT(comm) --4  null���� ���Ե� �÷��� null�� ������ üũ���� �ʴ´�. 
FROM emp;


-- ��� comm�� ������??
SELECT AVG(comm) -- 550 null�� ������ �������� �ʰ� ��հ��
SELECT SUM(comm)/COUNT(*) -- 183.3333 null���鵵 ���Խ��Ѽ� ��հ��
FROM emp;

-- 2) ���� �Լ� : TRUNC(��¥, ����), FLOOR(����) 
--TRUNC(number) ���ڰ��� Ư�� ��ġ���� �����Ͽ� �����Ѵ�. 
-- TRUNC : ��¥�� ���� ��ο��� ���谡��
--FLOOR ���ڰ��� �Ҽ��� ù°�ڸ����� �����Ͽ� �������� �����Ѵ�. 
-- FLOOR : ���ڸ� ���谡��
-- ������ 1 : TRUNC(��¥, ����), FLOOR(����) ���� �����ϴ�.
-- ������ 2 : TRUNC()�� Ư�� ��ġ���� ������ �����ϰ�, FLOOR()�Լ��� �Ҽ��� ù ° �ڸ����� ���谡���ϴ�.
SELECT 3.141592
    , TRUNC(3.141592)    -- �Ҽ��� ù ��° �ڸ����� ����
    , TRUNC(3.141592, 0) -- �Ҽ��� ù ��° �ڸ����� ����
    , TRUNC(3.141592, 3)
    , TRUNC(3.141592, -1)
    , FLOOR(3.141592 * 1000) / 1000 -- �Ҽ��� �� ��° �ڸ����� ������ �� �ִ� ���
FROM dual;


-- CEIL ���ڰ��� �Ҽ��� ù°�ڸ����� �ø��Ͽ� �������� �����Ѵ�. 
-- 3) ���� �Լ� : CELI() : �Ҽ��� ù ��° �ڸ����� �ø�(����)�ϴ� �Լ�
SELECT CEIL(3.14), CEIL(3.54)
FROM dual;

-- 3.141592�� CEIL�� ����ؼ� �Ҽ��� �� ��° �ڸ����� �ø�����.
SELECT CEIL( 3.141592 *100 ) / 100 ceil
FROM dual;

-- �Խ��ǿ��� �� ������ ���� ����� �� CEIL()�Լ��� ����Ѵ�.
-- �� �Խñ�(���) ��
SELECT COUNT(*)
FROM emp;
-- emp ���̺��� �� ������� �ٸ� ������ �� ���
-- 2.4 �� ������ ���� ����ߴµ� �Ҽ����̸� �ø� ó�� �ع�����. => 3
SELECT CEIL((SELECT COUNT(*) FROM emp) / 5)
FROM dual;


MOD ���������� �����Ѵ�. 

-- 4) ABS() ���ڰ��� ���밪�� �����Ѵ�. 
SELECT ABS(100), ABS(-100)
FROM dual;


-- SIGN() : ���ڰ��� ��ȣ�� ���� (���)1, (0)0, (����)-1�� ������ �����Ѵ�. 
SELECT SIGN(100), SIGN(-100), SIGN(0)
FROM dual;

-- ���� : emp ���̺��� ��� �޿��� ���ؼ� �� ����� �޿�(pay)�� ��� �޿����� ������ '��ձ޿����� ����'��� ��� ������ '��ձ޿����� ����'��� ���
SELECT AVG(sal+NVL(comm, 0))
FROM emp;

-- [3]
SELECT  ename, pay, avg_pay
        ,NVL2(NULLIF(SIGN(pay - avg_pay), 1 ), '����' , '����')
FROM (
    SELECT ename, sal+NVL(comm, 0) pay
            , (SELECT AVG( sal + NVL(comm, 0)) avg_pay FROM emp) avg_pay
            FROM emp
    );


-- [2]
SELECT ename, sal+NVL(comm, 0) pay
       , REPLACE(REPLACE( SIGN(sal+NVL(comm, 0) - (SELECT AVG(sal+NVL(comm, 0)) FROM emp)), -1, '����'), 1, '����') SIGN_PAY
FROM emp;

-- [1]
SELECT s.*, '����'
FROM emp s
WHERE sal + NVL(comm, 0) > (SELECT AVG(sal+NVL(comm, 0)) FROM emp)
UNION
SELECT s.*, '����'
FROM emp s
WHERE sal + NVL(comm, 0) < (SELECT AVG(sal+NVL(comm, 0)) FROM emp);

-- POWER(n1,n2) n1^n2�� ���������� �����Ѵ�. 
SELECT POWER(2,3), POWER(2, -3)
FROM dual;

SQRT(n) n�� ������ ���� �����Ѵ�. 
SELECT SQRT(8)
FROM dual;


-- [���� �Լ�] --
-- INSTR() : 1�� ���ڿ� �ӿ��� 2�� ���ڿ��� ���Ե� INDEX���� �����ش�.
SELECT INSTR('Corea','e') e
FROM dual;


SELECT INSTR('corporate floor','or')      -- 2 (���� ó�� ������ or�� index��)
        -- 2��° or�� ����ִ� ��ġ���� ã�ƿ´�.
    ,  INSTR('corporate floor','or',3,2)  -- 14( �տ��� 3������� 2��° or�� index��)
    ,  INSTR('corporate floor','or',-3,2) -- 2 ( �ڿ��� 3������� 2��° or�� index��)
FROM dual;


SELECT '010-1234-5678' hp
     , SUBSTR( '02-1234-5678', 1, INSTR('02-1234-5678', '-') -1) a
     , SUBSTR( '02-1234-5678', INSTR('02-1234-5678', '-')+1, INSTR('02-1234-5678', '-', -1) - INSTR('02-1234-5678', '-')+1) b
     , SUBSTR( '02-1234-5678', INSTR('02-1234-5678', '-', -1)+1, 4) c
FROM dual;

DESC tbl_tel;

SELECT *
FROM tbl_tel;

SELECT SUBSTR( tel, 1, INSTR(tel, ')')-1) a
    , INSTR(tel, ')')-1
    , INSTR(tel, '-')
    , SUBSTR(tel, INSTR(tel, ')')+1, INSTR(tel, '-') - INSTR(tel, ')')-1) b
    , SUBSTR(tel, INSTR(tel, '-')+1) c
FROM tbl_tel;

INSERT INTO tbl_tel (tel, name) VALUES ('063)469-4567', 'ū����');
INSERT INTO tbl_tel VALUES ('052)1456-2367', '��°����');
COMMIT;

-- RPAD() / LPAD()
-- PAD == �� ��� ��, �޿� ���� ��, �е� // ���� �����ڸ��� ���� ���ϴ� ���ڷ� ä��ڴ�.
-- ���� ) RPAD(expr1, n, [expr2])
-- pay�� 10�ڸ� Ȯ���ϰ� ���� ������ *�� ä���ֱ�
SELECT ename, pay
    , RPAD(pay, 10, '*')
    , LPAD(pay, 10, '*')
FROM (
    SELECT ename, sal + NVL(comm, 0) pay    
    FROM emp    
    ) t;
    
-- RTRIM() : ������ ���� ���� / LTRIM() : ���� ���� ���� / TRIM() : ���� ���� ����
-- ���� ) RTRIM(char [, set])


SELECT '    admin    '
    , '[' || ' admin   ' || ']'
    , '[' || RTRIM(' admin   ') || ']'
    , '[' || LTRIM(' admin   ') || ']'
    , '[' || TRIM(' admin   ') || ']'
FROM dual;

-- TRIM()�� ����ϸ� ������ ���鸸�� ������ �� �ִ�.(���ڿ��� ���� �Ұ���) 
-- RTRIM����ϸ� ���� �����ʿ� �ִ� 'xy'�� ���� ���ڿ��� ���� �����ϴ�.
SELECT RTRIM('BROWINGyxXxy', 'xy')
    ,  RTRIM('BROWINGyxXxyxyxy', 'xy')
    ,  LTRIM('xyBROWINGyxXxyxyxy', 'xy')
    ,  RTRIM(LTRIM('xyBROWINGyxXxyxyxy', 'xy'), 'xy') -- ������ xy�� �����ϰ� ������ �ι� ����ؾ��Ѵ�.
--    ,  TRIM('xyBROWINGyxXxyxyxy', 'xy') �̷��� �ϸ� ���� �߻�
FROM dual;


SELECT ename
    , ASCII( SUBSTR(ename, 1, 1) ) -- �ƽ�Ű �ڵ尪 �����ö� ����ϴ� �Լ� 
    , CHR(ASCII( SUBSTR(ename, 1, 1) )) -- �ƽ�Ű �ڵ尪�� ���ڰ����� ��ȯ�ϴ� �Լ�
FROM emp;

SELECT ASCII('0'), ASCII('A'), ASCII('a')
FROM dual;


-- ���� ū �� GREATEST() / ���� ���� �� LEAST()
SELECT GREATEST(3, 5, 2, 4, 1)
     , GREATEST('R','A','Z','X')
     , LEAST(3, 5, 2, 4, 1)
     , LEAST('R','A','Z','X')
FROM dual;

-- VSIZE() BYTE���� �����ִ� �Լ�
SELECT ename
    , VSIZE(ename)  
    , VSIZE('ȫ�浿') -- 9 byte
    , VSIZE('a')
    , VSIZE('��')
FROM emp;

-- ��¥ ��ȯ �Լ�
SELECT SYSDATE, CURRENT_TIMESTAMP -- 24/02/19
    , ROUND(SYSDATE) -- ������ �������� ��¥�� �ݿø� �Ѵ�. -- 24/02/20
    , ROUND(SYSDATE, 'DD') b
    , ROUND(SYSDATE, 'MONTH') c -- �� ���� 15���� �������� 15�� �̻��̸� �����޷� �ٲﰪ�� ��� 2 / 15�� -> 3�� 1��
    , ROUND(SYSDATE, 'YEAR') d  -- �� ������ �������� 6���� ������ �����ظ� �������ش�. 6�� ���� �������� �̹������� ���
FROM dual;


SELECT SYSDATE
    , TO_CHAR( SYSDATE, 'YYYY.MM.DD.HH.MI.SS') A -- 2024.02.19.03.41.17
    , TRUNC(SYSDATE) -- 24/02/19
    , TO_CHAR( TRUNC(SYSDATE), 'YYYY.MM.DD.HH.MI.SS')  B -- 2024.02.19.12.00.00
    , TRUNC( SYSDATE, 'MONTH') C -- 24/02/01
    , TRUNC( SYSDATE, 'YEAR') D  --- 24/01/01
FROM dual;


-- ��¥ + ���� ��¥ ��¥�� �ϼ��� ���Ͽ� ��¥ ���
SELECT SYSDATE + 100 
FROM dual;


-- ���� : �Ի��� ��¥ ���� ���� ��¥���� �ٹ��� �ϼ� ����?
SELECT ename
    , hiredate
    , SYSDATE
    ,  TRUNC(SYSDATE+1) - TRUNC(HIREDATE) --�Ի� ��¥ ���� ���ó�¥ ���� �� ��¥ ���
FROM emp;

SELECT SYSDATE
    , TO_CHAR( SYSDATE + 1, 'YYYY/MM/DD HH24:MI:SS')
    -- SYSDATE + 2/24 => ���糯¥ + 2�ð��� ��Ÿ����.
    , TO_CHAR( SYSDATE + 2/24, 'YYYY/MM/DD HH24:MI:SS')
FROM dual;

-- 24�� 2�� ������ ��¥ ���ϱ��� �ִ���??

SELECT SYSDATE -- 24/02/19
    ,TRUNC( SYSDATE, 'DD') -- 24/02/19 �ð�, ��, �� ����
    ,TRUNC( SYSDATE, 'MONTH') -- 24/02/01 : �� ������ �� ��, �ð�, ��, �� ����
    -- 1�� ���ϱ�
    ,ADD_MONTHS( TRUNC( SYSDATE, 'MONTH'), -1) A -- 24/01/01 1���� �� ���� ��ȯ
    ,ADD_MONTHS( TRUNC( SYSDATE, 'MONTH'), 1) B -- 24/03/01 1���� ���� ���� ��ȯ
    -- 1���� ���� �ڿ� -1�� ���� �Ϸ� ���� 'DD'�ϸ� 29���� ���´�.
    ,TO_CHAR(ADD_MONTHS( TRUNC( SYSDATE, 'MONTH'), 1) -1, 'DD') C -- 2���� ������ ��¥�� ��ȯ 29��
    ,ADD_MONTHS( SYSDATE, 12) D -- 25/02/19 1���� ���� ��¥
FROM dual;

-- [����] �����Ϸκ��� ���ó�¥���� �ϼ�?
-- 2023.12.29 ����

SELECT CEIL( SYSDATE - TO_DATE('2023/12/29' , 'YYYY.MM.DD') ) "DATE"
FROM dual;

-- [����] ���ó�¥���� �����ϱ��� ���� �ϼ�?
-- 2024.06.14 ����
SELECT CEIL( TO_DATE(' 2024.06.14 ' , 'YYYY.MM.DD') - SYSDATE ) "DATE1"
    , ABS(CEIL( SYSDATE - TO_DATE(' 2024.06.14 ' , 'YYYY.MM.DD') ) ) "DATE2"
FROM dual;

SELECT SYSDATE
    , LAST_DAY(SYSDATE) -- 24/02/29 ������ ��¥ �������ִ� �Լ� LAST_DAT()
    , TO_CHAR(LAST_DAY(SYSDATE), 'DD') -- 29 ������ ��¥�� ���
FROM dual;


-- NEXT_DAY() �Լ� : 2��° �Ű������� �� ������ ���ƿ��� ���� �ֱ� ��¥�� ��ȯ�ϴ� �Լ�
SELECT SYSDATE
    , TO_CHAR( SYSDATE, 'YYYY/MM/DD (DY)') A  -- DY = ��
    , TO_CHAR( SYSDATE, 'YYYY/MM/DD (DAY)') B -- DAY = ������
    , NEXT_DAY( SYSDATE , '��') C  --24/02/23
    , NEXT_DAY( SYSDATE , '��') D  --24/02/26
FROM dual;

--[����] 4�� ù ��° ȭ���� ������ ( ��� )
-- SELECT TO_DATE( '2024.04.01') �̷��� �����ϴϱ� ���� �ֱ� �������� 24/04/08 ������ �����Ϸ� ������ ������ ���ܼ� -1�� ���� 3�� ������ ��¥���� �����ϵ��� ���� ����
-- NEXT_DAY()�� ���糯¥�� ���� X
SELECT TO_DATE( '2024.04.01')
    , NEXT_DAY( TO_DATE( '2024.04.01')-1 , 'ȭ') -- 24/04/02
    , NEXT_DAY( TO_DATE( '2024.04.01')-1 , '��')
FROM dual;

-- MONTH_BETWEEN() �� ��¥������ ���� ���� ��ȯ �ϴ� �Լ�

SELECT ename, hiredate
    , SYSDATE
    , CEIL( ABS( hiredate - SYSDATE ) ) "WORK_DATE" -- �ٹ� �� ��
    , CEIL( MONTHS_BETWEEN( SYSDATE, hiredate) ) "WORK_MONTH" -- �ٹ� ���� ��
    , ROUND (MONTHS_BETWEEN( SYSDATE, hiredate)/12, 2) "WORK_YEAR" -- �ٹ� �� ��
FROM emp;


SELECT SYSDATE
    , CURRENT_DATE
    , CURRENT_TIMESTAMP
FROM dual;



-- TO_CHAR(��¥, ����)
-- [����] insa ���̺��� pay�� ���ڸ����� �޸��� ����ϰ� �տ� ��ȭ��ȣ�� ������
SELECT num, name
    , basicpay
    , sudang
--    , basicpay + sudang pay
    , TO_CHAR(basicpay + sudang, '9,999,999L') pay
FROM insa;


SELECT 12345
    , TO_CHAR( 12345 )  -- 12345
    , TO_CHAR( 12345, '99,999') --  12,345
    , TO_CHAR( 12345, '99,999.00') --  12,345.00
    , TO_CHAR( 12345.123, '99,999.00') --  12,345.12
    , TO_CHAR( -100, 'S9999')
FROM dual;
-- SCOTT

SELECT sal + NVL(comm, 0) pay
    , (SELECT ROUND(AVG(sal + NVL(comm, 0)), 2) AVG_PAY FROM emp) AVG_PAY
    , (CEIL((sal + NVL(comm, 0)  - (SELECT AVG(sal + NVL(comm, 0)) AVG_PAY FROM emp))*100))/100 차올림
    , ROUND(sal + NVL(comm, 0)  - (SELECT AVG(sal + NVL(comm, 0)) AVG_PAY FROM emp), 2) "차 반올림"
    , TRUNC(sal + NVL(comm, 0)  - (SELECT AVG(sal + NVL(comm, 0)) AVG_PAY FROM emp), 2) 차내림
FROM emp;


-- WITH절 사용해서 풀기
WITH temp AS
    (SELECT comm, sal, sal + NVL(comm, 0) pay , (SELECT AVG(sal + NVL(comm, 0)) FROM emp)AVG_PAY FROM emp)
SELECT ename, deptno 
    , CEIL( ((t.sal + NVL(t.comm, 0)) - t.AVG_PAY) *100 )/100 CEIL_PAY
    , ROUND(( t.pay - t.avg_pay), 2) ROUND_PAY
    , TRUNC(( t.pay - t.avg_pay), 2) TRUNC_PAY
FROM temp t;



SELECT empno, ename
    , sal + NVL(comm, 0) pay
    , (SELECT ROUND(AVG(sal + NVL(comm, 0)), 2) AVG_PAY FROM emp) AVG_PAY
    , REPLACE(REPLACE(SIGN(sal + NVL(comm, 0) - (SELECT AVG(sal + NVL(comm, 0)) FROM emp)), -1 , '적다') , 1, '많다') AB
FROM emp GROUP BY empno, ename, sal + NVL(comm, 0);


SELECT DISTINCT (SELECT COUNT(*) FROM insa WHERE REGEXP_LIKE(ssn, '\d-[13579]')) "남자 사원수"
    , (SELECT COUNT(*) FROM insa WHERE REGEXP_LIKE(ssn, '\d-[24680]')) "여자 사원수"
    , REPLACE( MOD(SUBSTR(ssn, 8, 1), 2), 1, '여자'), 0
FROM insa;


SELECT '남자사원수' "성별", COUNT(*) 사원수
FROM insa
WHERE MOD(SUBSTR(ssn, 8, 1), 2) = 1
UNION
SELECT '여자사원수' "성별", COUNT(*)
FROM insa
WHERE MOD(SUBSTR(ssn, 8, 1), 2) = 0;


SELECT REPLACE(REPLACE( MOD(SUBSTR(ssn, 8, 1), 2), 1, '남자'), 0, '여자')||'사원수' GENDER, COUNT(*) 사원수
FROM insa
GROUP BY MOD(SUBSTR(ssn, 8, 1), 2);


SELECT *-- COUNT(*)/14
FROM insa;



SELECT ename, empno, job, mgr, hiredate, deptno, sal + NVL(comm, 0) pay
    , REPLACE(REPLACE(  sal + NVL(comm, 0), (SELECT MAX(sal + NVL(comm, 0)) pay FROM emp) , '최고 급여자'), (SELECT MIN(sal + NVL(comm, 0)) pay FROM emp) , '최저 급여자') "etc"
FROM emp
WHERE sal + NVL(comm, 0) >= ANY (SELECT MAX(sal + NVL(comm, 0)) pay FROM emp)
    OR sal + NVL(comm, 0) <= ANY (SELECT MIN(sal + NVL(comm, 0)) pay FROM emp);
    
    
SELECT *
FROM emp
--WHERE sal+NVL(comm,0) IN ( 5000, 800 );
--WHERE sal+NVL(comm,0) = (SELECT MAX(sal+NVL(comm,0)) max_pay FROM emp) 
--     OR sal+NVL(comm,0) = (SELECT MIN(sal+NVL(comm,0)) min_pay FROM emp);
WHERE sal+NVL(comm,0) IN (
                   (SELECT MAX(sal+NVL(comm,0)) max_pay FROM emp)
                  , (SELECT MIN(sal+NVL(comm,0)) min_pay FROM emp) 
      );     

SELECT emp.* , '최고 급여자' max_min
FROM emp
WHERE sal + NVL(comm, 0) = (SELECT MAX(sal + NVL(comm, 0)) pay FROM emp)
UNION ALL
SELECT emp.* , '최저 급여자'
FROM emp 
WHERE sal + NVL(comm, 0) = (SELECT MIN(sal + NVL(comm, 0)) pay FROM emp);


SELECT emp.* , '최고 급여자' max_min
FROM emp
WHERE sal + NVL(comm, 0) >= ALL (SELECT sal + NVL(comm, 0)FROM emp)
UNION ALL
SELECT emp.* , '최저 급여자'
FROM emp 
WHERE sal + NVL(comm, 0) <= ALL (SELECT sal + NVL(comm, 0)FROM emp);
    
    
    
    
SELECT ename, sal, comm 
FROM emp
WHERE comm is null OR comm <= 400;

-- LNNVL() 함수
-- LNNVL(NULL) => true
-- LNNVL(400) => false
SELECT ename, sal, comm 
FROM emp
WHERE LNNVL(comm >= 400);


SELECT CEIL(COUNT(*)/14) "총 팀수"
FROM insa;

SELECT ename, empno, sal + NVL(comm, 0) pay, deptno
FROM emp p
WHERE sal + NVL(comm, 0) >= ANY ( SELECT MAX(sal + NVL(comm, 0)) FROM emp c WHERE c.deptno = p.deptno)
ORDER BY deptno ASC;



SELECT ename, empno, sal + NVL(comm, 0) pay
FROM emp
WHERE deptno = 10 AND sal+NVL(comm, 0) = (SELECT MAX(sal + NVL(comm, 0)) FROM emp WHERE deptno = 10)
UNION
SELECT ename, empno, sal + NVL(comm, 0) pay
FROM emp
WHERE deptno = 20 AND sal+NVL(comm, 0) = (SELECT MAX(sal + NVL(comm, 0)) FROM emp WHERE deptno = 20)
UNION
SELECT ename, empno, sal + NVL(comm, 0) pay
FROM emp
WHERE deptno = 30 AND sal+NVL(comm, 0) = (SELECT MAX(sal + NVL(comm, 0)) FROM emp WHERE deptno = 30);



SELECT TO_CHAR(LAST_DAY(SYSDATE) , 'DD')
FROM dual;



-- 번호 14자리

SELECT  ssn, RPAD(SUBSTR(ssn,1, 8), 14, '*') RPAD_SSN
FROM insa;

SELECT deptno, ename 
    ,(sal + NVL(comm, 0)) pay
    ,RPAD( ' ' , ROUND((sal + NVL(comm, 0))/100)+1, '#')  BAR_LENGTH
FROM emp
WHERE deptno = 30
ORDER BY sal + NVL(comm, 0) DESC;



SELECT TRUNC( SYSDATE, 'YEAR' )
    , TRUNC( SYSDATE, 'MONTH' )      
    , TRUNC( SYSDATE  )
FROM dual;


SELECT TO_CHAR(NEXT_DAY( SYSDATE, '월'), 'DD')
FROM dual;


SELECT hiredate
    , ADD_MONTHS(hiredate, 12*10+5)+20 ADD_MONTH
FROM emp ;

SELECT SUBSTR(ssn, 1, 2) || TO_CHAR(SYSDATE, 'MM') || TO_CHAR(SYSDATE, 'DD') || SUBSTR(ssn, 7, 14)
FROM insa
WHERE num = 1002;


WITH temp AS 
    (
    SELECT ename, empno, sal + NVL(comm, 0) pay, (SELECT ROUND(AVG(sal + NVL(comm, 0)),2) FROM emp)avg_pay FROM emp
    )
SELECT temp.ename, temp.empno, temp.pay, temp.avg_pay
FROM temp
WHERE temp.pay > temp.avg_pay;

SELECT ename, sal+NVL(comm, 0) pay
    , ROUND((sal+NVL(comm, 0)) / (SELECT MAX(sal+NVL(comm, 0)) FROM emp)*10) "별 갯수"
    , RPAD( ' ' , ROUND((sal+NVL(comm, 0)) / (SELECT MAX(sal+NVL(comm, 0)) FROM emp)*10)+1, '*') 별
FROM emp GROUP BY ename, sal+NVL(comm, 0);

WITH t AS (
SELECT ename, sal + NVL(comm, 0) pay
    , ( SELECT SUM(sal + NVL(comm, 0) )  FROM emp) sum_pay
FROM emp
)
SELECT t.pay, t.ename, t.sum_pay
    , ROUND( t.pay / t.sum_pay * 100 , 3) PERSENT
    , RPAD (' ' , ROUND( t.pay / t.sum_pay * 100 )+1 , '*') "별"
FROM t;

-- TOP_N 을 사용해서 급여 가장 많이 받는 사원들 조회
-- 실제 존재하지 않는 컬럼을 선언하는 것을 슈도 컬럼(의사 컬럼) 이라고 한다. ==> rownum 
SELECT e.*, ROWNUM 
FROM (
    SELECT empno, ename, hiredate, sal, comm, sal + NVL(comm, 0) pay
    FROM emp 
    ORDER BY sal + NVL(comm, 0) DESC
    ) e
--WHERE ROWNUM BETWEEN 3 AND 5;   : 1등부터 ~N등 까지는 가져올 수 있지만 3등 ~ 5등과 같이 사이에 있는 값은 결과가 안나온다. 꼭 1~N까지만 출력
WHERE ROWNUM<= 3;
    
-- RANK 함수 사용해서 DESC 급여 가장 많이 받는 사람 / ASC 하면 급여 가장 적게 받는 사람
-- 3등에서 ~ 5등 까지도 가져올 수 있다.
SELECT e.*
FROM (
SELECT 
      RANK() OVER( ORDER BY sal + NVL(comm, 0) ASC) RANK
    , empno, ename, hiredate, sal + NVL(comm, 0) pay
FROM emp
) e
WHERE e.rank BETWEEN 3 AND 5;

-- 각 부서별 PAY 2등까지 출력
SELECT e.*
FROM(
SELECT 
    deptno
    , RANK() OVER( PARTITION BY deptno ORDER BY sal + NVL(comm, 0) DESC, ename ) "dept_pay_rank"
    , deptno, empno, ename, hiredate, sal + NVL(comm, 0) pay
FROM emp
) e
WHERE e.dept_pay_rank = 1;

SELECT ename, empno, sal + NVL(comm, 0) pay, deptno
FROM emp p
WHERE sal + NVL(comm, 0) >= ANY ( SELECT MAX(sal + NVL(comm, 0)) FROM emp c WHERE c.deptno = p.deptno)
ORDER BY deptno ASC;

-- 기존 주민 번호 801007-1544236
UPDATE insa
SET ssn = SUBSTR(ssn, 1, 2) || TO_CHAR(SYSDATE, 'MMDD') || SUBSTR(ssn, 7, 14)
WHERE num = 1002;
COMMIT;

SELECT *--SUBSTR(ssn, 1, 2) || TO_CHAR(SYSDATE, 'MMDD') || SUBSTR(ssn, 7, 14)
FROM insa
WHERE num = 1002;

-- TRUNC로 현재 날짜에서 시, 분, 초 절삭해서 다시 계산
SELECT name, ssn, SYSDATE
    , SUBSTR(ssn, 3, 4) ssn_mmdd
    , TO_DATE(SUBSTR(ssn, 3, 4), 'MMDD')
    , SIGN(TO_DATE(SUBSTR(ssn, 3, 4), 'MMDD') - TRUNC(SYSDATE))
    , REPLACE(REPLACE(REPLACE( SIGN(TO_DATE(SUBSTR(ssn, 3, 4), 'MMDD') - TRUNC(SYSDATE)), -1 , '지남') , 1 , '지나지 않음'), 0, '오늘')
FROM insa;
-- JOIN(조인)
--               관계
-- dept(부서)   소속관계    emp(사원)
--     1                     0    (부서는 1개 이상 꼭 있어야하고, 사원은 0개 있어도 된다)
-- 부모 테이블             자식 테이블


-- [ 문제 ] 사원 정보를 출력 ( 부서번호, 부서명, 사원명,입사일자 ) JOIN 사용
-- dept : deptno, dname, loc
-- emp  : deptno, empno, ename, sal, job, comm, hiredate
-- ORA-00918: column ambiguously defined : 컬럼이 애매하게 선언되어 있다.
-- deptno가 dept테이블과 emp테이블 둘다 있어서 dept.deptno 또는 emp.deptno라고 해야한다.
-- [1]번
SELECT dept.deptno, dname ,ename, hiredate
FROM emp , dept  -- 테이블 2개 서언하면 JOIN
WHERE emp.deptno = dept.deptno  -- JOIN 조건절
ORDER BY dept.deptno;  

-- [2]번
SELECT dept.deptno, dname ,ename, hiredate
FROM emp JOIN dept ON emp.deptno = dept.deptno   -- JOIN 조건절
ORDER BY dept.deptno;



-- 오늘 수업 --
TO_CHAR(NUMBER) : 숫자를 -> 문자로 변환
TO_CHAR(DATE)   : 날짜를 -> 문자로 변환


--WW  년중 몇번째 주 (sysdate,'WW') 44 
--W   월중 몇번째 주 (sysdate,'W') 4 
--IW  1년중 몇째주 (systimestamp,'IW') 07 

SELECT SYSDATE
    , TO_CHAR(SYSDATE, 'CC')  -- 세기
    , TO_CHAR(SYSDATE, 'DDD') -- 해당 연도의 몇일이 지났는지
    , TO_CHAR(SYSDATE, 'WW')  -- 08  년중 몇번째 주
    , TO_CHAR(SYSDATE, 'W')   -- 3   월중 몇번째 주
    , TO_CHAR(SYSDATE, 'IW')  -- 08  1년중 몇째주
FROM dual;

-- WW는 그 연도의 1~7을 기준으로 주차 표시
SELECT TO_CHAR( TO_DATE ('2024.01.01'), 'WW')
    , TO_CHAR( TO_DATE ('2024.01.02'), 'WW')
    , TO_CHAR( TO_DATE ('2024.01.03'), 'WW')
    , TO_CHAR( TO_DATE ('2024.01.04'), 'WW')
    , TO_CHAR( TO_DATE ('2024.01.05'), 'WW')
    , TO_CHAR( TO_DATE ('2024.01.06'), 'WW')
    , TO_CHAR( TO_DATE ('2024.01.07'), 'WW')
    , TO_CHAR( TO_DATE ('2024.01.08'), 'WW')
    , TO_CHAR( TO_DATE ('2024.01.14'), 'WW')
    , TO_CHAR( TO_DATE ('2024.01.15'), 'WW')
FROM dual;

-- IW는 일요일을 기점으로 주차 표시
-- 1월 1일 과 1월 2일은 토, 일요일 이라서 2019년에 포함되어서 52라는 숫자가 나온다.
SELECT TO_CHAR( TO_DATE ('2022.01.01'), 'IW') 52
    , TO_CHAR( TO_DATE ('2022.01.02'), 'IW') 52
    , TO_CHAR( TO_DATE ('2022.01.03'), 'IW') 01
    , TO_CHAR( TO_DATE ('2022.01.04'), 'IW') 01
    , TO_CHAR( TO_DATE ('2022.01.05'), 'IW') 01
    , TO_CHAR( TO_DATE ('2022.01.06'), 'IW')
    , TO_CHAR( TO_DATE ('2022.01.07'), 'IW')
    , TO_CHAR( TO_DATE ('2022.01.08'), 'IW')
    , TO_CHAR( TO_DATE ('2022.01.14'), 'IW')
    , TO_CHAR( TO_DATE ('2022.01.15'), 'IW')
FROM dual;


SELECT 
    TO_CHAR( SYSDATE, 'BC')  -- 서기 출력
    , TO_CHAR( SYSDATE, 'Q') -- 1분기 ~ 4분기 출력
    , TO_CHAR( SYSDATE, 'HH24') -- 15 // 24시간 기준
    , TO_CHAR( SYSDATE, 'HH')   -- 3  // 12시간 기준
    , TO_CHAR( SYSDATE, 'SS')
    , TO_CHAR( SYSDATE, 'MI')
    , TO_CHAR( SYSDATE, 'DY')   -- 화
    , TO_CHAR( SYSDATE, 'DAY')  -- 화요일
    , TO_CHAR( SYSDATE, 'DL')   -- 2024년 2월 20일 화요일
    , TO_CHAR( SYSDATE, 'DS')   -- 2024/02/20
FROM dual;



SELECT ename, hiredate
    , TO_CHAR( hiredate, 'DL')
    , TO_CHAR( hiredate, 'DS')
    , TO_CHAR( SYSDATE , 'TS') -- 오후 3:50:12 시간을 출력
    , TO_CHAR( CURRENT_TIMESTAMP, 'HH24:MI.SS.FF9') NANO-- TIMESTAMP 사용하면 FF정수 줘서 나노 세컨드값을 가져올 수 있다.
FROM emp;

-- TO_CHAR() : 날짜, 숫자 -> 문자 형식으로 변환
-- [ 문제 ] : 오늘 날짜를 TO_CHAR()  사용해서 
-- 2024년 02월 20일 오후 16:05:29 (화)

SELECT TO_CHAR( SYSDATE, 'YYYY"년" MM"월" DD"일" TS "("DY")"')
FROM dual;


SELECT name, ssn
    , SUBSTR(ssn, 1, 6)
    , TO_DATE(SUBSTR(ssn, 1, 6))
    , TO_CHAR(TO_DATE(SUBSTR(ssn, 1, 6)), 'DL')
FROM insa;


SELECT 
    TO_DATE( '0821', 'MMDD' ) -- MMDD주면 날짜 객체로 만들어 준다.
    , TO_DATE( '2024', 'YYYY') -- 24/02/01 2월1일 날짜로 자동으로 세팅된다.
    , TO_DATE( '202312', 'YYYYMM') --  23/12/01
    , TO_DATE( '23년01월12일', 'YY"년"MM"월"DD"일"' ) -- 문자열을 날짜 객체로 바꾸고 싶을때는 " " 붙여서 해당하는 문자 포맷 줘야한다.
FROM dual;


-- 문제 : 수요일 '6/14' 오늘부터 남은 일수 ?
SELECT SYSDATE
    , TO_DATE( '6/14', 'MM"/"DD') "DATE"
    , CEIL(ABS(SYSDATE - TO_DATE( '6/14', 'MM"/"DD'))) CEIL_DATE
    , CEIL(ABS(TO_DATE( '6/14', 'MM"/"DD') - SYSDATE)) CEIL_DATE2
FROM dual;


-- 문제 : 4자리 부서번호로 출력
SELECT LPAD(deptno, 4, '0') deptno
    , TO_CHAR( deptno, '0999') deptno2
FROM emp;


-- DECODE 함수
-- 비교연산시 = 만 비교할 수 있다.( > < 이런 비교 안된다)
    
DECODE( A, B, 'C')
DECODE( A, B, 'C', 'D')
DECODE( A, B, 'C', F, 'D', 'X')

SELECT empno, ename
    , sal + NVL(comm, 0) pay
    , (SELECT ROUND(AVG(sal + NVL(comm, 0)), 2) AVG_PAY FROM emp) AVG_PAY
    , REPLACE(REPLACE(SIGN(sal + NVL(comm, 0) - (SELECT AVG(sal + NVL(comm, 0)) FROM emp)), -1 , '적다') , 1, '많다') AB
    , DECODE(SIGN(sal + NVL(comm, 0) - (SELECT AVG(sal + NVL(comm, 0)) FROM emp)), -1, '적다', 1, '많다', '같다') DECODE
FROM emp GROUP BY empno, ename, sal + NVL(comm, 0);


SELECT name, ssn
    , DECODE(MOD(SUBSTR(ssn, 8, 1), 2), 1, '남', '여') GENDER
    , DECODE(MOD(SUBSTR(ssn, 8, 1), 2), 1, '남', 0,'여') GENDER2
FROM insa;


-- INSA 테이블에서 오늘을 기준으로 생일이 지남 여부를 출력하는 쿼리
SELECT t.name, t.ssn, t.생일, 
    DECODE(t.s, -1, '지남', 0, '오늘' , '안지남')
FROM
    (
SELECT name, ssn
        , DECODE(SIGN(TO_DATE(SUBSTR(ssn, 3, 4), 'MMDD') - TRUNC(SYSDATE)), -1, '생일 지남', 0, '오늘이 생일', '생일이 안지남') "생일"
        , SIGN(TO_DATE(SUBSTR(ssn, 3, 4), 'MMDD') - TRUNC(SYSDATE)) s
FROM insa
    ) t;
    
    
    
-- 문제 emp 테이블에서 각 사원의 번호, 이름, 급여 출력
-- 조건1 : 10번 부서원들은 급여의 15%인상
-- 조건2 : 20번 부서원들은 급여의 10%인상
-- 조건3 : 30번 부서원들은 급여의 5%인상


SELECT empno, ename , sal
    , DECODE( deptno, 10, '15%', 20, '10%', '5%') "인상률"
    , sal + DECODE( deptno, 10, sal*0.15, 20, sal*0.1, sal*0.05) "인상된_PAY"
FROM emp;


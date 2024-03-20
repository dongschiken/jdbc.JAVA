CREATE TABLE salgrade
(
    grade NUMBER PRIMARY KEY,
    losal NUMBER NOT NULL,
    hisal NUMBER NOT NULL
    
);

SELECT dname, d.deptno , COUNT(d.deptno) cnt
FROM dept d JOIN emp e ON d.deptno = e.deptno
GROUP BY d.deptno, dname
ORDER BY deptno;

SELECT ename, empno, hiredate, sal, d.deptno
FROM emp e LEFT JOIN dept d ON d.deptno = e.deptno
WHERE e.deptno IS NULL;


SELECT d.deptno , dname, COUNT(*) cnt
FROM dept d RIGHT JOIN emp e ON d.deptno = e.deptno
GROUP BY d.deptno, dname
ORDER BY d.deptno ASC;

UPDATE emp
SET deptno = null
WHERE ename = 'KING';

SELECT *
FROM dept;

COMMIT;
WITH t AS (            
SELECT DISTINCT empno, dname, ename, hiredate, t.pay,
    CASE 
    WHEN t.pay BETWEEN losal AND hisal THEN grade
    END sal_grade
FROM salgrade s, (SELECT empno, dname, ename, hiredate, sal+NVL(comm, 0) pay
                 FROM dept d RIGHT OUTER JOIN emp e ON e.deptno = d.deptno) t
ORDER BY empno
            )
SELECT t.*
FROM t
WHERE t.sal_grade IS NOT NULL;
                

SELECT empno, dname, ename, hiredate, sal+NVL(comm, 0) pay, grade
FROM dept d RIGHT OUTER JOIN emp e ON e.deptno = d.deptno      
                        JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal;

COMMIT;

SELECT *
FROM emp;

SELECT *
FROM dept;

CREATE OR REPLACE PROCEDURE up_update_dept
(
    pdeptno dept.deptno%TYPE,
    pdname dept.dname%TYPE default null,
    ploc dept.loc%TYPE default null
)
IS
    vdname dept.dname%TYPE;
    vloc dept.loc%TYPE;
BEGIN
    SELECT dname, loc
        INTO vdname, vloc
    FROM dept
    WHERE deptno = pdeptno;
    
    UPDATE dept
    SET dname = NVL(pdname, vdname), loc = NVL(ploc, vloc)
    WHERE deptno = pdeptno;
    
--EXCEPTION
END;
EXEC up_update_dept()

DELETE FROM dept  WHERE deptno IN(50, 60);



-- ID 중복체크하는 저장 프로시저
-- emp 테이블의 empno(사원번호)를 아이디로 생각하고 프로시저를 구현
CREATE OR REPLACE PROCEDURE up_idcheck
(
    pid IN emp.empno%TYPE,
    pcheck OUT NUMBER
)
IS
    
BEGIN

    SELECT COUNT(*)
        INTO pcheck
    FROM emp
    WHERE empno = pid;
    
--EXCEPTION
END;

DECLARE
    vcheck NUMBER(1);
BEGIN
    up_idcheck( 8888, vcheck );
    DBMS_OUTPUT.PUT_LINE(vcheck);
END;
-- Procedure UP_IDCHECK이(가) 컴파일되었습니다.
-- 프로젝트할때 저장 프로시저를 테스트 한 후에 자바 코딩에서 사용하자.



CREATE OR REPLACE PROCEDURE up_login
(
    pid IN emp.empno%TYPE
    , ppwd IN emp.ename%TYPE
    , pcheck OUT NUMBER  -- 1(성공), 0(실패)
)
IS
   vpwd emp.ename%TYPE;
BEGIN
    SELECT COUNT(*) INTO  pcheck
    FROM emp
    WHERE empno = pid;
    
    IF pcheck = 1 THEN  -- ID 존재 O
       SELECT ename INTO vpwd
       FROM emp
       WHERE empno = pid;
       
       IF vpwd = ppwd THEN -- PWD 일치
          pcheck := 0;
       ELSE
          pcheck := 1; -- 아이디는 존재하지만 비밀번호가 불일치
       END IF;
       
    ELSE   -- 아이디가 존재하지 않는다.
      pcheck := -1;
    END IF; 
    --  0이되면 로그인 성공
    --  1이되면 아이디는 존재 비밀번호는 불일치
    -- -1이되면 아이디자체가 존재 X
END;
-- Procedure UP_LOGIN이(가) 컴파일되었습니다.
DECLARE
    vcheck NUMBER(1);
BEGIN
    -- up_login(7369, 'SMITH', vcheck);
    -- up_login(7369, 'SMITHSS', vcheck);
    up_login(8888, 'SMITHSS', vcheck);
    DBMS_OUTPUT.PUT_LINE(vcheck);
END;

CREATE OR REPLACE PROCEDURE up_delete
(
    pdeptno IN dept.deptno%TYPE,
    pcount OUT NUMBER
)
IS
BEGIN

    SELECT COUNT(*)
        INTO pcount
    FROM dept
    WHERE deptno = pdeptno;
    
    DELETE FROM dept
    WHERE deptno = pdeptno;
    COMMIT;
--EXCEPTION
END;

DECLARE
    vcount NUMBER(1);
BEGIN
    up_delete( 50, vcount );
    DBMS_OUTPUT.PUT_LINE( vcount );
END;

SELECT *
FROM dept;
ROLLBACK;


-- 시퀀스 확인
SELECT *
FROM user_sequences;


CREATE OR REPLACE PROCEDURE up_selectdept
(
    pdeptcursor OUT SYS_REFCURSOR

)
IS
 
BEGIN
    -- OPEN 커서  
    OPEN pdeptcursor FOR SELECT * FROM dept;
END;

EXECUTE up_selectdept;



CREATE OR REPLACE PROCEDURE up_insertdept
(
    pdname dept.dname%TYPE := NULL,
    ploc dept.loc%TYPE := NULL

)
IS
 
BEGIN
    
    INSERT INTO dept
    VALUES ( seq_deptno.nextVAL, pdname, ploc );
    COMMIT;
END;


CREATE OR REPLACE PROCEDURE up_updatedept
(
    pdeptno IN dept.deptno%TYPE,
    pdname IN dept.dname%TYPE := NULL,
    ploc IN dept.loc%TYPE := NULL

)
IS
BEGIN
    UPDATE dept
    SET dname = NVL( pdname, dname),
        loc = NVL( ploc, loc)
    WHERE deptno = pdeptno;
    COMMIT;
--EXCEPTION
END;


--Procedure UP_INSERTDEPT이(가) 컴파일되었습니다.

CREATE TABLE tbl_cstVSBoard (
         seq NUMBER NOT NULL PRIMARY KEY , -- 글 일련번호 ( PK )
         writer VARCHAR2(20) NOT NULL ,
         pwd VARCHAR2(20) NOT NULL ,
         email VARCHAR2(100) ,
         title VARCHAR2(200) NOT NULL ,
         writedate DATE DEFAULT SYSDATE ,
         readed NUMBER  default (0) ,
         tag NUMBER(1) NOT NULL ,
         content CLOB
			);

CREATE SEQUENCE seq_tbl_cstVSBoard INCREMENT BY 1 START WITH 1 NOCACHE NOCYCLE;

--Table TBL_CSTVSBOARD이(가) 생성되었습니다.
--Sequence SEQ_TBL_CSTVSBOARD이(가) 생성되었습니다.
-- 오라클 테이블로 변경


// 150 개의 게시글을 임의로 추가

BEGIN
    FOR i IN 1.. 150
    LOOP
        INSERT INTO TBL_CSTVSBOARD
        (seq, writer, pwd, email, title, tag, content)
        VALUES
        ( seq_TBL_CSTVSBOARD.NEXTVAL, '홍길동' || i, '1234', 'hong' || i || '@sist.com' 
        , 'title-' || i
        , 0
        , 'content - ' || i);
        END LOOP;
        COMMIT;
END;
-- PL/SQL 프로시저가 성공적으로 완료되었습니다.SELECT *
FROM user_sequences;

BEGIN
    UPDATE TBL_CSTVSBOARD
    SET writer = '김영진'
    WHERE MOD( seq, 15 ) = 2;
    COMMIT;
END;
BEGIN
    UPDATE TBL_CSTVSBOARD
    SET title = '저장 프로시저'
    WHERE MOD( seq, 9 ) IN(3, 5);
    COMMIT;
END;

DESC TBL_CSTVSBOARD;

SELECT *
FROM TBL_CSTVSBOARD;
-- 문제1) 번호,이름,국,영,수,총점,평균,등수,등급을 관리하는 tbl_score 테이블 생성
--       (num, name, kor, eng, mat, tot, avg, rank, grade ) 


CREATE TABLE tbl_score
(
    num NUMBER  PRIMARY KEY,
    name VARCHAR2(5 CHAR) NOT NULL,
    kor NUMBER(3),
    eng NUMBER(3),
    mat NUMBER(3),
    tot NUMBER(3),
    avg NUMBER(5, 2),
    rank NUMBER(2),
    grade VARCHAR2(1 CHAR)
)

SELECT *
FROM user_sequences;

CREATE SEQUENCE seq_tblscore INCREMENT BY 1 START WITH 1001 NOCYCLE NOCACHE;

-- 문제4) 학생 추가하는 저장 프로시저 생성
--EXEC up_insertscore(1001, '홍길동', 89,44,55 );
--EXEC up_insertscore(1002, '윤재민', 49,55,95 );
--EXEC up_insertscore(1003, '김도균', 90,94,95 );

CREATE OR REPLACE PROCEDURE up_insertscore
(
    pnum tbl_score.num%TYPE,
    pname tbl_score.name%TYPE,
    pkor tbl_score.kor%TYPE,
    peng tbl_score.eng%TYPE,
    pmat tbl_score.mat%TYPE
)
IS
    vtot NUMBER(3);
    vavg NUMBER(5);
    vgrade CHAR(1 CHAR);
BEGIN
    vtot := pkor + peng + pmat;
    vavg := vtot/3;
    IF vavg >= 90 THEN vgrade := 'A';
    ELSIF vavg >= 80 THEN vgrade := 'B';
    ELSIF vavg >= 70 THEN vgrade := 'C';
    ELSIF vavg >= 60 THEN vgrade := 'D';
    ELSE vgrade := 'F';
    END IF;
    INSERT INTO tbl_score (num, name, kor, eng, mat, tot, avg, grade)
    VALUES ( pnum, pname, pkor, peng, pmat, vtot, vavg, vgrade );
    
    UPDATE tbl_score a
    SET rank = ( SELECT COUNT(*)+1 FROM tbl_score WHERE tot > a.tot );
    COMMIT;
--EXCEPTION
END;

DELETE tbl_score;

EXEC up_insertscore(1001, '홍길동', 89,44,55 );
EXEC up_insertscore(1002, '윤재민', 49,55,95 );
EXEC up_insertscore(1003, '김도균', 90,94,95 );


-- 문제2) 번호를 기본키로 설정
-- 문제3) seq_tblscore 시퀀스 생성



-- 문제5) 학생 수정하는 저장 프로시저 생성
CREATE OR REPLACE PROCEDURE up_updateScore
(
    pnum tbl_score.num%TYPE,
    pkor tbl_score.kor%TYPE DEFAULT NULL,
    peng tbl_score.eng%TYPE DEFAULT NULL,
    pmat tbl_score.mat%TYPE DEFAULT NULL
)
IS
    vtot NUMBER(3);
    vavg NUMBER(3);
    vgrade VARCHAR2(3);
    vkor tbl_score.kor%TYPE DEFAULT NULL;
    veng tbl_score.eng%TYPE DEFAULT NULL;
    vmat tbl_score.mat%TYPE DEFAULT NULL;
BEGIN
    SELECT kor, eng, mat INTO vkor, veng, vmat
    FROM tbl_score
    WHERE num = pnum;
    
    vtot := NVL(pkor, vkor) + NVL(peng, veng) + NVL(pmat, vmat);
    vavg := vtot/3;
    
    IF vavg >= 90 THEN vgrade := 'A';
    ELSIF vavg >= 80 THEN vgrade := 'B';
    ELSIF vavg >= 70 THEN vgrade := 'C';
    ELSIF vavg >= 60 THEN vgrade := 'D';
    ELSE vgrade := 'F';
    END IF;
    
    UPDATE tbl_score
    SET kor = NVL(pkor, vkor),
        eng = NVL(peng, veng),
        mat = NVL(pmat, vmat),
        tot = vtot,
        avg = vavg,
        grade = vgrade
    WHERE num = pnum;
    
    UPDATE tbl_score a
    SET rank = (SELECT COUNT(*)+1 FROM tbl_score WHERE tot > a.tot);
    COMMIT;
--EXCEPTION
END;
EXEC up_updateScore( 1001, 100, 100, 100 );
EXEC up_updateScore( 1001, pkor =>34 );
EXEC up_updateScore( 1001, pkor =>34, pmat => 90 );
EXEC up_updateScore( 1001, peng =>45, pmat => 90 );

SELECT *
FROM tbl_score;
-- 문제6) 학생 삭제하는 저장 프로시저 생성
 EXEC UP_DELETESCORE( 1002 ); 

CREATE OR REPLACE PROCEDURE up_deletescore
(
    pnum tbl_score.num%TYPE
 
)
IS
BEGIN
    DELETE tbl_score
    WHERE num = pnum;
    UPDATE tbl_score a
    SET rank = (SELECT COUNT(*)+1 FROM tbl_score WHERE tot > a.tot);
    COMMIT;
--EXCEPTION
END;

-- 문제7) 모든 학생 출력하는 저장 프로시저 생성( 명시적 커서 사용 )
EXEC UP_SELECTSCORE;
CREATE OR REPLACE PROCEDURE up_selectscore
IS
--    TYPE tbl_score_type IS RECORD
--    (
--        num tbl_score.num%TYPE,
--        name tbl_score.name%TYPE,
--        kor tbl_score.kor%TYPE,
--        eng tbl_score.eng%TYPE,
--        mat tbl_score.mat%TYPE,
--        tot tbl_score.tot%TYPE,
--        avg tbl_score.avg%TYPE,
--        rank tbl_score.rank%TYPE,
--        grade tbl_score.grade%TYPE
--    );
    vrow tbl_score%ROWTYPE;
    CURSOR tbl_score_cur IS 
    (
        SELECT num, name, kor, eng, mat, tot, avg, rank, grade
        FROM tbl_score
    );
    
BEGIN
    OPEN tbl_score_cur;
    LOOP
    FETCH tbl_score_cur INTO vrow;
    EXIT WHEN tbl_score_cur%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE( vrow.num || ' ' || vrow.name || ' ' || vrow.kor || ' ' || vrow.eng || ' ' || vrow.mat || ' ' || vrow.avg || ' ' || vrow.rank || ' ' || vrow.grade);
    END LOOP;
    CLOSE tbl_score_cur;
--EXCEPTION
END;


CREATE OR REPLACE PROCEDURE up_selectscore
IS
    vrow tbl_score%ROWTYPE;
BEGIN
    FOR vrow IN 
    (
        SELECT num, name, kor, eng, mat, tot, avg, rank, grade
        FROM tbl_score
    )
    LOOP     
    DBMS_OUTPUT.PUT_LINE( vrow.num || ' ' || vrow.name || ' ' || vrow.kor || ' ' || vrow.eng || ' ' || vrow.mat || ' ' || vrow.avg || ' ' || vrow.rank || ' ' || vrow.grade);
    END LOOP;
--EXCEPTION
END;


-- 문제8) 학생 검색하는 저장 프로시저 생성
 EXEC UP_SEARCHSCORE(1001);


-- 문제7) 모든 학생 출력하는 저장 프로시저 생성( 명시적 커서 사용 )
 EXEC UP_SELECTSCORE;
CREATE OR REPLACE PROCEDURE UP_SEARCHSCORE
(
    pnum tbl_score.num%TYPE
)
IS
    vrow tbl_score%ROWTYPE;
BEGIN
    SELECT *
        INTO vrow
    FROM tbl_score
    WHERE num = pnum; 
    DBMS_OUTPUT.PUT_LINE( vrow.num || ' ' || vrow.name || ' ' || vrow.kor || ' ' || vrow.eng || ' ' || vrow.mat || ' ' || vrow.avg || ' ' || vrow.rank || ' ' || vrow.grade);

END;

-- JDBC, JSP에서 많이쓰이는 
-- ( ) 파라미터에 SELECT의 실행결과물을 가지는 커서를 매개변수로 받는다.
CREATE OR REPLACE PROCEDURE up_selectinsa
(
    pinsacursor SYS_REFCURSOR -- 커서 자료형 
)
IS
    vname  insa.name%TYPE;
    vcity  insa.city%TYPE;
    vbasicpay insa.basicpay%TYPE;
BEGIN
    LOOP
    FETCH pinsacursor INTO vname, vcity, vbasicpay;
    EXIT WHEN pinsacursor%NOTFOUND;
    DBMS_OUTPUT.PUT( RPAD(pinsacursor%ROWCOUNT, 4, '  ' ) );
    DBMS_OUTPUT.PUT_LINE( vname || ' ' || vcity || ' ' || vbasicpay );
    END LOOP;
    CLOSE pinsacursor;
--EXCEPTION
END;


CREATE OR REPLACE PROCEDURE up_selectinsa_test
IS
    vinsacursor SYS_REFCURSOR; -- 커서 자료형 

BEGIN
--    OPEN FOR문
     OPEN vinsacursor FOR SELECT name, city, basicpay FROM insa;
     -- 또다른 프로시저 호출
     up_selectinsa(vinsacursor);
     -- 커서를 여기서 새로 닫는다. (pinsacursor)
--     CLOSE pinsacursor;
--EXCEPTION
END;
-- Procedure UP_SELECTINSA_TEST이(가) 컴파일되었습니다.

EXEC up_selectinsa_test;

CREATE TABLE tbl_exam1
(
    id NUMBER PRIMARY KEY
    , name VARCHAR2(20)
)
-- Table TBL_EXAM1이(가) 생성되었습니다.
DROP TABLE tbl_exam2 PURGE;

CREATE TABLE tbl_exam2
(
    memo VARCHAR2(100)
    , ilja DATE DEFAULT SYSDATE
);
-- Table TBL_EXAM2이(가) 생성되었습니다.
INSERT INTO tbl_exam1 VALUES( 1, 'hong' );
INSERT INTO tbl_exam1 VALUES( 2, 'admin' );
INSERT INTO tbl_exam2 (memo) VALUES( 'hong 새로 추가되었다.' );
COMMIT;

ROLLBACK;
SELECT *
FROM tbl_exam1;

SELECT *
FROM tbl_exam2;

UPDATE tbl_exam1
SET name = 'admin'
WHERE id = 2;

DELETE FROM tbl_exam1
WHERE id = 1;


-- 트리거 생성 순서
-- 1) 어떤 대상 테이블에 : tbl_exam1
-- 2) 어떤 이벤트 ( INSERT, UPDATE, DELETE ) : INSERT
-- 3) 작업전 OR 작업후 일어나는 트리거 여부를 결정 : AFTER
-- 4) 행마다 트리거 발생시킬지 여부를 결정 : 행트리거 필요 X
--  INSERTING, UPDATING, DELETING ( INSERT, UPDATE, DELETE 작업이 일어난 경우 사용 가능 )
-- NEW.name : 새로운 이름이 추가되었다 / OLD.name : 기존의 이름이 수정  ( :NEW, :OLD 사용하려면 FOR EACH ROW가 필요하다.)
CREATE OR REPLACE TRIGGER ut_log
AFTER
    -- exam1에서 INSERT작업이 실행되면 작동하는 트리거
INSERT OR UPDATE OR DELETE ON tbl_exam1
FOR EACH ROW
BEGIN
    IF INSERTING
    THEN INSERT INTO tbl_exam2 (memo) VALUES ( :NEW.name || '추가...');
    ELSIF UPDATING
    THEN INSERT INTO tbl_exam2 (memo) VALUES ( :OLD.name || '->' || :NEW.name ||'수정...');
    ELSIF DELETING
    THEN INSERT INTO tbl_exam2 (memo) VALUES ( :OLD.name ||'삭제...');
    END IF;

--EXCEPTION
END;
-- Trigger UT_LOG이(가) 컴파일되었습니다.
-- BEFORE트리거
-- 예) tbl_exam1 대상 테이블에 DML문이 근무시간외 또는 주말에는 처리 X 근무시간 외( 13시 ~ 18시 사이X 또는 주말에는 처리 X )
CREATE OR REPLACE TRIGGER ut_log_before
BEFORE
    -- tbl_exam1에서 작업이 실행되기 전에 작동하는 트리거
INSERT OR UPDATE OR DELETE ON tbl_exam1
BEGIN
    -- 근무시간이 아니라는 IF문
    IF TO_CHAR( SYSDATE, 'HH24' ) < 12 OR  TO_CHAR( SYSDATE, 'HH24' ) > 18
    OR TO_CHAR( SYSDATE, 'DY' ) IN ('토', '일')
    -- RAISE_APPLICATION_ERROR(예외코드(우리가 정하는것), 예외 메시지) 강제로 예외를 발생시키는 코드 ( 자바에 throw )
    THEN RAISE_APPLICATION_ERROR(-20001, '근무시간이 아니기에 DML작업 불가');
    END IF;

--EXCEPTION
END;
COMMIT;
INSERT INTO tbl_exam1 VALUES (3, 'park');
DROP TRIGGER ut_log;
DROP TABLE tbl_dept  PURGE;
DROP TABLE tbl_emp   PURGE;
DROP TABLE tbl_exam1 PURGE;
DROP TABLE tbl_exam2 PURGE;
DROP TABLE tbl_score PURGE;




CREATE TABLE tbl_score
( 
      hak  VARCHAR2(10) PRIMARY KEY 
    , name VARCHAR2(20) 
    , kor  NUMBER(3)  
    , eng  NUMBER(3)
    , mat  NUMBER(3)
);
-- Table TBL_SCORE이(가) 생성되었습니다.
CREATE TABLE tbl_scorecontent
( 
      hak  VARCHAR2(10) PRIMARY KEY 
    , tot  NUMBER(3) 
    , avg  NUMBER(5,2)  
    , rank  NUMBER(3)
    , grade  VARCHAR2(3)
    , CONSTRAINT FK_tblSCORECONTENT_HAK FOREIGN KEY (hak) REFERENCES tbl_score(hak)
);
-- Table TBL_SCORECONTENT이(가) 생성되었습니다.
CREATE OR REPLACE PROCEDURE up_insertscore
(
    phak tbl_score.hak%TYPE,
    pname tbl_score.name%TYPE,
    pkor tbl_score.kor%TYPE,
    peng tbl_score.eng%TYPE,
    pmat tbl_score.mat%TYPE
)
IS
BEGIN
    INSERT INTO tbl_score (hak, name, kor, eng, mat)
    VALUES ( phak, pname, pkor, peng, pmat);
    
--EXCEPTION
END;
SELECT * FROM tbl_score;
SELECT * FROM tbl_scorecontent;

EXECUTE up_insertscore( '1', '홍길동', 89, 23, 55);

CREATE OR REPLACE TRIGGER ut_insertscore
AFTER
INSERT ON tbl_score
FOR EACH ROW -- 행 레벨 트리거로 만드는 방법 : NEW , :OLD를 사용 가능해진다.
DECLARE
    vtot NUMBER(3);
    vavg NUMBER(5,2);
    vgrade VARCHAR2(3);
BEGIN
--    :NEW.hak;
    vtot := :NEW.kor + :NEW.eng + :NEW.mat;
    vavg := vtot/3;
    IF vavg >= 90 THEN vgrade := 'A';
    ELSIF vavg >= 80 THEN vgrade := 'B';
    ELSIF vavg >= 70 THEN vgrade := 'C';
    ELSIF vavg >= 60 THEN vgrade := 'D';
    ELSE vgrade := 'F';
    END IF;
    
    INSERT INTO tbl_scorecontent (hak, tot, avg, rank, grade)
    VALUES ( :NEW.hak, vtot, vavg, 1, vgrade);
--EXCPETION
END;

-- 문제)
EXEC up_updateScore( 1, 100, 100, 100 );
EXEC up_updateScore( 1, pkor =>34 );
EXEC up_updateScore( 1, pkor =>34, pmat => 90 );
EXEC up_updateScore( 1, peng =>45, pmat => 90 );

SELECT *
FROM tbl_score;
SELECT *
FROM tbl_scorecontent;

CREATE OR REPLACE PROCEDURE up_updateScore
(
    phak tbl_score.hak%TYPE,
    pkor tbl_score.kor%TYPE DEFAULT NULL,
    peng tbl_score.eng%TYPE DEFAULT NULL,
    pmat tbl_score.mat%TYPE DEFAULT NULL
)
IS
BEGIN
    UPDATE tbl_score 
    SET hak = phak 
        , kor = NVL(pkor, kor)
        , eng = NVL(peng, eng)
        , mat = NVL(pmat, mat)
    WHERE hak = phak;
    
--EXCEPTION
END;

CREATE OR REPLACE PROCEDURE up_deleteScore
(
    phak NUMBER
)
IS
BEGIN
    DELETE tbl_score 
    WHERE hak = phak;
    
--EXCEPTION
END;

CREATE OR REPLACE TRIGGER ut_deleteScore
BEFORE
DELETE ON tbl_score
FOR EACH ROW
DECLARE
BEGIN
--    :NEW.hak;
    -- DELETE 트리거에서는 :NEW사용할 수 없다.
    DELETE tbl_scorecontent 
    WHERE hak = :OLD.hak;
END;


EXEC up_deleteScore( '1' );

SELECT *
FROM tbl_score;

SELECT *
FROM tbl_scorecontent;

CREATE OR REPLACE TRIGGER ut_updateScore
AFTER
UPDATE ON tbl_score
FOR EACH ROW -- 행 레벨 트리거로 만드는 방법 : NEW , :OLD를 사용 가능해진다.
DECLARE
    vtot NUMBER(3);
    vavg NUMBER(5,2);
    vgrade VARCHAR2(3);
BEGIN
--    :NEW.hak;
    vtot := :NEW.kor + :NEW.eng + :NEW.mat;
    vavg := vtot/3;
    IF vavg >= 90 THEN vgrade := 'A';
    ELSIF vavg >= 80 THEN vgrade := 'B';
    ELSIF vavg >= 70 THEN vgrade := 'C';
    ELSIF vavg >= 60 THEN vgrade := 'D';
    ELSE vgrade := 'F';
    END IF;
    UPDATE tbl_scorecontent 
    SET hak = :NEW.hak
        , tot = vtot
        , avg = vavg
        , rank = 1
        , grade = vgrade
    WHERE hak = :NEW.hak;
--EXCPETION
END;

SELECT ename, sal
FROM emp
WHERE sal = 800;



CREATE OR REPLACE PROCEDURE up_emplist
(
    psal emp.sal%TYPE
)
IS
    vename emp.ename%TYPE;
    vsal emp.sal%TYPE;
BEGIN
    SELECT ename, sal INTO vename, vsal
    FROM emp
    WHERE sal = psal;
    
    DBMS_OUTPUT.PUT_LINE( vename || ', ' || vsal );
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'NO DATA FOUND');
    WHEN TOO_MANY_ROWS THEN 
        RAISE_APPLICATION_ERROR(-20002, 'QUERY DATA TOO_MANY_ROWS FOUND');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20009, 'QUERY OTHERS EXCEPTION FOUND');
END;

INSERT INTO emp (empno, ename, deptno)
VALUES ( 9999, 'admin', 90);

EXEC up_emplist(6000);
EXEC up_emplist(0);


CREATE OR REPLACE PROCEDURE up_emplist
(
    pempno emp.empno%TYPE,
    pename emp.ename%TYPE,
    pdeptno emp.deptno%TYPE
)
IS
    PARENT_KEY_NOT_FOUND EXCEPTION;
    -- PRAGMA로 예외 번호를 매핑시켜준 예제
    PRAGMA EXCEPTION_INIT ( PARENT_KEY_NOT_FOUND , -02291 );
BEGIN
    INSERT INTO emp (empno, ename, deptno)
    VALUES ( pempno, pename, pdeptno);
EXCEPTION
    WHEN PARENT_KEY_NOT_FOUND THEN
        RAISE_APPLICATION_ERROR(-20011, 'FOREIGN KEY NOT');
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'NO DATA FOUND');
    WHEN TOO_MANY_ROWS THEN 
        RAISE_APPLICATION_ERROR(-20002, 'QUERY DATA TOO_MANY_ROWS FOUND');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20009, 'QUERY OTHERS EXCEPTION FOUND');
END;


-- 사용자 정의 에러처리 방법
자바 - 국어 0 ~ 100점사이의 정수

SELECT COUNT(*)
FROM emp
WHERE sal BETWEEN A AND A;

--만약 COUNT(*)가 0일경우 예외를 발생시키자
CREATE OR REPLACE PROCEDURE up_myexception
(
    psal NUMBER 
)
IS 
    vcount NUMBER;
    -- 사용자 예외 객체 선언
    ZERO_EMP_COUNT EXCEPTION;
BEGIN
    
    SELECT COUNT(*) INTO vcount
    FROM emp
    WHERE sal BETWEEN psal-100 AND psal+100;
    
    IF vcount = 0 THEN 
        RAISE ZERO_EMP_COUNT;
    ELSE
        DBMS_OUTPUT.PUT_LINE( ' > 사원수 : ' || vcount );
    END IF;
EXCEPTION
    WHEN ZERO_EMP_COUNT THEN
        RAISE_APPLICATION_ERROR(-20022, 'QUERY EMP COUNT 0(ZERO)...');
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'NO DATA FOUND');
    WHEN TOO_MANY_ROWS THEN 
        RAISE_APPLICATION_ERROR(-20002, 'QUERY DATA TOO_MANY_ROWS FOUND');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20009, 'QUERY OTHERS EXCEPTION FOUND');
END;


EXEC up_myexception(6000);
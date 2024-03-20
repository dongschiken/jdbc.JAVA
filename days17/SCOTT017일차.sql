-- ����1) ��ȣ,�̸�,��,��,��,����,���,���,����� �����ϴ� tbl_score ���̺� ����
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

-- ����4) �л� �߰��ϴ� ���� ���ν��� ����
--EXEC up_insertscore(1001, 'ȫ�浿', 89,44,55 );
--EXEC up_insertscore(1002, '�����', 49,55,95 );
--EXEC up_insertscore(1003, '�赵��', 90,94,95 );

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

EXEC up_insertscore(1001, 'ȫ�浿', 89,44,55 );
EXEC up_insertscore(1002, '�����', 49,55,95 );
EXEC up_insertscore(1003, '�赵��', 90,94,95 );


-- ����2) ��ȣ�� �⺻Ű�� ����
-- ����3) seq_tblscore ������ ����



-- ����5) �л� �����ϴ� ���� ���ν��� ����
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
-- ����6) �л� �����ϴ� ���� ���ν��� ����
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

-- ����7) ��� �л� ����ϴ� ���� ���ν��� ����( ����� Ŀ�� ��� )
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


-- ����8) �л� �˻��ϴ� ���� ���ν��� ����
 EXEC UP_SEARCHSCORE(1001);


-- ����7) ��� �л� ����ϴ� ���� ���ν��� ����( ����� Ŀ�� ��� )
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

-- JDBC, JSP���� ���̾��̴� 
-- ( ) �Ķ���Ϳ� SELECT�� ���������� ������ Ŀ���� �Ű������� �޴´�.
CREATE OR REPLACE PROCEDURE up_selectinsa
(
    pinsacursor SYS_REFCURSOR -- Ŀ�� �ڷ��� 
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
    vinsacursor SYS_REFCURSOR; -- Ŀ�� �ڷ��� 

BEGIN
--    OPEN FOR��
     OPEN vinsacursor FOR SELECT name, city, basicpay FROM insa;
     -- �Ǵٸ� ���ν��� ȣ��
     up_selectinsa(vinsacursor);
     -- Ŀ���� ���⼭ ���� �ݴ´�. (pinsacursor)
--     CLOSE pinsacursor;
--EXCEPTION
END;
-- Procedure UP_SELECTINSA_TEST��(��) �����ϵǾ����ϴ�.

EXEC up_selectinsa_test;

CREATE TABLE tbl_exam1
(
    id NUMBER PRIMARY KEY
    , name VARCHAR2(20)
)
-- Table TBL_EXAM1��(��) �����Ǿ����ϴ�.
DROP TABLE tbl_exam2 PURGE;

CREATE TABLE tbl_exam2
(
    memo VARCHAR2(100)
    , ilja DATE DEFAULT SYSDATE
);
-- Table TBL_EXAM2��(��) �����Ǿ����ϴ�.
INSERT INTO tbl_exam1 VALUES( 1, 'hong' );
INSERT INTO tbl_exam1 VALUES( 2, 'admin' );
INSERT INTO tbl_exam2 (memo) VALUES( 'hong ���� �߰��Ǿ���.' );
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


-- Ʈ���� ���� ����
-- 1) � ��� ���̺� : tbl_exam1
-- 2) � �̺�Ʈ ( INSERT, UPDATE, DELETE ) : INSERT
-- 3) �۾��� OR �۾��� �Ͼ�� Ʈ���� ���θ� ���� : AFTER
-- 4) �ึ�� Ʈ���� �߻���ų�� ���θ� ���� : ��Ʈ���� �ʿ� X
--  INSERTING, UPDATING, DELETING ( INSERT, UPDATE, DELETE �۾��� �Ͼ ��� ��� ���� )
-- NEW.name : ���ο� �̸��� �߰��Ǿ��� / OLD.name : ������ �̸��� ����  ( :NEW, :OLD ����Ϸ��� FOR EACH ROW�� �ʿ��ϴ�.)
CREATE OR REPLACE TRIGGER ut_log
AFTER
    -- exam1���� INSERT�۾��� ����Ǹ� �۵��ϴ� Ʈ����
INSERT OR UPDATE OR DELETE ON tbl_exam1
FOR EACH ROW
BEGIN
    IF INSERTING
    THEN INSERT INTO tbl_exam2 (memo) VALUES ( :NEW.name || '�߰�...');
    ELSIF UPDATING
    THEN INSERT INTO tbl_exam2 (memo) VALUES ( :OLD.name || '->' || :NEW.name ||'����...');
    ELSIF DELETING
    THEN INSERT INTO tbl_exam2 (memo) VALUES ( :OLD.name ||'����...');
    END IF;

--EXCEPTION
END;
-- Trigger UT_LOG��(��) �����ϵǾ����ϴ�.
-- BEFOREƮ����
-- ��) tbl_exam1 ��� ���̺� DML���� �ٹ��ð��� �Ǵ� �ָ����� ó�� X �ٹ��ð� ��( 13�� ~ 18�� ����X �Ǵ� �ָ����� ó�� X )
CREATE OR REPLACE TRIGGER ut_log_before
BEFORE
    -- tbl_exam1���� �۾��� ����Ǳ� ���� �۵��ϴ� Ʈ����
INSERT OR UPDATE OR DELETE ON tbl_exam1
BEGIN
    -- �ٹ��ð��� �ƴ϶�� IF��
    IF TO_CHAR( SYSDATE, 'HH24' ) < 12 OR  TO_CHAR( SYSDATE, 'HH24' ) > 18
    OR TO_CHAR( SYSDATE, 'DY' ) IN ('��', '��')
    -- RAISE_APPLICATION_ERROR(�����ڵ�(�츮�� ���ϴ°�), ���� �޽���) ������ ���ܸ� �߻���Ű�� �ڵ� ( �ڹٿ� throw )
    THEN RAISE_APPLICATION_ERROR(-20001, '�ٹ��ð��� �ƴϱ⿡ DML�۾� �Ұ�');
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
-- Table TBL_SCORE��(��) �����Ǿ����ϴ�.
CREATE TABLE tbl_scorecontent
( 
      hak  VARCHAR2(10) PRIMARY KEY 
    , tot  NUMBER(3) 
    , avg  NUMBER(5,2)  
    , rank  NUMBER(3)
    , grade  VARCHAR2(3)
    , CONSTRAINT FK_tblSCORECONTENT_HAK FOREIGN KEY (hak) REFERENCES tbl_score(hak)
);
-- Table TBL_SCORECONTENT��(��) �����Ǿ����ϴ�.
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

EXECUTE up_insertscore( '1', 'ȫ�浿', 89, 23, 55);

CREATE OR REPLACE TRIGGER ut_insertscore
AFTER
INSERT ON tbl_score
FOR EACH ROW -- �� ���� Ʈ���ŷ� ����� ��� : NEW , :OLD�� ��� ����������.
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

-- ����)
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
    -- DELETE Ʈ���ſ����� :NEW����� �� ����.
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
FOR EACH ROW -- �� ���� Ʈ���ŷ� ����� ��� : NEW , :OLD�� ��� ����������.
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
    -- PRAGMA�� ���� ��ȣ�� ���ν����� ����
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


-- ����� ���� ����ó�� ���
�ڹ� - ���� 0 ~ 100�������� ����

SELECT COUNT(*)
FROM emp
WHERE sal BETWEEN A AND A;

--���� COUNT(*)�� 0�ϰ�� ���ܸ� �߻���Ű��
CREATE OR REPLACE PROCEDURE up_myexception
(
    psal NUMBER 
)
IS 
    vcount NUMBER;
    -- ����� ���� ��ü ����
    ZERO_EMP_COUNT EXCEPTION;
BEGIN
    
    SELECT COUNT(*) INTO vcount
    FROM emp
    WHERE sal BETWEEN psal-100 AND psal+100;
    
    IF vcount = 0 THEN 
        RAISE ZERO_EMP_COUNT;
    ELSE
        DBMS_OUTPUT.PUT_LINE( ' > ����� : ' || vcount );
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
--------------------------------------------------------
--  ������ ������ - ������-3��-04-2024   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table T_MEMBER
--------------------------------------------------------

  CREATE TABLE "SCOTT"."T_MEMBER" 
   (	"MEMBERSEQ" NUMBER(4,0), 
	"MEMBERID" VARCHAR2(20 BYTE), 
	"MEMBERPASSWD" VARCHAR2(20 BYTE), 
	"MEMBERNAME" VARCHAR2(20 BYTE), 
	"MEMBERPHONE" VARCHAR2(20 BYTE), 
	"MEMBERADDRESS" VARCHAR2(100 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;

   COMMENT ON COLUMN "SCOTT"."T_MEMBER"."MEMBERSEQ" IS 'ȸ��SEQ';
   COMMENT ON COLUMN "SCOTT"."T_MEMBER"."MEMBERID" IS 'ȸ�����̵�';
   COMMENT ON COLUMN "SCOTT"."T_MEMBER"."MEMBERPASSWD" IS '��й�ȣ';
   COMMENT ON COLUMN "SCOTT"."T_MEMBER"."MEMBERNAME" IS 'ȸ����';
   COMMENT ON COLUMN "SCOTT"."T_MEMBER"."MEMBERPHONE" IS '�޴���';
   COMMENT ON COLUMN "SCOTT"."T_MEMBER"."MEMBERADDRESS" IS '�ּ�';
   COMMENT ON TABLE "SCOTT"."T_MEMBER"  IS 'ȸ��';
--------------------------------------------------------
--  DDL for Table T_POLLSUB
--------------------------------------------------------

  CREATE TABLE "SCOTT"."T_POLLSUB" 
   (	"POLLSUBSEQ" NUMBER(38,0), 
	"ANSWER" VARCHAR2(100 BYTE), 
	"ACOUNT" NUMBER(4,0), 
	"POLLSEQ" NUMBER(4,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;

   COMMENT ON COLUMN "SCOTT"."T_POLLSUB"."POLLSUBSEQ" IS '�亯�׸�SEQ';
   COMMENT ON COLUMN "SCOTT"."T_POLLSUB"."ANSWER" IS '�亯�׸�';
   COMMENT ON COLUMN "SCOTT"."T_POLLSUB"."ACOUNT" IS '�亯�׸��ü�';
   COMMENT ON COLUMN "SCOTT"."T_POLLSUB"."POLLSEQ" IS '����SEQ';
   COMMENT ON TABLE "SCOTT"."T_POLLSUB"  IS '�����׸�';
--------------------------------------------------------
--  DDL for Table T_POLL
--------------------------------------------------------

  CREATE TABLE "SCOTT"."T_POLL" 
   (	"POLLSEQ" NUMBER(4,0), 
	"QUESTION" VARCHAR2(256 BYTE), 
	"SDATE" DATE, 
	"EDATE" DATE, 
	"ITEMCOUNT" NUMBER(1,0) DEFAULT 1, 
	"POLLTOTAL" NUMBER(4,0), 
	"REGDATE" DATE DEFAULT sysdate, 
	"MEMBERSEQ" NUMBER(4,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;

   COMMENT ON COLUMN "SCOTT"."T_POLL"."POLLSEQ" IS '����SEQ';
   COMMENT ON COLUMN "SCOTT"."T_POLL"."QUESTION" IS '����';
   COMMENT ON COLUMN "SCOTT"."T_POLL"."SDATE" IS '������';
   COMMENT ON COLUMN "SCOTT"."T_POLL"."EDATE" IS '������';
   COMMENT ON COLUMN "SCOTT"."T_POLL"."ITEMCOUNT" IS '�亯�׸��';
   COMMENT ON COLUMN "SCOTT"."T_POLL"."POLLTOTAL" IS '��������';
   COMMENT ON COLUMN "SCOTT"."T_POLL"."REGDATE" IS '�ۼ���';
   COMMENT ON COLUMN "SCOTT"."T_POLL"."MEMBERSEQ" IS '�ۼ���(ȸ��SEQ)';
   COMMENT ON TABLE "SCOTT"."T_POLL"  IS '��������';
--------------------------------------------------------
--  DDL for Table T_VOTER
--------------------------------------------------------

  CREATE TABLE "SCOTT"."T_VOTER" 
   (	"VECTORSEQ" NUMBER, 
	"USERNAME" VARCHAR2(20 BYTE), 
	"REGDATE" DATE, 
	"POLLSEQ" NUMBER(4,0), 
	"POLLSUBSEQ" NUMBER(38,0), 
	"MEMBERSEQ" NUMBER(4,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;

   COMMENT ON COLUMN "SCOTT"."T_VOTER"."VECTORSEQ" IS '��ǥSEQ';
   COMMENT ON COLUMN "SCOTT"."T_VOTER"."USERNAME" IS '������̸�';
   COMMENT ON COLUMN "SCOTT"."T_VOTER"."REGDATE" IS '��ǥ��';
   COMMENT ON COLUMN "SCOTT"."T_VOTER"."POLLSEQ" IS '����SEQ';
   COMMENT ON COLUMN "SCOTT"."T_VOTER"."POLLSUBSEQ" IS '�亯�׸�SEQ';
   COMMENT ON COLUMN "SCOTT"."T_VOTER"."MEMBERSEQ" IS 'ȸ��SEQ';
   COMMENT ON TABLE "SCOTT"."T_VOTER"  IS '��ǥ��';
--------------------------------------------------------
--  DDL for Index PK_T_MEMBER
--------------------------------------------------------

  CREATE UNIQUE INDEX "SCOTT"."PK_T_MEMBER" ON "SCOTT"."T_MEMBER" ("MEMBERSEQ") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_T_POLLSUB
--------------------------------------------------------

  CREATE UNIQUE INDEX "SCOTT"."PK_T_POLLSUB" ON "SCOTT"."T_POLLSUB" ("POLLSUBSEQ") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_T_POLL
--------------------------------------------------------

  CREATE UNIQUE INDEX "SCOTT"."PK_T_POLL" ON "SCOTT"."T_POLL" ("POLLSEQ") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_T_VOTER
--------------------------------------------------------

  CREATE UNIQUE INDEX "SCOTT"."PK_T_VOTER" ON "SCOTT"."T_VOTER" ("VECTORSEQ") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table T_MEMBER
--------------------------------------------------------

  ALTER TABLE "SCOTT"."T_MEMBER" ADD CONSTRAINT "PK_T_MEMBER" PRIMARY KEY ("MEMBERSEQ")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "SCOTT"."T_MEMBER" MODIFY ("MEMBERID" NOT NULL ENABLE);
  ALTER TABLE "SCOTT"."T_MEMBER" MODIFY ("MEMBERSEQ" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table T_POLLSUB
--------------------------------------------------------

  ALTER TABLE "SCOTT"."T_POLLSUB" ADD CONSTRAINT "PK_T_POLLSUB" PRIMARY KEY ("POLLSUBSEQ")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "SCOTT"."T_POLLSUB" MODIFY ("POLLSEQ" NOT NULL ENABLE);
  ALTER TABLE "SCOTT"."T_POLLSUB" MODIFY ("ANSWER" NOT NULL ENABLE);
  ALTER TABLE "SCOTT"."T_POLLSUB" MODIFY ("POLLSUBSEQ" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table T_POLL
--------------------------------------------------------

  ALTER TABLE "SCOTT"."T_POLL" ADD CONSTRAINT "PK_T_POLL" PRIMARY KEY ("POLLSEQ")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "SCOTT"."T_POLL" MODIFY ("REGDATE" NOT NULL ENABLE);
  ALTER TABLE "SCOTT"."T_POLL" MODIFY ("ITEMCOUNT" NOT NULL ENABLE);
  ALTER TABLE "SCOTT"."T_POLL" MODIFY ("EDATE" NOT NULL ENABLE);
  ALTER TABLE "SCOTT"."T_POLL" MODIFY ("SDATE" NOT NULL ENABLE);
  ALTER TABLE "SCOTT"."T_POLL" MODIFY ("QUESTION" NOT NULL ENABLE);
  ALTER TABLE "SCOTT"."T_POLL" MODIFY ("POLLSEQ" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table T_VOTER
--------------------------------------------------------

  ALTER TABLE "SCOTT"."T_VOTER" ADD CONSTRAINT "PK_T_VOTER" PRIMARY KEY ("VECTORSEQ")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "SCOTT"."T_VOTER" MODIFY ("VECTORSEQ" NOT NULL ENABLE);
--------------------------------------------------------
--  Ref Constraints for Table T_POLLSUB
--------------------------------------------------------

  ALTER TABLE "SCOTT"."T_POLLSUB" ADD CONSTRAINT "FK_T_POLL_TO_T_POLLSUB" FOREIGN KEY ("POLLSEQ")
	  REFERENCES "SCOTT"."T_POLL" ("POLLSEQ") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table T_POLL
--------------------------------------------------------

  ALTER TABLE "SCOTT"."T_POLL" ADD CONSTRAINT "FK_T_MEMBER_TO_T_POLL" FOREIGN KEY ("MEMBERSEQ")
	  REFERENCES "SCOTT"."T_MEMBER" ("MEMBERSEQ") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table T_VOTER
--------------------------------------------------------

  ALTER TABLE "SCOTT"."T_VOTER" ADD CONSTRAINT "FK_T_MEMBER_TO_T_VOTER" FOREIGN KEY ("MEMBERSEQ")
	  REFERENCES "SCOTT"."T_MEMBER" ("MEMBERSEQ") ENABLE;
  ALTER TABLE "SCOTT"."T_VOTER" ADD CONSTRAINT "FK_T_POLLSUB_TO_T_VOTER" FOREIGN KEY ("POLLSUBSEQ")
	  REFERENCES "SCOTT"."T_POLLSUB" ("POLLSUBSEQ") ENABLE;
  ALTER TABLE "SCOTT"."T_VOTER" ADD CONSTRAINT "FK_T_POLL_TO_T_VOTER" FOREIGN KEY ("POLLSEQ")
	  REFERENCES "SCOTT"."T_POLL" ("POLLSEQ") ENABLE;
      
--------------------------------------------------------------------------------
SELECT * FROM t_member;
SELECT * FROM t_poll;
SELECT * FROM t_pollsub;
SELECT * FROM t_voter;

1) ȸ�� ����/����/Ż�� ����..
DESC T_MEMBER;
�̸�            ��?       ����            
------------- -------- ------------- 
MEMBERSEQ     NOT NULL NUMBER(4)       PK
MEMBERID      NOT NULL VARCHAR2(20)  
MEMBERPASSWD           VARCHAR2(20)  
MEMBERNAME             VARCHAR2(20)  
MEMBERPHONE            VARCHAR2(20)  
MEMBERADDRESS          VARCHAR2(100) 

  ��. T_MEMBER  -> PK Ȯ��.
SELECT *  
FROM user_constraints  
WHERE table_name LIKE 'T_M%'  AND constraint_type = 'P';
    
  ��.  ȸ������
  ������(sequence)  �ڵ����� ��ȣ �߻���Ű�� ��ü == ���� (��ȣ)
INSERT INTO   T_MEMBER (  MEMBERSEQ,MEMBERID,MEMBERPASSWD,MEMBERNAME,MEMBERPHONE,MEMBERADDRESS )
VALUES                 (  1,         'admin', '1234',  '������', '010-1111-1111', '���� ������' );
INSERT INTO   T_MEMBER (  MEMBERSEQ,MEMBERID,MEMBERPASSWD,MEMBERNAME,MEMBERPHONE,MEMBERADDRESS )
VALUES                 (  2,         'hong', '1234',  'ȫ�浿', '010-1111-1112', '���� ���۱�' );
INSERT INTO   T_MEMBER (  MEMBERSEQ,MEMBERID,MEMBERPASSWD,MEMBERNAME,MEMBERPHONE,MEMBERADDRESS )
VALUES                 (  3,         'kim', '1234',  '����', '010-1111-1341', '��� �����ֽ�' );
    COMMIT;
  ��. ȸ�� ���� ��ȸ
  SELECT * 
  FROM t_member;
  
  ��. ȸ�� ���� ����
  �α��� -> (ȫ�浿) -> [�� ����] -> �� ���� ���� -> [����] -> [�̸�][][][][][][] -> [����]
  PL/SQL
  UPDATE T_MEMBER
  SET    MEMBERNAME = , MEMBERPHONE = 
  WHERE MEMBERSEQ = 2;
  ��. ȸ�� Ż��
  DELETE FROM T_MEMBER 
  WHERE MEMBERSEQ = 2;
  
--------------------------------------------------------------------------------
1) ȸ�� ����/����/Ż�� ����..    
   ��. �����ڷ� �α���         
   ��. [�����ۼ�] �޴� ����
   ��. ���� �ۼ� �������� �̵�...
   INSERT INTO T_POLL (PollSeq,Question,SDate, EDAte , ItemCount,PollTotal, RegDate, MemberSEQ )
   VALUES             ( 1  ,'�����ϴ� �����?'
                          , TO_DATE( '2024-02-01 00:00:00'   ,'YYYY-MM-DD HH24:MI:SS')
                          , TO_DATE( '2024-02-15 18:00:00'   ,'YYYY-MM-DD HH24:MI:SS') 
                          , 5
                          , 0
                          , TO_DATE( '2023-01-15 00:00:00'   ,'YYYY-MM-DD HH24:MI:SS')
                          , 1
                    );
    ��. ���� �׸�                  
 
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (1 ,'�载��', 0, 1 );
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (2 ,'�����', 0, 1 );
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (3 ,'������', 0, 1 );
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (4 ,'�輱��', 0, 1 );
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (5 ,'ȫ�浿', 0, 1 );      
   COMMIT;
--
   ��. ���� �ۼ� �������� �̵�...
   INSERT INTO T_POLL (PollSeq,Question,SDate, EDAte , ItemCount,PollTotal, RegDate, MemberSEQ )
   VALUES             ( 3  ,'�����ϴ� ��?'
                          , TO_DATE( '2024-03-25 00:00:00'   ,'YYYY-MM-DD HH24:MI:SS')
                          , TO_DATE( '2024-04-15 18:00:00'   ,'YYYY-MM-DD HH24:MI:SS') 
                          , 3
                          , 0
                          , TO_DATE( '2024-03-01 00:00:00'   ,'YYYY-MM-DD HH24:MI:SS')
                          , 1
                    );
    ��. ���� �׸�                  
 
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (10 ,'����', 0, 3 );
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (11 ,'���', 0, 3 );
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (12 ,'�Ķ�', 0, 3 );

   
   COMMIT;
--
SELECT *
FROM t_poll;
SELECT *
FROM t_pollsub; 
 
   ���� ����, ���� ���� query
 
 11:03 ����...
--------------------------------------------------------------------------------
3) ȸ���� �α����߽��ϴ�.     [ �������������  ]
   2 ���� : �����ϴ� ���� "����" Ŭ��
SELECT *
FROM t_member;   
  --> 3   kim   1234   ���� (����)
SELECT *
FROM (
    SELECT  pollseq ��ȣ, question ����, membername �ۼ���
         , sdate ������, edate ������, itemcount �׸��, polltotal �����ڼ�
         , CASE 
              WHEN  SYSDATE > edate THEN  '����'
              WHEN  SYSDATE BETWEEN  sdate AND edate THEN '���� ��'
              ELSE '���� ��'
           END ���� -- ����Ӽ�   ����, ���� ��, ���� ��
    FROM t_poll p JOIN  t_member m ON m.memberseq = p.memberseq
    ORDER BY ��ȣ DESC
) t 
WHERE ���� != '���� ��';  

--------------------------------------------------------------------------------  
3)  3(����) �α��� ���� +  2�� ���� ����..( �����ϴ� ���� ) [ ��ǥ ������ ]
   ���� ���μ��� 
   ���� ������������� ���������ϱ� ���ؼ� 2�� ������ Ŭ��
   [���� ���� ������]
   1) 2�� ������ ������ SELECT-> ���
       ��. �������� 
           ����, �ۼ���, �ۼ���, ������, ������, ����, �׸�� ��ȸ
           SELECT question, membername
               , TO_CHAR(regdate, 'YYYY-MM-DD AM hh:mi:ss')
               , TO_CHAR(sdate, 'YYYY-MM-DD')
               , TO_CHAR(edate, 'YYYY-MM-DD')
               , CASE 
                  WHEN  SYSDATE > edate THEN  '����'
                  WHEN  SYSDATE BETWEEN  sdate AND edate THEN '���� ��'
                  ELSE '���� ��'
               END ����
               , itemcount
           FROM t_poll p JOIN t_member m ON p.memberseq = m.memberseq
           WHERE pollseq = 2;
       ��. �����׸�
           SELECT answer
           FROM t_pollsub
           WHERE pollseq = 2;
   2) �������ڼ� 7��
      �� []
      .  []
      .  []
    -- 2�� ������ �������ڼ�   
    SELECT  polltotal  
    FROM t_poll
    WHERE pollseq = 2;
    -- 
    SELECT answer, acount
        , ( SELECT  polltotal      FROM t_poll    WHERE pollseq = 2 ) totalCount
        -- ,  ����׷���
        , ROUND (acount /  ( SELECT  polltotal      FROM t_poll    WHERE pollseq = 2 ) * 100) || '%'
     FROM t_pollsub
    WHERE pollseq = 2;
  
  3) [ ��ǥ�ϱ� ] ��ư Ŭ��
     - 2������ �׸��� ������ �ؾߵȴ�. 
    �ڹ�
    ����Ŭ (üũ)  PK 7  ( �����׸�  PK ���� 7�� ����)
    HTML5
    JSP
    
    SELECT *
    FROM t_voter;
    -- (1) t_voter
    INSERT INTO t_voter 
    ( vectorseq, username, regdate, pollseq, pollsubseq, memberseq )
    VALUES
    (      1   ,  '����'      , SYSDATE,   2  ,     7 ,        3 );
    COMMIT;
    
    -- 1)         2/3 �ڵ� UPDATE  [Ʈ����]
    -- (2) t_poll   totalCount = 1����
    UPDATE   t_poll
    SET polltotal = polltotal + 1
    WHERE pollseq = 2;
    
    -- (3)t_pollsub   account = 1����
    UPDATE   t_pollsub
    SET acount = acount + 1
    WHERE  pollsubseq = 7;
    
    commit;
    
    SELECT *
    FROM t_poll;      
        
    SELECT *
    FROM t_pollsub;     



CREATE SEQUENCE ��������
[ INCREMENT BY ����] -- ������
[ START WITH ����]   -- ���۰�
[ MAXVALUE n ? NOMAXVALUE]  -- �ִ밪
[ MINVALUE n ? NOMINVALUE]  -- �ּҰ�
[ CYCLE ? NOCYCLE]          -- ����Ŭ
[ CACHE n ? NOCACHE];       

-- dept���̺��� ����� ������ ����
SELECT *
FROM dept;
-- ������ ������ �� �ش��ϴ� �Ӽ��� ������ �����ؼ� MAX�� ����

CREATE SEQUENCE SEQ_dept 
INCREMENT BY 10 
START WITH 50 
MAXVALUE 90 
MINVALUE 1 
NOCYCLE NOCACHE;

CREATE SEQUENCE SEQ_test INCREMENT BY 10 START WITH 50;
SELECT *
FROM user_sequences;

DROP SEQUENCE seq_dept;
-- NEXTVAL�� ���� ����ϰ� CURRVAL�� ����ؾ� ������ �������� �ʴ´�.
--ORA-08002: sequence SEQ_DEPT.CURRVAL is not yet defined in this session
--08002. 00000 -  "sequence %s.CURRVAL is not yet defined in this session"
--*Cause:    sequence CURRVAL has been selected before sequence NEXTVAL
--*Action:   select NEXTVAL from the sequence before selecting CURRVAL
SELECT seq_dept.CURRVAL
FROM dual;


INSERT INTO dept (deptno, dname, loc ) VALUES ( seq_dept.NEXTVAL, 'QC', '����' );

INSERT INTO dept (deptno, dname, loc ) VALUES ( seq_dept.NEXTVAL, 'QC2', '����' );

DESC dept;

SELECT seq_dept.NEXTVAL, seq_dept.CURRVAL
FROM dual;

SELECT *
FROM dept;

DELETE FROM dept
WHERE deptno >= 50;
COMMIT;

PL/SQL = Procedural Language (�������� ���) Ȯ��� SQL
         ���, ����, ���ν���, �Լ�, ��� ���
PL/SQL�� �� ������ ����̴�. - 3���� ���� �ִ�.
 1) ���� �� : DECLARE�� 
 2) ���� �� : BEGIN��
 3) ���� ó�� �� : EXCEPTION��
 
DECLARE(��������)
    -- ���� �� : DECLARE�� 
BEGIN
    -- ���� �� : BEGIN��
    /* */ : PL/SQL�� �� �ȿ����� �ڹ�ó�� �������� �ּ�ó�� ����
    
    SELECT ��;
    INSERT ��;
    SELECT ��;
    UPDATE ��;
    DELETE ��;
    SELECT ��;
    COMMIT;
EXCEPTION(��������)
    -- ���� ó�� �� : EXCEPTION��
END;


DESC emp;

DBMS_output ��Ű��
PUT
PUT_LINE


PL/SQL�� 5���� ����
1) �͸� ���ν��� (anonymous procedure) : DECLARE�� �����ϴ� ���ν���
-- �����ȣ�� 7369�� ����� �̸�, pay�� ���ͼ� ������ �����ϰ� ���
DECLARE
   --����, ��� �����ϴ� ��
   --������ �̸��տ� v�� ���δ�.(vename)
   -- BIGIN���� ����� ������ ������� DECLARE�� ����� ������ ���� SMITH 800
--   vename VARCHAR2(10);
   -- ���̺� ������ ���� ����� �� TYPE�� ������ �����ؼ� ���
   vename emp.ename%TYPE; -- TYPE�� ������ ���� emp���̺��� ename�� �ڷ����� �����ͼ� ������ ����
   vpay NUMBER;
   -- ����Ŭ���� ��� ���� CONSTANT
   -- ����Ŭ���� ���Կ����� := 
   vpi CONSTANT NUMBER := 3.141592;
BEGIN
--    vpay := 0;
    SELECT ename, sal + NVL(comm, 0) pay
        INTO vename, vpay -- INTO�������� ������ ���� �Ҵ�
    FROM emp
    WHERE empno = 7369;
     -- ����Ŭ���� ����Ҽ��ִ� ����DBMS_OUTPUT.PUT_LINE()
     -- ����(v)���� DBMS ��´����� SCOTT���� ������ ���� ����ϸ� �ڹ� consoleâó�� ���´�.
--    DBMS_OUTPUT.PUT_LINE('Hello World');
      DBMS_OUTPUT.PUT_LINE(vename || ' ' || vpay || ' ' || vpi);
    
--EXCEPTION
END;

������ ���� ���  
���1) := �����ڿ� ���� ���� 
 ��) 
   vpi CONSTANT NUMBER := 3.141592;
   bonus := current_salary*0.10; 
   amount := TO_NUMBER(SUBSTR('750 dollars',1,3)); 
   valid := FALSE; 
   
���2) select�� fetch�� ���ؼ� ������ ���� 
������ emp ���̺��� sal�� select�Ͽ� 10%�� ���ʽ��� ����Ŭ�� ����ϴ� ���̴�. 
 ��) 
   SELECT sal * 0.10 INTO bonus FROM emp WHERE empno=emp_id; 

-- ���� : dept���̺��� 30�� �μ��� �μ����� ���ͼ� ����ϴ� �͸� ���ν����� �ۼ�

DECLARE
   vdname dept.dname%TYPE;
BEGIN
    SELECT dname
        INTO vdname
    FROM dept
    WHERE deptno = 30;
    
    DBMS_OUTPUT.PUT_LINE( '�μ��� : ' || vdname );
--EXCEPTON
END;

-- ���� : 30�� �μ��� �������� ���ͼ� 10�� �μ��� ���������� ����

DECLARE 
    vloc dept.loc%TYPE;
BEGIN
    SELECT loc
        INTO vloc
    FROM dept
    WHERE deptno = 30;

    UPDATE dept
    SET loc = vloc
    WHERE deptno = 10;
    DBMS_OUTPUT.PUT_LINE( '������ : ' || vloc ); 
--EXCEPTON
END;

ROLLBACK;

SELECT *
FROM emp;

-- ���� 10�� �μ��� �߿� �ְ�޿��� �޴� ����� ������ ���

[1] �� Ǯ��
DECLARE
    vename emp.ename%TYPE;
    vempno emp.empno%TYPE;
    vsal   emp.sal%TYPE;
    vdeptno emp.deptno%TYPE;
BEGIN 
    SELECT ename, empno, sal+NVL(comm, 0) sal, deptno
        INTO vename, vempno, vsal, vdeptno
    FROM emp
    WHERE deptno = 10 AND sal+NVL(comm, 0) = (
    SELECT MAX(sal + NVL(comm, 0)) sal
    FROM emp
    WHERE deptno = 10
    );
    
    DBMS_OUTPUT.PUT_LINE( vename || ' ' || vempno || ' ' || vsal || ' ' || vdeptno);
END;

[2] �� Ǯ��
DECLARE
    vename emp.ename%TYPE;
    vempno emp.empno%TYPE;
    vjob emp.job%TYPE;
    vmgr emp.mgr%TYPE;
    vhiredate emp.hiredate%TYPE;
    vsal   emp.sal%TYPE;
    vdeptno emp.deptno%TYPE;
BEGIN 
    
    WITH t AS (
    SELECT ename
        ,empno
        ,job
        ,mgr
        ,hiredate
        ,sal + NVL(comm, 0) sal 
        ,deptno
        ,RANK() OVER(ORDER BY sal+NVL(comm, 0) DESC) RANK
    FROM emp
    WHERE deptno = 10
    )
    SELECT t.ename, t.empno, t.job, t.mgr, t.hiredate, t.sal, t.deptno
        INTO vename, vempno, vjob, vmgr, vhiredate, vsal, vdeptno
    FROM t
    WHERE t.rank = 1;
    
    
    DBMS_OUTPUT.PUT_LINE( vename || ' ' || vempno || ' ' || 
    vjob || ' ' || vmgr || ' ' || vhiredate || ' ' || vsal || ' ' || vdeptno);
END;

[3]�� Ǯ��
DECLARE
  vmax_sal_10 emp.sal%TYPE;
  vemp_row.emp%ROWTYPE;
BEGIN
  SELECT MAX(sal) INTO vmax_sal_10
  FROM emp
  WHERE deptno = 10;
  
  SELECT empno, ename, job, sal, hiredate, deptno
   INTO  vemp_row.empno, vename_row.ename, vjob_row.job, vsal_row.sal, vhiredate_row.hiredate, vdeptno_rwo.deptno
  FROM emp
  WHERE deptno = 10 AND sal = vmax_sal_10;
  
  DBMS_OUTPUT.PUT_LINE( '�����ȣ :'  || vempno );
  DBMS_OUTPUT.PUT_LINE( '����� :'    || vename );
  DBMS_OUTPUT.PUT_LINE( '�Ի����� :'  || vhiredate );
-- EXCEPTION
END;

-- insa���̺��� 1001���� �̸��� pay�� ���
-- Ŀ��
DECLARE
    vname insa.name%TYPE := '�͸�';
    vpay NUMBER := 0;
    vmessage VARCHAR2(100);
BEGIN
    -- PL/SQL���� �������� ���� ó���� ���� �ݵ�� "Ŀ��"�� ����ؾ� �Ѵ�. (�ϱ�)
    SELECT name, basicpay + sudang pay
        INTO vname, vpay
    FROM insa
--    WHERE num = 1001;
    
    vmessage := vname || +  ', ' || vpay;
    DBMS_OUTPUT.PUT_LINE(vmessage);
--EXCEPTION
END;
--���� ���� -
--ORA-06550: line 12, column 14:
--PL/SQL: ORA-00933: SQL command not properly ended
--ORA-06550: line 7, column 5:
--PL/SQL: SQL Statement ignored
--06550. 00000 -  "line %s, column %s:\n%s"
--*Cause:    Usually a PL/SQL compilation error.

-- 1) �͸� ���ν��� + ���Կ����� ( := ) , ���
DECLARE
    a NUMBER :=1;
    b NUMBER;
    c NUMBER := 0;
BEGIN
    c := a + b;
    
    DBMS_OUTPUT.PUT_LINE( c );
END;

-- PL/SQL�� �ȿ��� ����ϴ� ����� ����
�ڹٿ����� if��
if(){}
if(){}else{}
if(){}else if(){}else{}

--����Ŭ������ IF�� == �ڹ� if(){}��
IF ���ǽ� THEN
END IF;

--����Ŭ������ IF ELSE == �ڹ� if(){}else{}
IF ���ǽ� THEN
ELSE
END IF;

--����Ŭ���� IF ELSE IF == �ڹ� if(){}else if(){} else{}
IF ���ǽ� THEN
ELSIF ���ǽ� THEN
ELSIF ���ǽ� THEN
ELSIF ���ǽ� THEN
ELSE
END IF;

-- ���� ���ν��� �׽�Ʈ �Ҷ��� ��â �����ؼ� 1�����κ��� ����
-- ����) �ϳ��� �������Է¹޾Ƽ� Ȧ�� / ¦����� ���...(�͸� ���ν���)
DECLARE
    vnum NUMBER(2) := 0;
    vresult VARCHAR2(2 CHAR);
    
BEGIN
    vnum := :bindNumber; -- :���ε�������;
    IF MOD(vnum,2) = 0 
    THEN vresult := '¦��';--DBMS_OUTPUT.PUT_LINE('¦��');
    ELSE vresult := 'Ȧ��';--DBMS_OUTPUT.PUT_LINE('Ȧ��');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(vresult);
--EXCEPTION
END;


-- �������� �Է¹޾Ƽ� ����̾簡 ������ (�͸����ν���)
[1]�� ���
DECLARE
    vkor NUMBER(3) := 0;
    vgrade VARCHAR2(1 CHAR);

BEGIN
    vkor := :bindNumber;
--    IF vkor >=90 AND vkor <= 100 THEN vgrade := '��';
    IF vkor BETWEEN 90 AND 100 THEN vgrade := '��';
    ELSIF vkor BETWEEN 80 AND 89 THEN vgrade := '��';
    ELSIF vkor BETWEEN 70 AND 79 THEN vgrade := '��';
    ELSIF vkor BETWEEN 60 AND 69 THEN vgrade := '��'; 
    ELSIF vkor BETWEEN 0 AND 59 THEN vgrade := '��';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(vgrade);
END;

[2]�� ���
DECLARE
   vkor NUMBER(3) := 0;
   vgrade VARCHAR2(3) := '��';
BEGIN
   vkor := :bindNumber; -- ���ε庯��
   IF  (vkor BETWEEN 90 AND 100) THEN   
     vgrade := '��';
   ELSIF vkor BETWEEN 80 AND 89 THEN   
     vgrade := '��';
   ELSIF vkor BETWEEN 70 AND 79 THEN
     vgrade := '��';
   ELSIF vkor BETWEEN 60 AND 69 THEN
     vgrade := '��';
   ELSIF vkor BETWEEN 0 AND 59 THEN
     vgrade := '��';
     -- ������ �Է� �߸�!! ���� �߻�..
   END IF;
   DBMS_OUTPUT.PUT_LINE( vgrade );   
--EXCEPTION
END;

[3]�� ���
DECLARE
   vkor NUMBER(3) := 0;
   vgrade VARCHAR2(3) := '��';
BEGIN
   vkor := :bindNumber; -- ���ε庯��
   IF vkor BETWEEN 0 AND 100 THEN
    vgrade := CASE TRUNC(vkor/10)
              WHEN 10 THEN '��'
              WHEN 9 THEN '��'
              WHEN 8 THEN '��'
              WHEN 7 THEN '��'
              WHEN 6 THEN '��'
              ELSE '��'
              END;
   ELSE
    DBMS_OUTPUT.PUT_LINE( '�������� 0~100���� �Է��ؾ��մϴ�.');
    
   END IF;
   
   DBMS_OUTPUT.PUT_LINE(vgrade);
END;

-- 1) WHITE LOOF��
�ڹ� while
while(���ǽ�){
}

����Ŭ PL/SQL WHILE��
WHILE (���ǽ�)LOOP

WHILE (���ǽ�){
} END LOOP

-- -- ���� 1~10������ �� ����Ŭ���� ���ض�(�͸� ���ν��� ���)
DECLARE
    vi NUMBER := 1;
    vsum NUMBER := 0;
BEGIN
    WHILE( vi <= 10 )
    LOOP
        IF vi = 10 THEN DBMS_OUTPUT.PUT(vi);
        ELSE
        DBMS_OUTPUT.PUT(vi || '+');
        END IF;
        vi := vi + 1;
        vsum := vsum + vi;
    END LOOP;
    
        DBMS_OUTPUT.PUT_LINE( ' = ' || vsum );
--EXCEPTION
END;

-- 2) LOOP END LOOP��
�ڹ� ���ѷ��� break;
while( true ){
 if (���ǽ�) break;
}

-- 1~10���� �� ���ϱ� LOOP END LOOP��
DECLARE
    vi NUMBER := 1;
    vsum NUMBER := 0;
BEGIN
    LOOP
        IF vi = 10 THEN DBMS_OUTPUT.PUT(vi);
        ELSE
        DBMS_OUTPUT.PUT(vi || '+');
        END IF;
        vi := vi + 1;
        vsum := vsum + vi;
        EXIT WHEN vi = 10;
       
        
    END LOOP;
    
        DBMS_OUTPUT.PUT_LINE( ' = ' || vsum );
--EXCEPTION
END;

EXIT ���ǽ�
END LOOP;


-- 3) FOR LOOP��
DECLARE
    vi NUMBER := 1;
    vsum NUMBER := 0;
BEGIN
   FOR i IN 1..10
   LOOP 
        IF i = 10 THEN DBMS_OUTPUT.PUT( i );
        ELSE DBMS_OUTPUT.PUT( i || '+' );
        END IF;
        vsum := vsum+i;
   END LOOP;
        DBMS_OUTPUT.PUT_LINE( ' = ' || vsum );
--EXCEPTION
END;


DECLARE
    vi NUMBER := 1;
    vsum NUMBER := 0;
BEGIN
   FOR i IN REVERSE 1..10
   LOOP 
        IF i = 1 THEN DBMS_OUTPUT.PUT( i );
        ELSE DBMS_OUTPUT.PUT( i || '+' );
        END IF;
        vsum := vsum+i;
   END LOOP;
        DBMS_OUTPUT.PUT_LINE( ' = ' || vsum );
--EXCEPTION
END;


-- FOR �� LOOP�� ���� ������ ���� ���

BEGIN
  FOR i IN 2..9 LOOP
    FOR j IN 1..9 LOOP
      DBMS_OUTPUT.PUT(i || ' * ' || j || ' = ' || (i * j) || '  ');
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(''); -- �� ���� ������ �ٹٲ�
  END LOOP;
END;

�̷��� Ǯ���µ� Ȥ�� for �� Ǫ�� ��?

EXIT ���ǽ�
END LOOP;


-- GOTO �� ~~ GOTO���� ��������
--DECLARE (��������)
BEGIN
  --
  GOTO first_proc;

-- WHILE�� ����ؼ� ������ ���η� ���
-- FOR�� ����ؼ� ������ ���η� ���
DECLARE
    vi NUMBER := 1;
    vj NUMBER := 1;
BEGIN
    LOOP
        vj := vj+1;
        vi := 1;
    LOOP     DBMS_OUTPUT.PUT( vj || '*' || vi || ' = ' || vi * vj ||' ');    
        vi := vi+1;
        EXIT WHEN vi = 10; 
    END LOOP;
        EXIT WHEN vj = 10;
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;
--EXCEPTION
END;

-- WHILE������ ó����� �𸣰���(�����)
--DECLARE
--    vnum NUMBER := 1;
--    vdan NUMBER := 1;
--BEGIN
--    WHILE ( vnum < 10 )
--    LOOP
--       vdan := vdan+1;
--       vnum := 1;
--    LOOP
--       DBMS_OUTPUT.PUT( vdan || '*' || vnum || ' = ' || vdan*vnum ||' ');
--    END LOOP;
--    END LOOP;
--END;        


--DECLARE 
--    vnum NUMBER := 1;
--    vdan NUMBER := 1;
BEGIN
    FOR i IN 2..9
    LOOP
    FOR j IN 1..9
    LOOP
    DBMS_OUTPUT.PUT_LINE( i || '*' || j || ' = ' || j * i);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE( '' );
    END LOOP;
END;




  --
  <<second_proc>>
  DBMS_OUTPUT.PUT_LINE('> 2 ó�� ');
  GOTO third_proc; 
  -- 
  --
  <<first_proc>>
  DBMS_OUTPUT.PUT_LINE('> 1 ó�� ');
  GOTO second_proc; 
  -- 
  --
  --
  <<third_proc>>
  DBMS_OUTPUT.PUT_LINE('> 3 ó�� '); 
--EXCEPTION
END;

2) ���� ���ν��� (stored procedure) : ��ǥ���� PL/SQL (���� ���� ���Ǵ� PL/SQL)
3) ���� �Լ�    (stored function )
4) ��Ű��       (package)
5) Ʈ����       (trigger)

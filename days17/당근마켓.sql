-- ��ٸ��� ����

-- SCOTT 
-- ��ٸ��� 

-- ���ڰ� �ʹ� �� ġȯ
-- COMMUNITY : COMM 
-- COMMENT : CMT  
-- CATEGORY : CTGR 
-- NUMBER : NUM 

-- ���ڿ��� ���Ե� & �� �Ϲ� ���ڷ� ����մϴ�. 
SHOW define;
SET define off;

-- ������ �̹��� ������
CREATE 
SEQUENCE seq_item_image
INCREMENT BY 1 
START WITH 1 
NOCYCLE NOCACHE;

--INSERT INTO item_image VALUES ( seq_item_image.NEXTVAL, 1, ' ');
--INSERT INTO item_image VALUES ( seq_item_image.NEXTVAL, 1, ' ');
--INSERT INTO item_image VALUES ( seq_item_image.NEXTVAL, 1, ' ');
--INSERT INTO item_image VALUES ( seq_item_image.NEXTVAL, 1, ' ');
--INSERT INTO item_image VALUES ( seq_item_image.NEXTVAL, 1, ' ');
--INSERT INTO item_image VALUES ( seq_item_image.NEXTVAL, 1, ' ');
--INSERT INTO item_image VALUES ( seq_item_image.NEXTVAL, 1, ' ');
--INSERT INTO item_image VALUES ( seq_item_image.NEXTVAL, 1, ' ');
--INSERT INTO item_image VALUES ( seq_item_image.NEXTVAL, 1, ' ');
--INSERT INTO item_image VALUES ( seq_item_image.NEXTVAL, 1, ' ');
--INSERT INTO item_image VALUES ( seq_item_image.NEXTVAL, 1, ' ');
--INSERT INTO item_image VALUES ( seq_item_image.NEXTVAL, 1, ' ');
--INSERT INTO item_image VALUES ( seq_item_image.NEXTVAL, 1, ' ');
--INSERT INTO item_image VALUES ( seq_item_image.NEXTVAL, 1, ' ');
--INSERT INTO item_image VALUES ( seq_item_image.NEXTVAL, 1, ' ');
--INSERT INTO item_image VALUES ( seq_item_image.NEXTVAL, 1, ' ');
--INSERT INTO item_image VALUES ( seq_item_image.NEXTVAL, 1, ' ');
--INSERT INTO item_image VALUES ( seq_item_image.NEXTVAL, 1, ' ');
--INSERT INTO item_image VALUES ( seq_item_image.NEXTVAL, 1, ' ');
--INSERT INTO item_image VALUES ( seq_item_image.NEXTVAL, 1, ' ');
--INSERT INTO item_image VALUES ( seq_item_image.NEXTVAL, 1, ' ');
--INSERT INTO item_image VALUES ( seq_item_image.NEXTVAL, 1, ' ');
--INSERT INTO item_image VALUES ( seq_item_image.NEXTVAL, 1, ' ');
--INSERT INTO item_image VALUES ( seq_item_image.NEXTVAL, 1, ' ');
--INSERT INTO item_image VALUES ( seq_item_image.NEXTVAL, 1, ' ');

-- ���ƿ� �ѹ� ������
CREATE 
SEQUENCE seq_board_like
INCREMENT BY 1 
START WITH 1 
NOMAXVALUE
NOCYCLE NOCACHE;


INSERT INTO item_image VALUES ( seq_board_like.NEXTVAL, 1, 1);
INSERT INTO item_image VALUES ( seq_board_like.NEXTVAL, 1, 2);
INSERT INTO item_image VALUES ( seq_board_like.NEXTVAL, 2, 1);
INSERT INTO item_image VALUES ( seq_board_like.NEXTVAL, 2, 3);
INSERT INTO item_image VALUES ( seq_board_like.NEXTVAL, 2, 3);
INSERT INTO item_image VALUES ( seq_board_like.NEXTVAL, 2, 3);
INSERT INTO item_image VALUES ( seq_board_like.NEXTVAL, 2, 3);
INSERT INTO item_image VALUES ( seq_board_like.NEXTVAL, 2, 3);
INSERT INTO item_image VALUES ( seq_board_like.NEXTVAL, 2, 3);
INSERT INTO item_image VALUES ( seq_board_like.NEXTVAL, 2, 3);
INSERT INTO item_image VALUES ( seq_board_like.NEXTVAL, 2, 3);
INSERT INTO item_image VALUES ( seq_board_like.NEXTVAL, 2, 3);
INSERT INTO item_image VALUES ( seq_board_like.NEXTVAL, 2, 3);
INSERT INTO item_image VALUES ( seq_board_like.NEXTVAL, 2, 3);
INSERT INTO item_image VALUES ( seq_board_like.NEXTVAL, 2, 3);


-- ȸ�� ������
CREATE SEQUENCE seq_member_id 
INCREMENT BY 1 
START WITH 1 
NOCYCLE NOCACHE;

INSERT INTO member(member_num, member_birth, member_nickname, member_address, member_tel, member_profile) 
VALUES (seq_member_id.NEXTVAL, '1998-06-29', '����', '�λ걤���� �ؿ�뱸 �ߵ�', '010-4044-4444', 'https://cliimage.commutil.kr/phpwas/restmb_allidxmake.php?pp=002&idx=3&simg=20170712195535009572d12411ff9587970114.jpg&nmt=12');

-- ��ǰ �Խ��� ������
CREATE SEQUENCE SEQ_BOARD 
INCREMENT BY 1 
START WITH 1 
NOCYCLE NOCACHE;

INSERT INTO TRADE_BOARD VALUES ( 
SEQ_BOARD.NEXTVAL
    , '����' 
    , 'https://cliimage.commutil.kr/phpwas/restmb_allidxmake.php?pp=002&idx=3&simg=20170712195535009572d12411ff9587970114.jpg&nmt=12'
    , '�����̸ƽ� ����ǰ'
    , '3�� ��'
    , '200,000��'
    , '�̰��� ����ǰ�ε� ���� �̹� �ϳ� �־ �Ⱦƿ�'
    , '���� ��õ�� ��'
    , '45.5��'
    , 1
    , 1
    );
INSERT INTO TRADE_BOARD VALUES ( SEQ_BOARD.NEXTVAL
    , �ۼ��� �г���, �������̹���
    , '���̽� ��� ����̾�'
    , '8�� ��'
    , '100,000��'
    , '�ݳ� ���� ������ ���̽� ������̾��Դϴ�. �̻�뿡 �������.'
    , '��⵵ ����� ���嵿'
    , '39��'
    , 1
    , 1
    );
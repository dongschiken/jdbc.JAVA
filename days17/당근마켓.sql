-- 당근마켓 쿼리

-- SCOTT 
-- 당근마켓 

-- 문자가 너무 길어서 치환
-- COMMUNITY : COMM 
-- COMMENT : CMT  
-- CATEGORY : CTGR 
-- NUMBER : NUM 

-- 문자열에 포함된 & 를 일반 문자로 취급합니다. 
SHOW define;
SET define off;

-- 아이템 이미지 시퀀스
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

-- 좋아요 넘버 시퀀스
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


-- 회원 시퀀스
CREATE SEQUENCE seq_member_id 
INCREMENT BY 1 
START WITH 1 
NOCYCLE NOCACHE;

INSERT INTO member(member_num, member_birth, member_nickname, member_address, member_tel, member_profile) 
VALUES (seq_member_id.NEXTVAL, '1998-06-29', '진돌', '부산광역시 해운대구 중동', '010-4044-4444', 'https://cliimage.commutil.kr/phpwas/restmb_allidxmake.php?pp=002&idx=3&simg=20170712195535009572d12411ff9587970114.jpg&nmt=12');

-- 물품 게시판 시퀀스
CREATE SEQUENCE SEQ_BOARD 
INCREMENT BY 1 
START WITH 1 
NOCYCLE NOCACHE;

INSERT INTO TRADE_BOARD VALUES ( 
SEQ_BOARD.NEXTVAL
    , '진돌' 
    , 'https://cliimage.commutil.kr/phpwas/restmb_allidxmake.php?pp=002&idx=3&simg=20170712195535009572d12411ff9587970114.jpg&nmt=12'
    , '에어팟맥스 새상품'
    , '3일 전'
    , '200,000원'
    , '미개봉 새상품인데 저는 이미 하나 있어서 팔아요'
    , '서울 양천구 목동'
    , '45.5℃'
    , 1
    , 1
    );
INSERT INTO TRADE_BOARD VALUES ( SEQ_BOARD.NEXTVAL
    , 작성자 닉네임, 프로필이미지
    , '접이식 헤어 드라이어'
    , '8일 전'
    , '100,000원'
    , '반년 전에 구입한 접이식 헤어드라이어입니다. 미사용에 가까워요.'
    , '경기도 오산시 신장동'
    , '39℃'
    , 1
    , 1
    );
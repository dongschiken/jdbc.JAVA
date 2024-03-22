package days05;

import java.sql.Connection;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;

import com.util.DBConn;

import days05.board.controller.BoardController;
import days05.board.persistance.BoardDAO;
import days05.board.persistance.BoardDAOImpl;
import days05.board.service.BoardService;
import days05.board_domain.BoardDTO;

/**
 * @author dongs
 * @date 2024. 3. 20. - 오후 4:03:49
 * @subject
 * @content
 */
public class Ex01 {

	public static void main(String[] args) throws SQLException {
		// 게시판 전체목록 출력
//		Connection conn = DBConn.getConnection();
//		BoardDAOImpl daoimpl = new BoardDAOImpl(conn);
//		ArrayList<BoardDTO> list = daoimpl.select();
//		Iterator<BoardDTO> ir = list.iterator();
//		while (ir.hasNext()) {
//			BoardDTO boardDTO = (BoardDTO) ir.next();
//			System.out.println(boardDTO.toString());
//		}
			// [1] 게시판 만들기위한 패키지 선언
			// days05  
			// 		- board
			//			-- domain
			//				 BoardDTO.java			클래스
			//			-- persistence
			//				 BoardDAO.java			인터페이스
			//				 BoardDAOImpl.java  클래스
			//			-- service
			//			-- controller
			// [2] 테이블 + 시퀀스 생성
//CREATE TABLE tbl_cstVSBoard (
//         seq NUMBER NOT NULL PRIMARY KEY , -- 글 일련번호 ( PK )
//         writer VARCHAR2(20) NOT NULL ,
//         pwd VARCHAR2(20) NOT NULL ,
//         email VARCHAR2(100) ,
//         title VARCHAR2(200) NOT NULL ,
//         writedate DATE DEFAULT SYSDATE ,
//         readed NUMBER  default (0) ,
//         tag NUMBER(1) NOT NULL ,
//         content CLOB
//			);
//
//CREATE SEQUENCE seq_tbl_cstVSBoard INCREMENT BY 1 START WITH 1 NOCACHE NOCYCLE;
//
//--Table TBL_CSTVSBOARD이(가) 생성되었습니다.
//--Sequence SEQ_TBL_CSTVSBOARD이(가) 생성되었습니다.
	
// 150 개의 게시글을 임의로 추가
//		BEGIN
//	    FOR i IN 1.. 150
//	    LOOP
//	        INSERT INTO TBL_CSTVSBOARD
//	        (seq, writer, pwd, email, title, tag, content)
//	        VALUES
//	        ( seq_TBL_CSTVSBOARD.NEXTVAL, '홍길동' || i, '1234', 'hong' || i || '@sist.com' 
//	        , 'title-' || i
//	        , 0
//	        , 'content - ' || i);
//	        END LOOP;
//	        COMMIT;
//	END;
//	-- PL/SQL 프로시저가 성공적으로 완료되었습니다.SELECT *
//	FROM user_sequences;
//
//	BEGIN
//	    UPDATE TBL_CSTVSBOARD
//	    SET writer = '김영진'
//	    WHERE MOD( seq, 15 ) = 2;
//		SET writer = '권맑음'
//		WHERE MOD( seq, 7 ) = 1;
//	    COMMIT;
//	END;
//	BEGIN
//	    UPDATE TBL_CSTVSBOARD
//	    SET title = '저장 프로시저'
//	    WHERE MOD( seq, 9 ) IN(3, 5);
//	    COMMIT;
//	END;
		 													//BoardDTO객체 생성
			// 사용자 글작성후 -> BoardController.java -> BoardService.java
			// 	게시글 쓰기 : 작성 												1) 게시글 쓰기(DB처리, 로그기록)  BoardDTO
																					//    -    BoardDAOImpl.java  -> 오라클 DB서버를 연동
																					//    -     INSERT(dto객체) 작업
		
																					// DB처리 + 로그기록 + 3번째 작업... 논리적인 처리작업으로 성공하면 커밋, 실패하면 롤백한다.
		
		// 목록, 쓰기, 삭제, 수정, 검색
		// BoardDAO, BoardDAOImpl, BoardService, BoardController
		Connection conn = DBConn.getConnection();
		BoardDAO dao =  new BoardDAOImpl(conn);
		BoardService service = new BoardService(dao);
		BoardController controller = new BoardController(service);
		
		// 이동찬, 1234, lee@sist.com, 오류, 0, 오류해결
		controller.boardStart();
		
		
		
		
	}		

}

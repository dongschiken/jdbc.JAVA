package board_test;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import org.junit.jupiter.api.Test;
import com.util.DBConn;

import days05.board.persistance.BoardDAO;
import days05.board.persistance.BoardDAOImpl;
import days05.board.service.BoardService;
import days05.board_domain.BoardDTO;

class BoardServiceTest {

	@Test
	void test_selectService() {
		Connection conn = DBConn.getConnection();
		BoardDAO dao = new BoardDAOImpl(conn);

		ArrayList<BoardDTO> list = new ArrayList();
		BoardService boardService = new BoardService(dao);
		
		try {
			list = boardService.selectService();
		} catch (Exception e) {
			e.printStackTrace();
		}		
		System.out.println(" 게시글 수" + list.size() + "개");
		DBConn.close();
	}
	// writer, pwd, email, title,  tag, content
	
	
	
	@Test
	void test_insertService() {
		
		BoardDTO dto = new BoardDTO().builder()
				.writer("김영진")
				.pwd("1234")
				.email("kim@sist.com")
				.title("예비군 훈련")
				.tag(0)
				.content("결석")
				.build();
		Connection conn = DBConn.getConnection();
		BoardDAO dao = new BoardDAOImpl(conn);
		BoardService boardService = new BoardService(dao);
		int rowCount = 0;
		try {
			rowCount = boardService.insertService(dto);
			if( rowCount == 1 ) {
				System.out.println("게시글 작성 완료!!");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConn.close();
		}

		System.out.println("end");
	}
}

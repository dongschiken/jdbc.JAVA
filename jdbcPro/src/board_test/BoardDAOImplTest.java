package board_test;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import org.junit.jupiter.api.Test;
import com.util.DBConn;

import days05.board.persistance.BoardDAO;
import days05.board.persistance.BoardDAOImpl;
import days05.board_domain.BoardDTO;

class BoardDAOImplTest {

	@Test
	void test_select() {
		Connection conn = DBConn.getConnection();
		BoardDAO dao = new BoardDAOImpl(conn);

		ArrayList<BoardDTO> list = new ArrayList();
		try {
			list = dao.select();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println(" 게시글 수" + list.size() + "개");
		DBConn.close();
	}
	// writer, pwd, email, title,  tag, content
	
	
	
	@Test
	void test_insert() {
		Connection conn = DBConn.getConnection();
		BoardDAO dao = new BoardDAOImpl(conn);
		BoardDTO dto = new BoardDTO().builder()
				.writer("김영진")
				.pwd("1234")
				.email("kim@sist.com")
				.title("첫 번째 게시글")
				.tag(0)
				.content("첫 번째 게시글 내용")
				.build();

		int rowCount = 0;
		try {
			rowCount = dao.insert(dto);
			if( rowCount == 1 ) {
				System.out.println("게시글 작성 완료!!");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConn.close();
		}
		System.out.println("end");
	}
	
	@Test
	void test_view() {
		Connection conn = DBConn.getConnection();
		BoardDAO dao = new BoardDAOImpl(conn);

		try {
			BoardDTO dto = dao.view(151);
			System.out.printf("%d \n%s \n%s \n%s \n%s, \n%d \n%s"
					, dto.getSeq()
					, dto.getTitle()
					, dto.getWriter()
					, dto.getEmail()
					, dto.getWritedate()
					,  dto.getReaded()
					, dto.getContent() 
					);
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		DBConn.close();
	}
	
}

package test;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import org.junit.jupiter.api.Test;

import com.util.DBConn;

import days05.board.persistence.BoardDAO;
import days05.board.persistence.BoardDAOImpl;
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
				.writer("동스")
				.pwd("1234")
				.email("123@naver.co")
				.title("오늘 심심하네")
				.tag(2)
				.content("오늘 참 심심한 날이네 뭐하고 놀지")
				.build();
		try {
			dao.insert(dto);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		DBConn.close();
	}
}

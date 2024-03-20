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
	void test() {
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

}

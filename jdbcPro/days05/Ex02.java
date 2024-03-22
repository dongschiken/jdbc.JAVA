package days05;

import java.sql.Connection;

import com.util.DBConn;

import days05.board.controller.BoardController;
import days05.board.persistance.BoardDAO;
import days05.board.persistance.BoardDAOImpl;
import days05.board.service.BoardService;

public class Ex02 {

	public static void main(String[] args) {
		// 페이징 처리
		// 1. 현재 페이지의 번호
		// 2. 한페이지에 몇개의 게시판 출력??
		
		Connection conn = DBConn.getConnection();
		BoardDAO dao = new BoardDAOImpl(conn);
		BoardService service = new BoardService(dao);
		BoardController controller = new BoardController(service);
		controller.boardStart();
		
	}

}

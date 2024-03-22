package days05;

import java.sql.Connection;

import com.util.DBConn;

import days05.board.controller.BoardController;
import days05.board.persistance.BoardDAO;
import days05.board.persistance.BoardDAOImpl;
import days05.board.service.BoardService;

public class Ex03 {

	public static void main(String[] args) {
		// 페이징 처리
		// 1. 현재 페이지의 번호
		// 2. 한페이지에 몇개의 게시판 출력??

		int numberPerPage = 15;	
		// WHERE no BETWEEN start AND end
		int currentPage = 3;
		int start = 1, end = 10;
//		1 10
//		11 20
//		21 30
//		31 40
//		41 50
//		c가 2일때 == > 11 20
//		c가 3일때 == > 21 30
		
		start = currentPage+(9*(currentPage-1));
		end = currentPage+(9*currentPage);
		
		// 1 15
		// 16 30
		// 31 45
		
		end = numberPerPage*currentPage;
		start = end - numberPerPage +1;
		
		
		System.out.println(start + " ," + end);
		
		
	}

}

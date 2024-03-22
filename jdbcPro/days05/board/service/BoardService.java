package days05.board.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import days05.board.persistance.BoardDAO;
import days05.board.persistance.BoardDAOImpl;
import days05.board_domain.BoardDTO;

public class BoardService {

	public BoardDAO dao = null;

	public BoardService(BoardDAO dao) {
		this.dao = dao;
	}

	public void setDao(BoardDAO dao) {
		this.dao = dao;
	}


	// 1. 게시글 목록 조회 서비스
	public ArrayList<BoardDTO> selectService() {


		ArrayList<BoardDTO> list = null;
		// DB처리
		try {
			list = this.dao.select();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("BoardDAO.selectService() 예외 발생");
		}

		// 로그 기록	
		System.out.println(" > 게시글 목록 조회 : 로그 기록 작업...");		

		return list;
	}


	

	// 2. 게시글 쓰기 서비스
	public int insertService(BoardDTO dto) {


		int rowCount = 0;
		// DB처리
		try {
			rowCount = this.dao.insert(dto);
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("BoardDAO.insertService() 예외 발생");
		} 

		// 로그 기록	
		System.out.println(" > 게시글 쓰기 : 로그 기록 작업...");

		return rowCount;
	}

	
	// 3. 게시글 보기 서비스
	public BoardDTO viewService(long seq) {

		BoardDTO dto = null;
		BoardDAOImpl daoimpl = (BoardDAOImpl) this.dao;
		Connection conn = daoimpl.getConn();
		try {
			// 트랜잭션 처리 ( 2가지 이상의 작업을 할때 
			conn.setAutoCommit(false);

			// 1. 조회수 증가
			int rowCount = dao.increaseReaded(seq);

			// 2. 해당 게시글 얻어오기
			dto = this.dao.view(seq);

			// 3. 로그기록
			System.out.println(" > 게시글 보기 : 로그 기록 작업...");	

			conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			} 
		}finally {
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return dto;
	}


	// 4. 게시글 삭제 서비스
	public int deleteService(long seq) {
		int rowCount = 0;

		// 1. DB처리
		try {
			rowCount = this.dao.delete(seq);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// 2. 로그 기록
		System.out.println(" > 게시글 삭제 : 로그 기록 작업...");

		return rowCount;
	}


	// 5. 게시글 수정 서비스 
	public int updateService(BoardDTO dto) {


		int rowCount = 0;
		// DB처리
		try {
			rowCount = this.dao.update(dto);
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("BoardDAO.updateService() 예외 발생");
		} 

		// 로그 기록	
		System.out.println(" > 게시글 수정 : 로그 기록 작업...");

		return rowCount;
	}


	// 6. 게시글 검색 서비스
	public ArrayList<BoardDTO> searchService(int searchCondition, String searchWord) {


		ArrayList<BoardDTO> list = null;
		try {
			list = this.dao.search(searchCondition, searchWord);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// 로그 기록	
		System.out.println(" > 검색된 게시글 목록 조회 : 로그 기록 작업...");		

		return list;
	}
	
	// 6-2 게시글 검색 ( 페이징 처리 )
	public ArrayList<BoardDTO> searchService(int searchCondition, String searchWord, int currentPage, int numberPerPage) {
		
		
		ArrayList<BoardDTO> list = null;
		try {
			list = this.dao.search(searchCondition, searchWord, currentPage, numberPerPage);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// 로그 기록	
		System.out.println(" > 검색된 게시글 목록 조회 : 로그 기록 작업...");		

		return list;
	}
	
	// 페이징 처리된 게시물 목록 출력
	public ArrayList<BoardDTO> selectService(int currentPage, int numberPerPage) {
		ArrayList<BoardDTO> list = null;
		try {
			list = this.dao.select(currentPage, numberPerPage);
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("BoardDAO.selectService() 예외 발생");
		}

		// 로그 기록	
		System.out.println(" > 게시글 목록 조회 : 로그 기록 작업...");		

		return list;
	}
	
	// 페이징 처리 문자열로 반환하는 메서드
	public String pageService(int currentPage, int numberPerPage, int numberOfPageBlock) {
		String pageblock = "\t\t\t";
		int totalPages = 0;
		
		
		try {
			totalPages = this.dao.getTotalPages(numberPerPage);
			int start = (currentPage-1)/numberOfPageBlock * numberPerPage+1;
			int end = start + numberOfPageBlock-1;
			if( end > totalPages ) end = totalPages;
			
			if(start != 1) pageblock +=("<");
			for (int i = start ; i <= end; i++) {
				pageblock += String.format( i == currentPage ? "[%d] " : "%d ", i);
			}
			if(end != totalPages) pageblock +=(">");

		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return pageblock;
	}

	// 검색 조건에 따른 페이지 처리서비스 
	public String pageService(int currentPage, int numberPerPage, int numberOfPageBlock, int searchCondition, String searchWord) {
		String pageblock = "\t\t\t";
		int totalPages = 0;
		
		
		try {
			totalPages = this.dao.getTotalPages(numberPerPage , searchCondition, searchWord);
			int start = (currentPage-1)/numberOfPageBlock * numberPerPage+1;
			int end = start + numberOfPageBlock-1;
			if( end > totalPages ) end = totalPages;
			
			if(start != 1) pageblock +=("<");
			for (int i = start ; i <= end; i++) {
				pageblock += String.format( i == currentPage ? "[%d] " : "%d ", i);
			}
			if(end != totalPages) pageblock +=(">");

		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return pageblock;
	}



//	public ArrayList<BoardDTO> searchService(int searchCondition, String searchWord, int currentPage, int numberPerPage) {
//		ArrayList<BoardDTO> list = null;
//		try {
//			list = this.dao.search(searchCondition, searchWord, currentPage, numberPerPage );
//		} catch (SQLException e) {
//			e.printStackTrace();
//			System.out.println("BoardDAO.selectService() 예외 발생");
//		}
//
//		// 로그 기록	
//		System.out.println(" > 게시글 목록 조회 : 로그 기록 작업...");		
//
//		return list;
//	}

}

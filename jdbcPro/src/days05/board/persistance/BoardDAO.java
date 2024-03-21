package days05.board.persistance;

import java.sql.SQLException;
import java.util.ArrayList;

import days05.board_domain.BoardDTO;

public interface BoardDAO {
	
	// 1. 게시글 목록 조회 + 페이징 처리 아직은 X
	ArrayList<BoardDTO> select() throws SQLException;
	
	// 2. 게시글 쓰기 
	int insert(BoardDTO dto) throws SQLException;
	
	// 3-1. 조회수 하나 증가시키는 함수
	int increaseReaded(long seq) throws SQLException;
	// 3-2. 게시글 상세보기 함수
	BoardDTO view(long seq) throws SQLException;
	
	// 4. 게시글 삭제 함수
	int delete(long seq) throws SQLException;
	
	// 5. 게시글 수정 함수
//	int update(long seq, String title, String content, String email) throws SQLException;
	int update(BoardDTO dto) throws SQLException;
	
	// 6. 게시글 검색
	ArrayList<BoardDTO> search(int searchCondition, String searchWord) throws SQLException;

}

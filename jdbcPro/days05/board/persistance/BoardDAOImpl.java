package days05.board.persistance;

import java.sql.Connection;


import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.util.DBConn;

import java.sql.Date;

import days05.board_domain.BoardDTO;
import domain.EmpVO;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class BoardDAOImpl implements BoardDAO{
	
	
	private Connection conn = DBConn.getConnection();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private BoardDAO dao = null;
	
	
	// 생성자를 통한 DI
	public BoardDAOImpl(Connection conn) {
		this.conn = conn;
	}

	// Setter를 통한 DI
	public void setConn(Connection conn) {
		this.conn  = conn;
	}
	
	// Getter를 통한 conn 객체를 생성해서 리턴
	public Connection getConn() {
		return this.conn;
	}
	
	public void SetDao(BoardDAO dao) {
		this.dao  = dao;
	}
	
	public BoardDAO getDao() {
		return dao;
	}
	
	// 게시판 목록 출력문 ( 게시판 전체보기 )
	@Override
	public ArrayList<BoardDTO> select() throws SQLException {

		ArrayList<BoardDTO> list = null;
		
		long 		seq;
		String 	title;
		String 	writer;
		String 	email;
		Date 	writedate;
		long 		readed;
		
		String sql = "SELECT seq, title, writer, email, writedate, readed "
				+ "		FROM TBL_CSTVSBOARD"
				+ " ORDER BY seq DESC ";
		try {
			//           st = conn.createStatement();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			//           rs = st.executeQuery(sql);
			if(rs.next()) {
				list = new ArrayList();
			}
			do {
				seq 			= rs.getLong(1);   
				title 			= rs.getString(2);     
				writer 		= rs.getString(3);    
				email 		= rs.getString(4);     
				writedate  = rs.getDate(5); 
				readed 		= rs.getLong(6);
				
				BoardDTO dto = 
						BoardDTO.builder()
						.seq(seq)
						.title(title)
						.writer(writer)
						.email(email)
						.writedate(writedate)
						.readed(readed)
						.build();
				list.add(dto);
			}
			while (rs.next()) ;

		} catch (SQLException e) {
			e.printStackTrace();
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}			
		}
		return list;
	}

	@Override
	public int insert(BoardDTO dto) throws SQLException {
		int rowCount = 0;
		
		String sql = "INSERT INTO TBL_CSTVSBOARD (seq, writer, pwd, email, title, tag, content)  "
				+ " VALUES ( seq_tbl_cstvsboard.NEXTVAL , ?, ?, ?, ?, ?, ?)";
		
		this.pstmt = this.conn.prepareStatement(sql);
			this.pstmt.setString(1, dto.getWriter());
			this.pstmt.setString(2, dto.getPwd());
			this.pstmt.setString(3, dto.getEmail());
			this.pstmt.setString(4, dto.getTitle());
			this.pstmt.setInt(5, dto.getTag());
			this.pstmt.setString(6, dto.getContent());

		rowCount = this.pstmt.executeUpdate();
		
		this.pstmt.close();
		if(rowCount == 1) {
			System.out.println("게시글 추가 성공!");
		}else {
			System.out.println("게시글 추가 실패!");
		}
		
		return rowCount;
	}

	@Override
	public int increaseReaded(long seq) throws SQLException {
		String sql = "UPDATE TBL_CSTVSBOARD"
				+ "	SET readed = readed + 1 "
				+ " WHERE seq = ? ";
		int rowCount = 0;
		this.pstmt = this.conn.prepareStatement(sql);
		this.pstmt.setLong(1, seq);
		rowCount = this.pstmt.executeUpdate();	
		return rowCount;
	}

	@Override
	public BoardDTO view(long seq) throws SQLException {
		BoardDTO dto = null;		
		
		String 	title;
		String 	writer;
		String 	email;
		Date 	writedate;
		long 		readed;
		String   content;
		
		String sql = "SELECT seq, title, writer, email, writedate, readed, content "
				+ "		FROM TBL_CSTVSBOARD"
				+ " WHERE seq = ? ";
		try {
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, seq);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				seq 			= rs.getLong(1);   
				title 			= rs.getString(2);     
				writer 		= rs.getString(3);    
				email 		= rs.getString(4);     
				writedate  = rs.getDate(5); 
				readed 		= rs.getLong(6);
				content 	= rs.getString(7);
				
						dto = 
						BoardDTO.builder()
						.seq(seq)
						.title(title)
						.writer(writer)
						.email(email)
						.writedate(writedate)
						.readed(readed)
						.content(content)
						.build();
						
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}			
		}
		return dto;
		// 만약 게시글이 없으면 dto는  null값으로 들어간다.
	}
	
	@Override
	public int delete(long seq) throws SQLException {
		int rowCount = 0;
		
		String sql = "DELETE FROM tbl_cstvsboard"
				+ " WHERE seq = ?";
		this.pstmt = conn.prepareStatement(sql);
		this.pstmt.setLong(1, seq);
		rowCount = this.pstmt.executeUpdate();
		
		this.pstmt.close();
		return rowCount;
	}

	@Override
	public int update(BoardDTO dto) throws SQLException {
		int rowCount = 0;
		
		String sql = "UPDATE TBL_CSTVSBOARD "
				+ " SET email = ? , title = ?, content =? "
				+ " WHERE seq = ? ";
		
		this.pstmt = this.conn.prepareStatement(sql);
			this.pstmt.setString(1, dto.getEmail());
			this.pstmt.setString(2, dto.getTitle());
			this.pstmt.setString(3, dto.getContent());
			this.pstmt.setLong(4, dto.getSeq());
		rowCount = this.pstmt.executeUpdate();
		
		this.pstmt.close();
		if(rowCount == 1) {
			System.out.println("게시글 수정 성공!");
		}else {
			System.out.println("게시글 수정 실패!");
		}
		
		return rowCount;
	}

	@Override
	public ArrayList<BoardDTO> search(int searchCondition, String searchWord) {
		ArrayList<BoardDTO> list = null;
		
		long 		seq;
		String 	title;
		String 	writer;
		String 	email;
		Date 	writedate;
		long 		readed;
		
		String sql = "SELECT seq, title, writer, email, writedate, readed "
				+ "		FROM TBL_CSTVSBOARD";
				// WHERE 검색 조건 START
			switch ( searchCondition) {
		      case 1:  // 제목
		         sql += " WHERE REGEXP_LIKE( title, ?, 'i') ";
		         break;
		      case 2: // 내용
		         sql += " WHERE REGEXP_LIKE( content, ?, 'i') ";
		         break;
		      case 3: // 작성자
		         sql += " WHERE REGEXP_LIKE( writer, ?, 'i') ";
		         break;         
		      case 4: // 제목 + 내용 
		         sql += " WHERE REGEXP_LIKE( title, ?, 'i') OR  REGEXP_LIKE( content, ?, 'i') ";
	          break;
	      } // switch
		  
			
				// WHERE 검색 조건 END
				sql += " ORDER BY seq DESC ";
		try {
			//           st = conn.createStatement();
			pstmt = conn.prepareStatement(sql);
			// 어차피 들어오는 정보 자체가 한정적이라서
			this.pstmt.setString(1, searchWord);
			if(searchCondition == 4) {
				this.pstmt.setString(2, searchWord);
			}
			rs = pstmt.executeQuery();
			//           rs = st.executeQuery(sql);
			if(rs.next()) {
				list = new ArrayList();
			}
			do {
				seq 			= rs.getLong(1);   
				title 			= rs.getString(2);     
				writer 		= rs.getString(3);    
				email 		= rs.getString(4);     
				writedate  = rs.getDate(5); 
				readed 		= rs.getLong(6);
				
				BoardDTO dto = 
						BoardDTO.builder()
						.seq(seq)
						.title(title)
						.writer(writer)
						.email(email)
						.writedate(writedate)
						.readed(readed)
						.build();
				list.add(dto);
			}
			while (rs.next()) ;

		} catch (SQLException e) {
			e.printStackTrace();
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}			
		}
		return list;
	}

	@Override
	public ArrayList<BoardDTO> select(int currentPage, int numberPerPage) throws SQLException {
		ArrayList<BoardDTO> list = null;
		
		long 		seq;
		String 	title;
		String 	writer;
		String 	email;
		Date 	writedate;
		long 		readed;
		
		String sql = " "
				+ "SELECT b.* "
				+ "FROM ( "
				+ "SELECT ROWNUM no, t.* "
				+ "FROM "
				+ "    ( "
				+ "        SELECT seq, title, writer, email, writedate, readed "
				+ "        FROM TBL_CSTVSBOARD "
				+ "        ORDER BY seq DESC "
				+ "    ) t "
				+ "    ) b "
				+ "WHERE no BETWEEN ? AND ? ";
		
		
		try {
			//           st = conn.createStatement();
			int start = (currentPage - 1)*numberPerPage +1;
			int end = start + numberPerPage-1;
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			//           rs = st.executeQuery(sql);
			if(rs.next()) {
				list = new ArrayList();
			}
			do {
				seq 			= rs.getLong("seq");   
				title 			= rs.getString("title");     
				writer 		= rs.getString("writer");    
				email 		= rs.getString("email");     
				writedate  = rs.getDate("writedate"); 
				readed 		= rs.getLong("readed");
				
				BoardDTO dto = 
						BoardDTO.builder()
						.seq(seq)
						.title(title)
						.writer(writer)
						.email(email)
						.writedate(writedate)
						.readed(readed)
						.build();
				list.add(dto);
			}
			while (rs.next()) ;

		} catch (SQLException e) {
			e.printStackTrace();
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}			
		}
		return list;
	}

	@Override
	public int getTotaRecords() throws SQLException {
		int totalRecords = 0;
		String sql = " SELECT COUNT(*) FROM tbl_cstvsboard ";
		
		this.pstmt = conn.prepareStatement(sql);
		this.rs =  this.pstmt.executeQuery();
		
		if(this.rs.next())
		totalRecords = rs.getInt(1);
		
		this.rs.close();
		this.pstmt.close();
		return totalRecords;
	}

	@Override
	public int getTotalPages(int numberPerPage) throws SQLException {
		int totalPages = 0;
		String sql = " SELECT CEIL(COUNT(*)/?) FROM tbl_cstvsboard ";
		
		this.pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, numberPerPage);
		this.rs =  this.pstmt.executeQuery();
		
		if(this.rs.next())
			totalPages = rs.getInt(1);
		
		this.rs.close();
		this.pstmt.close();
		return totalPages;
	}

	// 페이징 처리 + 검색 메서드
	@Override
	public ArrayList<BoardDTO> search(
			  int searchCondition, String searchWord
			, int currentPage, int numberPerPage)
			throws SQLException {
		
		ArrayList<BoardDTO> list = null;

		long 	seq;
		String 	title;
		String 	writer;
		String 	email;
		Date 	writedate;
		int 	readed;

		String sql = "SELECT * "
				+ "FROM ( "
				+ "        SELECT ROWNUM no, t.* "
				+ "        FROM ( "
				+ "                SELECT seq, title, writer, email, writedate, readed  "
				+ "                FROM tbl_cstvsboard  ";
				
				// WHERE 검색조건 START
				switch ( searchCondition) {
				case 1:  // 제목
					sql += " WHERE REGEXP_LIKE( title, ?, 'i') ";
					break;
				case 2: // 내용
					sql += " WHERE REGEXP_LIKE( content, ?, 'i') ";
					break;
				case 3: // 작성자
					sql += " WHERE REGEXP_LIKE( writer, ?, 'i') ";
					break;			
				case 4: // 제목 + 내용 
					sql += " WHERE REGEXP_LIKE( title, ?, 'i') OR  REGEXP_LIKE( content, ?, 'i') ";
					break;
				} // switch
				// END
				
		   sql += "                ORDER BY seq DESC "
				+ "             ) t "
				+ "     ) b "
				+ "WHERE no BETWEEN ? AND ? ";
		
		

		try {
			int start = (currentPage-1)*numberPerPage +1;
	        int end = start + numberPerPage-1;
	        
			pstmt = conn.prepareStatement(sql);
			
			this.pstmt.setString(1, searchWord);
			if (searchCondition == 4) { // ? ? ? ? 
				this.pstmt.setString(2, searchWord);
				this.pstmt.setInt(3, start);
				this.pstmt.setInt(4, end);
			}else {                     // ?  ?  ? 
				this.pstmt.setInt(2, start);
				this.pstmt.setInt(3, end);
			}
			
			
			rs = pstmt.executeQuery();

			if (rs.next()) {
				list = new ArrayList<>();
				do {
					
					seq = rs.getLong("seq");      
					title = rs.getString("title");    
					writer = rs.getString("writer");   
					email = rs.getString("email");    
					writedate = rs.getDate("writedate");
					readed = rs.getInt("readed");   
					
					BoardDTO dto = BoardDTO.builder()
							.seq(seq)
							.title(title)
							.writer(writer)
							.email(email)
							.writedate(writedate)
							.readed(readed)
							.build();
					list.add(dto);
				} while (rs.next());

			} // if 

		} catch (SQLException e) { 
			e.printStackTrace();
		} catch( Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				pstmt.close();
			} catch (SQLException e) { 
				e.printStackTrace();
			}			
		}

		return list;
	}


	@Override
	public int getTotalPages(int numberPerPage
			, int searchCondition, String searchWord)  throws SQLException	{
		int totalPages = 0;		
		String sql = "SELECT CEIL(COUNT(*)/?) FROM tbl_cstvsboard ";
		
		// WHERE 검색조건 START
		switch ( searchCondition) {
		case 1:  // 제목
			sql += " WHERE REGEXP_LIKE( title, ?, 'i') ";
			break;
		case 2: // 내용
			sql += " WHERE REGEXP_LIKE( content, ?, 'i') ";
			break;
		case 3: // 작성자
			sql += " WHERE REGEXP_LIKE( writer, ?, 'i') ";
			break;			
		case 4: // 제목 + 내용 
			sql += " WHERE REGEXP_LIKE( title, ?, 'i') OR  REGEXP_LIKE( content, ?, 'i') ";
			break;
		} // switch
		// END
		
		this.pstmt = this.conn.prepareStatement(sql);
		this.pstmt.setInt(1, numberPerPage);
		
		this.pstmt.setString(2, searchWord);
		if( searchCondition == 4 )
			this.pstmt.setString(3, searchWord);	
		
		this.rs =  this.pstmt.executeQuery();		
		if( this.rs.next() ) totalPages = rs.getInt(1);		
		this.rs.close();
		this.pstmt.close();				
		return totalPages;
		
	}
	
	
	
	
	// 검색된 결과물 뿌리면서 페이징 처리
	// 검색된 결과에서 1 , 2 , 3번 페이지가 나오도록 로직처리
	

}

package days05.board.persistence;

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
	
	
	// 생성자를 통한 DI
	public BoardDAOImpl(Connection conn) {
		this.conn = conn;
	}

	// Setter를 통한 DI
	public void setConn(Connection conn) {
		this.conn  = conn;
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
		int 		readed;
		
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
				readed 		= rs.getInt(6);
				
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
		Connection conn = DBConn.getConnection();
		PreparedStatement pstmt = null;
		int rowCount = 0;
		
		String sql = "INSERT INTO TBL_CSTVSBOARD (seq, writer, pwd, email, title, writedate,  tag, content)  "
				+ " VALUES ( seq_tbl_cstvsboard.NEXTVAL , ?, ?, ?, ?, SYSDATE , ?, ?)";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, dto.getWriter());
		pstmt.setString(2, dto.getPwd());
		pstmt.setString(3, dto.getEmail());
		pstmt.setString(4, dto.getTitle());
		pstmt.setInt(5, dto.getTag());
		pstmt.setString(6, dto.getContent());

		rowCount = pstmt.executeUpdate();
		if(rowCount == 1) {
			System.out.println("게시글 추가 성공!");
		}else {
			System.out.println("게시글 추가 실패!");
		}
		
		return rowCount;
	}
	
	

}

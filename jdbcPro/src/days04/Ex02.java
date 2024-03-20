package days04;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.util.DBConn;

public class Ex02 {

	public static void main(String[] args)  {
		// 자바에서 트랜잭션 처리
		// 오라클에서 트랜잭션 처리
		// 계좌 이체 
		//		A -> 인출
		//		B -> 입금
		
		
		// INSERT dept 50 부서 추가 : 성공
		// INSERT dept 50 부서 추가 : PK 제약조건 위배 에러
		
		String sql = "INSERT INTO dept VALUES ( ? , ? , ? )";
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		
		conn = DBConn.getConnection();
		
		try {
			// 자동으로 커밋되는 작업을 막는다.
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, 50);
			pstmt.setString(2, "QC");
			pstmt.setString(3, "SEOUL");			
			rowCount = pstmt.executeUpdate();
			System.out.println("첫번째 INSERT문" + rowCount);
			
//			
//			pstmt.setInt(1, 50);
//			pstmt.setString(2, "QC2");
//			pstmt.setString(3, "SEOUL2");			
//			rowCount = pstmt.executeUpdate();
//			System.out.println("두번째 INSERT문" + rowCount);
			
			// 예외발생 안하면 commit();
			conn.commit();
		} catch (SQLException e) {
			try {
				// 만약 예외발생하면 rollback(); 처리
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} // try
		
		
		
		try {
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		DBConn.close();
		System.out.println("end");
	} // main

} // class

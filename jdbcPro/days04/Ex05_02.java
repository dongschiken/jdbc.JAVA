package days04;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.util.DBConn;

import domain.DeptVO;
import oracle.jdbc.internal.OracleTypes;

/**
 * @author dongs
 * @date 2024. 3. 20. - 오후 2:01:34
 * @subject dept - select 부서조회
 * @content up_insertdept
 */
public class Ex05_02 {

	public static void main(String[] args) {

		String sql = " { CALL up_insertdept ( ? , ?) }";
//		String sql = " { CALL up_insertdept ( pdname => ? ) }";
//		String sql = " { CALL up_insertdept ( ploc => ? ) }";
		Connection conn = null;
		CallableStatement cstmt = null;
		
		
		int rowCount = 0;
		String pdname = "QC", ploc = "SEOUL";


		conn = DBConn.getConnection();
		try {
			cstmt = conn.prepareCall(sql);
			cstmt.setString(1, pdname);
			cstmt.setString(2, ploc);
			rowCount = cstmt.executeUpdate();
			if (rowCount == 1) {
				System.out.println("부서추가 성공");
			}else {
				System.out.println("부서추가 실패");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				cstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (Exception e2) {
				e2.printStackTrace();
			} 
		}

		DBConn.close();
		System.out.println("end");
	}

} // class


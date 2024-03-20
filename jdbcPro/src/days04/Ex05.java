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
 * @content up_selectdept
 */
public class Ex05 {

	public static void main(String[] args) {


		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;

		String sql = " { CALL up_selectdept ( ? ) }";

		conn = DBConn.getConnection();
		try {
			cstmt = conn.prepareCall(sql);
			cstmt.registerOutParameter(1, OracleTypes.CURSOR); // OUTPUT용으로 오라클 타입은 CURSOR
			cstmt.executeQuery();

			rs = (ResultSet) cstmt.getObject(1);
			
//			boolean rs.isFirst();
			
			DeptVO vo = null;
			
			while (rs.next()) {
				int deptno = rs.getInt(1);
				String dname = rs.getString(2);
				String loc = rs.getString(3);
				vo = vo.builder()
				.deptno(deptno)
				.dname(dname)
				.loc(loc)
				.build();
				
				System.out.printf("%d \t %s \t %s \n", vo.getDeptno(), vo.getDname(), vo.getLoc());
			} // while
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
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


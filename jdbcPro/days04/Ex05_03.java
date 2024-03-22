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
 * @subject dept - update 부서수정
 * @content up_updatedept
 */
public class Ex05_03 {

	public static void main(String[] args) {

		String sql = " { CALL up_updatedept (?,  ? , ?) }";

		Connection conn = null;
		CallableStatement cstmt = null;
		
		
		int rowCount = 0;
		int deptno = 50;
		String pdname = "QC3";
		conn = DBConn.getConnection();
		try {
			cstmt = conn.prepareCall(sql);
			cstmt.setInt(1, deptno);
			cstmt.setString(2, pdname);
			rowCount = cstmt.executeUpdate();
			if (rowCount == 1) {
				System.out.println("부서수정 성공");
			}else {
				System.out.println("부서수정 실패");
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

/*
CREATE OR REPLACE PROCEDURE up_updatedept
(
    pdeptno IN dept.deptno%TYPE,
    pdname IN dept.dname%TYPE := NULL,
    ploc IN dept.loc%TYPE := NULL

)
IS
BEGIN
    UPDATE dept
    SET dname = NVL( pdname, dname),
        loc = NVL( ploc, loc)
    WHERE deptno = pdeptno;
    COMMIT;
--EXCEPTION
END;
*/
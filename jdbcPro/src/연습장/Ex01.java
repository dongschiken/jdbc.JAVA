package 연습장;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Ex01 {

	public static void main(String[] args) throws SQLException {

		Connection conn = DBConn.getConnection();

		
		String query1 = "SELECT grade || '등급' AS 등급, losal || '~' || hisal AS lohi, COUNT(*) || '명' AS 사원수 "
				+ "FROM emp e JOIN dept d ON e.deptno = d.deptno "
				+ "JOIN salgrade s ON e.sal BETWEEN losal AND hisal "
				+ "GROUP BY losal, hisal, grade "
				+ "ORDER BY grade";


		int i = 1;
		PreparedStatement pstmt1 = conn.prepareStatement(query1);
		ResultSet rs1 = pstmt1.executeQuery() ;

		while (rs1.next()) {
			String query2 = "SELECT d.deptno, e.empno, e.ename, e.sal "
					+ "FROM emp e JOIN dept d ON e.deptno = d.deptno "
					+ "JOIN salgrade s ON e.sal BETWEEN losal AND hisal "
					+ "WHERE grade = "+i++;
			System.out.printf("%s    ( %s ) - %s\n", rs1.getString("등급"), rs1.getString("lohi"), rs1.getString("사원수"));
			
				PreparedStatement pstmt2 = conn.prepareStatement(query2);
				ResultSet rs2 = pstmt2.executeQuery() ;
				while (rs2.next()) {
					System.out.printf("부서번호: %d, 사원번호: %d, 이름: %s, 급여: %d\n",
							rs2.getInt("deptno"), rs2.getInt("empno"), rs2.getString("ename"), rs2.getInt("sal"));
				}
			}
	}

}



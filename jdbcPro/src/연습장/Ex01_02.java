package 연습장;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Ex01_02 {
	
	public static void main(String[] args) throws SQLException {
		Connection conn = DBConn.getConnection();
		PreparedStatement prstmt1 = null;
		PreparedStatement prstmt2 = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		
		
		String sql1 = "SELECT grade || '등급' \"등급\" , losal || '~' ||hisal \"lohi\",  COUNT(*) || '명' AS \"사원수\" "
				+ " FROM emp e JOIN dept d ON e.deptno = d.deptno "
				+ "           JOIN salgrade s ON e.sal BETWEEN losal AND hisal "
				+ " GROUP BY losal, hisal, grade "
				+ " ORDER BY grade";
		int i = 1;
		prstmt1  = conn.prepareStatement(sql1);
		rs1 = prstmt1.executeQuery();
		while (rs1.next()) {
			String sql2 = "SELECT d.deptno, job, empno, ename, sal "
					+ "FROM emp e JOIN dept d ON e.deptno = d.deptno "
					+ "           JOIN salgrade s ON e.sal BETWEEN losal AND hisal "
					+ "WHERE grade = "+i++;
			System.out.printf("%s   %s  - %s\n", rs1.getString("등급"), rs1.getString("lohi"), rs1.getString("사원수"));
//			--   20   RESEARCH   7369   SMITH   800
//			--	 30   SALES      7900   JAMES   950

			
			prstmt2 = conn.prepareStatement(sql2);
			rs2 = prstmt2.executeQuery();
			while (rs2.next()) {
				System.out.printf("%s %s %s %s %s\n", rs2.getString("deptno"),  rs2.getString("job"),  rs2.getString("empno"),  rs2.getString("ename"),  rs2.getString("sal"));
			}
		}
	}

}

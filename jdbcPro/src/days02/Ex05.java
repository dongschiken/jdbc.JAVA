package days02;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Ex05 {

	public static void main(String[] args) throws SQLException, ClassNotFoundException {
		// TODO Auto-generated method stub
		
	    String className = "oracle.jdbc.driver.OracleDriver";
        String url = "jdbc:oracle:thin:@localhost:1521:xe";
        String user = "scott";
        String password = "tiger";
        Class.forName(className);
		Connection conn = DriverManager.getConnection(url, user, password);
		PreparedStatement prstmt1 = null;
		PreparedStatement prstmt2 = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		
		
		String sql1 = "SELECT grade || '등급' \"등급\" , losal || '~' ||hisal \"lohi\",  COUNT(*) || '명' AS \"사원수\" "
				+ " FROM emp e LEFT JOIN dept d ON e.deptno = d.deptno "
				+ "           JOIN salgrade s ON e.sal BETWEEN losal AND hisal "
				+ " GROUP BY losal, hisal, grade "
				+ " ORDER BY grade";
		
		String i = "";
		prstmt1  = conn.prepareStatement(sql1);
		rs1 = prstmt1.executeQuery();
		while (rs1.next()) {
			 i = rs1.getString("등급");
			// 등 전까지만 잘라와서 1, 2, 3, 4, 5.. (만약에 등급이 더있다면 6, 7, 8, 9, 10..도 가능)
			 int x = i.indexOf("등");
			 
			String sql2 = "SELECT d.deptno, job, empno, ename, sal "
					+ "FROM emp e LEFT JOIN dept d ON e.deptno = d.deptno "
					+ "           			  JOIN salgrade s ON e.sal BETWEEN losal AND hisal "
					+ "WHERE grade = "+i.substring(0, x);
			
			System.out.printf("%s   %s  - %s\n",i, rs1.getString("lohi"), rs1.getString("사원수"));

			
			prstmt2 = conn.prepareStatement(sql2);
			rs2 = prstmt2.executeQuery();
			while (rs2.next()) {
				System.out.printf("%s %s %s %s %s\n", rs2.getString("deptno"),  rs2.getString("job"),  rs2.getString("empno"),  rs2.getString("ename"),  rs2.getString("sal"));
			}
		}

	}

}

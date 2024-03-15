package days01;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Iterator;

import domain.EmpVO;

public class Ex04 {

	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		// 문제
		// 해당 부서원의 정보를 출력
		// 부서정보를 입력받아서 emp WHERE deptno = 30;
		// EmpVO를 출력	
		int empno = 0;
		String ename = "";
		String job = "";
		int mgr = 0;
		String hiredate =  "";
		int sal = 0;
		int comm = 0;
		int deptno = 0;
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "scott";
		String password = "tiger";
		String className = "oracle.jdbc.driver.OracleDriver";
		Class.forName(className);
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList< EmpVO > list = new ArrayList();
		conn = DriverManager.getConnection(url, user, password);
		stmt = conn.createStatement();
		
		
		String sql = "SELECT * FROM emp WHERE deptno = 30";
		
		rs = stmt.executeQuery(sql);
		while (rs.next()) {
			
			empno = rs.getInt("empno");
			ename = rs.getString("ename");
			job = rs.getString("job");
			mgr = rs.getInt("mgr");
			hiredate = rs.getString("hiredate");
			sal = rs.getInt("sal");
			comm = rs.getInt("comm");
			deptno = rs.getInt("deptno");
			
			
			list.add( new EmpVO(empno,  ename, job , mgr, hiredate, sal, comm, deptno));
			
		}
		System.out.println("empno|ename | job       | mgr |      hiredate     | sal | comm | deptno ");
		dispEmpvo(list);
		
		
		rs.close();
		stmt.close();
		conn.close();
		
	}

	private static void dispEmpvo(ArrayList<EmpVO> list) {
		Iterator ir = list.iterator();
		while (ir.hasNext()) {
			EmpVO empvo = (EmpVO) ir.next();
//			System.out.println(empvo.toString());
			System.out.println(empvo.getEmpno() + "   " + empvo.getEname() + "  " + empvo.getJob() + " " + empvo.getMgr() + " " + empvo.getHiredate().substring(0, 11) + " " + empvo.getSal() + "  " + empvo.getComm() + " " + empvo.getDeptno());
		}
	}
}

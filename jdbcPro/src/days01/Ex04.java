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

	public static void main(String[] args) throws ClassNotFoundException, SQLException  {
		int empno;
		String ename;
		String job;
		int mgr;
		String hiredate;
		int sal;
		int comm;
		int deptno;
		
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "scott";
		String password = "tiger";
		String className = "oracle.jdbc.driver.OracleDriver";
		ArrayList<EmpVO> emp_list = new ArrayList();
		
		
		Class.forName(className);
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		conn = DriverManager.getConnection(url, user, password);
		
		String sql = " SELECT * FROM emp WHERE deptno = 30 ";
		
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		
		while (rs.next()) {
			empno = rs.getInt("empno");
			ename = rs.getString("ename");
			job = rs.getString("job");
			mgr = rs.getInt("manageno");
			hiredate = rs.getString("hiredate").substring(0, 11);
			sal = rs.getInt("sal");
			comm = rs.getInt("comm");
			deptno = rs.getInt("deptno");
			
			emp_list.add(new EmpVO(empno, ename, job, mgr, hiredate, sal, comm, deptno));
			
		}
		dispEmp(emp_list);
		
		
		
		
		rs.close();
		stmt.close();
		conn.close();
		
		
		
	}

	private static void dispEmp(ArrayList<EmpVO> emp_list) {
		Iterator ir = emp_list.iterator();
		while (ir.hasNext()) {
			EmpVO empvo = (EmpVO) ir.next();
			System.out.println(empvo.toString());
		}
	}
}

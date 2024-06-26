package days01;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.Scanner;

import domain.EmpVO;

public class Ex05 {

	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		/*
		 * 
 - emp,dept,salgrade 테이블을 사용해서
   ename으로 검색하여 
   ArrayList<> 에 저장하여 
   dispEmpList(ArrayList<> list) 메서드를 선언하여 출력하는 코딩을 하세요.
 - empno, dname, ename, hiredate, pay, salgrade 컬럼 출력.   
 - 검색결과가 없는 경우 
    "사원이 존재하지 않습니다." 라고 출력
		 */
		Scanner sc = new Scanner(System.in);
		String searchWord = null;
		System.out.println("검색할 사원명 입력?");
		searchWord = sc.next();
		
		
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "scott";
		String password = "tiger";
		String className = "oracle.jdbc.driver.OracleDriver";
		Class.forName(className);
		ArrayList<EmpVO> emp_list = null;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		int empno;
		String dname;
		String ename;
		Date hiredate;
		int pay;
		int salgrade;
		
		
		conn = DriverManager.getConnection(url, user, password);
		stmt = conn.createStatement();
		String sql = String.format("WITH t AS ( "
				+ " SELECT DISTINCT empno, dname, ename, hiredate, t.pay, "
				+ "    CASE "
				+ "    WHEN t.pay BETWEEN losal AND hisal THEN grade "
				+ "    END sal_grade"
				+ " FROM salgrade s, (SELECT empno, dname, ename, hiredate, sal+NVL(comm, 0) pay "
				+ "                 			  FROM dept d RIGHT OUTER JOIN emp e ON e.deptno = d.deptno) t "
				+ " ORDER BY empno) "
				+ " SELECT t.* "
				+ " FROM t "
				+ " WHERE t.sal_grade IS NOT NULL AND REGEXP_LIKE ( ename, '%s', 'i') ", searchWord ); 
		
//		String sql = "WITH t AS ( "
//				+ " SELECT DISTINCT empno, dname, ename, hiredate, t.pay, "
//				+ "    CASE "
//				+ "    WHEN t.pay BETWEEN losal AND hisal THEN grade "
//				+ "    END sal_grade"
//				+ " FROM salgrade s, (SELECT empno, dname, ename, hiredate, sal+NVL(comm, 0) pay "
//				+ "                 			  FROM dept d RIGHT OUTER JOIN emp e ON e.deptno = d.deptno) t "
//				+ " ORDER BY empno) "
//				+ " SELECT t.* "
//				+ " FROM t "
//				+ " WHERE t.sal_grade IS NOT NULL AND REGEXP_LIKE ( ename, '%"+searchWord+"%', 'i')" ; 
				// WHERE  ename LIKE '%LA%' ;
		rs = stmt.executeQuery(sql);
		
		if( rs.next() ) {
			emp_list = new ArrayList();
		}
		do {
			empno = rs.getInt("empno");  
			dname = rs.getString("dname");
			ename = rs.getString("ename");
			hiredate = rs.getDate("hiredate");
			pay = rs.getInt("pay");
			salgrade = rs.getInt("sal_grade");

			emp_list.add(new EmpVO(empno, dname, ename, hiredate, pay, salgrade, salgrade, salgrade));
		} while (rs.next());
		
		dispEmpList(emp_list);
		rs.close();
		stmt.close();
		conn.close();

	}

	private static void dispEmpList(ArrayList<EmpVO> emp_list) {
		if( emp_list == null) {
			System.out.println("사원이 존재하지 않는다.");
			return;
		}
		Iterator<EmpVO> ir = emp_list.iterator();
		while (ir.hasNext()) {
			EmpVO empVO = (EmpVO) ir.next();
			System.out.println(empVO.toString());
		}
	}
}

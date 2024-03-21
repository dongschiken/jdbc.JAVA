//package days02;
//
//import java.io.BufferedReader;
//import java.io.IOException;
//import java.io.InputStreamReader;
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.sql.Statement;
//import java.util.ArrayList;
//import java.util.Iterator;
//import java.util.Scanner;
//
//import com.util.DBConn;
//
//import domain.EmpVO;
//
//
//public class Ex03 {
//	
//	public static Connection conn = DBConn.getConnection();
//	public static Scanner sc = new Scanner(System.in);
//	
//	public static void main(String[] args) throws SQLException, IOException {
//		// COMMIT이 안되었을때 INSERT 이후에 안넘어가는 오류가 생김
//		// 모든 작업할때 SQL DEVELOPER에서 COMMIT이 되어있는지 확인하기
//		// 6명 
//		// 7명
//		// emp 사원 테이블 -
//		// 1) 사원추가
//		// 2) 사원수정
//		// 3) 사원삭제
//		// 4) 사원검색
//		// 5) 사원조회
//
////		Scanner sc = new Scanner(System.in);
////		String searchWord = null;
////		
////		searchWord = sc.next();
////		
////		
////		ArrayList<EmpVO> emp_list = null;
////		Connection conn = null;
////		Statement stmt = null;
////		ResultSet rs = null;
//		사원검색();
////		사원추가();
////		사원수정();
//		
//		
//		// 개인문제 resultset 두개 statement 두개
//		/*
//	      [실행결과]
//	      1등급   (     700~1200 ) - 2명
//	            20   RESEARCH   7369   SMITH   800
//	            30   SALES         7900   JAMES   950
//	      2등급   (   1201~1400 ) - 2명
//	         30   SALES   7654   MARTIN   2650
//	         30   SALES   7521   WARD      1750   
//	      3등급   (   1401~2000 ) - 2명
//	         30   SALES   7499   ALLEN      1900
//	         30   SALES   7844   TURNER   1500
//	      4등급   (   2001~3000 ) - 4명
//	          10   ACCOUNTING   7782   CLARK   2450
//	         20   RESEARCH   7902   FORD   3000
//	         20   RESEARCH   7566   JONES   2975
//	         30   SALES   7698   BLAKE   2850
//	      5등급   (   3001~9999 ) - 1명   
//	         10   ACCOUNTING   7839   KING   5000
//	     */   
//		
//		
//
//	}
//	
////	if( searchCondition == 1) {
////		sql += String.format("deptno IN (%s)", searchWord);
////	}else if ( searchCondition == 4){
////		sql += String.format("REGEXP_LIKE(%s, '%s', 'i') OR REGEXP_LIKE(%s, '%s', 'i')", "dname", searchWord, "loc", searchWord);
////	}else {
////		sql += String.format(" REGEXP_LIKE(%s, '%s', 'i')", searchCondition == 2 ? "dname" : "loc",
////				searchWord);
////	}  
//	
//	
//	private static void 사원검색() {
//		System.out.println("검색 조건 검색어를 입력하시오 >> ");
//		PreparedStatement pstmt = null;
//		ArrayList<EmpVO> emp_list = null;
//		ResultSet rs = null;
//		int searchCondition = 1;
//		String searchWord = null;
//		
//		String sql = "SELECT * "
//				+ "FROM emp"
//				+ " WHERE ";
//		
//		searchCondition = sc.nextInt();
//		searchWord = sc.next();
//		// 사원 번호, 사원 명으로만 검색
//		// 1번일경우 사원번호로 검색
//		// 2번일경우 사원명으로 검색
//		// 3번일경우 job으로 검색
//		// 4번일경우 job 사원명으로 검색
//		
//		int empno;
//		String ename;
//		String job;
//		String hiredate;
//		int mgr;
//		int sal;
//		int comm ;
//		int deptno;
//		if(searchCondition == 1) {
//			sql += "empno = ? ";
//		}else if(searchCondition == 2) {
//			sql += "REGEXP_LIKE(ename , ?, 'i')" ;
//		}else if(searchCondition == 3) {
//			sql += "REGEXP_LIKE(job , ?, 'i')" ;
//		}else {
//			sql += "REGEXP_LIKE(ename , ?, 'i') OR REGEXP_LIKE(job , ?, 'i')" ;
//		}	
//			
//		try {
//			pstmt = conn.prepareStatement(sql);
//			if(searchCondition == 1) {
//				pstmt.setInt(1, Integer.parseInt(searchWord));
//			}else if(searchCondition == 2) {
//				pstmt.setString(1, searchWord);
//			}else if(searchCondition == 3) {
//				pstmt.setString(1, searchWord);
//			}else {
//				pstmt.setString(1, searchWord);
//				pstmt.setString(2, searchWord);
//			}
//			rs = pstmt.executeQuery();
//			
//			if(rs.next()) {
//				emp_list = new ArrayList<EmpVO>();
//			}
//			do {
//				empno = rs.getInt("empno");
//				ename = rs.getString("ename");
//				job = rs.getString("job");
//				hiredate = rs.getString("hiredate");
//				mgr = rs.getInt("mgr");
//				sal = rs.getInt("sal");
//				comm = rs.getInt("comm");
//				deptno = rs.getInt("deptno");
//				
//				EmpVO vo = new EmpVO(empno, ename, job, hiredate, mgr, sal, comm, deptno);
//				emp_list.add(vo);
//			} while (rs.next());
//			disp_emp(emp_list);
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//	}
//	
//	
////	empno, ename, job, mgr, hiredate, sal, comm, deptno
//	private static void 사원추가() {
//		Statement stmt = null;
//		System.out.print(" 추가할 부서원의 사원번호, 사원명, 직업, 매니저번호, 입사일자, 급여, 커미션, 부서번호를 입력하시오 >>");
//		int empno = sc.nextInt();
//		String ename = sc.next();
//		String job = sc.next();
//		int mgr = sc.nextInt();
//		String hiredate = sc.next();
//		int sal = sc.nextInt();
//		int comm = sc.nextInt();
//		int deptno = sc.nextInt();
//		
//		
//		try {
//			String sql = String.format("INSERT INTO emp ( empno, ename, job, mgr, hiredate, sal, comm, deptno)"
//					+ " VALUES ( %d, '%s', '%s', %d, '%s', %d, %d, %d)", empno, ename, job, mgr, hiredate, sal, comm, deptno);
//			System.out.println(sql);
//			stmt = conn.createStatement();
//			System.out.println(conn);
//			System.out.println(stmt);
//			int rowCount = stmt.executeUpdate(sql);
//			System.out.println(rowCount);
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} catch (NullPointerException n) {
//			n.printStackTrace();
//		}
//		try {
//			stmt.close();
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//	}
//	
//	private static void 사원조회() {
//		Statement stmt = null;
//		ArrayList<EmpVO> emp_list = null;
//		ResultSet rs = null;
//		int empno;
//		String ename;
//		String job;
//		String hiredate;
//		int mgr;
//		int sal;
//		int comm;
//		int deptno;
//		
//		String sql = "SELECT * FROM emp";
//		try {
//			stmt = conn.createStatement();
//			rs = stmt.executeQuery(sql);
//			
//			if(rs.next()) {
//				emp_list = new ArrayList<EmpVO>();
//			}
//			do {
//				empno = rs.getInt("empno");
//				ename = rs.getString("ename");
//				job = rs.getString("job");
//				hiredate = rs.getString("hiredate");
//				mgr = rs.getInt("mgr");
//				sal = rs.getInt("sal");
//				comm = rs.getInt("comm");
//				deptno = rs.getInt("deptno");
//				
//				EmpVO vo = new EmpVO(empno, ename, job, hiredate, mgr, sal, comm, deptno);
//				emp_list.add(vo);
//			} while (rs.next());
//			disp_emp(emp_list);
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//	}
//	private static void disp_emp(ArrayList<EmpVO> emp_list) {
//		Iterator<EmpVO> ir = emp_list.iterator();
//		while (ir.hasNext()) {
//			EmpVO empVO = (EmpVO) ir.next();
//			System.out.println(empVO.toString());
//		}
//	}
//	
//	
//	private static void 사원수정() throws IOException {
//		
//		Statement stmt = null;
//		ArrayList<EmpVO> emp_list = null;
//		ResultSet rs = null;
//		int empno;
//		String ename;
//		String job;
//		String hiredate;
//		int mgr;
//		int sal;
//		int comm;
//		int deptno;
//		
//		String sql = "SELECT * FROM emp";
//		try {
//			stmt = conn.createStatement();
//			rs = stmt.executeQuery(sql);
//			
//			if(rs.next()) {
//				emp_list = new ArrayList<EmpVO>();
//			}
//			do {
//				empno = rs.getInt("empno");
//				ename = rs.getString("ename");
//				job = rs.getString("job");
//				hiredate = rs.getString("hiredate");
//				mgr = rs.getInt("mgr");
//				sal = rs.getInt("sal");
//				comm = rs.getInt("comm");
//				deptno = rs.getInt("deptno");
//				
//				EmpVO vo = new EmpVO(empno, ename, job, hiredate, mgr, sal, comm, deptno);
//				emp_list.add(vo);
//			} while (rs.next());
//			disp_emp(emp_list);
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		
//		
//		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
//		stmt = null;
//		sql = null;
//		System.out.print("수정할 사원의 번호를 입력하시오 >> ");
//		empno = Integer.parseInt(br.readLine());
//		
//		System.out.println("수정할 사원의 이름을 입력하시오 (없으면 엔터) >> ");
//		ename = "";
//		ename = br.readLine();
//		if(ename.equals("")) {
//			
//			
//			
//			
//			
//			
//		};
//		
//		
//		System.out.println("수정할 사원의 직업을 입력하시오 (없으면 엔터) >> ");
//		job = "";
//		job = br.readLine();
//		
//		System.out.println("수정할 사원의 입사날짜를 입력하시오 (없으면 엔터) >> ");
//	    hiredate = "";
//	    hiredate = br.readLine();
//	    
//	    System.out.println("수정할 사원의 매니저번호를 입력하시오 (없으면 엔터) >> ");
//	    mgr = 0;
//	    mgr = Integer.parseInt(br.readLine());
//	    
//	    System.out.println("수정할 사원의 급여를 입력하시오 (없으면 엔터) >> ");
//	    sal = 0;
//	    sal = Integer.parseInt(br.readLine());
//	    
//	    System.out.println("수정할 사원의 커미션을 입력하시오 (없으면 엔터) >> ");
//	    comm = 0;
//	    comm = Integer.parseInt(br.readLine());
//	    
//	    System.out.println("수정할 사원의 부서번호를 입력하시오 (없으면 엔터) >> ");
//	    deptno = 0;
//	    deptno = Integer.parseInt(br.readLine());
//	    
//	    if( ename.equals("") ) {
//	    	sql = String.format(" UPDATE emp "
//	    			+ "SET job = '%s', hiredate = '%s', mgr = %d, sal = %d, comm = %d, deptno = %d"
//	    			+ "WHERE empno = %d", job, hiredate, mgr, sal, comm, deptno, empno);
//	    }else if (job.equals("")) {
//	    	sql = String.format(" UPDATE emp "
//	    			+ "SET ename = '%s', hiredate = '%s', mgr = %d, sal = %d, comm = %d, deptno = %d"
//	    			+ "WHERE empno = %d", ename, hiredate, mgr, sal, comm, deptno, empno);
//	    }else if (hiredate.equals("")) {
//	    	sql = String.format(" UPDATE emp "
//	    			+ "SET ename = '%s', job = '%s', mgr = %d, sal = %d, comm = %d, deptno = %d"
//	    			+ "WHERE empno = %d", ename, job, mgr, sal, comm, deptno, empno);
//	    }else if (mgr == 0) {
//	    	sql = String.format(" UPDATE emp "
//	    			+ "SET ename = '%s', hiredate = '%s', job = '%s', sal = %d, comm = %d, deptno = %d"
//	    			+ "WHERE empno = %d", ename, hiredate, job, sal, comm, deptno, empno);
//	    }else if (sal == 0) {
//	    	sql = String.format(" UPDATE emp "
//	    			+ "SET ename = '%s', hiredate = '%s', mgr = %d, job = '%s', comm = %d, deptno = %d"
//	    			+ "WHERE empno = %d", ename, hiredate, mgr, job, comm, deptno, empno);
//	    }else if (comm == 0) {
//	    	sql = String.format(" UPDATE emp "
//	    			+ "SET ename = '%s', hiredate = '%s', mgr = %d, sal = %d, job = '%s', deptno = %d"
//	    			+ "WHERE empno = %d", ename, hiredate, mgr, sal, job, deptno, empno);
//	    }else if (deptno == 0) {
//	    	sql = String.format(" UPDATE emp "
//	    			+ "SET ename = '%s', hiredate = '%s', mgr = %d, sal = %d, job = '%s', comm = %d"
//	    			+ "WHERE empno = %d", ename, hiredate, mgr, sal, job, comm, empno);
//	    }
//		try {
//			// conn.setAutoCommit(true); 커밋 자동 설정되어져 있다.
//			stmt = conn.createStatement();
//			// select -> stmt.executeQuery();
//			// INSERT, UPDATE, DELETE -> stmt.executeUpdate()
//			int rowCount = stmt.executeUpdate(sql);
//			if ( rowCount == 1 ) {
//				System.out.println("부서수정 성공");
//			}
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} finally {
//			try {
//				stmt.close();
//			} catch (SQLException e) {
//				e.printStackTrace();
//			}
//		}
//	}
//
//}
////sql = String.format("UPDATE dept"
////		+ " SET loc = '%s' "
////		+ " WHERE deptno = %d ", loc, deptno );

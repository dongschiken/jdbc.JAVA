package days02;
//package days02;
//
//import java.io.IOException;
//import java.sql.Connection;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.sql.Statement;
//import java.util.ArrayList;
//import java.util.Iterator;
//import java.util.Scanner;
//
//import com.util.DBConn;
//
//import domain.DeptVO;
//
///**
// * @author dongs
// * @date 2024. 3. 18. - 오전 11:45:31
// * @subject dept 부서 테이블에 
// * 			추가, 수정, 삭제, 조회
// * @content
// */
//public class Ex02 {
//
//	static String[] menu = { "추가", "수정", "삭제", "조회", "종료", "검색"};
//	public static int selectedNumber;
//	public static Connection conn;
//	public static Scanner sc = new Scanner(System.in);
//	
//	public static void main(String[] args) throws SQLException, NullPointerException {
//		// 1. DB 사용할 작업
//		conn = DBConn.getConnection();
//
//		do {
//			메뉴출력();
//			메뉴선택();
//			메뉴처리();
//
//		}while(true);
//
//	}
//
//	private static void 메뉴처리() throws SQLException, NullPointerException {
//
//
//		switch (selectedNumber) {
//		case 1: // 추가
//			부서추가();
//			break;
//		case 2: // 수정
//			부서수정();
//			break;
//		case 3: // 삭제
//			부서삭제();
//			break;
//		case 4: // 조회
//			부서조회();
//			break;
//		case 5: // 종료
//			프로그램종료();
//			break;
//		case 6: // 검색
//			부서검색();
//			break;
//		}
//		일시정지();
//
//	}
//
//	private static void 부서검색() {
//		// 검색 조건 입력? 1. 부서번호 / 2. 부서명 / 3. 지역명
//		// SELECT * FROM dept
//		//3번입력 : WHERE REGEXP_LIKE ( loc, 'lo', 'i')
//		//2번입력 : WHERE REGEXP_LIKE ( dname, 'SL', 'i')
//		//1번입력 : WHERE deptno = 10;
//		
//		int searchCondition = 1;
//		String searchWord = null;
//		
//		System.out.print("검색조건, 검색어 입력하세요 >> ");
//		searchCondition = sc.nextInt();
//		searchWord = sc.next();
//		
//		ArrayList<DeptVO> dept_list = null;
//		int deptno;
//		String dname, loc;
//		Statement stmt = null;
//		ResultSet rs = null;
//		DeptVO vo = null;
//		String sql = "SELECT * "
//				+ "FROM dept"
//				+ " WHERE ";
//		
//		if( searchCondition == 1) {
//			sql += String.format("deptno IN (%s)", searchWord);
//		}else if ( searchCondition == 4){
//			sql += String.format("REGEXP_LIKE(%s, '%s', 'i') OR REGEXP_LIKE(%s, '%s', 'i')", "dname", searchWord, "loc", searchWord);
//		}else {
//			sql += String.format(" REGEXP_LIKE(%s, '%s', 'i')", searchCondition == 2 ? "dname" : "loc",
//					searchWord);
//		}  
//		System.out.println(sql);
//		try {
//			stmt = conn.createStatement();
//			rs = stmt.executeQuery(sql);
//			if(rs.next()) {
//				dept_list = new ArrayList();
//			}
//			do {
//				deptno = rs.getInt("deptno");
//				dname = rs.getString("dname");
//				loc = rs.getString("loc");
//				vo = new DeptVO(deptno, dname, loc);
//				dept_list.add(vo);
//			} while (rs.next());
//			dispDept(dept_list);
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} finally {
//			try {
//				stmt.close();
//				rs.close();
//			} catch (SQLException e) {
//				e.printStackTrace();
//			}
//		}
//		
//	}
//	
//
//	private static void 부서삭제()  {
//		System.out.print("삭제할 부서번호를 입력하시오 >>");
//		String deptno;
//		deptno = sc.next();
//		Statement stmt = null;
//		String sql = null;
//		try {
//			stmt = conn.createStatement();
//		} catch (SQLException e1) {
//			e1.printStackTrace();
//		}
//		try {
//			sql = String.format( "DELETE FROM dept "
//					+ "WHERE deptno = IN(%s) ", deptno);
//			System.out.println(sql);
//			
//			int rowCount = stmt.executeUpdate(sql);
//			if( rowCount == 1 ) {
//				System.out.println("부서가 삭제되었습니다.");
//			}
//		} catch (Exception e) {
//		}
//		try {
//			stmt.close();
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//						
//
//	}
//
//	private static void 부서추가() throws SQLException, NullPointerException {
//		System.out.print("> 추가할 부서번호, 부서명, 지역명을 입력하세요 >>");
//		int deptno = sc.nextInt();
//		String dname = sc.next();
//		String loc = sc.next();
//		Statement stmt = null;
//		String sql = String.format("INSERT INTO dept(deptno, dname, loc) "
//				+ "	VALUES (%d, '%s', '%s' )", deptno, dname, loc );
//		System.out.println(sql); //쿼리 확인하는 작업 꼭 넣자.
//		
//		
//		stmt = conn.createStatement();
//		int rowCount = stmt.executeUpdate(sql);
//		if ( rowCount == 1 ) {
//			System.out.println("부서추가 성공");
//			}
//	
//		stmt.close();
//		
//		
//	}
//
//
//	//[2]
//	private static void 부서수정() {
//		System.out.print("> 부서번호를 입력하세요 >>");
//		int deptno = sc.nextInt();
//		sc.nextLine();		
//		String dname = "";
//		String loc = "";
//		String sql = null;
//
//		System.out.println("부서명 입력하시오");
//		dname = sc.nextLine();
//
//		System.out.println("지역명을 입력하시오");
//		loc = sc.nextLine();
//
//
//		if ( dname.equals("")) {
//			sql = String.format("UPDATE dept"
//					+ " SET loc = '%s' "
//					+ " WHERE deptno = %d ", loc, deptno );
//		} else if (loc.equals("")) {
//			sql = String.format("UPDATE dept"
//					+ " SET dname = '%s' "
//					+ " WHERE deptno = %d ", dname, deptno );
//		} else {
//			sql = String.format("UPDATE dept"
//					+ " SET dname = '%s', loc = '%s' "
//					+ " WHERE deptno = %d ", dname, loc, deptno );
//		}
//
//		Statement stmt = null;
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
//
//	}
//
//
//
//	private static void 일시정지() {
//		System.out.println("엔터치면 계속합니다~");
//		try {
//			System.in.read();
//			System.in.skip(System.in.available());
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//
//	}
//
//	private static void 부서조회() {
//		ArrayList<DeptVO> dept_list = null;
//		int deptno;
//		String dname, loc;
//		Statement stmt = null;
//		ResultSet rs = null;
//		DeptVO vo = null;
//		String sql = "SELECT * "
//				+ "FROM dept";
//		try {
//			stmt = conn.createStatement();
//			rs = stmt.executeQuery(sql);
//			if(rs.next()) {
//				dept_list = new ArrayList();
//			}
//			do {
//				deptno = rs.getInt("deptno");
//				dname = rs.getString("dname");
//				loc = rs.getString("loc");
//				vo = new DeptVO(deptno, dname, loc);
//				dept_list.add(vo);
//			} while (rs.next());
//			dispDept(dept_list);
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} finally {
//			try {
//				stmt.close();
//				rs.close();
//			} catch (SQLException e) {
//				e.printStackTrace();
//			}
//		}
//	}
//
//	private static void dispDept(ArrayList<DeptVO> dept_list) {
//		Iterator<DeptVO> ir = dept_list.iterator();
//		System.out.println("-".repeat(30));
//		System.out.printf("deptno\tdname\tloc\n");
//		System.out.println("-".repeat(30));
//		while (ir.hasNext()) {
//			DeptVO deptVO = ir.next();
//			System.out.printf("%d\t%s\t%s\n", deptVO.getDeptno(),
//					deptVO.getDname(), deptVO.getLoc());
//		}
//		System.out.println("-".repeat(30));
//	}
//
//	private static void 프로그램종료() {
//		// 1. DB 닫기
//		DBConn.close();
//		// 2. 종료메시지 출력
//		System.out.println("프로그램 종료!!");
//		System.exit(-1);	
//	}
//
//	private static void 메뉴선택() {		
//		try {
//			System.out.println(" >  메뉴를 선택하세요? " );
//			selectedNumber = sc.nextInt();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}
//
//	private static void 메뉴출력() {
//		System.out.printf("[메뉴]\n");
//		for (int i = 0; i < menu.length; i++) {
//			System.out.printf("%d. %s\n", i+1, menu[i]);
//		}
//	}
//}

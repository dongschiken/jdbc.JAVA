package days03;
//package days03;
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
//import domain.DeptVO;
//
///**
// * @author dongs
// * @date 2024. 3. 18. - 오전 11:45:31
// * @subject dept 부서 테이블에 
// * 			추가, 수정, 삭제, 조회
// * @content
// */
//public class EX01 {
//
//	static String[] menu = { "추가", "수정", "삭제", "조회", "종료", "검색"};
//	public static int selectedNumber;
//	public static Connection conn;
//	public static Scanner sc = new Scanner(System.in);
//
//	public static void main(String[] args) throws SQLException, NullPointerException, IOException {
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
//	private static void 메뉴처리() throws SQLException, NullPointerException, IOException {
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
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		DeptVO vo = null;
//		String sql = "SELECT * "
//				+ "FROM dept"
//				+ " WHERE ";
//
//		if( searchCondition == 1) {
//			sql +=  "deptno IN (?)";
//		}else if ( searchCondition == 4){
//			sql += "REGEXP_LIKE(dname , ?, 'i') OR REGEXP_LIKE( loc , ?, 'i')";
//		}else {
//			sql += String.format(" REGEXP_LIKE(%s, ?, 'i') " ,  searchCondition == 2 ? "dname" : "loc");
//		}
//		// 컬럼명이나 테이블명은 "?" 로 줄수없다.
//		System.out.println(sql);
//		try {
//			pstmt = conn.prepareStatement(sql);
//			if( searchCondition == 1) {
//				pstmt.setInt(1, Integer.parseInt(searchWord));
//			}else if ( searchCondition == 4 ){
//				pstmt.setString(1, searchWord);
//				pstmt.setString(2, searchWord);
//			}else {
//				pstmt.setString(1, searchWord);
//			}  
//			rs = pstmt.executeQuery();
//			if(rs.next()) {
//				dept_list = new ArrayList<DeptVO>();
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
//		} catch (NullPointerException e) {
//			e.printStackTrace();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}finally {
//			try {
//				pstmt.close();
//				rs.close();
//			} catch (SQLException e) {
//				e.printStackTrace();
//			}
//		}
//	}
//
//
////	private static void 부서삭제()  {
////		System.out.print("삭제할 부서번호를 입력하시오 >>");
////		String deptno;
////		deptno = sc.next();
////		Statement stmt = null;
////		String sql = null;
////		try {
////			stmt = conn.createStatement();
////		} catch (SQLException e1) {
////			e1.printStackTrace();
////		}
////		try {
////			sql = String.format( "DELETE FROM dept "
////					+ " WHERE deptno IN (%s) ",  deptno);
////			System.out.println(sql);
////
////			int rowCount = stmt.executeUpdate(sql);
////			if(rowCount == 1) {
////				System.out.println("부서삭제 완료");
////			}
////		} catch (Exception e) {
////		}
////		try {
////			stmt.close();
////		} catch (SQLException e) {
////			e.printStackTrace();
////		}
//
////}
//	private static void 부서삭제() throws IOException  {
//		System.out.print("삭제할 부서번호를 입력하시오 >>");
//		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
//		String[] deptno = br.readLine().trim().split("\s*,\s*");
//		
//		
//		PreparedStatement pstmt = null;
//		String sql = null;
//		
//		try {
//			sql = "DELETE FROM dept "
//					+ " WHERE deptno IN (?) ";
//			System.out.println(sql);
//			pstmt = conn.prepareStatement(sql);
//			
//			for (int i = 0; i < deptno.length; i++) {
//				pstmt.setString(1, deptno[i]);
//				int rowCount = pstmt.executeUpdate();
//				if(rowCount == 1) {
//					System.out.println("부서삭제 완료");
//				}
//			}
//			
//		} catch (Exception e) {
//		}
//		try {
//			pstmt.close();
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//	}
//	
////	 private static void 부서삭제() {
////	      String deptno ;
////	      System.out.print("> 삭제할 부서번호를 입력 ? ");
////	      deptno = sc.nextLine(); // 60, 70, 100
////	      
////	      String sql =  String.format(
////	                   " DELETE FROM dept "
////	                 + " WHERE deptno IN ( %s )", deptno);
////	      
////	      System.out.println( sql );
////	      
////	      Statement stmt = null;
////
////	      try { 
////	         stmt = conn.createStatement(); 
////	         int rowCount = stmt.executeUpdate(sql);
////
////	         if( rowCount == 1 ) {
////	            System.out.println(" 부서 삭제 성공!!!");
////	         } 
////	       
////	      } catch (SQLException e) { 
////	         e.printStackTrace();
////	      } finally {
////	         try {
////	            stmt.close();
////	         } catch (SQLException e) { 
////	            e.printStackTrace();
////	         }
////	      }
////	      
////	   }
//	   
//
//	private static void 부서추가() throws SQLException, NullPointerException {
//		System.out.print("> 추가할 부서번호, 부서명, 지역명을 입력하세요 >>");
//		int deptno = sc.nextInt();
//		String dname = sc.next();
//		String loc = sc.next();
//		PreparedStatement pstmt = null;
//		// sql에서 매개변수는 항상 ?로 들어간다.
//		String sql = "INSERT INTO dept(deptno, dname, loc) "
//				+ "	VALUES (?, ?, ? )" ;
//		System.out.println(sql); //쿼리 확인하는 작업 꼭 넣자.
//
//
//		pstmt = conn.prepareStatement(sql);
//		
//		pstmt.setInt(1, deptno); // 1째 ?
//		pstmt.setString(2, dname); //2째 ?
//		pstmt.setString(3, loc); //3째 ?
//		
//		
////		Exception in thread "main" java.sql.SQLException: 인덱스에서 누락된 IN 또는 OUT 매개변수:: 1
//		int rowCount = pstmt.executeUpdate();
//		if ( rowCount == 1 ) {
//			System.out.println("부서추가 성공");
//		}
//		pstmt.close();
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
//			sql = "UPDATE dept"
//					+ " SET loc = ? "
//					+ " WHERE deptno = ?";
//		} else if (loc.equals("")) {
//			sql = "UPDATE dept"
//					+ " SET dname = ?"
//					+ " WHERE deptno = ?";
//		} else {
//			sql = "UPDATE dept"
//					+ " SET dname = ?, loc = ? "
//					+ " WHERE deptno = ?";
//		}
//
//		
//		PreparedStatement pstmt = null;
//		try {
//			// conn.setAutoCommit(true); 커밋 자동 설정되어져 있다.
//			pstmt = conn.prepareStatement(sql);
//			
//			 // 1째 ?
//			if( dname.equals("")) {
//				pstmt.setString(1, loc);
//				pstmt.setInt(2, deptno);
//			}else if (loc.equals("")) {
//				pstmt.setString(1, dname); 
//				pstmt.setInt(2, deptno);
//			}else {
//				pstmt.setString(1, dname); 
//				pstmt.setString(2, loc); 
//				pstmt.setInt(3, deptno);
//			}
//
//			// select -> stmt.executeQuery();
//			// INSERT, UPDATE, DELETE -> stmt.executeUpdate()
//			int rowCount = pstmt.executeUpdate();
//			if ( rowCount == 1 ) {
//				System.out.println("부서수정 성공");
//			}
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} finally {
//			try {
//				pstmt.close();
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
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		DeptVO vo = null;
//		String sql = "SELECT * "
//				+ "FROM dept";
//		try {
////			stmt = conn.createStatement();
//			// 객체 생성될때 sql 구문을 준다.
//			pstmt = conn.prepareStatement(sql);
//// 			rs = stmt.executeQuery(sql);
//			rs = pstmt.executeQuery();
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
//				pstmt.close();
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

package days04;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Scanner;

import com.util.DBConn;

import domain.DeptVO;
import oracle.jdbc.internal.OracleTypes;

/**
 * @author dongs
 * @date 2024. 3. 20. - 오후 3:09:27
 * @subject 	자바 리플렉션
 * @content 반사, 상, 반영
 * 				- JDBC 리플렉션 ? 결과물 ( RS )에 대한 정보를 추출해서 사용할 수 있는 기술
 */
public class Ex06 {

	public static void main(String[] args) {

		String sql = "SELECT table_name FROM tabs";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<String> tn_list = new ArrayList<String>();;
		String tableName = null;


		conn = DBConn.getConnection();

		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			
			while (rs.next()) {
				tableName = rs.getString(1);
				tn_list.add(tableName);
			} // while
			

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (Exception e2) {
				e2.printStackTrace();
			} 
		}
		System.out.println(tn_list);
		
		// [2]번 작업
		Scanner sc = new Scanner(System.in);
		System.out.println(" > 테이블명을 입력 ??");
		tableName = sc.next();
		
		// ( 테이블 명 또는 컬럼명은 ?의 매개변수로 사용할 수 없다.)
		sql = "SELECT * FROM  " + tableName;
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			ResultSetMetaData rsmd = rs.getMetaData();
			
//			System.out.println(" > 컬럼수 : " + rsmd.getColumnCount());
			int columnCount = rsmd.getColumnCount();
			
			System.out.println("-".repeat(columnCount*9));
			
			/*
			System.out.println("-".repeat(columnCount*9));
			
			for (int i = 1; i <= columnCount; i++) {
				String colName = rsmd.getColumnName(i);
				String colType = rsmd.getColumnTypeName(i);
				
				if( colType.equals("NUMBER")) {
					int precision = rsmd.getPrecision(i);
					int scale = rsmd.getScale(i);
					System.out.printf("%s  \t%s (%d, %d)\n"  , colName, colType, precision, scale);
				}else {
					System.out.printf("%s  \t%s \n"  , colName, colType);
				}
			}
			System.out.println("-".repeat(columnCount*9));
			*/
			
//			for (int i = 1; i <= columnCount; i++) {
//				String colName = rsmd.getColumnName(i);
//				int colType = rsmd.getColumnType(i);
//				System.out.printf("%s\t %d"  , colName, colType);
//			}

			
			System.out.println();
			System.out.println("-".repeat(columnCount*9));
			// col 타입이 2 == NUMBER
			// col 타입이 12 == VARCHAR2
			// col 타입이 93 == DATE
			while (rs.next()) {
				for (int i = 1; i <= columnCount; i++) {
					int colType = rsmd.getColumnType(i);
					if(colType == 2) {
						int scale = rsmd.getScale(i);
						if(scale == 0  || scale == -127) { // scale이 0이면 정수
							System.out.printf(" %d \t ", rs.getInt(i));
						}else { // 0이 아닌 숫자는 실수
							System.out.printf(" %.2f \t", rs.getDouble(i));
						}
					}else if (colType == 12) {
						System.out.printf(" %s \t ", rs.getString(i));
					}else if (colType == 93) {
						System.out.printf(" %tF \t ", rs.getDate(i));
					}
				}
				System.out.println();
				
			}
			
			
			System.out.println("-".repeat(columnCount*9));
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (Exception e2) {
				e2.printStackTrace();
			} 
		}
		
		DBConn.close();
		System.out.println("end");
	}


}



package days01;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import oracle.net.jdbc.TNSAddress.SOException;

public class Ex02 {

	public static void main(String[] args) throws SQLException {
		// [ Ex02.java <--> localhost oracle 서버에 연결 ]
		String className = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "scott";
		String password = "tiger";
		Connection conn = null;
		//		Class.forName("패키지.클래스명");
		try {
			// 1. Class.forName() JDBC 드라이버 로딩
			Class.forName(className);

			// 2. Connection객체 생성 - DriverManager.getConnection
			conn = DriverManager.getConnection(url, user, password);

			// 3. 필요한작업 ( CRUD )
			System.out.println( conn.isClosed() ? "DB 닫힘" : "DB 연결");


		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			// 4. Connection 닫기 (Close)
			conn.close();
			System.out.println( conn.isClosed() ? "DB 닫힘" : "DB 연결");
			System.out.println("end");
		}
		
		
		
	}
}
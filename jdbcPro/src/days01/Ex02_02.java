package days01;

import java.sql.Connection;
import java.sql.SQLException;

import oracle.jdbc.pool.OracleDataSource;

public class Ex02_02 {

	public static void main(String[] args) {
		// [ Ex02.java <--> localhost oracle 서버에 연결 ]
		String className = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "scott";
		String password = "tiger";
		Connection conn = null;
		//		Class.forName("패키지.클래스명");
		
		// DataSource 객체
		OracleDataSource ds;
		
		try {
			ds = new OracleDataSource();
			
			ds.setURL(url);
			conn  =  ds.getConnection(user, password);
			
			System.out.println( conn.isClosed() );
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} 

		
		System.out.println("end");
		
	}

}
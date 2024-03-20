package days04;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Scanner;

import com.util.DBConn;

import oracle.jdbc.internal.OracleTypes;

public class Ex07 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		Scanner sc = new Scanner(System.in);

		System.out.println("삭제할 부서 입력 >>> ");
		int deptno = sc.nextInt();
		Connection conn = null;
		CallableStatement cstmt = null;
		int check = 0;
		String sql = " {call up_delete ( ?, ? )}  ";

		conn = DBConn.getConnection();
		try {
			cstmt = conn.prepareCall(sql);
			cstmt.setInt(1, deptno); 	
			cstmt.registerOutParameter(2, OracleTypes.INTEGER);// OUTPUT용 매개변수 설정
			cstmt.executeQuery();
			check = cstmt.getInt(2);
			if (check == 0) {
				System.out.println("삭제할 부서가 없습니다.");
			}else {
				System.out.println(deptno + "번 부서삭제 완료!!");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				cstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}


		DBConn.close();
		System.out.println("end");
	}

}



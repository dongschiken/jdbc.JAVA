package days04;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Scanner;

import com.util.DBConn;

import oracle.jdbc.internal.OracleTypes;

public class Ex04 {

	public static void main(String[] args) {
		
		Scanner sc = new Scanner(System.in);
		System.out.println("로그인할 아이디 패스워드 입력 >>>");
		int id = sc.nextInt();
		String password = sc.next();
		
		Connection conn = null;
		CallableStatement cstmt = null;
		int check = 0;
		String sql = " {call up_login ( ? , ?, ? )}  ";
		
		
		conn = DBConn.getConnection();
		try {
			cstmt = conn.prepareCall(sql);
			cstmt.setInt(1, id); // INPUT용 매개변수 설정
			cstmt.setString(2, password);
			
														// 오라클의 정수타입으로 매개변수 설정
			cstmt.registerOutParameter(3, OracleTypes.INTEGER);// OUTPUT용 매개변수 설정
			cstmt.executeQuery();
			
			
			check = cstmt.getInt(3);
			if( check == 0 ) {
				System.out.println("로그인 성공했다 !!");
			} else if( check == 1) {
				System.out.println("아이디는 존재하지만 비밀번호가 잘못되었다.");
			}else {
				System.out.println("아이디가 존재하지 않습니다.");
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

// 추가 수정 삭제하는 저장 프로시저 만들기


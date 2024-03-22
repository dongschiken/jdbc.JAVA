package days04;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.SQLType;
import java.util.Scanner;

import com.util.DBConn;

import oracle.jdbc.internal.OracleTypes;
import oracle.jdbc.oracore.OracleType;

public class Ex03 {

	public static void main(String[] args) {

		// https://docs.oracle.com/cd/E17781_01/appdev.112/e18805/addfunc.htm#TDPJD209
		// JDBC syntaxCallableStatement cs1 = conn.prepareCall
//        ( "{call proc (?,?)}" ) ; // stored proc
//        CallableStatement cs2 = conn.prepareCall
//        ( "{? = call func (?,?)}" ) ; // stored func
//
//        //Oracle PL/SQL block syntax
//        CallableStatement cs3 = conn.prepareCall
//        ( "begin proc (?,?); end;" ) ; // stored proc
//        CallableStatement cs4 = conn.prepareCall
//        ( "begin ? := func(?,?); end;" ) ; // stored func
			
		// CallableStatement - 저장 프로시저, 저장함수
		//  저장 프로시저 - 회원가입 - 입력받은 ID를 사용할 수 있는지 체크하는 프로시저
//								아이디		: 
//								비밀번호	:
//								이메일		:
//								주소		:
//								연락처		:
		
		Scanner sc = new Scanner(System.in);
		System.out.print(" > 중복 체크할 ID(empno)를 입력? >>> ");
		int id = sc.nextInt(); // 7369, 8888 입력
		
		Connection conn = null;
		CallableStatement cstmt = null;
		int check = 0;
		
		// call 명령어 + 프로시저 이름 + 매개변수
		String sql = " {call UP_IDCHECK ( ? , ? )}  ";
		
//		String sql = " {call UP_IDCHECK (pid  => ? , pcheck => ?)}  ";
		
		conn = DBConn.getConnection();
		try {
			cstmt = conn.prepareCall(sql);
			cstmt.setInt(1, id); // INPUT용 매개변수 설정
														// 오라클의 정수타입으로 매개변수 설정
			cstmt.registerOutParameter(2, OracleTypes.INTEGER);// OUTPUT용 매개변수 설정
			cstmt.executeQuery();
			
			check = cstmt.getInt(2);
			if( check == 0 ) {
				System.out.println("사용가능한 ID(empno)입니다.");
			}else {
				System.out.println("이미 사용중인 ID(empno)입니다.");
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

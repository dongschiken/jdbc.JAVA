package days03;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Scanner;

import com.util.DBConn;

public class Ex10 {
	public static Connection conn = null;
	public static void main(String[] args) throws NumberFormatException, IOException {
		int empno;
		String deptno, ename, job, mgr, hiredate, sal, comm;
		String updateWord;
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		String sql = "UPDATE emp "
				+ "SET ";

		Scanner scanner = new Scanner(System.in);


		conn = DBConn.getConnection();
		int count = 0;
		System.out.println("> 사원번호를 입력하세요 : ");
		empno = Integer.parseInt(br.readLine());

		System.out.println("> 부서번호 입력(미수정 시 엔터) : ");
		deptno = "";
		deptno = br.readLine();      
		if(!deptno.equals("")) {
			count++;
			sql += " deptno = ? ";
		}

		System.out.println("> 사원명 입력(미수정 시 엔터) : ");
		ename = "";
		ename = br.readLine();      
		if(!ename.equals("")) {
			count++;
			if(count == 1) {
				sql += " ename = ? ";
			}else {
				sql += " , ename = ? ";
			}
		}

		System.out.print("> 직업 입력(미수정 시 엔터) : ");
		job = "";
		job = br.readLine();
		if(!job.equals("")) {
			count++;
			if(count == 1) {
				sql += " job = ? ";
			}else {
				sql += " , job = ? ";
			}

		}

		System.out.print("> 사수번호 입력(미수정 시 엔터) : ");
		mgr = "";
		mgr = br.readLine();
		if( !mgr.equals("")) {
			count++;
			if(count == 1) {
				sql += " mgr = ? ";
			}else {
				sql += " , mgr = ? ";
			}
		}

		System.out.print("> 입사날짜 입력(미수정 시 엔터) : ");
		hiredate = "";
		hiredate =br.readLine();
		if( !hiredate.equals("")) {
			count++;
			if(count == 2) {
				sql += " hiredate = ? ";
			}else {
				sql += " , hiredate = ? ";
			}

		}

		System.out.print("> 급여 입력(미수정 시 엔터) : ");
		sal = "";
		sal = br.readLine();
		if(!sal.equals("")) {
			count++;
			if(count == 1) {
				sql += " sal = ? ";
			}else {
				sql += " , sal = ? ";
			}

		}


		System.out.print("> 커미션 입력(미수정 시 엔터) : ");
		comm = "";
		comm = br.readLine();
		if(!comm.equals("")) {
			count++;
			if(count == 1) {
				sql += "comm = ? ";
			}else {
				sql += ", comm = ? ";
			}

		}
		sql += " WHERE empno = "+ empno;

		System.out.println(sql);
		PreparedStatement pstmt = null;
		int i = 1;
		try {
			pstmt = conn.prepareStatement(sql);
			if(!deptno.equals("")) {
				pstmt.setString(i, deptno);
				i++;
			}
			if(!ename.equals("")) {
				pstmt.setString(i, ename);
				i++;
			}
			if(!job.equals("")) {
				pstmt.setString(i, job);
				i++;
			}
			if(!mgr.equals("")) {
				pstmt.setString(i, mgr);
				i++;
			}
			if(!hiredate.equals("")) {
				pstmt.setString(i, hiredate);
				i++;
			}
			if(!sal.equals("")) {
				pstmt.setString(i, sal);
				i++; 
			}
			if(!comm.equals("")) {
				pstmt.setString(i, comm);
			}

			int rowCount = pstmt.executeUpdate();
			if (rowCount == 1) {
				System.out.println("부서 수정 성공");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}//main
}

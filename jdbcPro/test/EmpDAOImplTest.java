package test;

import static org.junit.jupiter.api.Assertions.*;


import java.sql.Connection;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import org.junit.jupiter.api.Test;

import com.util.DBConn;

import domain.EmpVO;
import persistance.EmpDAO;
import persistance.EmpDAOImp1;

// 단위테스트하는 클래스
class EmpDAOImplTest {

private Date date;

	@Test
	void test() { 
		Connection conn = DBConn.getConnection();
		EmpDAO dao = new EmpDAOImp1(conn);
		
		ArrayList<EmpVO> list = dao.getEmpSelect();
		
		System.out.print("사원수 : "  + list.size() + "명");
		DBConn.close();
	}
	//int empno, String ename, String job, Date hiredate, int mgr, double sal, double comm, int deptno
//	@Test
//	void test() { 
//		
//		
//		
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//        try {
//			this.date = sdf.parse("2017-01-01");
//		} catch (ParseException e) {
//			e.printStackTrace();
//		} 
//        
//		Connection conn = DBConn.getConnection();
//		EmpDAO dao = new EmpDAOImp1(conn);
//		EmpVO vo = new EmpVO( 9999 , "동영", "SALES", date  , 9998, 1000.0, 100.0, 0);
//		int rowCount = dao.addEmp(vo);
//		
//		if(rowCount == 1) {
//			System.out.println("사원 추가 성공");
//		}
//		DBConn.close();
//	}

}

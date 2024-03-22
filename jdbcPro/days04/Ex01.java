package days04;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map.Entry;
import java.util.Set;

import com.util.DBConn;

import domain.DeptEmpSalgradeVO;
import domain.DeptVO;

public class Ex01 {

	public static void main(String[] args) throws SQLException {
		// 부서명, 부서번호, 몇명 클래스
		// empno ename hiredate pay 클래스 ?
		Connection conn1 = DBConn.getConnection();
		Connection conn2 = DBConn.getConnection();
		ArrayList<DeptEmpSalgradeVO> des_list = null;
		DeptVO dvo = null;
		DeptEmpSalgradeVO desvo = null;
		LinkedHashMap<DeptVO , ArrayList<DeptEmpSalgradeVO>> ent_map = new LinkedHashMap();
		PreparedStatement des_pstmt = null, dvo_pstmt = null;
		ResultSet des_rs = null, dvo_rs = null;
		
		String  dvo_sql = "SELECT d.deptno , dname, COUNT(*) cnt "
				+ " FROM dept d RIGHT JOIN emp e ON d.deptno = e.deptno "
				+ " GROUP BY d.deptno, dname "
				+ " ORDER BY d.deptno ASC ";
		
		String des_sql = "SELECT ename, empno, hiredate, sal "
				+ " FROM emp e LEFT OUTER JOIN dept d  ON d.deptno = e.deptno "
				+ " WHERE e.deptno = ? ";
		String des_sql2 = "SELECT ename, empno, hiredate, sal "
				+ " FROM emp e LEFT OUTER JOIN dept d  ON d.deptno = e.deptno "
				+ " WHERE e.deptno IS NULL ";
		
		
		dvo_pstmt = conn1.prepareStatement(dvo_sql);
		dvo_rs = dvo_pstmt.executeQuery();
		if(dvo_rs.next()) {
			
		}
		int deptno = 0;
		do {
			
			deptno = dvo_rs.getInt("deptno");
			dvo = new DeptVO().builder()
					.dname(dvo_rs.getString("dname"))
					.deptno(deptno)
					.cnt(dvo_rs.getInt("cnt"))
					.build();
			if(deptno == 0) {
				des_pstmt = conn2.prepareStatement(des_sql2);
			}else {
				des_pstmt = conn2.prepareStatement(des_sql);
				des_pstmt.setInt(1, deptno);
			}
			des_rs = des_pstmt.executeQuery();
			if( des_rs.next() ) {
				des_list = new ArrayList<DeptEmpSalgradeVO>();
			}
			do {
				
				desvo = new DeptEmpSalgradeVO().builder()
						
						.empno(des_rs.getInt("empno"))
						.ename(des_rs.getString("ename"))
						.hiredate(des_rs.getDate("hiredate"))
						.pay(des_rs.getDouble("sal"))
						.build();
				des_list.add(desvo);
			} while (des_rs.next());
			
			ent_map.put(dvo, des_list);
			
		} while (dvo_rs.next());
		
		dispEntry(ent_map);
		
		
		des_rs.close();
		des_pstmt.close();
		dvo_rs.close();
		dvo_pstmt.close();
		conn2.close();
		conn1.close();
	}
	
	private static void dispEntry(LinkedHashMap<DeptVO, ArrayList<DeptEmpSalgradeVO>> ent_map) {
		Set<Entry<DeptVO, ArrayList<DeptEmpSalgradeVO>>> entry = ent_map.entrySet();
		Iterator<Entry<DeptVO, ArrayList<DeptEmpSalgradeVO>>> ir = entry.iterator();
		while (ir.hasNext()) {
			Entry<domain.DeptVO, java.util.ArrayList<domain.DeptEmpSalgradeVO>> entry2 = ir.next();
			
			DeptVO dvo = entry2.getKey();
			System.out.printf("%s (%d) - %d명\n", dvo.getDname(), dvo.getDeptno(), dvo.getCnt());
			ArrayList<DeptEmpSalgradeVO> des_list = entry2.getValue();
			Iterator<DeptEmpSalgradeVO> ir2 = des_list.iterator();
			while (ir2.hasNext()) {
				DeptEmpSalgradeVO deptEmpSalgradeVO =  ir2.next();
				System.out.printf("\t%d \t%s \t\t%s \t%.2f\n", deptEmpSalgradeVO.getEmpno(), deptEmpSalgradeVO.getEname(), deptEmpSalgradeVO.getHiredate(), deptEmpSalgradeVO.getPay());
			}
		}
	}

}

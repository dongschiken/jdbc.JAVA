
package days03;

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
import domain.EmpVO;
import domain.SalgradeVO;

public class Ex03_02 {

	public static void main(String[] args) {

		String sql = "SELECT grade, losal, hisal "
				+ " , COUNT (*) cnt "
				+ " FROM salgrade s JOIN emp e ON e.sal BETWEEN s.losal AND s.hisal"
				+ " GROUP BY grade, losal, hisal"
				+ " ORDER BY grade";
		
		String empSql = " SELECT d.deptno, dname, empno, ename, sal, grade "
				+ " FROM dept d RIGHT JOIN emp e ON d.deptno = e.deptno "
				+ "                  JOIN salgrade s ON e.sal BETWEEN losal AND hisal "
				+ " WHERE grade = ? ";


		Connection conn = null;
		PreparedStatement pstmt = null, empPstmt = null;
		ResultSet rs = null, empRs = null;
		SalgradeVO vo = null;
		ArrayList<DeptEmpSalgradeVO> emplist = null;
		LinkedHashMap<SalgradeVO, ArrayList<DeptEmpSalgradeVO>> map = new LinkedHashMap<SalgradeVO, ArrayList<DeptEmpSalgradeVO>>();

		DeptEmpSalgradeVO empvo = null;
		conn = DBConn.getConnection();

		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {

				do {
					int grade = rs.getInt("grade");

					vo = new SalgradeVO(
							grade
							,rs.getInt("losal")
							,rs.getInt("hisal")
							,rs.getInt("cnt")
							);
					empPstmt = conn.prepareStatement(empSql);
					empPstmt.setInt(1, grade);
					empRs = empPstmt.executeQuery();

					if( empRs.next()) {
						emplist = new ArrayList();
						do {
							empvo = DeptEmpSalgradeVO.
									builder().
									empno(empRs.getInt("empno")).
									dname(empRs.getString("dname")).
									ename(empRs.getString("ename")).
									pay(empRs.getDouble("sal")).
									build();
							emplist.add(empvo);
						} while (empRs.next());
					}

					map.put(vo, emplist);

					empRs.close();
					empPstmt.close();
				} while (rs.next());
			}
			dispSalgrade(map);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				pstmt.close();
				conn.close();

			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	private static void dispSalgrade(LinkedHashMap<SalgradeVO, ArrayList<DeptEmpSalgradeVO>> map) {
		Set<Entry<SalgradeVO, ArrayList<DeptEmpSalgradeVO>>> set = map.entrySet();
		Iterator<Entry<SalgradeVO, ArrayList<DeptEmpSalgradeVO>>> ir = set.iterator();
		while (ir.hasNext()) {
			Entry<domain.SalgradeVO, java.util.ArrayList<domain.DeptEmpSalgradeVO>> entry = ir.next();
			SalgradeVO vo = entry.getKey();
			ArrayList<DeptEmpSalgradeVO> emp_list =  entry.getValue();
			System.out.printf("%d 등급  ( %d ~ %d )  -  %d명\n", vo.getGrade(), vo.getLosal(), vo.getHisal(), vo.getCnt());
			Iterator ir2 = emp_list.iterator();
			while (ir2.hasNext()) {
				DeptEmpSalgradeVO deptempsal = (DeptEmpSalgradeVO) ir2.next();
				System.out.printf("\t%s\t%d\t%s\t%.02f\n", deptempsal.getDname(), deptempsal.getEmpno(), deptempsal.getEname(), deptempsal.getPay());
				
			}
		}
	}

	private static void dispSalgrade(ArrayList<SalgradeVO> list) {
		Iterator<SalgradeVO> ir = list.iterator();
		while (ir.hasNext()) {
			SalgradeVO vo = (SalgradeVO) ir.next();
			System.out.printf("%d 등급 ( %d~%d ) - %d명\n", vo.getGrade(), vo.getLosal(), vo.getHisal(), vo.getCnt());
		}
	}

}

package persistance;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import domain.EmpVO;

public class EmpDAOImp1 implements EmpDAO{

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	// 생성자를 통한 DI
	public EmpDAOImp1(Connection conn) {
		this.conn = conn;
	}

	// Setter를 통한 DI
	public void setConn(Connection conn) {
		this.conn  = conn;
	}

	@Override
	public ArrayList<EmpVO> getEmpSelect() {
		ArrayList<EmpVO> emp_list = null;
		int empno;
		String ename;
		String job;
		int mgr;
		Date hiredate;
		double sal;
		double comm;
		int deptno;
		String sql = "SELECT * "
				+ "		FROM emp";
		try {
			//           st = conn.createStatement();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			//           rs = st.executeQuery(sql);
			if(rs.next()) {
				emp_list = new ArrayList<EmpVO>();
			}
			do {
				empno = rs.getInt(1);
				ename = rs.getString(2);
				job = rs.getString(3);
				mgr = rs.getInt(4);
				hiredate = rs.getDate(5);
				sal = rs.getInt(6);
				comm = rs.getInt(7);
				deptno = rs.getInt(8);
				EmpVO ev = new EmpVO(empno,ename,job,hiredate,mgr ,sal,comm,deptno);
				emp_list.add(ev);
			}
			while (rs.next()) ;


		} catch (SQLException e) {
			e.printStackTrace();
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}			
		}
		return emp_list;
	}



	@Override
	public int addEmp(EmpVO vo) {

		int rowCount=0;
		String sql = " INSERT INTO emp ( deptno, empno, ename, job, mgr, hiredate, sal, comm  )"
				+ " VALUES ( ?, ?, ?, ?, ?, ?, ?, ? )" ;

		System.out.println(sql);

		PreparedStatement pstmt = null;

		try {
			pstmt = conn.prepareStatement(sql);

			// ?, ?, ?  pstmt의 매개변수 설정 X
			// java.sql.SQLException: 부적합한 열 인덱스
			pstmt.setInt(1, vo.getDeptno());
			pstmt.setInt(2, vo.getEmpno());
			pstmt.setString(3, vo.getEname());
			pstmt.setString(4, vo.getJob());
			pstmt.setInt(5, vo.getMgr());
			java.util.Date utilDate = vo.getHiredate();
			java.sql.Date sdHiredate = new java.sql.Date(utilDate.getTime());
			pstmt.setDate(6, sdHiredate);
			pstmt.setDouble(7, vo.getSal());
			pstmt.setDouble(8, vo.getComm());

			rowCount = pstmt.executeUpdate();


			if (rowCount == 1) {
				System.out.println("사원 추가 성공!!");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		return rowCount;

	}

	@Override
	public int updateEmp(EmpVO vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteEmp(int empno) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public ArrayList<EmpVO> searchEmp(int searchCondition, String searchWord) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public EmpVO getEmp(int empno) {
		// TODO Auto-generated method stub
		return null;
	}

}

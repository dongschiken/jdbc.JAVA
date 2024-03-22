package domain;

import java.util.Date;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
//empno, ename, job, mgr, hiredate, sal, comm, deptno
public class EmpVO {
	
	private int empno;
	private String ename;
	private String job;
	private Date hiredate;
	private int mgr;
	private double sal;
	private double comm;
	private int deptno;
	
	public EmpVO(int empno, String ename, String job, Date hiredate, int mgr, double sal, double comm, int deptno) {
		super();
		this.empno = empno;
		this.ename = ename;
		this.job = job;
		this.hiredate = hiredate;
		this.mgr = mgr;
		this.sal = sal;
		this.comm = comm;
		this.deptno = deptno;
	}
		
	

		
	
}

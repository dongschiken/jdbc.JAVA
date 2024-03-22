package domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DeptEmpSalgradeVO {
	private int empno;
	private String dname;
	private String ename;
	private Date hiredate;
	private double pay;
	private int grade;
	private int deptno;
	
	
	
	public DeptEmpSalgradeVO(int empno, String ename, Date hiredate, double pay, int deptno) {
		super();
		this.empno = empno;
		this.ename = ename;
		this.hiredate = hiredate;
		this.pay = pay;
		this.deptno = deptno;
	}
	
	
}



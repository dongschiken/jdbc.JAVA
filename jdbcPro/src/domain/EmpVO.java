package domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor

//empno, ename, job, mgr, hiredate, sal, comm, deptno
public class EmpVO {
	
		int empno;
		String ename;
		String job;
		String hiredate;
		int mgr;
		int sal;
		int comm;
		int deptno;
		
	

		
	
}

package domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class EmpVO {
	int empno;
	String ename;
	String job;
	int mgr;
	String hiredate;
	int sal;
	int comm;
	int deptno;

//empno, ename, job, mgr, hiredate, sal, comm, deptno

}
package domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@Getter
@Setter
@NoArgsConstructor
@Data
@Builder
@ToString
public class EmpVO {
	int empno;
	String ename;
	String job;
	int mgr;
	String hiredate;
	int sal;
	int comm;
	int deptno;
	
}

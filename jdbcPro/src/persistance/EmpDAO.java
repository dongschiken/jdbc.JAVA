package persistance;

import java.util.ArrayList;

import domain.EmpVO;

/**
 * @author dongs
 * @date 2024. 3. 19. - 오후 2:37:36
 * @subject
 * @content
 */
public interface EmpDAO {
	// 모든 사원정보를 조회하는 추상메서드
	public abstract ArrayList<EmpVO> getEmpSelect();
	
	// 사원 정보를 추가하는 추상메서드
	int addEmp(EmpVO vo);
	
	// 사원 수정하는 추상메서드
	int updateEmp(EmpVO vo);
	
	// 사원 삭제하는 추상메서드
	int deleteEmp(int empno);
	// 사원 많이 삭제
//	int deleteEmp(int[] empnos);
//	int deleteEmp(ArrayList<Integer> empnos);
	
	// 사원 검색
	ArrayList<EmpVO> searchEmp(int searchCondition, String searchWord);
	
	// 한 사원 정보
	EmpVO getEmp(int empno);
	
}

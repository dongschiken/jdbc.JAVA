package days02;

import java.text.MessageFormat;
import java.text.ParseException;

/**
 * @author dongs
 * @date 2024. 3. 18. - 오후 3:25:05
 * @subject
 * @content
 */
public class Ex02_02 {

	public static void main(String[] args) {
		// 형식화 클래스 : MessageFormat
		// Object잡은 이유 => 각각의 배열값이 int, String, String이라서
		// [1] 번
//		Object[] objs = { 50, "영업부", "서울"};
//		String pattern = "INSERT INTO dept ( deptno, dname, loc )"
//				+ " VALUES({0}, ''{1}'', ''{2}'' )";
//		String sql = MessageFormat.format(pattern, objs);
//		System.out.println(sql);
		
		// [2] 번 입력값 받는 코딩
//		String record = "50,  , SEOUL";
//		String pattern = "{0}, {1}, {2}";
//		MessageFormat mf = new MessageFormat(pattern);
//		try {
//			Object[] objs = mf.parse(record);
//			System.out.println(objs[0]);
//			System.out.println(objs[1]);
//			System.out.println(objs[2]);
//		} catch (ParseException e) {
//			e.printStackTrace();
//		}
		
		
		
	} // main

} // class

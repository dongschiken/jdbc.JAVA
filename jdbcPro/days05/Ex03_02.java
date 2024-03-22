package days05;

public class Ex03_02 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		int numberPerPage = 10;	
		int numberOfPageBlock = 10;
		
		// start end
		// currentPage = 1; 페이징 블럭 : [1] 2 3 4 5 6 7 8 9 10 >
		// currentPage = 2; 페이징 블럭 : 1 [2] 3 4 5 6 7 8 9 10 >
		// currentPage = 3; 페이징 블럭 : 1 2 [3] 4 5 6 7 8 9 10 >
		// currentPage = 4; 페이징 블럭 : 1 2 3 [4] 5 6 7 8 9 10 >
		// currentPage = 5; 페이징 블럭 : 1 2 3 4 [5] 6 7 8 9 10 >
		// currentPage = 6; 페이징 블럭 : 1 2 3 4 5 [6] 7 8 9 10 >
		// currentPage = 7; 페이징 블럭 : 1 2 3 4 5 6 [7] 8 9 10 >
		// currentPage = 8; 페이징 블럭 : 1 2 3 4 5 6 7 [8] 9 10 >
		// currentPage = 9; 페이징 블럭 : 1 2 3 4 5 6 7 8 [9] 10 >
		// currentPage = 10; 페이징 블럭 : 
		// currentPage = 11; 페이징 블럭 : [11] 12 13 14 15 16 >
		
		// 1)  총 게시글 수?  :  152
		// 2)  총 페이지 수?  :  16
		
		

		for (int currentPage = 1; currentPage <= 34 ; currentPage++) {
			int start = (currentPage-1)/numberOfPageBlock * numberPerPage+1;
			int end = start + numberOfPageBlock-1;
			if(end > 34) end = 34;
			
			System.out.printf("currentPage =  %d \n", currentPage );
			if(start != 1) System.out.printf("PREV");
			for (int i = start ; i <= end; i++) {
				if(i == currentPage) System.out.printf("[%d]", i);
				else  System.out.printf("%d", i);
			}
			if(end != 34)System.out.printf("NEXT");
			System.out.println();
		}
		
	}

}

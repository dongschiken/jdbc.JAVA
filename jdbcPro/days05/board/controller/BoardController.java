package days05.board.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Scanner;

import com.util.DBConn;

import days05.board.persistance.BoardDAO;
import days05.board.persistance.BoardDAOImpl;
import days05.board.service.BoardService;
import days05.board_domain.BoardDTO;
import oracle.net.aso.a;

public class BoardController {

	private Scanner sc = null;
	private int selectedNumber;
	private BoardService service;
	private int currentPage = 1;
	private int numberPerPage = 10;			// 한페이지에 10개씩 출력
	private int numberOfPageBlock = 10;

	// 기본 생성자
	public BoardController() {
		super();
		this.sc = new Scanner(System.in);
	}

	// 생성자를 통한 DI
	public BoardController(BoardService service) {
		this();
		this.service = service;
	}
	
	
	// 게시판 기능을 사용...
	public void boardStart() {
		while (true) {
			메뉴출력();
			메뉴선택();
			메뉴처리();
		} // while
	}

	private void 메뉴처리() {
		switch (this.selectedNumber) {
		case 1:// 새글   
			새글쓰기();
			break;
		case 2:// 목록
			목록보기();
			break;
		case 3:// 보기
			상세보기();
			break;
		case 4:// 수정
			수정하기();
			break;
		case 5:// 삭제
			삭제하기();
			break;
		case 6:// 검색
			검색하기();
			break;
		case 7:// 종료   
			exit();
			break; 
		} // switch
		일시정지();
	}

	private void 검색하기() {
		System.out.print(
				"> 검색 조건 : 제목(1) , 내용(2), 작성자(3), 제목+내용(4) 선택  ? ");
		int searchCondition = this.sc.nextInt();
		System.out.print("> 검색어 입력 ? ");
		String searchWord = this.sc.next();

		// 목록보기 코딩 복+붙
		System.out.print("> 현재 페이지번호를 입력 ? ");
		this.currentPage = this.sc.nextInt();

		ArrayList<BoardDTO> list = 
				this.service.searchService(
						searchCondition
						, searchWord
						, this.currentPage
						, this.numberPerPage
						);
		
		

		// 뷰(View)-출력담당
		System.out.println("\t\t\t  게시판");
		System.out.println("-------------------------------------------------------------------------");
		System.out.printf("%s\t%-40s\t%s\t%-10s\t%s\n", 
				"글번호","글제목","글쓴이","작성일","조회수");
		System.out.println("-------------------------------------------------------------------------");
		if (list == null) {
			System.out.println("\t\t> 게시글 존재 X");	
		} else {
			Iterator<BoardDTO> ir = list.iterator();
			while (ir.hasNext()) {
				BoardDTO dto =  ir.next();
				System.out.printf("%d\t%-30s  %s\t%-10s\t%d\n",
						dto.getSeq(), 
						dto.getTitle(),
						dto.getWriter(),
						dto.getWritedate(),
						dto.getReaded());	
			} // while
		}
		System.out.println("-------------------------------------------------------------------------");
		//  System.out.println("\t\t\t [1] 2 3 >");
		String pageblock = this.service.pageService(
				currentPage, numberPerPage, numberOfPageBlock
				, searchCondition, searchWord );
		System.out.println( pageblock ); 
		System.out.println("-------------------------------------------------------------------------");
	}

	private void 삭제하기() {
		System.out.println(" > 삭제하고싶은 글 번호 입력");
		long seq = this.sc.nextLong();
		int rowCount  = this.service.deleteService(seq);

		if(rowCount == 1) {
			System.out.println(" > 게시글 삭제 성공!!");
		}

	}

	
	private void 수정하기() {
		
		System.out.println(" > 수정하고 싶은 글 번호 입력");
		long seq = this.sc.nextLong();
		
		// 1. 원래 게시글 정보를 출력
		BoardDTO dto = null;
		try {
			dto = this.service.dao.view(seq);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		if( dto == null ) {
			System.out.println("조회할 게시글이 존재하지 않습니다.");
			return;
		}
		// 출력 담당 객체 view(뷰) : 우리는 현재 만들지 않음
		System.out.println("\tㄱ. 글번호 : " + seq );
		System.out.println("\tㄴ. 작성자 : " + dto.getWriter() );
		System.out.println("\tㄷ. 조회수 : " + dto.getReaded() );
		System.out.println("\tㄹ. 글제목 : " + dto.getTitle() );
		System.out.println("\tㅁ. 글내용 : " + dto.getContent() );
		System.out.println("\tㅂ. 작성일 : " + dto.getWritedate() );
		
		System.out.println(" >1.  수정할 이메일 입력");
		String email = this.sc.next();
		
		System.out.println(" >2.  수정 할 글 제목 입력");
		String title = this.sc.next();

		System.out.println(" >3.  수정할 글 내용 입력");
		String content = this.sc.next();
		
			dto = new BoardDTO().builder()
												.seq(seq)
												.title(title)
												.email(email)
												.content(content)
												.build();
		
		int rowCount = this.service.updateService(dto);
		
		if(rowCount == 1){
			System.out.printf(" > %d번 게시글 게시글 수정 성공\n",  seq);
		}
		
	}


	private void 상세보기() {
		System.out.println(" > 보고싶은 글 번호 입력");
		long seq = this.sc.nextLong();

		BoardDTO dto = this.service.viewService(seq);

		if( dto == null ) {
			System.out.println("조회할 게시글이 존재하지 않습니다.");
			return;
		}
		// 출력 담당 객체 view(뷰) : 우리는 현재 만들지 않음
		System.out.println("\tㄱ. 글번호 : " + seq );
		System.out.println("\tㄴ. 작성자 : " + dto.getWriter() );
		System.out.println("\tㄷ. 조회수 : " + dto.getReaded() );
		System.out.println("\tㄹ. 글제목 : " + dto.getTitle() );
		System.out.println("\tㅁ. 글내용 : " + dto.getContent() );
		System.out.println("\tㅂ. 작성일 : " + dto.getWritedate() );

		System.out.println("\t\n [수정] [삭제] [목록(home)]");

		일시정지();
	}


	
	private void 목록보기() {
		

		System.out.print(" > 현재 페이지번호를 입력 ??");
		this.currentPage  = this.sc.nextInt();
		ArrayList<BoardDTO> list = this.service.selectService(this.currentPage, this.numberPerPage);
		// 뷰(View)-출력담당
		System.out.println("\t\t\t  게시판");
		System.out.println("-------------------------------------------------------------------------");
		System.out.printf("%s\t%-40s\t%s\t%-10s\t%s\n", 
				"글번호","글제목","글쓴이","작성일","조회수");
		System.out.println("-------------------------------------------------------------------------");
		if(list == null) {
			System.out.println("게시글이 존재하지 않는다.");
		}else {
			Iterator<BoardDTO> ir = list.iterator();
			while (ir.hasNext()) {
				BoardDTO dto = (BoardDTO) ir.next();
				System.out.printf("%d\t%-30s  %s\t%-10s\t%d\n",dto.getSeq()
						, dto.getTitle()
						, dto.getWriter()
						, dto.getWritedate()
						, dto.getReaded());
			} // while
		} // if else 
		System.out.println("-------------------------------------------------------------------------");
		String pageblock = this.service.pageService(currentPage, numberPerPage, numberOfPageBlock);
		System.out.println(pageblock);
		System.out.println("-------------------------------------------------------------------------");
	}

	private void 새글쓰기() {
		System.out.print("> writer, pwd, email, title, tag, content 입력 ? ");
		String [] datas = this.sc.nextLine().split("\s*,\s*");
		String writer = datas[0];
		String pwd = datas[1];
		String email = datas[2];
		String title = datas[3];
		int tag = Integer.parseInt(datas[4]);
		String content = datas[5];

		BoardDTO dto = new BoardDTO()
				.builder()
				.writer(writer)
				.pwd(pwd)
				.email(email)
				.title(title)
				.tag(tag)
				.content(content)
				.build();
		int rowCount = this.service.insertService(dto);
		if(rowCount == 1) {
			System.out.println(" > 새글 쓰기 성공 !! ");
		}
	}

	private void 메뉴선택() {
		System.out.print(" >> 메뉴 선택하세요 ?");
		this.selectedNumber = this.sc.nextInt();
		this.sc.nextLine(); // \r\n을 제거하는 코드
	}

	private void exit() {
		DBConn.close();
		System.out.println("\t\t\t  프로그램 종료!!!");
		System.exit(-1);
	}

	private void 일시정지() {
		System.out.println(" \t\t 계속하려면 엔터치세요.");
		try {
			System.in.read();
			System.in.skip(System.in.available()); // 13, 10
		} catch (IOException e) { 
			e.printStackTrace();
		}
	}

	private void 메뉴출력() {
		// TODO Auto-generated method stub
		String[] menu = { "새글" , "목록", "보기", "수정", "삭제", "검색", "종료" };
		System.out.println("[ 메뉴 ]");
		for (int i = 0; i < menu.length; i++) {
			System.out.printf("%d. %s\t", i+1, menu[i]);
		}
		System.out.println();
	}




}

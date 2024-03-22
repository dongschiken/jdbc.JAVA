package days05.board_domain;

import java.sql.Date;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class BoardDTO {
	private long 	seq;
	private String 	writer;
	private String 	pwd;
	private String 	email;
	private String 	title;
	private Date  	writedate;
	private long 	 	readed;
	private int 	 	tag;
	private String 	content;
	

}

package practice.board.dto;

import java.util.Date;

import lombok.Data;

@Data
public class BoardDTO {

	private int id;
	private String title;
	private String content;
	private String writer;
	private Date writeDate;
	private int hit;
	
	// 댓글 전용 - 필요에 따라 추후 삭제 가능
	private int reply_id;
	private int board_id;
}

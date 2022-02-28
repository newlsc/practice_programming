package practice.board.service;

import java.util.HashMap;
import java.util.List;

import practice.board.dto.BoardDTO;

public interface BoardService {

	public int countList();
	public List<BoardDTO> boardList(HashMap<String, Integer> map);
	public List<BoardDTO> boardListDetail(int id);
	public int replyTotal(int id);
	public void writeReply(HashMap<Object, Object> map);
	public List<BoardDTO> reply(int id);
	public void increaseViews(int id);
	public void write(BoardDTO dto);
	public void update(BoardDTO dto);
	public void delete(int id);
}

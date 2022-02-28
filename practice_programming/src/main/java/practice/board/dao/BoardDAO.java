package practice.board.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import practice.board.dto.BoardDTO;

public interface BoardDAO {

	public int countList(SqlSessionTemplate session);
	public List<BoardDTO> boardList(SqlSessionTemplate session, HashMap<String, Integer> map);
	public List<BoardDTO> boardListDetail(SqlSessionTemplate session, int id);
	public int replyTotal(SqlSessionTemplate session, int id);
	public List<BoardDTO> reply(SqlSessionTemplate session, int id);
	public void increaseViews(SqlSessionTemplate session, int id);
	public void write(SqlSessionTemplate session, BoardDTO dto);
	public void update(SqlSessionTemplate session, BoardDTO dto);
	public void delete(SqlSessionTemplate session, int id);
	public void writeReply(SqlSessionTemplate session, HashMap<Object, Object> map);

}

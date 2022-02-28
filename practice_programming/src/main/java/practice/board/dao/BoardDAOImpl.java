package practice.board.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import practice.board.dto.BoardDTO;

@Repository
public class BoardDAOImpl implements BoardDAO {

	@Override
	public int countList(SqlSessionTemplate session) {
		return session.selectOne("board.countList");
	}
	@Override
	public List<BoardDTO> boardList(SqlSessionTemplate session, HashMap<String, Integer> map) {
		return session.selectList("board.list", map);
	}
	@Override
	public List<BoardDTO> boardListDetail(SqlSessionTemplate session, int id) {
		return session.selectList("board.listDetail", id);
	}
	@Override
	public int replyTotal(SqlSessionTemplate session, int id) {
		return session.selectOne("board.replyTotal", id);
	}
	@Override
	public List<BoardDTO> reply(SqlSessionTemplate session, int id) {
		return session.selectList("reply", id);
	}
	@Override
	public void writeReply(SqlSessionTemplate session, HashMap<Object, Object> map) {
		session.insert("board.writeReply", map);
	}
	@Override
	public void increaseViews(SqlSessionTemplate session, int id) {
		session.selectList("board.increaseViews", id);
	}
	@Override
	public void write(SqlSessionTemplate session, BoardDTO dto) {
		session.selectList("board.write", dto);
	}
	@Override
	public void update(SqlSessionTemplate session, BoardDTO dto) {
		session.selectList("board.update", dto);
	}
	@Override
	public void delete(SqlSessionTemplate session, int id) {
		session.selectList("board.delete", id);
	}

}

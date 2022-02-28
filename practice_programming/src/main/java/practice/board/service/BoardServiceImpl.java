package practice.board.service;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import practice.board.dao.BoardDAO;
import practice.board.dto.BoardDTO;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDAO dao;
	@Autowired
	SqlSessionTemplate session;
	
	@Override
	public int countList() {
		return dao.countList(session);
	}
	@Override
	public List<BoardDTO> boardList(HashMap<String, Integer> map) {
		return dao.boardList(session, map);
	}
	@Override
	public List<BoardDTO> boardListDetail(int id) {
		return dao.boardListDetail(session, id);
	}
	@Override
	public int replyTotal(int id) {
		return dao.replyTotal(session, id);
	}
	@Override
	public List<BoardDTO> reply(int id) {
		return dao.reply(session, id);
	}
	@Override
	public void writeReply(HashMap<Object, Object> map) {
		dao.writeReply(session, map);
	}
	@Override
	public void increaseViews(int id) {
		dao.increaseViews(session, id);
	}
	@Override
	public void write(BoardDTO dto) {
		dao.write(session, dto);
	}
	@Override
	public void update(BoardDTO dto) {
		dao.update(session, dto);
	}
	@Override
	public void delete(int id) {
		dao.delete(session, id);
	}

}

package practice.account.service;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import practice.account.dao.AccountDAO;
import practice.account.dto.AccountDTO;

@Service
public class AccountServiceImpl implements AccountService {

	@Autowired
	private AccountDAO dao;
	@Autowired
	SqlSessionTemplate session;
	
	@Override
	public String idCheck(String id) {
		return dao.idCheck(session, id);
	}
	@Override
	public void createAccount(AccountDTO dto) {
		dao.createAccount(session, dto);
	}
	@Override
	public String loginCheck(HashMap<String, String> map) {
		return dao.loginCheck(session, map);
	}
	@Override
	public int countList(String id) {
		return dao.countList(session, id);
	}
	@Override
	public List<AccountDTO> list(HashMap<Object, Object> map) {
		return dao.list(session, map);
	}
	@Override
	public long balanceCheck(String id) {
		return dao.balanceCheck(session,id);
	}
	@Override
	public void updateAccount(AccountDTO dto) {
		dao.updateAccount(session, dto);
	}

}

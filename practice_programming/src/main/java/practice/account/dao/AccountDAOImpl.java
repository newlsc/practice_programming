package practice.account.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import practice.account.dto.AccountDTO;


@Repository
public class AccountDAOImpl implements AccountDAO {

	@Override
	public String idCheck(SqlSessionTemplate session, String id) {
		return session.selectOne("account.idCheck", id);
	}
	@Override
	public void createAccount(SqlSessionTemplate session, AccountDTO dto) {
		session.insert("account.createAccount", dto);
		session.insert("account.logAccount", dto);
	}
	@Override
	public String loginCheck(SqlSessionTemplate session, HashMap<String, String> map) {
		return session.selectOne("account.loginCheck", map);
	}
	@Override
	public int countList(SqlSessionTemplate session, String id) {
		return session.selectOne("account.countList", id);
	}
	@Override
	public List<AccountDTO> list(SqlSessionTemplate session, HashMap<Object, Object> map) {
		return session.selectList("account.list", map);
	}
	@Override
	public long balanceCheck(SqlSessionTemplate session, String id) {
		return session.selectOne("account.balanceCheck", id);
	}
	@Override
	public void updateAccount(SqlSessionTemplate session, AccountDTO dto) {
		// 두 개 중 하나가 실패하면 롤백시키는 기능이 필요함
		session.update("account.updateAccountInfo", dto);
		session.insert("account.insertAccountLog", dto);
	}


}

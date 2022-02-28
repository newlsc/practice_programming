package practice.account.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import practice.account.dto.AccountDTO;

public interface AccountDAO {

	public String idCheck(SqlSessionTemplate session, String id);

	public void createAccount(SqlSessionTemplate session, AccountDTO dto);

	public String loginCheck(SqlSessionTemplate session, HashMap<String, String> map);

	public int countList(SqlSessionTemplate session, String id);
	
	public List<AccountDTO> list(SqlSessionTemplate session, HashMap<Object, Object> map);

	public long balanceCheck(SqlSessionTemplate session, String id);

	public void updateAccount(SqlSessionTemplate session, AccountDTO dto);


}

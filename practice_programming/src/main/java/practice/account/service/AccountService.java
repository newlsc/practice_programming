package practice.account.service;

import java.util.HashMap;
import java.util.List;

import practice.account.dto.AccountDTO;

public interface AccountService {

	public String idCheck(String id);

	public void createAccount(AccountDTO dto);

	public String loginCheck(HashMap<String, String> map);

	public int countList(String id);
	
	public List<AccountDTO> list(HashMap<Object, Object> map);

	public long balanceCheck(String id);

	public void updateAccount(AccountDTO dto);


}

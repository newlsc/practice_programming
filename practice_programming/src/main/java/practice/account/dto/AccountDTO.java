package practice.account.dto;

import java.util.Date;

import lombok.Data;

@Data
public class AccountDTO {

	private String id;
	private String pw;
	private String account_number;
	private String customer_name;
	private String contact_number;
	private long current_balance;
	private long balance;
	private Date created_date;
	private String type;
	private long amount;
	private String log_date;
	
}

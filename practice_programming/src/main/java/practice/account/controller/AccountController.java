package practice.account.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import practice.account.dto.AccountDTO;
import practice.account.service.AccountService;
import practice.page.util.PageUtil;

@Controller
@RequestMapping("/account/*")
public class AccountController {
	
	private static final Logger logger = LoggerFactory.getLogger("AccountController");
	
	@Autowired
	private AccountService service;
	
	@GetMapping("main.do")
	public String accountMain() {
		return "account/main";
	}
	@GetMapping("createForm.do")
	public String createForm() {
		return "account/createForm";
	}
	@PostMapping("idCheck.do")
	@ResponseBody
	public String idCheck(String id) {
		String result = service.idCheck(id);
		return result;
	}
	@PostMapping("createAccount.do")
	public String createAccount(AccountDTO dto) {
		service.createAccount(dto);
		logger.info("계좌가 개설되었습니다.");
		return "redirect:main.do";
	}
	@GetMapping("loginForm.do")
	public String lonin() {
		return "account/login";
	}
	@PostMapping("loginCheck.do")
	@ResponseBody
	public String loginCheck(String id, String pw) {
		HashMap<String, String> map = new HashMap<String, String>(); // map 선언
		map.put("id", id); // map 안에 값 넣기 
		map.put("pw", pw); // map 안에 값 넣기
		String result = service.loginCheck(map);
		if (result == null) {
			result = "unmatch";
		} else {
			result = "match";
		}
		return result;
	}
	@PostMapping("login.do")
	public String login(Model model, HttpSession session, String id, String pw) {
		session.setAttribute("id", id);
		logger.info("로그인 되었습니다.");
		return "account/main";
	}
	@GetMapping("logout.do")
	public String logout (HttpSession session) {
		session.invalidate();
		logger.info("로그아웃 되었습니다.");
		return "redirect:main.do";
	}
	
	@GetMapping("list.do")
	public String list(Model model, HttpSession session, @RequestParam (defaultValue = "1") int no) {
		String id = (String) session.getAttribute("id");
		// 정상적인 로그인으로 리스트 진입
		if (id != null && id.length() > 0) { 
			// 요청 번호 와 목록 수량 세팅
			PageUtil pageUtil = new PageUtil();
			pageUtil.setNo(no);
			pageUtil.setCountList(service.countList(id));
			// 요청한 목록 가져오기 - 부득이 object 사용
			HashMap<Object, Object> map = new HashMap<Object, Object>();
			map.put("id", id);
			map.put("postNum", pageUtil.getPostNum());
			map.put("displayPost", pageUtil.getDisplayPost());
			// 목록 가져오기
			model.addAttribute("list", service.list(map));
			// 페이징 처리 관련 전달 값
			model.addAttribute("pageUtil", pageUtil);
			// 현재 페이지
			model.addAttribute("currentPage", no);
		}
		return "account/list";
	}
	@GetMapping("useAccount.do")
	public String useAccount() {
		return "account/useAccountPopUp";
	}
	// 잔액으로 입출금 가능 확인
	@PostMapping("balanceCheck.do")
	@ResponseBody
	public String balanceCheck(String id, String type, long amount) {
		long current_balance = service.balanceCheck(id);
		String result = "unknown";
		System.out.println(current_balance);
		System.out.println(amount);
		if (type.equals("입금") && current_balance+amount >= 100000000) {
			result = "amountLimit";
			logger.info("잔액이 1억원을 초과하게 됩니다.");
		} else if (type.equals("출금") && current_balance-amount < 0) {
			result = "lackOfBalance";
			logger.info("잔액이 부족합니다.");
		} else {
			result = "tradeable";
		}
		return result;
	}
	@PostMapping("updateAccount.do")
	public String updateAccount(AccountDTO dto) {
		service.updateAccount(dto);
		return null;
	}
	
}

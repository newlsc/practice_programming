package practice.board.controller;


import java.util.HashMap;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import practice.board.dto.BoardDTO;
import practice.board.service.BoardService;
import practice.page.util.PageUtil;


@Controller
@RequestMapping("/board/*")
public class BoardController {
	
	@Autowired
	private BoardService service;
	
	private static final Logger logger = LoggerFactory.getLogger("BoardController"); // "BoardController는 변수명"
	
	@GetMapping("list.do")
	public String boardList(Model model, @RequestParam (defaultValue = "1") int no) {
		
		PageUtil pageUtil = new PageUtil();
		// 요청 번호 와 목록 수량 세팅
		pageUtil.setNo(no);
		pageUtil.setCountList(service.countList());
		// 요청한 목록 가져오기
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("postNum", pageUtil.getPostNum());
		map.put("displayPost", pageUtil.getDisplayPost());
		model.addAttribute("list", service.boardList(map));
		// 페이징 처리 관련 전달 값
		model.addAttribute("pageUtil", pageUtil);
		// 현재 페이지
		model.addAttribute("currentPage", no);
		
		return "board/list";
	}
	@GetMapping("listDetail.do")
	public String boardListDetail(Model model, int id, HttpServletRequest request, HttpServletResponse response) {
        
		Cookie viewCookie = null; // 비교하기 위해 새로운 쿠키
		Cookie[] cookies = request.getCookies();
		// 조회용 쿠키 존재 확인(조회용 쿠키가 있을 경우)
		if (cookies != null && cookies.length > 0) {
			for(int i = 0; i < cookies.length; i++) {
				if (cookies[i].getName().equals("viewNo"+id)) {
                    viewCookie = cookies[i];
				} 
			}
		}
		// 조회용 쿠키가 없을 경우
		if (viewCookie == null) {
			Cookie newCookie = new Cookie("viewNo"+id, "viewNo"+id); // 쿠키 생성(이름, 값)
			newCookie.setPath("/"); //모든 경로에서 접근 가능하도록 설정
			newCookie.setMaxAge(60*60*24); //쿠키 유효 기간: 하루로 설정(60초 * 60분 * 24시간)
			response.addCookie(newCookie); // response에 쿠키 추가
			service.increaseViews(id); // 조회수 1 증가
			logger.info("조회용 쿠키가 생성되었습니다.");
		} else {
            String value = viewCookie.getValue(); // 쿠키 값 받아옴.
            logger.info("조회용 쿠키가 이미 존재합니다."+ value);
        }
		model.addAttribute("detail", service.boardListDetail(id));
		model.addAttribute("replyTotal", service.replyTotal(id));
		model.addAttribute("reply", service.reply(id));
		return "board/listDetail";
	}
	// 댓글 기능
	@PostMapping("writeReply.do")
//	@ResponseBody
	public String writeReply(int id, String content) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		map.put("id", id);
		map.put("content", content);
		service.writeReply(map);
		return "redirect:listDetail.do?id="+id+"&justReplied";
	}
	@GetMapping("wirteForm.do")
	public String wirteForm() {
		return "board/write";
	}
	@PostMapping("write.do")
	public String write(BoardDTO dto) {
		// 앞 뒤 공백 제거 후 저장
		dto.setTitle(dto.getTitle().trim());
		dto.setContent(dto.getContent().trim());
		dto.setWriter(dto.getWriter().trim());
		service.write(dto);
		return "redirect:list.do";
	}
	@GetMapping("updateForm.do")
	public String updateForm(Model model, int id) {
		model.addAttribute("detail", service.boardListDetail(id));
		return "board/update";
	}
	@PostMapping("update.do")
	public String update(Model model, BoardDTO dto) {
		// 앞 뒤 공백 제거 후 저장
		dto.setTitle(dto.getTitle().trim());
		dto.setContent(dto.getContent().trim());
		dto.setWriter(dto.getWriter().trim());
		service.update(dto);
		return "redirect:list.do";
	}
	@GetMapping("delete.do")
	public String delete(int id) {
		service.delete(id);
		return "redirect:list.do";
	}
	

}

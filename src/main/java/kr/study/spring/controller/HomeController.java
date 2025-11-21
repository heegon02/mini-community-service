package kr.study.spring.controller;

import java.util.Map;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.study.spring.command.BCommand;
import kr.study.spring.command.BContentCommand;
import kr.study.spring.command.BDeleteCommand;
import kr.study.spring.command.BListCommand;
import kr.study.spring.command.BModifyCommand;
import kr.study.spring.command.BReply;
import kr.study.spring.command.BReplyUpdate;
import kr.study.spring.command.BWriteCommand;
import kr.study.spring.command.Command;
import kr.study.spring.command.EditProfile;
import kr.study.spring.command.EditProfileAction;
import kr.study.spring.command.JoinAction;
import kr.study.spring.command.LoginAction;

@Controller
public class HomeController {
	
	Command command = null;
	BCommand bcommand = null;
	
	//회원가입 페이지
	@RequestMapping("/join")
	public String join() {
		return "join";
	}
	
	//회원가입 처리 페이지
	@RequestMapping(value="/joinAction", method=RequestMethod.POST)
	public String joinAction(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		command = new JoinAction();
		command.execute(model);
		return "redirect:login";
	}
	
	//로그인 페이지
	@RequestMapping("/login")
	public String login() {
		return "login";
	}
	
	//로그인 처리 페이지
	@RequestMapping(value="/loginAction", method=RequestMethod.POST)
	public String loginAction(HttpServletRequest request, Model model) {
	    model.addAttribute("request", request);
	    command = new LoginAction();
	    command.execute(model);
	    
	    Map<String, Object> map = model.asMap();
	    Boolean loginResult = (Boolean) map.get("loginResult");
	    
	    if (loginResult != null && loginResult) {
	    	return "redirect:main";
	    } else {
	    	return "login";
	    }
	}

	//메인 페이지
	@RequestMapping("/main")
	public String main(HttpServletRequest request, Model model) {
	    if (request.getSession().getAttribute("userId") == null) {
	    	return "redirect:login";
	    }
	    BCommand bcommand = new BListCommand();
	    bcommand.execute(model);
	    
	    return "main";
	}

	//로그아웃 처리 페이지
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request) {
		request.getSession().invalidate();
		return "redirect:login";
	}
	
	//개인정보 수정 화면 페이지
	@RequestMapping("/editProfile")
	public String editProfile(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		command = new EditProfile();
		command.execute(model);
		
		return "editProfile";
	}
	
	//개인정보 실제 수정 로직 페이지
	@RequestMapping(value="/editProfileAction", method=RequestMethod.POST)
	public String editProfileAction(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		command = new EditProfileAction();
		command.execute(model);
		
		return "redirect:main";
	}
	
		
		
		//글 작성 초기 화면
		@RequestMapping("/write_view")
		public String write_view() {
			return "write_view";
		}
		
		//글 작성
		@RequestMapping("/write")
		public String write(HttpServletRequest request, Model model) {
			model.addAttribute("request", request);
			bcommand = new BWriteCommand();
			bcommand.execute(model);
			
			return "redirect:main";
		}
		
		//글 내용 보여주기
		@RequestMapping("/content_view")
		public String content_view(HttpServletRequest request, Model model) {
			model.addAttribute("request", request);
			bcommand = new BContentCommand();
			bcommand.execute(model);
			
			return "content_view";
		}
		
		//수정
		@RequestMapping(value="/modify", method=RequestMethod.POST)
		public String modify(HttpServletRequest request, Model model) {
			model.addAttribute("request", request);
			bcommand = new BModifyCommand();
			bcommand.execute(model);
			
			return "redirect:main";
		}
		
		//글 삭제
		@RequestMapping("/delete")
		public String delete(HttpServletRequest request, Model model) {
			model.addAttribute("request", request);
			bcommand = new BDeleteCommand();
			bcommand.execute(model);
			
			return "redirect:main";
		}
		
		//댓글 작성을 위한 뷰페이지
		@RequestMapping("/reply_view")
		public String reply_view(HttpServletRequest request, Model model) {
			model.addAttribute("request", request);
			bcommand = new BReply();
			bcommand.execute(model);
			
			return "reply_view";
		}
		
		//댓글 업데이트
	    @RequestMapping(value="/reply", method=RequestMethod.POST)
		public String reply(HttpServletRequest request, Model model) {
			model.addAttribute("request", request);
			bcommand = new BReplyUpdate();
			bcommand.execute(model);
			
			return "redirect:main";
		}
	
}

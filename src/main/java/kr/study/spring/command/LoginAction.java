package kr.study.spring.command;

import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import kr.study.spring.dao.Dao;

public class LoginAction implements Command {

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		
		String userId = request.getParameter("userId");
		String password = request.getParameter("password");
		
		Dao dao = new Dao();
		boolean result = dao.loginAction(userId, password);
		
		if(result) {
			HttpSession session = request.getSession();
			session.setAttribute("userId", userId);
			
			String name = dao.getName(userId);
			session.setAttribute("name", name);
		}
		
		model.addAttribute("loginResult", result);
	}
}

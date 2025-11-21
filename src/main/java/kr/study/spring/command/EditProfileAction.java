package kr.study.spring.command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import kr.study.spring.dao.Dao;

public class EditProfileAction implements Command {
	
	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
        HttpServletRequest request = (HttpServletRequest) map.get("request");

        String userId = request.getParameter("userId");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String detailAddress = request.getParameter("detailAddress");

        String[] interests = request.getParameterValues("interest");
        String interest = (interests != null) ? String.join(",", interests) : "";

        String introduce = request.getParameter("introduce");

        Dao dao = new Dao();
        dao.updateProfile(userId, password, email, name, address, detailAddress, interest, introduce);
	}

}

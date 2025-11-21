package kr.study.spring.command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import kr.study.spring.dao.Dao;
import kr.study.spring.dto.Dto;

public class EditProfile implements Command {
    @Override
    public void execute(Model model) {
        Map<String, Object> map = model.asMap();
        HttpServletRequest request = (HttpServletRequest) map.get("request");
        
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");
        Dao dao = new Dao();
        Dto dto = dao.editProfile(userId);
        model.addAttribute("editProfile", dto);
    }
}

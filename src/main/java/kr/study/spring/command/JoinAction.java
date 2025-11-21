package kr.study.spring.command;

import java.sql.Date;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.ui.Model;

import kr.study.spring.dao.Dao;

public class JoinAction implements Command {
	
	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		
		//join.jsp 에서 입력한 회원정보 내용들 getParameter로 일단 가져옴. 
		String userId = request.getParameter("userId");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String name = request.getParameter("name");
		String residentNumber = request.getParameter("residentNumber");
		String address = request.getParameter("address"); 
		String detailAddress = request.getParameter("detailAddress");
		String introduce = request.getParameter("introduce");
		
		//생년월일 부분은 년, 월, 일이 따로 존재하기 때문에 나뉘어져 있는 걸 birth 변수에 담아준다. 
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String day = request.getParameter("day");
		
		String month2 = month.length() == 1 ? "0" + month : month;
        String day2   = day.length() == 1 ? "0" + day : day;
        String birthStr = year + "-" + month2 + "-" + day2;
        Date birth = Date.valueOf(birthStr);
		
        //관심분야는 배열로 처리
        String[] interests = request.getParameterValues("interest");
        String interest = "";
        if (interests != null) {
        	interest = String.join(",", interests);
        }
        
		Dao dao = new Dao();
		dao.joinAction(userId, password, email, name, residentNumber, address, detailAddress, birth, interest, introduce);
	}
}

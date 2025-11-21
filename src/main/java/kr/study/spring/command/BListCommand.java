package kr.study.spring.command;

import java.util.ArrayList;

import org.springframework.ui.Model;

import kr.study.spring.dao.BDao;
import kr.study.spring.dto.BDto;

public class BListCommand implements BCommand {

	@Override
	public void execute(Model model) {
		BDao dao = new BDao();
		ArrayList<BDto> dtos = dao.list();
		model.addAttribute("list", dtos);
	}
}

package kr.study.spring.command;

import org.springframework.ui.Model;

public interface BCommand {

	//DB거쳐야 하는 페이지들은 전부 execute를 통해서 이루어지게. 
	void execute(Model model);
}

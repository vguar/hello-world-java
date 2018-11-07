package hello;

import java.net.InetAddress;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class IndexController {

	private String hostname;

	@Value( "${spring.application.version:v1.0.0}")
	private String version;

	public IndexController() throws Exception {
		hostname = InetAddress.getLocalHost().getHostName();
	}

    @RequestMapping("/")
    public String greeting(Model model) throws Exception{

        model.addAttribute("hostname", this.hostname);
        model.addAttribute("version", version);

        return "index";
    }

}


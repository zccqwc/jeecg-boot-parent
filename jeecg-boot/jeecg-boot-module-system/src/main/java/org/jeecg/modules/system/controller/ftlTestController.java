package org.jeecg.modules.system.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/test")
public class ftlTestController {

    @RequestMapping("/freemarker")
    public String TestFtl(){
        System.out.print("进入控制器");
    return "bigscreen/template1/province";

    }

}

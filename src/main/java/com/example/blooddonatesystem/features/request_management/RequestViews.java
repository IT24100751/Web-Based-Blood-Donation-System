package com.example.blooddonatesystem.features.request_management;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class RequestViews {
    @GetMapping("/request")
    public String requestBlood(){
        return "request_management/request_management_request";
    }


    @GetMapping("/request-management")
    public String requestManagement(){
        return "request_management/request_management";
    }
}

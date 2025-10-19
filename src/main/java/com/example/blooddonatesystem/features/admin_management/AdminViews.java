package com.example.blooddonatesystem.features.admin_management;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminViews {

    @GetMapping("/")
    public String index(){
        return "index";
    }

    @GetMapping("/admin-login")
    public String adminLogin(){
        return "admin_management/login";
    }
    @GetMapping("/dashboard")
    public String dashboard(){
        return "admin_management/dashboard";
    }
    @GetMapping("/admin-management")
    public String adminManagement(){
        return "admin_management/admin_management";
    }

}

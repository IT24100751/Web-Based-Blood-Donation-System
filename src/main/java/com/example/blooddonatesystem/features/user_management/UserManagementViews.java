package com.example.blooddonatesystem.features.user_management;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserManagementViews {

    @GetMapping("/user-management")
    public String userManagement(){
        return "user_management/user_management";
    }

    @GetMapping("/login")
    public String login(){
        return "user_management/login";
    }

    @GetMapping("/register")
    public String register(){
        return "user_management/register";
    }

    @GetMapping("/user-profile")
    public String profile(){
        return "user_management/user_profile";
    }
}

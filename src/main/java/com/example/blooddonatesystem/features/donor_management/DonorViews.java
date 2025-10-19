package com.example.blooddonatesystem.features.donor_management;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DonorViews {
    @GetMapping("/donor-login")
    public String donorLogin(){
        return "donor_management/donor_login";
    }

    @GetMapping("/donor-register")
    public String donorRegister(){
        return "donor_management/donor_register";
    }

    @GetMapping("/donor-management")
    public String donorManagement(){
        return "donor_management/donor_management";
    }

    @GetMapping("/profile")
    public String donorProfile(){
        return "donor_management/donor_profile";
    }

    @GetMapping("/donor-dashboard")
    public String donorDashboard(){
        return "donor_management/donor_dashboard";
    }
}

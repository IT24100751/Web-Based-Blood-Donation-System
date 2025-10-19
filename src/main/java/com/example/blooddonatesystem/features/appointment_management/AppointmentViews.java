package com.example.blooddonatesystem.features.appointment_management;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AppointmentViews {
    @GetMapping("/appointment-management-donor")
    public String appointmentManagementDonor(){
        return "appointment_management/appointment_management_donor";
    }

    @GetMapping("/appointment-management")
    public String appointmentManagementAdmin(){
        return "appointment_management/appointment_management";
    }
}

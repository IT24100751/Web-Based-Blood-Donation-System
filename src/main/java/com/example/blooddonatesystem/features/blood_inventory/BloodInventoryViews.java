package com.example.blooddonatesystem.features.blood_inventory;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BloodInventoryViews {
    @GetMapping("/blood-inventory-management")
    public  String bloodInventoryManagement(){
        return "blood_inventory_management/blood_inventory_management";
    }
}

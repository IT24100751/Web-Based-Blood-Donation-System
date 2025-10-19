package com.example.blooddonatesystem.features.blood_inventory;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface BloodInventoryRepository extends JpaRepository<BloodInventoryModel, Long> {
    
    // Find inventory by blood type
    List<BloodInventoryModel> findByBloodType(String bloodType);
    
    // Find inventory items that are expiring soon (before a given date)
    List<BloodInventoryModel> findByExpiryDateBefore(LocalDate date);
    
    // Find inventory by blood type and with stock amount greater than specified value
    List<BloodInventoryModel> findByBloodTypeAndInstockAmountGreaterThan(String bloodType, Integer minAmount);
}
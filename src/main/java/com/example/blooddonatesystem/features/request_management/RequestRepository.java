package com.example.blooddonatesystem.features.request_management;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface RequestRepository extends JpaRepository<RequestModel, Long> {
    
    // Find requests by user ID
    List<RequestModel> findByUserId(Long userId);
    
    // Find requests by blood type
    List<RequestModel> findByBloodType(String bloodType);
    
    // Find requests by urgency
    List<RequestModel> findByUrgency(String urgency);
    
    // Find requests by status
    List<RequestModel> findByStatus(String status);
    
    // Find requests by user ID and status
    List<RequestModel> findByUserIdAndStatus(Long userId, String status);
    
    // Find requests by blood type and urgency
    List<RequestModel> findByBloodTypeAndUrgency(String bloodType, String urgency);
    
    // Count requests by blood type
    Long countByBloodType(String bloodType);
    
    // Count requests by urgency
    Long countByUrgency(String urgency);
}
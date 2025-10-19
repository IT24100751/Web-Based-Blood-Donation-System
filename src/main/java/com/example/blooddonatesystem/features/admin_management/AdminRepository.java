package com.example.blooddonatesystem.features.admin_management;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface AdminRepository extends JpaRepository<AdminModel, Long> {
    
    // Find admin by email
    Optional<AdminModel> findByEmail(String email);
    
    // Find admin by adminId
    Optional<AdminModel> findByAdminId(String adminId);
    
    // Check if admin exists by email
    boolean existsByEmail(String email);
    
    // Check if admin exists by adminId
    boolean existsByAdminId(String adminId);
    
    // Count total admins (for generating next admin ID)
    long count();
}
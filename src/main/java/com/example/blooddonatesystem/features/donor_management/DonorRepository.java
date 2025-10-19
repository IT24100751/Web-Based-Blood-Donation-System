package com.example.blooddonatesystem.features.donor_management;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface DonorRepository extends JpaRepository<DonorModel, Long> {
    
    // Find donor by email
    Optional<DonorModel> findByEmail(String email);
    
    // Find donor by email and not deleted
    Optional<DonorModel> findByEmailAndDeleteStatusFalse(String email);
    
    // Find all non-deleted donors
    @Query("SELECT d FROM DonorModel d WHERE d.deleteStatus = false")
    List<DonorModel> findAllNonDeleted();
    
    // Find donors by blood type and not deleted
    List<DonorModel> findByBloodTypeAndDeleteStatusFalse(String bloodType);
}
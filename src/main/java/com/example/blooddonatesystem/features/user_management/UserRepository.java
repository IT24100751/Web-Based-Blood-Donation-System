package com.example.blooddonatesystem.features.user_management;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<UserModel, Long> {
    // Find user by email
    Optional<UserModel> findByEmail(String email);
    
    // Find all non-deleted users
    List<UserModel> findByDeleteStatusFalse();
    
    // Find user by email and non-deleted status
    Optional<UserModel> findByEmailAndDeleteStatusFalse(String email);
}

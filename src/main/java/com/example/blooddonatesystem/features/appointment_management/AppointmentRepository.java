package com.example.blooddonatesystem.features.appointment_management;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface AppointmentRepository extends JpaRepository<AppointmentModel, Long> {
    
    // Find appointments by donor ID
    List<AppointmentModel> findByDonorId(Long donorId);
    
    // Find appointments by status
    List<AppointmentModel> findByStatus(String status);
    
    // Find appointments by date range
    List<AppointmentModel> findByAppointmentDateBetween(LocalDateTime startDate, LocalDateTime endDate);
    
    // Find appointments by donor ID and status
    List<AppointmentModel> findByDonorIdAndStatus(Long donorId, String status);
    
    // Find upcoming appointments (after current date)
    List<AppointmentModel> findByAppointmentDateAfterOrderByAppointmentDateAsc(LocalDateTime currentDate);
}
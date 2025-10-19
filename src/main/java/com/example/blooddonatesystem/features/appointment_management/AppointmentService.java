package com.example.blooddonatesystem.features.appointment_management;

import com.example.blooddonatesystem.features.donor_management.DonorModel;
import com.example.blooddonatesystem.features.donor_management.DonorRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class AppointmentService {

    private static final Logger logger = LoggerFactory.getLogger(AppointmentService.class);
    
    private final AppointmentRepository appointmentRepository;
    private final DonorRepository donorRepository;
    
    @Autowired
    public AppointmentService(AppointmentRepository appointmentRepository, DonorRepository donorRepository) {
        this.appointmentRepository = appointmentRepository;
        this.donorRepository = donorRepository;
    }
    
    // Get all appointments
    public List<AppointmentDTOS.GetAppointmentDTO> getAllAppointments() {
        try {
            List<AppointmentModel> appointments = appointmentRepository.findAll();
            return appointments.stream()
                    .map(AppointmentDTOS.GetAppointmentDTO::new)
                    .collect(Collectors.toList());
        } catch (Exception e) {
            logger.error("Error retrieving all appointments", e);
            throw new RuntimeException("Failed to retrieve appointments: " + e.getMessage());
        }
    }
    
    // Get appointment by ID
    public AppointmentDTOS.GetAppointmentDTO getAppointmentById(Long id) {
        try {
            AppointmentModel appointment = appointmentRepository.findById(id)
                    .orElseThrow(() -> new RuntimeException("Appointment not found with ID: " + id));
            return new AppointmentDTOS.GetAppointmentDTO(appointment);
        } catch (Exception e) {
            logger.error("Error retrieving appointment with ID: {}", id, e);
            throw new RuntimeException(e.getMessage());
        }
    }
    
    // Create new appointment
    public AppointmentDTOS.GetAppointmentDTO createAppointment(AppointmentDTOS.CreateAppointmentDTO createDTO) {
        try {
            DonorModel donor = donorRepository.findById(createDTO.getDonorId())
                    .orElseThrow(() -> new RuntimeException("Donor not found with ID: " + createDTO.getDonorId()));
            
            AppointmentModel appointment = createDTO.toAppointmentModel(donor);
            donor.addAppointment(appointment);
            
            AppointmentModel savedAppointment = appointmentRepository.save(appointment);
            return new AppointmentDTOS.GetAppointmentDTO(savedAppointment);
        } catch (Exception e) {
            logger.error("Error creating appointment", e);
            throw new RuntimeException("Failed to create appointment: " + e.getMessage());
        }
    }
    
    // Update appointment
    public AppointmentDTOS.GetAppointmentDTO updateAppointment(Long id, AppointmentDTOS.UpdateAppointmentDTO updateDTO) {
        try {
            AppointmentModel appointment = appointmentRepository.findById(id)
                    .orElseThrow(() -> new RuntimeException("Appointment not found with ID: " + id));
            
            updateDTO.updateAppointmentModel(appointment);
            AppointmentModel updatedAppointment = appointmentRepository.save(appointment);
            return new AppointmentDTOS.GetAppointmentDTO(updatedAppointment);
        } catch (Exception e) {
            logger.error("Error updating appointment with ID: {}", id, e);
            throw new RuntimeException(e.getMessage());
        }
    }
    
    // Delete appointment
    public void deleteAppointment(Long id) {
        try {
            AppointmentModel appointment = appointmentRepository.findById(id)
                    .orElseThrow(() -> new RuntimeException("Appointment not found with ID: " + id));
            
            appointmentRepository.delete(appointment);
        } catch (Exception e) {
            logger.error("Error deleting appointment with ID: {}", id, e);
            throw new RuntimeException(e.getMessage());
        }
    }
    
    // Get appointments by donor ID
    public List<AppointmentDTOS.GetAppointmentDTO> getAppointmentsByDonorId(Long donorId) {
        try {
            List<AppointmentModel> appointments = appointmentRepository.findByDonorId(donorId);
            return appointments.stream()
                    .map(AppointmentDTOS.GetAppointmentDTO::new)
                    .collect(Collectors.toList());
        } catch (Exception e) {
            logger.error("Error retrieving appointments for donor ID: {}", donorId, e);
            throw new RuntimeException("Failed to retrieve appointments: " + e.getMessage());
        }
    }
    
    // Get appointments by status
    public List<AppointmentDTOS.GetAppointmentDTO> getAppointmentsByStatus(String status) {
        try {
            List<AppointmentModel> appointments = appointmentRepository.findByStatus(status);
            return appointments.stream()
                    .map(AppointmentDTOS.GetAppointmentDTO::new)
                    .collect(Collectors.toList());
        } catch (Exception e) {
            logger.error("Error retrieving appointments with status: {}", status, e);
            throw new RuntimeException("Failed to retrieve appointments: " + e.getMessage());
        }
    }
    
    // Get upcoming appointments
    public List<AppointmentDTOS.GetAppointmentDTO> getUpcomingAppointments() {
        try {
            List<AppointmentModel> appointments = appointmentRepository
                    .findByAppointmentDateAfterOrderByAppointmentDateAsc(LocalDateTime.now());
            return appointments.stream()
                    .map(AppointmentDTOS.GetAppointmentDTO::new)
                    .collect(Collectors.toList());
        } catch (Exception e) {
            logger.error("Error retrieving upcoming appointments", e);
            throw new RuntimeException("Failed to retrieve upcoming appointments: " + e.getMessage());
        }
    }
}
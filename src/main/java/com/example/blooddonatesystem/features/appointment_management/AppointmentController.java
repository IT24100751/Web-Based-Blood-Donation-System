package com.example.blooddonatesystem.features.appointment_management;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/appointments")
public class AppointmentController {

    private static final Logger logger = LoggerFactory.getLogger(AppointmentController.class);
    
    private final AppointmentService appointmentService;
    
    @Autowired
    public AppointmentController(AppointmentService appointmentService) {
        this.appointmentService = appointmentService;
    }
    
    // Get all appointments
    @GetMapping
    public ResponseEntity<?> getAllAppointments() {
        try {
            List<AppointmentDTOS.GetAppointmentDTO> appointments = appointmentService.getAllAppointments();
            return ResponseEntity.ok(appointments);
        } catch (Exception e) {
            logger.error("Error retrieving all appointments", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Failed to retrieve appointments: " + e.getMessage());
        }
    }
    
    // Get appointment by ID
    @GetMapping("/{id}")
    public ResponseEntity<?> getAppointmentById(@PathVariable Long id) {
        try {
            AppointmentDTOS.GetAppointmentDTO appointment = appointmentService.getAppointmentById(id);
            return ResponseEntity.ok(appointment);
        } catch (RuntimeException e) {
            if (e.getMessage().contains("not found")) {
                logger.error("Appointment not found with ID: {}", id);
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body("Appointment not found with ID: " + id);
            }
            logger.error("Error retrieving appointment with ID: {}", id, e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Failed to retrieve appointment: " + e.getMessage());
        }
    }
    
    // Create new appointment
    @PostMapping
    public ResponseEntity<?> createAppointment(@RequestBody AppointmentDTOS.CreateAppointmentDTO createDTO) {
        try {
            AppointmentDTOS.GetAppointmentDTO createdAppointment = appointmentService.createAppointment(createDTO);
            return ResponseEntity.status(HttpStatus.CREATED).body(createdAppointment);
        } catch (RuntimeException e) {
            if (e.getMessage().contains("Donor not found")) {
                logger.error("Donor not found with ID: {}", createDTO.getDonorId());
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body(e.getMessage());
            }
            logger.error("Error creating appointment", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Failed to create appointment: " + e.getMessage());
        }
    }
    
    // Update appointment
    @PutMapping("/{id}")
    public ResponseEntity<?> updateAppointment(@PathVariable Long id, @RequestBody AppointmentDTOS.UpdateAppointmentDTO updateDTO) {
        try {
            AppointmentDTOS.GetAppointmentDTO updatedAppointment = appointmentService.updateAppointment(id, updateDTO);
            return ResponseEntity.ok(updatedAppointment);
        } catch (RuntimeException e) {
            if (e.getMessage().contains("not found")) {
                logger.error("Appointment not found with ID: {}", id);
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body("Appointment not found with ID: " + id);
            }
            logger.error("Error updating appointment with ID: {}", id, e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Failed to update appointment: " + e.getMessage());
        }
    }
    
    // Delete appointment
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteAppointment(@PathVariable Long id) {
        try {
            appointmentService.deleteAppointment(id);
            return ResponseEntity.ok("Appointment deleted successfully");
        } catch (RuntimeException e) {
            if (e.getMessage().contains("not found")) {
                logger.error("Appointment not found with ID: {}", id);
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body("Appointment not found with ID: " + id);
            }
            logger.error("Error deleting appointment with ID: {}", id, e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Failed to delete appointment: " + e.getMessage());
        }
    }
    
    // Get appointments by donor ID
    @GetMapping("/donor/{donorId}")
    public ResponseEntity<?> getAppointmentsByDonorId(@PathVariable Long donorId) {
        try {
            List<AppointmentDTOS.GetAppointmentDTO> appointments = appointmentService.getAppointmentsByDonorId(donorId);
            return ResponseEntity.ok(appointments);
        } catch (Exception e) {
            logger.error("Error retrieving appointments for donor ID: {}", donorId, e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Failed to retrieve appointments: " + e.getMessage());
        }
    }
    
    // Get appointments by status
    @GetMapping("/status/{status}")
    public ResponseEntity<?> getAppointmentsByStatus(@PathVariable String status) {
        try {
            List<AppointmentDTOS.GetAppointmentDTO> appointments = appointmentService.getAppointmentsByStatus(status);
            return ResponseEntity.ok(appointments);
        } catch (Exception e) {
            logger.error("Error retrieving appointments with status: {}", status, e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Failed to retrieve appointments: " + e.getMessage());
        }
    }
    
    // Get upcoming appointments
    @GetMapping("/upcoming")
    public ResponseEntity<?> getUpcomingAppointments() {
        try {
            List<AppointmentDTOS.GetAppointmentDTO> appointments = appointmentService.getUpcomingAppointments();
            return ResponseEntity.ok(appointments);
        } catch (Exception e) {
            logger.error("Error retrieving upcoming appointments", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Failed to retrieve upcoming appointments: " + e.getMessage());
        }
    }
}
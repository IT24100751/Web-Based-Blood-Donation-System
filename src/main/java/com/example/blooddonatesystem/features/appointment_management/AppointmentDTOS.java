package com.example.blooddonatesystem.features.appointment_management;

import com.example.blooddonatesystem.features.donor_management.DonorModel;
import java.time.LocalDateTime;

public class AppointmentDTOS {

    // DTO for retrieving appointment data
    public static class GetAppointmentDTO {
        private Long id;
        private LocalDateTime appointmentDate;
        private Long donorId;
        private String donorName;
        private String donorEmail;
        private String status;
        private String message;
        private LocalDateTime createdAt;
        private LocalDateTime updatedAt;

        public GetAppointmentDTO() {
        }

        public GetAppointmentDTO(AppointmentModel appointment) {
            this.id = appointment.getId();
            this.appointmentDate = appointment.getAppointmentDate();
            this.donorId = appointment.getDonor().getId();
            this.donorName = appointment.getDonor().getFirstName() + " " + appointment.getDonor().getLastName();
            this.donorEmail = appointment.getDonor().getEmail();
            this.status = appointment.getStatus();
            this.message = appointment.getMessage();
            this.createdAt = appointment.getCreatedAt();
            this.updatedAt = appointment.getUpdatedAt();
        }

        // Getters and Setters
        public Long getId() {
            return id;
        }

        public void setId(Long id) {
            this.id = id;
        }

        public LocalDateTime getAppointmentDate() {
            return appointmentDate;
        }

        public void setAppointmentDate(LocalDateTime appointmentDate) {
            this.appointmentDate = appointmentDate;
        }

        public Long getDonorId() {
            return donorId;
        }

        public void setDonorId(Long donorId) {
            this.donorId = donorId;
        }

        public String getDonorName() {
            return donorName;
        }

        public void setDonorName(String donorName) {
            this.donorName = donorName;
        }

        public String getDonorEmail() {
            return donorEmail;
        }

        public void setDonorEmail(String donorEmail) {
            this.donorEmail = donorEmail;
        }

        public String getStatus() {
            return status;
        }

        public void setStatus(String status) {
            this.status = status;
        }

        public String getMessage() {
            return message;
        }

        public void setMessage(String message) {
            this.message = message;
        }

        public LocalDateTime getCreatedAt() {
            return createdAt;
        }

        public void setCreatedAt(LocalDateTime createdAt) {
            this.createdAt = createdAt;
        }

        public LocalDateTime getUpdatedAt() {
            return updatedAt;
        }

        public void setUpdatedAt(LocalDateTime updatedAt) {
            this.updatedAt = updatedAt;
        }
    }

    // DTO for creating a new appointment
    public static class CreateAppointmentDTO {
        private LocalDateTime appointmentDate;
        private Long donorId;
        private String status;
        private String message;

        public CreateAppointmentDTO() {
        }

        public CreateAppointmentDTO(LocalDateTime appointmentDate, Long donorId, String status, String message) {
            this.appointmentDate = appointmentDate;
            this.donorId = donorId;
            this.status = status;
            this.message = message;
        }

        public AppointmentModel toAppointmentModel(DonorModel donor) {
            return new AppointmentModel(appointmentDate, donor, status, message);
        }

        // Getters and Setters
        public LocalDateTime getAppointmentDate() {
            return appointmentDate;
        }

        public void setAppointmentDate(LocalDateTime appointmentDate) {
            this.appointmentDate = appointmentDate;
        }

        public Long getDonorId() {
            return donorId;
        }

        public void setDonorId(Long donorId) {
            this.donorId = donorId;
        }

        public String getStatus() {
            return status;
        }

        public void setStatus(String status) {
            this.status = status;
        }

        public String getMessage() {
            return message;
        }

        public void setMessage(String message) {
            this.message = message;
        }
    }

    // DTO for updating an existing appointment
    public static class UpdateAppointmentDTO {
        private LocalDateTime appointmentDate;
        private String status;
        private String message;

        public UpdateAppointmentDTO() {
        }

        public UpdateAppointmentDTO(LocalDateTime appointmentDate, String status, String message) {
            this.appointmentDate = appointmentDate;
            this.status = status;
            this.message = message;
        }

        public void updateAppointmentModel(AppointmentModel appointment) {
            if (appointmentDate != null) {
                appointment.setAppointmentDate(appointmentDate);
            }
            if (status != null) {
                appointment.setStatus(status);
            }
            if (message != null) {
                appointment.setMessage(message);
            }
            appointment.setUpdatedAt(LocalDateTime.now());
        }

        // Getters and Setters
        public LocalDateTime getAppointmentDate() {
            return appointmentDate;
        }

        public void setAppointmentDate(LocalDateTime appointmentDate) {
            this.appointmentDate = appointmentDate;
        }

        public String getStatus() {
            return status;
        }

        public void setStatus(String status) {
            this.status = status;
        }

        public String getMessage() {
            return message;
        }

        public void setMessage(String message) {
            this.message = message;
        }
    }
}
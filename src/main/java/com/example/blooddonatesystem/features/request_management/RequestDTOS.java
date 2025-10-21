package com.example.blooddonatesystem.features.request_management;

import com.example.blooddonatesystem.features.user_management.UserModel;
import java.time.LocalDateTime;


public class RequestDTOS {

    // DTO for retrieving request data
    public static class GetRequestDTO {
        private Long id;
        private Long userId;
        private String userName;
        private String bloodType;
        private Integer units;
        private String urgency;
        private String status;
        private LocalDateTime createdAt;
        private LocalDateTime updatedAt;

        // Default constructor
        public GetRequestDTO() {
        }

        // Constructor from RequestModel
        public GetRequestDTO(RequestModel request) {
            this.id = request.getId();
            this.userId = request.getUser().getId();
            this.userName = request.getUser().getFirstName() + " " + request.getUser().getLastName();
            this.bloodType = request.getBloodType();
            this.units = request.getUnits();
            this.urgency = request.getUrgency();
            this.status = request.getStatus();
            this.createdAt = request.getCreatedAt();
            this.updatedAt = request.getUpdatedAt();
        }

        // Getters and Setters
        public Long getId() {
            return id;
        }

        public void setId(Long id) {
            this.id = id;
        }

        public Long getUserId() {
            return userId;
        }

        public void setUserId(Long userId) {
            this.userId = userId;
        }

        public String getUserName() {
            return userName;
        }

        public void setUserName(String userName) {
            this.userName = userName;
        }

        public String getBloodType() {
            return bloodType;
        }

        public void setBloodType(String bloodType) {
            this.bloodType = bloodType;
        }

        public Integer getUnits() {
            return units;
        }

        public void setUnits(Integer units) {
            this.units = units;
        }

        public String getUrgency() {
            return urgency;
        }

        public void setUrgency(String urgency) {
            this.urgency = urgency;
        }

        public String getStatus() {
            return status;
        }

        public void setStatus(String status) {
            this.status = status;
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

    // DTO for creating a new request
    public static class CreateRequestDTO {
        private Long userId;
        private String bloodType;
        private Integer units;
        private String urgency;

        // Default constructor
        public CreateRequestDTO() {
        }

        // Constructor with fields
        public CreateRequestDTO(Long userId, String bloodType, Integer units, String urgency) {
            this.userId = userId;
            this.bloodType = bloodType;
            this.units = units;
            this.urgency = urgency;
        }

        // Convert to RequestModel
        public RequestModel toRequestModel(UserModel user) {
            return new RequestModel(user, this.bloodType, this.units, this.urgency);
        }

        // Getters and Setters
        public Long getUserId() {
            return userId;
        }

        public void setUserId(Long userId) {
            this.userId = userId;
        }

        public String getBloodType() {
            return bloodType;
        }

        public void setBloodType(String bloodType) {
            this.bloodType = bloodType;
        }

        public Integer getUnits() {
            return units;
        }

        public void setUnits(Integer units) {
            this.units = units;
        }

        public String getUrgency() {
            return urgency;
        }

        public void setUrgency(String urgency) {
            this.urgency = urgency;
        }
    }

    // DTO for updating an existing request
    public static class UpdateRequestDTO {
        private String bloodType;
        private Integer units;
        private String urgency;
        private String status;

        // Default constructor
        public UpdateRequestDTO() {
        }

        // Constructor with fields
        public UpdateRequestDTO(String bloodType, Integer units, String urgency, String status) {
            this.bloodType = bloodType;
            this.units = units;
            this.urgency = urgency;
            this.status = status;
        }

        // Update RequestModel
        public void updateRequestModel(RequestModel request) {
            if (this.bloodType != null) {
                request.setBloodType(this.bloodType);
            }
            if (this.units != null) {
                request.setUnits(this.units);
            }
            if (this.urgency != null) {
                request.setUrgency(this.urgency);
            }
            if (this.status != null) {
                request.setStatus(this.status);
            }
        }

        // Getters and Setters
        public String getBloodType() {
            return bloodType;
        }

        public void setBloodType(String bloodType) {
            this.bloodType = bloodType;
        }

        public Integer getUnits() {
            return units;
        }

        public void setUnits(Integer units) {
            this.units = units;
        }

        public String getUrgency() {
            return urgency;
        }

        public void setUrgency(String urgency) {
            this.urgency = urgency;
        }

        public String getStatus() {
            return status;
        }

        public void setStatus(String status) {
            this.status = status;
        }
    }
}
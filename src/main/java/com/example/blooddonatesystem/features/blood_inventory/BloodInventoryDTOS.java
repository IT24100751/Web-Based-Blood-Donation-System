package com.example.blooddonatesystem.features.blood_inventory;

import java.time.LocalDate;

public class BloodInventoryDTOS {

    // DTO for retrieving blood inventory data
    public static class GetBloodInventoryDTO {
        private Long id;
        private String bloodType;
        private Integer instockAmount;
        private LocalDate expiryDate;

        public GetBloodInventoryDTO() {
        }

        public GetBloodInventoryDTO(Long id, String bloodType, Integer instockAmount, LocalDate expiryDate) {
            this.id = id;
            this.bloodType = bloodType;
            this.instockAmount = instockAmount;
            this.expiryDate = expiryDate;
        }

        // Static method to convert from model to DTO
        public static GetBloodInventoryDTO fromModel(BloodInventoryModel model) {
            return new GetBloodInventoryDTO(
                    model.getId(),
                    model.getBloodType(),
                    model.getInstockAmount(),
                    model.getExpiryDate()
            );
        }

        // Getters and Setters
        public Long getId() {
            return id;
        }

        public void setId(Long id) {
            this.id = id;
        }

        public String getBloodType() {
            return bloodType;
        }

        public void setBloodType(String bloodType) {
            this.bloodType = bloodType;
        }

        public Integer getInstockAmount() {
            return instockAmount;
        }

        public void setInstockAmount(Integer instockAmount) {
            this.instockAmount = instockAmount;
        }

        public LocalDate getExpiryDate() {
            return expiryDate;
        }

        public void setExpiryDate(LocalDate expiryDate) {
            this.expiryDate = expiryDate;
        }
    }

    // DTO for creating new blood inventory
    public static class CreateBloodInventoryDTO {
        private String bloodType;
        private Integer instockAmount;
        private LocalDate expiryDate;

        public CreateBloodInventoryDTO() {
        }

        public CreateBloodInventoryDTO(String bloodType, Integer instockAmount, LocalDate expiryDate) {
            this.bloodType = bloodType;
            this.instockAmount = instockAmount;
            this.expiryDate = expiryDate;
        }

        // Convert to model
        public BloodInventoryModel toModel() {
            return new BloodInventoryModel(
                    this.bloodType,
                    this.instockAmount,
                    this.expiryDate
            );
        }

        // Getters and Setters
        public String getBloodType() {
            return bloodType;
        }

        public void setBloodType(String bloodType) {
            this.bloodType = bloodType;
        }

        public Integer getInstockAmount() {
            return instockAmount;
        }

        public void setInstockAmount(Integer instockAmount) {
            this.instockAmount = instockAmount;
        }

        public LocalDate getExpiryDate() {
            return expiryDate;
        }

        public void setExpiryDate(LocalDate expiryDate) {
            this.expiryDate = expiryDate;
        }
    }

    // DTO for updating blood inventory
    public static class UpdateBloodInventoryDTO {
        private String bloodType;
        private Integer instockAmount;
        private LocalDate expiryDate;

        public UpdateBloodInventoryDTO() {
        }

        public UpdateBloodInventoryDTO(String bloodType, Integer instockAmount, LocalDate expiryDate) {
            this.bloodType = bloodType;
            this.instockAmount = instockAmount;
            this.expiryDate = expiryDate;
        }

        // Apply updates to an existing model
        public void applyToModel(BloodInventoryModel model) {
            if (this.bloodType != null) {
                model.setBloodType(this.bloodType);
            }
            if (this.instockAmount != null) {
                model.setInstockAmount(this.instockAmount);
            }
            if (this.expiryDate != null) {
                model.setExpiryDate(this.expiryDate);
            }
        }

        // Getters and Setters
        public String getBloodType() {
            return bloodType;
        }

        public void setBloodType(String bloodType) {
            this.bloodType = bloodType;
        }

        public Integer getInstockAmount() {
            return instockAmount;
        }

        public void setInstockAmount(Integer instockAmount) {
            this.instockAmount = instockAmount;
        }

        public LocalDate getExpiryDate() {
            return expiryDate;
        }

        public void setExpiryDate(LocalDate expiryDate) {
            this.expiryDate = expiryDate;
        }
    }
}
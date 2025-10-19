package com.example.blooddonatesystem.features.blood_inventory;

import jakarta.persistence.*;
import java.io.Serializable;
import java.time.LocalDate;

@Entity
@Table(name = "blood_inventory")
public class BloodInventoryModel implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "blood_type", nullable = false)
    private String bloodType;

    @Column(name = "instock_amount", nullable = false)
    private Integer instockAmount;

    @Column(name = "expiry_date", nullable = false)
    private LocalDate expiryDate;

    // Default constructor
    public BloodInventoryModel() {
    }

    // Constructor with fields
    public BloodInventoryModel(String bloodType, Integer instockAmount, LocalDate expiryDate) {
        this.bloodType = bloodType;
        this.instockAmount = instockAmount;
        this.expiryDate = expiryDate;
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

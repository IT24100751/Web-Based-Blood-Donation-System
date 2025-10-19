package com.example.blooddonatesystem.features.blood_inventory;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class BloodInventoryService {
    
    private static final Logger logger = LoggerFactory.getLogger(BloodInventoryService.class);
    
    private final BloodInventoryRepository bloodInventoryRepository;
    
    @Autowired
    public BloodInventoryService(BloodInventoryRepository bloodInventoryRepository) {
        this.bloodInventoryRepository = bloodInventoryRepository;
    }
    
    // Get all blood inventory items
    public List<BloodInventoryDTOS.GetBloodInventoryDTO> getAllBloodInventory() {
        try {
            logger.info("Fetching all blood inventory items");
            return bloodInventoryRepository.findAll().stream()
                    .map(BloodInventoryDTOS.GetBloodInventoryDTO::fromModel)
                    .collect(Collectors.toList());
        } catch (Exception e) {
            logger.error("Error fetching all blood inventory items", e);
            throw new RuntimeException("Failed to retrieve blood inventory items", e);
        }
    }
    
    // Get blood inventory by ID
    public BloodInventoryDTOS.GetBloodInventoryDTO getBloodInventoryById(Long id) {
        try {
            logger.info("Fetching blood inventory with ID: {}", id);
            BloodInventoryModel bloodInventory = bloodInventoryRepository.findById(id)
                    .orElseThrow(() -> new RuntimeException("Blood inventory not found with ID: " + id));
            return BloodInventoryDTOS.GetBloodInventoryDTO.fromModel(bloodInventory);
        } catch (Exception e) {
            logger.error("Error fetching blood inventory with ID: {}", id, e);
            throw new RuntimeException("Failed to retrieve blood inventory with ID: " + id, e);
        }
    }
    
    // Create new blood inventory
    public BloodInventoryDTOS.GetBloodInventoryDTO createBloodInventory(BloodInventoryDTOS.CreateBloodInventoryDTO createDTO) {
        try {
            logger.info("Creating new blood inventory with type: {}", createDTO.getBloodType());
            BloodInventoryModel newBloodInventory = createDTO.toModel();
            BloodInventoryModel savedBloodInventory = bloodInventoryRepository.save(newBloodInventory);
            return BloodInventoryDTOS.GetBloodInventoryDTO.fromModel(savedBloodInventory);
        } catch (Exception e) {
            logger.error("Error creating blood inventory", e);
            throw new RuntimeException("Failed to create blood inventory", e);
        }
    }
    
    // Update blood inventory
    public BloodInventoryDTOS.GetBloodInventoryDTO updateBloodInventory(Long id, BloodInventoryDTOS.UpdateBloodInventoryDTO updateDTO) {
        try {
            logger.info("Updating blood inventory with ID: {}", id);
            BloodInventoryModel bloodInventory = bloodInventoryRepository.findById(id)
                    .orElseThrow(() -> new RuntimeException("Blood inventory not found with ID: " + id));
            
            updateDTO.applyToModel(bloodInventory);
            BloodInventoryModel updatedBloodInventory = bloodInventoryRepository.save(bloodInventory);
            return BloodInventoryDTOS.GetBloodInventoryDTO.fromModel(updatedBloodInventory);
        } catch (Exception e) {
            logger.error("Error updating blood inventory with ID: {}", id, e);
            throw new RuntimeException("Failed to update blood inventory with ID: " + id, e);
        }
    }
    
    // Delete blood inventory
    public void deleteBloodInventory(Long id) {
        try {
            logger.info("Deleting blood inventory with ID: {}", id);
            if (!bloodInventoryRepository.existsById(id)) {
                throw new RuntimeException("Blood inventory not found with ID: " + id);
            }
            bloodInventoryRepository.deleteById(id);
        } catch (Exception e) {
            logger.error("Error deleting blood inventory with ID: {}", id, e);
            throw new RuntimeException("Failed to delete blood inventory with ID: " + id, e);
        }
    }
    
    // Get blood inventory by blood type
    public List<BloodInventoryDTOS.GetBloodInventoryDTO> getBloodInventoryByType(String bloodType) {
        try {
            logger.info("Fetching blood inventory with type: {}", bloodType);
            return bloodInventoryRepository.findByBloodType(bloodType).stream()
                    .map(BloodInventoryDTOS.GetBloodInventoryDTO::fromModel)
                    .collect(Collectors.toList());
        } catch (Exception e) {
            logger.error("Error fetching blood inventory with type: {}", bloodType, e);
            throw new RuntimeException("Failed to retrieve blood inventory with type: " + bloodType, e);
        }
    }
    
    // Get expiring blood inventory
    public List<BloodInventoryDTOS.GetBloodInventoryDTO> getExpiringBloodInventory(LocalDate expiryDate) {
        try {
            logger.info("Fetching blood inventory expiring before: {}", expiryDate);
            return bloodInventoryRepository.findByExpiryDateBefore(expiryDate).stream()
                    .map(BloodInventoryDTOS.GetBloodInventoryDTO::fromModel)
                    .collect(Collectors.toList());
        } catch (Exception e) {
            logger.error("Error fetching expiring blood inventory", e);
            throw new RuntimeException("Failed to retrieve expiring blood inventory", e);
        }
    }
}
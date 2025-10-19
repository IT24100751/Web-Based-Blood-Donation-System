package com.example.blooddonatesystem.features.blood_inventory;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/api/blood-inventory")
public class BloodInventoryController {

    private static final Logger logger = LoggerFactory.getLogger(BloodInventoryController.class);
    
    private final BloodInventoryService bloodInventoryService;
    
    @Autowired
    public BloodInventoryController(BloodInventoryService bloodInventoryService) {
        this.bloodInventoryService = bloodInventoryService;
    }
    
    // Get all blood inventory
    @GetMapping
    public ResponseEntity<?> getAllBloodInventory() {
        try {
            List<BloodInventoryDTOS.GetBloodInventoryDTO> inventoryList = bloodInventoryService.getAllBloodInventory();
            return ResponseEntity.ok(inventoryList);
        } catch (Exception e) {
            logger.error("Error retrieving all blood inventory", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Failed to retrieve blood inventory: " + e.getMessage());
        }
    }
    
    // Get blood inventory by ID
    @GetMapping("/{id}")
    public ResponseEntity<?> getBloodInventoryById(@PathVariable Long id) {
        try {
            BloodInventoryDTOS.GetBloodInventoryDTO inventory = bloodInventoryService.getBloodInventoryById(id);
            return ResponseEntity.ok(inventory);
        } catch (RuntimeException e) {
            if (e.getMessage().contains("not found")) {
                logger.error("Blood inventory not found with ID: {}", id);
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body("Blood inventory not found with ID: " + id);
            }
            logger.error("Error retrieving blood inventory with ID: {}", id, e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Failed to retrieve blood inventory: " + e.getMessage());
        }
    }
    
    // Create new blood inventory
    @PostMapping
    public ResponseEntity<?> createBloodInventory(@RequestBody BloodInventoryDTOS.CreateBloodInventoryDTO createDTO) {
        try {
            BloodInventoryDTOS.GetBloodInventoryDTO createdInventory = bloodInventoryService.createBloodInventory(createDTO);
            return ResponseEntity.status(HttpStatus.CREATED).body(createdInventory);
        } catch (Exception e) {
            logger.error("Error creating blood inventory", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Failed to create blood inventory: " + e.getMessage());
        }
    }
    
    // Update blood inventory
    @PutMapping("/{id}")
    public ResponseEntity<?> updateBloodInventory(@PathVariable Long id, 
                                                 @RequestBody BloodInventoryDTOS.UpdateBloodInventoryDTO updateDTO) {
        try {
            BloodInventoryDTOS.GetBloodInventoryDTO updatedInventory = bloodInventoryService.updateBloodInventory(id, updateDTO);
            return ResponseEntity.ok(updatedInventory);
        } catch (RuntimeException e) {
            if (e.getMessage().contains("not found")) {
                logger.error("Blood inventory not found with ID: {}", id);
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body("Blood inventory not found with ID: " + id);
            }
            logger.error("Error updating blood inventory with ID: {}", id, e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Failed to update blood inventory: " + e.getMessage());
        }
    }
    
    // Delete blood inventory
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteBloodInventory(@PathVariable Long id) {
        try {
            bloodInventoryService.deleteBloodInventory(id);
            return ResponseEntity.ok("Blood inventory deleted successfully");
        } catch (RuntimeException e) {
            if (e.getMessage().contains("not found")) {
                logger.error("Blood inventory not found with ID: {}", id);
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body("Blood inventory not found with ID: " + id);
            }
            logger.error("Error deleting blood inventory with ID: {}", id, e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Failed to delete blood inventory: " + e.getMessage());
        }
    }
    
    // Get blood inventory by blood type
    @GetMapping("/type/{bloodType}")
    public ResponseEntity<?> getBloodInventoryByType(@PathVariable String bloodType) {
        try {
            List<BloodInventoryDTOS.GetBloodInventoryDTO> inventoryList = bloodInventoryService.getBloodInventoryByType(bloodType);
            return ResponseEntity.ok(inventoryList);
        } catch (Exception e) {
            logger.error("Error retrieving blood inventory by type: {}", bloodType, e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Failed to retrieve blood inventory by type: " + e.getMessage());
        }
    }
    
    // Get expiring blood inventory
    @GetMapping("/expiring")
    public ResponseEntity<?> getExpiringBloodInventory(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate expiryDate) {
        try {
            List<BloodInventoryDTOS.GetBloodInventoryDTO> inventoryList = bloodInventoryService.getExpiringBloodInventory(expiryDate);
            return ResponseEntity.ok(inventoryList);
        } catch (Exception e) {
            logger.error("Error retrieving expiring blood inventory", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Failed to retrieve expiring blood inventory: " + e.getMessage());
        }
    }
}
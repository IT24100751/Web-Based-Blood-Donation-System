package com.example.blooddonatesystem.features.request_management;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/requests")
public class RequestController {
    
    private static final Logger logger = LoggerFactory.getLogger(RequestController.class);
    
    @Autowired
    private RequestService requestService;
    
    // Get all requests
    @GetMapping
    public ResponseEntity<?> getAllRequests() {
        try {
            List<RequestDTOS.GetRequestDTO> requests = requestService.getAllRequests();
            return ResponseEntity.ok(requests);
        } catch (Exception e) {
            logger.error("Error getting all requests: {}", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Failed to get all requests: " + e.getMessage());
        }
    }
    
    // Get request by ID
    @GetMapping("/{id}")
    public ResponseEntity<?> getRequestById(@PathVariable Long id) {
        try {
            RequestDTOS.GetRequestDTO request = requestService.getRequestById(id);
            return ResponseEntity.ok(request);
        } catch (Exception e) {
            logger.error("Error getting request by id {}: {}", id, e.getMessage());
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body("Failed to get request: " + e.getMessage());
        }
    }
    
    // Create new request
    @PostMapping
    public ResponseEntity<?> createRequest(@RequestBody RequestDTOS.CreateRequestDTO createRequestDTO) {
        try {
            RequestDTOS.GetRequestDTO createdRequest = requestService.createRequest(createRequestDTO);
            return ResponseEntity.status(HttpStatus.CREATED).body(createdRequest);
        } catch (Exception e) {
            logger.error("Error creating request: {}", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body("Failed to create request: " + e.getMessage());
        }
    }
    
    // Update request
    @PutMapping("/{id}")
    public ResponseEntity<?> updateRequest(@PathVariable Long id, 
                                          @RequestBody RequestDTOS.UpdateRequestDTO updateRequestDTO) {
        try {
            RequestDTOS.GetRequestDTO updatedRequest = requestService.updateRequest(id, updateRequestDTO);
            return ResponseEntity.ok(updatedRequest);
        } catch (Exception e) {
            logger.error("Error updating request with id {}: {}", id, e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body("Failed to update request: " + e.getMessage());
        }
    }
    
    // Delete request
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteRequest(@PathVariable Long id) {
        try {
            requestService.deleteRequest(id);
            return ResponseEntity.ok("Request deleted successfully");
        } catch (Exception e) {
            logger.error("Error deleting request with id {}: {}", id, e.getMessage());
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body("Failed to delete request: " + e.getMessage());
        }
    }
    
    // Get requests by user ID
    @GetMapping("/user/{userId}")
    public ResponseEntity<?> getRequestsByUserId(@PathVariable Long userId) {
        try {
            List<RequestDTOS.GetRequestDTO> requests = requestService.getRequestsByUserId(userId);
            return ResponseEntity.ok(requests);
        } catch (Exception e) {
            logger.error("Error getting requests by user id {}: {}", userId, e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Failed to get requests by user id: " + e.getMessage());
        }
    }
    
    // Get requests by blood type
    @GetMapping("/blood-type/{bloodType}")
    public ResponseEntity<?> getRequestsByBloodType(@PathVariable String bloodType) {
        try {
            List<RequestDTOS.GetRequestDTO> requests = requestService.getRequestsByBloodType(bloodType);
            return ResponseEntity.ok(requests);
        } catch (Exception e) {
            logger.error("Error getting requests by blood type {}: {}", bloodType, e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Failed to get requests by blood type: " + e.getMessage());
        }
    }
    
    // Get requests by urgency
    @GetMapping("/urgency/{urgency}")
    public ResponseEntity<?> getRequestsByUrgency(@PathVariable String urgency) {
        try {
            List<RequestDTOS.GetRequestDTO> requests = requestService.getRequestsByUrgency(urgency);
            return ResponseEntity.ok(requests);
        } catch (Exception e) {
            logger.error("Error getting requests by urgency {}: {}", urgency, e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Failed to get requests by urgency: " + e.getMessage());
        }
    }
    
    // Get requests by status
    @GetMapping("/status/{status}")
    public ResponseEntity<?> getRequestsByStatus(@PathVariable String status) {
        try {
            List<RequestDTOS.GetRequestDTO> requests = requestService.getRequestsByStatus(status);
            return ResponseEntity.ok(requests);
        } catch (Exception e) {
            logger.error("Error getting requests by status {}: {}", status, e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Failed to get requests by status: " + e.getMessage());
        }
    }
}
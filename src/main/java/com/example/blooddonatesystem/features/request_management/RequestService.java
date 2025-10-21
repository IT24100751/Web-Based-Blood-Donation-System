package com.example.blooddonatesystem.features.request_management;

import com.example.blooddonatesystem.features.user_management.UserModel;
import com.example.blooddonatesystem.features.user_management.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class RequestService {

    private static final Logger logger = LoggerFactory.getLogger(RequestService.class);

    @Autowired
    private RequestRepository requestRepository;

    @Autowired
    private UserRepository userRepository;

    // Get all requests
    public List<RequestDTOS.GetRequestDTO> getAllRequests() {
        try {
            List<RequestModel> requests = requestRepository.findAll();
            return requests.stream()
                    .map(RequestDTOS.GetRequestDTO::new)
                    .collect(Collectors.toList());
        } catch (Exception e) {
            logger.error("Error getting all requests: {}", e.getMessage());
            throw new RuntimeException("Failed to get all requests", e);
        }
    }

    // Get request by ID
    public RequestDTOS.GetRequestDTO getRequestById(Long id) {
        try {
            RequestModel request = requestRepository.findById(id)
                    .orElseThrow(() -> new RuntimeException("Request not found with id: " + id));
            return new RequestDTOS.GetRequestDTO(request);
        } catch (Exception e) {
            logger.error("Error getting request by id {}: {}", id, e.getMessage());
            throw new RuntimeException("Failed to get request by id: " + id, e);
        }
    }

    // Create new request
    public RequestDTOS.GetRequestDTO createRequest(RequestDTOS.CreateRequestDTO createRequestDTO) {
        try {
            UserModel user = userRepository.findById(createRequestDTO.getUserId())
                    .orElseThrow(() -> new RuntimeException("User not found with id: " + createRequestDTO.getUserId()));

            RequestModel newRequest = createRequestDTO.toRequestModel(user);
            user.addRequest(newRequest);

            RequestModel savedRequest = requestRepository.save(newRequest);
            return new RequestDTOS.GetRequestDTO(savedRequest);
        } catch (Exception e) {
            logger.error("Error creating request: {}", e.getMessage());
            throw new RuntimeException("Failed to create request", e);
        }
    }

    // Update request
    public RequestDTOS.GetRequestDTO updateRequest(Long id, RequestDTOS.UpdateRequestDTO updateRequestDTO) {
        try {
            RequestModel request = requestRepository.findById(id)
                    .orElseThrow(() -> new RuntimeException("Request not found with id: " + id));

            updateRequestDTO.updateRequestModel(request);
            RequestModel updatedRequest = requestRepository.save(request);
            return new RequestDTOS.GetRequestDTO(updatedRequest);
        } catch (Exception e) {
            logger.error("Error updating request with id {}: {}", id, e.getMessage());
            throw new RuntimeException("Failed to update request with id: " + id, e);
        }
    }

    // Delete request
    public void deleteRequest(Long id) {
        try {
            RequestModel request = requestRepository.findById(id)
                    .orElseThrow(() -> new RuntimeException("Request not found with id: " + id));

            UserModel user = request.getUser();
            user.removeRequest(request);

            requestRepository.delete(request);
        } catch (Exception e) {
            logger.error("Error deleting request with id {}: {}", id, e.getMessage());
            throw new RuntimeException("Failed to delete request with id: " + id, e);
        }
    }

    // Get requests by user ID
    public List<RequestDTOS.GetRequestDTO> getRequestsByUserId(Long userId) {
        try {
            List<RequestModel> requests = requestRepository.findByUserId(userId);
            return requests.stream()
                    .map(RequestDTOS.GetRequestDTO::new)
                    .collect(Collectors.toList());
        } catch (Exception e) {
            logger.error("Error getting requests by user id {}: {}", userId, e.getMessage());
            throw new RuntimeException("Failed to get requests by user id: " + userId, e);
        }
    }

    // Get requests by blood type
    public List<RequestDTOS.GetRequestDTO> getRequestsByBloodType(String bloodType) {
        try {
            List<RequestModel> requests = requestRepository.findByBloodType(bloodType);
            return requests.stream()
                    .map(RequestDTOS.GetRequestDTO::new)
                    .collect(Collectors.toList());
        } catch (Exception e) {
            logger.error("Error getting requests by blood type {}: {}", bloodType, e.getMessage());
            throw new RuntimeException("Failed to get requests by blood type: " + bloodType, e);
        }
    }

    // Get requests by urgency
    public List<RequestDTOS.GetRequestDTO> getRequestsByUrgency(String urgency) {
        try {
            List<RequestModel> requests = requestRepository.findByUrgency(urgency);
            return requests.stream()
                    .map(RequestDTOS.GetRequestDTO::new)
                    .collect(Collectors.toList());
        } catch (Exception e) {
            logger.error("Error getting requests by urgency {}: {}", urgency, e.getMessage());
            throw new RuntimeException("Failed to get requests by urgency: " + urgency, e);
        }
    }

    // Get requests by status
    public List<RequestDTOS.GetRequestDTO> getRequestsByStatus(String status) {
        try {
            List<RequestModel> requests = requestRepository.findByStatus(status);
            return requests.stream()
                    .map(RequestDTOS.GetRequestDTO::new)
                    .collect(Collectors.toList());
        } catch (Exception e) {
            logger.error("Error getting requests by status {}: {}", status, e.getMessage());
            throw new RuntimeException("Failed to get requests by status: " + status, e);
        }
    }
}
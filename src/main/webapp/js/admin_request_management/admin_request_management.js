document.addEventListener('DOMContentLoaded', function() {
    // DOM Elements
    const requestsTableBody = document.getElementById('requestsTableBody');
    const noRequestsMessage = document.getElementById('noRequestsMessage');
    const loadingSpinner = document.getElementById('loadingSpinner');
    const successAlert = document.getElementById('successAlert');
    const successMessage = document.getElementById('successMessage');
    const errorAlert = document.getElementById('errorAlert');
    const errorMessage = document.getElementById('errorMessage');
    const bloodTypeFilter = document.getElementById('bloodTypeFilter');
    const generatePdfBtn = document.getElementById('generatePdfBtn');
    
    // Update Status Modal Elements
    const updateStatusModal = document.getElementById('updateStatusModal');
    const updateStatusForm = document.getElementById('updateStatusForm');
    const updateRequestId = document.getElementById('updateRequestId');
    const requestStatus = document.getElementById('requestStatus');
    const closeUpdateStatusModal = document.getElementById('closeUpdateStatusModal');
    const cancelUpdateStatus = document.getElementById('cancelUpdateStatus');
    
    // Store all requests for filtering
    let allRequests = [];
    
    // Load all requests
    loadAllRequests();
    
    // Event Listeners
    bloodTypeFilter.addEventListener('change', filterRequestsByBloodType);
    generatePdfBtn.addEventListener('click', generatePDF);
    updateStatusForm.addEventListener('submit', handleUpdateStatus);
    closeUpdateStatusModal.addEventListener('click', closeModal);
    cancelUpdateStatus.addEventListener('click', closeModal);
    
    // Functions
    function loadAllRequests() {
        showLoading();
        
        fetch('/api/requests')
            .then(response => {
                if (!response.ok) {
                    throw new Error('Failed to fetch requests');
                }
                return response.json();
            })
            .then(data => {
                hideLoading();
                allRequests = data;
                displayRequests(allRequests);
            })
            .catch(error => {
                hideLoading();
                showError('Error loading requests: ' + error.message);
                console.error('Error:', error);
            });
    }
    
    function displayRequests(requests) {
        requestsTableBody.innerHTML = '';
        
        if (requests.length === 0) {
            noRequestsMessage.classList.remove('hidden');
            return;
        }
        
        noRequestsMessage.classList.add('hidden');
        
        requests.forEach(request => {
            const row = document.createElement('tr');
            
            // Format date
            const createdDate = new Date(request.createdAt).toLocaleDateString();
            
            // Status class based on status value
            let statusClass = '';
            switch(request.status) {
                case 'Pending':
                    statusClass = 'bg-yellow-100 text-yellow-800';
                    break;
                case 'Approved':
                    statusClass = 'bg-green-100 text-green-800';
                    break;
                case 'Rejected':
                    statusClass = 'bg-red-100 text-red-800';
                    break;
                case 'Completed':
                    statusClass = 'bg-blue-100 text-blue-800';
                    break;
                default:
                    statusClass = 'bg-gray-100 text-gray-800';
            }
            
            row.innerHTML = `
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${request.id}</td>
                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${request.userName}</td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${request.bloodType}</td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${request.units}</td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${request.urgency}</td>
                <td class="px-6 py-4 whitespace-nowrap">
                    <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full ${statusClass}">
                        ${request.status}
                    </span>
                </td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${createdDate}</td>
                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                    <button 
                        class="text-indigo-600 hover:text-indigo-900 mr-3"
                        onclick="openUpdateStatusModal(${request.id}, '${request.status}')">
                        <i class="fas fa-edit"></i> Update Status
                    </button>
                </td>
            `;
            
            requestsTableBody.appendChild(row);
        });
    }
    
    // Global function to open update status modal
    window.openUpdateStatusModal = function(id, status) {
        updateRequestId.value = id;
        requestStatus.value = status;
        updateStatusModal.classList.remove('hidden');
    };
    
    function closeModal() {
        updateStatusModal.classList.add('hidden');
    }
    
    function handleUpdateStatus(e) {
        e.preventDefault();
        
        const id = updateRequestId.value;
        const status = requestStatus.value;
        
        showLoading();
        
        // Create update DTO with only status field
        const updateData = {
            status: status
        };
        
        fetch(`/api/requests/${id}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(updateData)
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to update request status');
            }
            return response.json();
        })
        .then(data => {
            hideLoading();
            closeModal();
            showSuccess('Request status updated successfully');
            
            // Update the request in allRequests array
            const index = allRequests.findIndex(req => req.id === parseInt(id));
            if (index !== -1) {
                allRequests[index].status = status;
            }
            
            // Re-apply current filter
            filterRequestsByBloodType();
        })
        .catch(error => {
            hideLoading();
            showError('Error updating request status: ' + error.message);
            console.error('Error:', error);
        });
    }
    
    function filterRequestsByBloodType() {
        const selectedBloodType = bloodTypeFilter.value;
        
        if (!selectedBloodType) {
            displayRequests(allRequests);
            return;
        }
        
        const filteredRequests = allRequests.filter(request => 
            request.bloodType === selectedBloodType
        );
        
        displayRequests(filteredRequests);
    }
    
    function generatePDF() {
        // Get current filter value
        const selectedBloodType = bloodTypeFilter.value;
        const title = selectedBloodType 
            ? `Blood Requests - ${selectedBloodType} Blood Type` 
            : 'All Blood Requests';
        
        // Get filtered data
        const data = selectedBloodType 
            ? allRequests.filter(request => request.bloodType === selectedBloodType)
            : allRequests;
            
        // Initialize jsPDF
        const { jsPDF } = window.jspdf;
        const doc = new jsPDF();
        
        // Add title
        doc.setFontSize(18);
        doc.text(title, 14, 22);
        
        // Add generation date
        doc.setFontSize(11);
        doc.text(`Generated on: ${new Date().toLocaleDateString()}`, 14, 30);
        
        // Prepare table data
        const tableColumn = ["ID", "User", "Blood Type", "Units", "Urgency", "Status", "Created At"];
        const tableRows = [];
        
        data.forEach(request => {
            const createdDate = new Date(request.createdAt).toLocaleDateString();
            const requestData = [
                request.id,
                request.userName,
                request.bloodType,
                request.units,
                request.urgency,
                request.status,
                createdDate
            ];
            tableRows.push(requestData);
        });
        
        // Generate table
        doc.autoTable({
            head: [tableColumn],
            body: tableRows,
            startY: 35,
            styles: {
                fontSize: 10,
                cellPadding: 3,
                overflow: 'linebreak'
            },
            headStyles: {
                fillColor: [220, 53, 69], // Red color
                textColor: 255,
                fontStyle: 'bold'
            },
            alternateRowStyles: {
                fillColor: [245, 245, 245]
            }
        });
        
        // Save PDF
        doc.save(`blood_requests_report_${new Date().toISOString().slice(0,10)}.pdf`);
    }
    
    // Utility functions
    function showLoading() {
        loadingSpinner.classList.remove('hidden');
    }
    
    function hideLoading() {
        loadingSpinner.classList.add('hidden');
    }
    
    function showSuccess(message) {
        successMessage.textContent = message;
        successAlert.classList.remove('hidden');
        
        // Auto hide after 3 seconds
        setTimeout(() => {
            successAlert.classList.add('hidden');
        }, 3000);
    }
    
    function showError(message) {
        errorMessage.textContent = message;
        errorAlert.classList.remove('hidden');
    }
});
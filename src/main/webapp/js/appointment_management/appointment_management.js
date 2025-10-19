document.addEventListener('DOMContentLoaded', function() {
    // DOM Elements
    const searchInput = document.getElementById('searchInput');
    const statusFilter = document.getElementById('statusFilter');
    const searchBtn = document.getElementById('searchBtn');
    const exportPdfBtn = document.getElementById('exportPdfBtn');
    const appointmentsTableBody = document.getElementById('appointmentsTableBody');
    const noResultsMessage = document.getElementById('noResultsMessage');
    const loadingMessage = document.getElementById('loadingMessage');
    const errorMessage = document.getElementById('errorMessage');
    const errorText = document.getElementById('errorText');
    
    // Update Modal Elements
    const updateModal = document.getElementById('updateModal');
    const updateAppointmentId = document.getElementById('updateAppointmentId');
    const updateStatus = document.getElementById('updateStatus');
    const updateMessage = document.getElementById('updateMessage');
    const cancelUpdateBtn = document.getElementById('cancelUpdateBtn');
    const confirmUpdateBtn = document.getElementById('confirmUpdateBtn');
    
    // Delete Modal Elements
    const deleteModal = document.getElementById('deleteModal');
    const deleteAppointmentId = document.getElementById('deleteAppointmentId');
    const cancelDeleteBtn = document.getElementById('cancelDeleteBtn');
    const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');
    
    // Store all appointments
    let allAppointments = [];
    
    // Initialize
    init();
    
    function init() {
        // Add event listeners
        searchBtn.addEventListener('click', handleSearch);
        searchInput.addEventListener('keyup', function(event) {
            if (event.key === 'Enter') {
                handleSearch();
            }
        });
        statusFilter.addEventListener('change', handleSearch);
        exportPdfBtn.addEventListener('click', exportToPdf);
        
        // Modal event listeners
        cancelUpdateBtn.addEventListener('click', closeUpdateModal);
        confirmUpdateBtn.addEventListener('click', updateAppointment);
        cancelDeleteBtn.addEventListener('click', closeDeleteModal);
        confirmDeleteBtn.addEventListener('click', deleteAppointment);
        
        // Fetch appointments on page load
        fetchAppointments();
    }
    
    function fetchAppointments() {
        showLoading(true);
        
        fetch('/api/appointments')
            .then(response => {
                if (!response.ok) {
                    throw new Error('Failed to fetch appointments');
                }
                return response.json();
            })
            .then(data => {
                allAppointments = data;
                renderAppointmentsTable(allAppointments);
                showLoading(false);
            })
            .catch(error => {
                showError(error.message);
                showLoading(false);
            });
    }
    
    function renderAppointmentsTable(appointments) {
        // Clear table
        appointmentsTableBody.innerHTML = '';
        
        if (appointments.length === 0) {
            noResultsMessage.classList.remove('hidden');
            return;
        }
        
        noResultsMessage.classList.add('hidden');
        
        // Render appointments
        appointments.forEach(appointment => {
            const row = document.createElement('tr');
            
            // Format date
            const appointmentDate = new Date(appointment.appointmentDate);
            const formattedDate = appointmentDate.toLocaleString();
            
            // Status badge class
            let statusClass = 'bg-gray-100 text-gray-800';
            if (appointment.status === 'pending') {
                statusClass = 'bg-yellow-100 text-yellow-800';
            } else if (appointment.status === 'confirmed') {
                statusClass = 'bg-blue-100 text-blue-800';
            } else if (appointment.status === 'completed') {
                statusClass = 'bg-green-100 text-green-800';
            } else if (appointment.status === 'cancelled') {
                statusClass = 'bg-red-100 text-red-800';
            }
            
            row.innerHTML = `
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${appointment.id}</td>
                <td class="px-6 py-4 whitespace-nowrap">
                    <div class="text-sm font-medium text-gray-900">${appointment.donorName}</div>
                </td>
                <td class="px-6 py-4 whitespace-nowrap">
                    <div class="text-sm text-gray-500">${appointment.donorEmail}</div>
                </td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${formattedDate}</td>
                <td class="px-6 py-4 whitespace-nowrap">
                    <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full ${statusClass}">
                        ${appointment.status}
                    </span>
                </td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                    ${appointment.message || '-'}
                </td>
                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                    <button class="text-blue-600 hover:text-blue-900 mr-3 update-btn" data-id="${appointment.id}" data-status="${appointment.status}" data-message="${appointment.message || ''}">
                        <i class="fas fa-edit"></i> Update
                    </button>
                    <button class="text-red-600 hover:text-red-900 delete-btn" data-id="${appointment.id}">
                        <i class="fas fa-trash"></i> Delete
                    </button>
                </td>
            `;
            
            // Add event listeners to action buttons
            const updateBtn = row.querySelector('.update-btn');
            const deleteBtn = row.querySelector('.delete-btn');
            
            updateBtn.addEventListener('click', function() {
                openUpdateModal(
                    this.getAttribute('data-id'),
                    this.getAttribute('data-status'),
                    this.getAttribute('data-message')
                );
            });
            
            deleteBtn.addEventListener('click', function() {
                openDeleteModal(this.getAttribute('data-id'));
            });
            
            appointmentsTableBody.appendChild(row);
        });
    }
    
    function handleSearch() {
        const searchTerm = searchInput.value.toLowerCase();
        const statusValue = statusFilter.value;
        
        let filteredAppointments = allAppointments;
        
        // Filter by search term
        if (searchTerm) {
            filteredAppointments = filteredAppointments.filter(appointment => 
                appointment.donorName.toLowerCase().includes(searchTerm) ||
                appointment.donorEmail.toLowerCase().includes(searchTerm) ||
                appointment.id.toString().includes(searchTerm)
            );
        }
        
        // Filter by status
        if (statusValue !== 'all') {
            filteredAppointments = filteredAppointments.filter(appointment => 
                appointment.status.toLowerCase() === statusValue.toLowerCase()
            );
        }
        
        renderAppointmentsTable(filteredAppointments);
    }
    
    function openUpdateModal(id, status, message) {
        updateAppointmentId.value = id;
        updateStatus.value = status;
        updateMessage.value = message;
        
        updateModal.classList.remove('hidden');
        updateModal.classList.add('flex');
    }
    
    function closeUpdateModal() {
        updateModal.classList.add('hidden');
        updateModal.classList.remove('flex');
    }
    
    function updateAppointment() {
        const id = updateAppointmentId.value;
        const status = updateStatus.value;
        const message = updateMessage.value;
        
        showLoading(true);
        
        fetch(`/api/appointments/${id}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                status: status,
                message: message
            })
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to update appointment');
            }
            return response.json();
        })
        .then(data => {
            // Update the appointment in the allAppointments array
            const index = allAppointments.findIndex(a => a.id === parseInt(id));
            if (index !== -1) {
                allAppointments[index] = data;
            }
            
            // Re-render the table
            handleSearch();
            
            // Close the modal
            closeUpdateModal();
            showLoading(false);
        })
        .catch(error => {
            showError(error.message);
            showLoading(false);
        });
    }
    
    function openDeleteModal(id) {
        deleteAppointmentId.value = id;
        
        deleteModal.classList.remove('hidden');
        deleteModal.classList.add('flex');
    }
    
    function closeDeleteModal() {
        deleteModal.classList.add('hidden');
        deleteModal.classList.remove('flex');
    }
    
    function deleteAppointment() {
        const id = deleteAppointmentId.value;
        
        showLoading(true);
        
        fetch(`/api/appointments/${id}`, {
            method: 'DELETE'
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to delete appointment');
            }
            return response.text();
        })
        .then(() => {
            // Remove the appointment from the allAppointments array
            allAppointments = allAppointments.filter(a => a.id !== parseInt(id));
            
            // Re-render the table
            handleSearch();
            
            // Close the modal
            closeDeleteModal();
            showLoading(false);
        })
        .catch(error => {
            showError(error.message);
            showLoading(false);
        });
    }
    
    function exportToPdf() {
        // Get currently displayed appointments (after filtering)
        const displayedAppointments = [...appointmentsTableBody.querySelectorAll('tr')].map(row => {
            const cells = row.querySelectorAll('td');
            return {
                id: cells[0].textContent,
                donorName: cells[1].textContent.trim(),
                donorEmail: cells[2].textContent.trim(),
                appointmentDate: cells[3].textContent,
                status: cells[4].textContent.trim(),
                message: cells[5].textContent.trim()
            };
        });
        
        if (displayedAppointments.length === 0) {
            showError('No appointments to export');
            return;
        }
        
        // Initialize jsPDF
        const { jsPDF } = window.jspdf;
        const doc = new jsPDF();
        
        // Add title
        doc.setFontSize(18);
        doc.setTextColor(220, 38, 38); // Red color
        doc.text('Blood Donation Appointments', 14, 22);
        
        // Add generation date
        doc.setFontSize(10);
        doc.setTextColor(100, 100, 100); // Gray color
        doc.text(`Generated on: ${new Date().toLocaleString()}`, 14, 30);
        
        // Define the columns for the table
        const columns = [
            { header: 'ID', dataKey: 'id' },
            { header: 'Donor Name', dataKey: 'donorName' },
            { header: 'Email', dataKey: 'donorEmail' },
            { header: 'Appointment Date', dataKey: 'appointmentDate' },
            { header: 'Status', dataKey: 'status' },
            { header: 'Message', dataKey: 'message' }
        ];
        
        // Convert appointments to table data
        const tableData = displayedAppointments;
        
        // Generate the table
        doc.autoTable({
            startY: 35,
            columns: columns,
            body: tableData,
            headStyles: {
                fillColor: [220, 38, 38], // Red color
                textColor: 255,
                fontStyle: 'bold'
            },
            alternateRowStyles: {
                fillColor: [245, 245, 245]
            },
            margin: { top: 35 }
        });
        
        // Save the PDF
        doc.save('blood_donation_appointments.pdf');
    }
    
    function showLoading(show) {
        if (show) {
            loadingMessage.classList.remove('hidden');
            errorMessage.classList.add('hidden');
        } else {
            loadingMessage.classList.add('hidden');
        }
    }
    
    function showError(message) {
        errorText.textContent = message;
        errorMessage.classList.remove('hidden');
        setTimeout(() => {
            errorMessage.classList.add('hidden');
        }, 5000);
    }
});
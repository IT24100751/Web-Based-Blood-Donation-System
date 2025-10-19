document.addEventListener('DOMContentLoaded', function() {
    // DOM Elements
    const appointmentsTableBody = document.getElementById('appointmentsTableBody');
    const noDataMessage = document.getElementById('noDataMessage');
    const loadingMessage = document.getElementById('loadingMessage');
    const errorMessage = document.getElementById('errorMessage');
    
    // Modal Elements
    const createAppointmentBtn = document.getElementById('createAppointmentBtn');
    const createAppointmentModal = document.getElementById('createAppointmentModal');
    const updateAppointmentModal = document.getElementById('updateAppointmentModal');
    const deleteConfirmationModal = document.getElementById('deleteConfirmationModal');
    const closeModalButtons = document.querySelectorAll('.closeModal');
    
    // Form Elements
    const createAppointmentForm = document.getElementById('createAppointmentForm');
    const updateAppointmentForm = document.getElementById('updateAppointmentForm');
    const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');
    
    // Get donor ID from localStorage
    const donorId = localStorage.getItem('donorId');
    if (!donorId) {
        showError('User not authenticated. Please login again.');
        setTimeout(() => {
            window.location.href = '/donor-login';
        }, 2000);
        return;
    }
    
    // Initialize
    loadAppointments();
    
    // Event Listeners
    createAppointmentBtn.addEventListener('click', () => openModal(createAppointmentModal));
    
    closeModalButtons.forEach(button => {
        button.addEventListener('click', () => {
            closeAllModals();
            clearFormErrors();
        });
    });
    
    createAppointmentForm.addEventListener('submit', function(e) {
        e.preventDefault();
        if (validateAppointmentForm(this)) {
            createAppointment();
        }
    });
    
    updateAppointmentForm.addEventListener('submit', function(e) {
        e.preventDefault();
        if (validateAppointmentForm(this)) {
            updateAppointment();
        }
    });
    
    confirmDeleteBtn.addEventListener('click', deleteAppointment);
    
    // Functions
    
    // Load appointments for the logged-in donor
    function loadAppointments() {
        showLoading();
        
        fetch(`/api/appointments/donor/${donorId}`)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Failed to load appointments');
                }
                return response.json();
            })
            .then(appointments => {
                hideLoading();
                renderAppointments(appointments);
            })
            .catch(error => {
                hideLoading();
                showError('Error loading appointments: ' + error.message);
            });
    }
    
    // Render appointments in the table
    function renderAppointments(appointments) {
        appointmentsTableBody.innerHTML = '';
        
        if (appointments.length === 0) {
            noDataMessage.classList.remove('hidden');
            return;
        }
        
        noDataMessage.classList.add('hidden');
        
        appointments.forEach(appointment => {
            const row = document.createElement('tr');
            
            // Format date for display
            const appointmentDate = new Date(appointment.appointmentDate);
            const formattedDate = appointmentDate.toLocaleString();
            
            // Format created date for display
            const createdDate = new Date(appointment.createdAt);
            const formattedCreatedDate = createdDate.toLocaleDateString();
            
            // Determine if appointment can be edited/deleted based on status
            const canModify = appointment.status !== 'COMPLETED' && appointment.status !== 'CANCELLED';
            
            row.innerHTML = `
                <td class="px-6 py-4 whitespace-nowrap">
                    <div class="text-sm text-gray-900">${formattedDate}</div>
                </td>
                <td class="px-6 py-4 whitespace-nowrap">
                    <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full ${getStatusClass(appointment.status)}">
                        ${appointment.status}
                    </span>
                </td>
                <td class="px-6 py-4">
                    <div class="text-sm text-gray-900">${appointment.message || '-'}</div>
                </td>
                <td class="px-6 py-4 whitespace-nowrap">
                    <div class="text-sm text-gray-900">${formattedCreatedDate}</div>
                </td>
                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                    ${canModify ? `
                        <button class="text-indigo-600 hover:text-indigo-900 mr-3 edit-btn" data-id="${appointment.id}">
                            <i class="fas fa-edit"></i>
                        </button>
                        <button class="text-red-600 hover:text-red-900 delete-btn" data-id="${appointment.id}">
                            <i class="fas fa-trash-alt"></i>
                        </button>
                    ` : `
                        <span class="text-gray-400">
                            <i class="fas fa-lock mr-1"></i> ${appointment.status}
                        </span>
                    `}
                </td>
            `;
            
            appointmentsTableBody.appendChild(row);
        });
        
        // Add event listeners to edit and delete buttons
        document.querySelectorAll('.edit-btn').forEach(btn => {
            btn.addEventListener('click', () => openEditModal(btn.getAttribute('data-id')));
        });
        
        document.querySelectorAll('.delete-btn').forEach(btn => {
            btn.addEventListener('click', () => openDeleteModal(btn.getAttribute('data-id')));
        });
    }
    
    // Get CSS class based on appointment status
    function getStatusClass(status) {
        switch(status) {
            case 'SCHEDULED':
                return 'bg-blue-100 text-blue-800';
            case 'COMPLETED':
                return 'bg-green-100 text-green-800';
            case 'CANCELLED':
                return 'bg-red-100 text-red-800';
            case 'PENDING':
                return 'bg-yellow-100 text-yellow-800';
            default:
                return 'bg-gray-100 text-gray-800';
        }
    }
    
    // Create a new appointment
    function createAppointment() {
        const appointmentDate = document.getElementById('appointmentDate').value;
        const message = document.getElementById('message').value;
        
        showSubmitLoading('create');
        
        const appointmentData = {
            appointmentDate: new Date(appointmentDate).toISOString(),
            donorId: donorId,
            status: 'SCHEDULED',
            message: message
        };
        
        fetch('/api/appointments', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(appointmentData)
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to create appointment');
            }
            return response.json();
        })
        .then(() => {
            hideSubmitLoading('create');
            closeAllModals();
            loadAppointments();
            resetForm(createAppointmentForm);
        })
        .catch(error => {
            hideSubmitLoading('create');
            showFormError(createAppointmentForm, 'appointmentDate', error.message);
        });
    }
    
    // Open edit modal and populate with appointment data
    function openEditModal(appointmentId) {
        showLoading();
        
        fetch(`/api/appointments/${appointmentId}`)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Failed to load appointment details');
                }
                return response.json();
            })
            .then(appointment => {
                hideLoading();
                
                // Format date for datetime-local input
                const appointmentDate = new Date(appointment.appointmentDate);
                const formattedDate = appointmentDate.toISOString().slice(0, 16);
                
                document.getElementById('updateAppointmentId').value = appointment.id;
                document.getElementById('updateAppointmentDate').value = formattedDate;
                document.getElementById('updateMessage').value = appointment.message || '';
                
                openModal(updateAppointmentModal);
            })
            .catch(error => {
                hideLoading();
                showError('Error loading appointment details: ' + error.message);
            });
    }
    
    // Update an existing appointment
    function updateAppointment() {
        const appointmentId = document.getElementById('updateAppointmentId').value;
        const appointmentDate = document.getElementById('updateAppointmentDate').value;
        const message = document.getElementById('updateMessage').value;
        
        showSubmitLoading('update');
        
        const appointmentData = {
            appointmentDate: new Date(appointmentDate).toISOString(),
            message: message
        };
        
        fetch(`/api/appointments/${appointmentId}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(appointmentData)
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to update appointment');
            }
            return response.json();
        })
        .then(() => {
            hideSubmitLoading('update');
            closeAllModals();
            loadAppointments();
        })
        .catch(error => {
            hideSubmitLoading('update');
            showFormError(updateAppointmentForm, 'updateAppointmentDate', error.message);
        });
    }
    
    // Open delete confirmation modal
    function openDeleteModal(appointmentId) {
        document.getElementById('deleteAppointmentId').value = appointmentId;
        openModal(deleteConfirmationModal);
    }
    
    // Delete an appointment
    function deleteAppointment() {
        const appointmentId = document.getElementById('deleteAppointmentId').value;
        
        showSubmitLoading('delete');
        
        fetch(`/api/appointments/${appointmentId}`, {
            method: 'DELETE'
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to cancel appointment');
            }
            return response.text();
        })
        .then(() => {
            hideSubmitLoading('delete');
            closeAllModals();
            loadAppointments();
        })
        .catch(error => {
            hideSubmitLoading('delete');
            showError('Error cancelling appointment: ' + error.message);
        });
    }
    
    // Validate appointment form
    function validateAppointmentForm(form) {
        let isValid = true;
        clearFormErrors();
        
        // Get the date input field (either appointmentDate or updateAppointmentDate)
        const dateField = form.querySelector('input[type="datetime-local"]');
        const dateValue = dateField.value;
        
        // Check if date is provided
        if (!dateValue) {
            showFormError(form, dateField.id, 'Please select a date and time for your appointment');
            isValid = false;
        } else {
            // Check if date is in the future
            const selectedDate = new Date(dateValue);
            const now = new Date();
            
            if (selectedDate <= now) {
                showFormError(form, dateField.id, 'Appointment date must be in the future');
                isValid = false;
            }
        }
        
        return isValid;
    }
    
    // Utility Functions
    
    // Show loading message
    function showLoading() {
        loadingMessage.classList.remove('hidden');
        errorMessage.classList.add('hidden');
    }
    
    // Hide loading message
    function hideLoading() {
        loadingMessage.classList.add('hidden');
    }
    
    // Show error message
    function showError(message) {
        errorMessage.textContent = message;
        errorMessage.classList.remove('hidden');
    }
    
    // Show form field error
    function showFormError(form, fieldId, message) {
        const field = form.querySelector(`#${fieldId}`);
        if (field) {
            field.classList.add('border-red-500');
            const errorElement = field.nextElementSibling;
            if (errorElement && errorElement.classList.contains('error-message')) {
                errorElement.textContent = message;
                errorElement.classList.remove('hidden');
            }
        }
    }
    
    // Clear all form errors
    function clearFormErrors() {
        document.querySelectorAll('.error-message').forEach(el => {
            el.classList.add('hidden');
            el.textContent = '';
        });
        
        document.querySelectorAll('input, textarea').forEach(el => {
            el.classList.remove('border-red-500');
        });
    }
    
    // Reset form fields
    function resetForm(form) {
        form.reset();
        clearFormErrors();
    }
    
    // Open modal
    function openModal(modal) {
        closeAllModals();
        modal.classList.remove('hidden');
    }
    
    // Close all modals
    function closeAllModals() {
        createAppointmentModal.classList.add('hidden');
        updateAppointmentModal.classList.add('hidden');
        deleteConfirmationModal.classList.add('hidden');
    }
    
    // Show loading indicator on submit button
    function showSubmitLoading(type) {
        document.getElementById(`${type}SubmitText`).classList.add('hidden');
        document.getElementById(`${type}SubmitLoading`).classList.remove('hidden');
    }
    
    // Hide loading indicator on submit button
    function hideSubmitLoading(type) {
        document.getElementById(`${type}SubmitText`).classList.remove('hidden');
        document.getElementById(`${type}SubmitLoading`).classList.add('hidden');
    }
});
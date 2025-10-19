document.addEventListener('DOMContentLoaded', function() {
    // DOM Elements
    const profileForm = document.getElementById('profileForm');
    const loadingMessage = document.getElementById('loadingMessage');
    const errorMessage = document.getElementById('errorMessage');
    const successMessage = document.getElementById('successMessage');
    const deleteAccountBtn = document.getElementById('deleteAccountBtn');
    const logoutBtn = document.getElementById('logoutBtn');
    const deleteConfirmationModal = document.getElementById('deleteConfirmationModal');
    const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');
    const closeModalButtons = document.querySelectorAll('.closeModal');
    
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
    loadDonorProfile();
    
    // Event Listeners
    profileForm.addEventListener('submit', function(e) {
        e.preventDefault();
        if (validateProfileForm()) {
            updateProfile();
        }
    });
    
    deleteAccountBtn.addEventListener('click', function() {
        deleteConfirmationModal.classList.remove('hidden');
    });
    
    closeModalButtons.forEach(button => {
        button.addEventListener('click', function() {
            deleteConfirmationModal.classList.add('hidden');
        });
    });
    
    confirmDeleteBtn.addEventListener('click', deleteAccount);
    
    logoutBtn.addEventListener('click', logout);
    
    // Functions
    
    // Load donor profile
    function loadDonorProfile() {
        showLoading();
        
        fetch(`/api/donors/${donorId}`)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Failed to load profile');
                }
                return response.json();
            })
            .then(donor => {
                hideLoading();
                populateForm(donor);
            })
            .catch(error => {
                hideLoading();
                showError('Error loading profile: ' + error.message);
            });
    }
    
    // Populate form with donor data
    function populateForm(donor) {
        document.getElementById('firstName').value = donor.firstName || '';
        document.getElementById('lastName').value = donor.lastName || '';
        document.getElementById('email').value = donor.email || '';
        document.getElementById('contactNumber').value = donor.contactNumber || '';
        document.getElementById('bloodType').value = donor.bloodType || '';
        document.getElementById('gender').value = donor.gender || '';
    }
    
    // Update profile
    function updateProfile() {
        showSubmitLoading('update');
        
        const updateData = {
            firstName: document.getElementById('firstName').value,
            lastName: document.getElementById('lastName').value,
            email: document.getElementById('email').value,
            contactNumber: document.getElementById('contactNumber').value,
            bloodType: document.getElementById('bloodType').value,
            gender: document.getElementById('gender').value
        };
        
        fetch(`/api/donors/${donorId}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(updateData)
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to update profile');
            }
            return response.json();
        })
        .then(updatedDonor => {
            hideSubmitLoading('update');
            showSuccess('Profile updated successfully');
            populateForm(updatedDonor);
        })
        .catch(error => {
            hideSubmitLoading('update');
            showError('Error updating profile: ' + error.message);
        });
    }
    
    // Delete account
    function deleteAccount() {
        showSubmitLoading('delete');
        
        fetch(`/api/donors/${donorId}`, {
            method: 'DELETE'
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to delete account');
            }
            return response.text();
        })
        .then(() => {
            hideSubmitLoading('delete');
            localStorage.removeItem('donorId');
            showSuccess('Account deleted successfully. Redirecting to login page...');
            setTimeout(() => {
                window.location.href = '/donor-login';
            }, 2000);
        })
        .catch(error => {
            hideSubmitLoading('delete');
            showError('Error deleting account: ' + error.message);
            deleteConfirmationModal.classList.add('hidden');
        });
    }
    
    // Logout
    function logout() {
        localStorage.removeItem('donorId');
        window.location.href = '/donor-login';
    }
    
    // Validate profile form
    function validateProfileForm() {
        let isValid = true;
        clearFormErrors();
        
        // Email validation
        const emailField = document.getElementById('email');
        const emailValue = emailField.value.trim();
        const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        
        if (!emailValue) {
            showFormError('email', 'Email is required');
            isValid = false;
        } else if (!emailRegex.test(emailValue)) {
            showFormError('email', 'Please enter a valid email address');
            isValid = false;
        }
        
        // First Name validation
        const firstNameField = document.getElementById('firstName');
        const firstNameValue = firstNameField.value.trim();
        
        if (!firstNameValue) {
            showFormError('firstName', 'First name is required');
            isValid = false;
        }
        
        // Last Name validation
        const lastNameField = document.getElementById('lastName');
        const lastNameValue = lastNameField.value.trim();
        
        if (!lastNameValue) {
            showFormError('lastName', 'Last name is required');
            isValid = false;
        }
        
        // Contact Number validation
        const contactNumberField = document.getElementById('contactNumber');
        const contactNumberValue = contactNumberField.value.trim();
        const phoneRegex = /^\d{10}$/;
        
        if (!contactNumberValue) {
            showFormError('contactNumber', 'Contact number is required');
            isValid = false;
        } else if (!phoneRegex.test(contactNumberValue)) {
            showFormError('contactNumber', 'Please enter a valid 10-digit phone number');
            isValid = false;
        }
        
        // Blood Type validation
        const bloodTypeField = document.getElementById('bloodType');
        const bloodTypeValue = bloodTypeField.value;
        
        if (!bloodTypeValue) {
            showFormError('bloodType', 'Blood type is required');
            isValid = false;
        }
        
        // Gender validation
        const genderField = document.getElementById('gender');
        const genderValue = genderField.value;
        
        if (!genderValue) {
            showFormError('gender', 'Gender is required');
            isValid = false;
        }
        
        return isValid;
    }
    
    // Utility Functions
    
    // Show loading message
    function showLoading() {
        loadingMessage.classList.remove('hidden');
        errorMessage.classList.add('hidden');
        successMessage.classList.add('hidden');
    }
    
    // Hide loading message
    function hideLoading() {
        loadingMessage.classList.add('hidden');
    }
    
    // Show error message
    function showError(message) {
        errorMessage.textContent = message;
        errorMessage.classList.remove('hidden');
        successMessage.classList.add('hidden');
    }
    
    // Show success message
    function showSuccess(message) {
        successMessage.textContent = message;
        successMessage.classList.remove('hidden');
        errorMessage.classList.add('hidden');
    }
    
    // Show form field error
    function showFormError(fieldId, message) {
        const field = document.getElementById(fieldId);
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
        
        document.querySelectorAll('input, select').forEach(el => {
            el.classList.remove('border-red-500');
        });
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
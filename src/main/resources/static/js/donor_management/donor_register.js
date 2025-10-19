/**
 * Donor Registration JavaScript
 * Handles form submission, validation, and API interaction
 */

document.addEventListener('DOMContentLoaded', function() {
    // Form elements
    const form = document.getElementById('donorRegistrationForm');
    const togglePasswordBtn = document.getElementById('togglePassword');
    
    // Regex patterns for validation
    const patterns = {
        name: /^[A-Za-z\s]{2,50}$/,
        email: /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/,
        password: /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*#?&]{8,}$/,
        contactNumber: /^[0-9]{10,15}$/
    };
    
    // Add event listeners
    if (form) {
        form.addEventListener('submit', handleFormSubmit);
    }
    
    if (togglePasswordBtn) {
        togglePasswordBtn.addEventListener('click', togglePasswordVisibility);
    }
    
    /**
     * Toggle password visibility
     */
    function togglePasswordVisibility() {
        const passwordInput = document.getElementById('password');
        const icon = togglePasswordBtn.querySelector('i');
        
        if (passwordInput.type === 'password') {
            passwordInput.type = 'text';
            icon.classList.remove('fa-eye');
            icon.classList.add('fa-eye-slash');
        } else {
            passwordInput.type = 'password';
            icon.classList.remove('fa-eye-slash');
            icon.classList.add('fa-eye');
        }
    }
    
    /**
     * Handle form submission
     * @param {Event} e - Form submit event
     */
    function handleFormSubmit(e) {
        e.preventDefault();
        
        // Get form data
        const formData = {
            firstName: document.getElementById('firstName').value.trim(),
            lastName: document.getElementById('lastName').value.trim(),
            email: document.getElementById('email').value.trim(),
            password: document.getElementById('password').value,
            bloodType: document.getElementById('bloodType').value,
            gender: document.getElementById('gender').value,
            contactNumber: document.getElementById('contactNumber').value.trim()
        };
        
        // Validate form data
        if (validateForm(formData)) {
            registerDonor(formData);
        }
    }
    
    /**
     * Validate form data
     * @param {Object} data - Form data
     * @returns {boolean} - Validation result
     */
    function validateForm(data) {
        let isValid = true;
        
        // Validate first name
        if (!patterns.name.test(data.firstName)) {
            showError('firstName', 'Please enter a valid first name');
            isValid = false;
        } else {
            hideError('firstName');
        }
        
        // Validate last name
        if (!patterns.name.test(data.lastName)) {
            showError('lastName', 'Please enter a valid last name');
            isValid = false;
        } else {
            hideError('lastName');
        }
        
        // Validate email
        if (!patterns.email.test(data.email)) {
            showError('email', 'Please enter a valid email address');
            isValid = false;
        } else {
            hideError('email');
        }
        
        // Validate password
        if (!patterns.password.test(data.password)) {
            showError('password', 'Password must be at least 8 characters with letters and numbers');
            isValid = false;
        } else {
            hideError('password');
        }
        
        // Validate blood type
        if (!data.bloodType) {
            showError('bloodType', 'Please select a blood type');
            isValid = false;
        } else {
            hideError('bloodType');
        }
        
        // Validate gender
        if (!data.gender) {
            showError('gender', 'Please select a gender');
            isValid = false;
        } else {
            hideError('gender');
        }
        
        // Validate contact number
        if (!patterns.contactNumber.test(data.contactNumber)) {
            showError('contactNumber', 'Please enter a valid contact number (10-15 digits)');
            isValid = false;
        } else {
            hideError('contactNumber');
        }
        
        return isValid;
    }
    
    /**
     * Show error message for a field
     * @param {string} fieldId - Field ID
     * @param {string} message - Error message
     */
    function showError(fieldId, message) {
        const errorElement = document.getElementById(`${fieldId}Error`);
        if (errorElement) {
            errorElement.textContent = message;
            errorElement.classList.remove('hidden');
        }
        
        const inputElement = document.getElementById(fieldId);
        if (inputElement) {
            inputElement.classList.add('border-red-500');
        }
    }
    
    /**
     * Hide error message for a field
     * @param {string} fieldId - Field ID
     */
    function hideError(fieldId) {
        const errorElement = document.getElementById(`${fieldId}Error`);
        if (errorElement) {
            errorElement.classList.add('hidden');
        }
        
        const inputElement = document.getElementById(fieldId);
        if (inputElement) {
            inputElement.classList.remove('border-red-500');
        }
    }
    
    /**
     * Show global error message
     * @param {string} message - Error message
     */
    function showGlobalError(message) {
        const errorElement = document.getElementById('errorMessage');
        const errorTextElement = document.getElementById('errorText');
        
        if (errorElement && errorTextElement) {
            errorTextElement.textContent = message;
            errorElement.classList.remove('hidden');
        }
    }
    
    /**
     * Hide global error message
     */
    function hideGlobalError() {
        const errorElement = document.getElementById('errorMessage');
        
        if (errorElement) {
            errorElement.classList.add('hidden');
        }
    }
    
    /**
     * Show loading indicator
     */
    function showLoading() {
        const loadingIndicator = document.getElementById('loadingIndicator');
        
        if (loadingIndicator) {
            loadingIndicator.classList.remove('hidden');
        }
    }
    
    /**
     * Hide loading indicator
     */
    function hideLoading() {
        const loadingIndicator = document.getElementById('loadingIndicator');
        
        if (loadingIndicator) {
            loadingIndicator.classList.add('hidden');
        }
    }
    
    /**
     * Register donor via API
     * @param {Object} data - Form data
     */
    function registerDonor(data) {
        showLoading();
        hideGlobalError();
        
        fetch('/api/donors', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        })
        .then(response => {
            if (!response.ok) {
                return response.json().then(data => {
                    throw new Error(data.message || 'Registration failed. Please try again.');
                });
            }
            return response.json();
        })
        .then(data => {
            // Registration successful
            window.location.href = '/donor-login?registered=true';
        })
        .catch(error => {
            hideLoading();
            showGlobalError(error.message || 'Registration failed. Please try again.');
        })
        .finally(() => {
            hideLoading();
        });
    }
});
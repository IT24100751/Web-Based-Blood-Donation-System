/**
 * Donor Login JavaScript
 * Handles form submission, validation, and API interaction
 */

document.addEventListener('DOMContentLoaded', function() {
    // Form elements
    const form = document.getElementById('donorLoginForm');
    const togglePasswordBtn = document.getElementById('togglePassword');
    
    // Regex patterns for validation
    const patterns = {
        email: /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/
    };
    
    // Check for registration success parameter
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('registered') === 'true') {
        document.getElementById('successMessage').classList.remove('hidden');
    }
    
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
            email: document.getElementById('email').value.trim(),
            password: document.getElementById('password').value
        };
        
        // Validate form data
        if (validateForm(formData)) {
            loginDonor(formData);
        }
    }
    
    /**
     * Validate form data
     * @param {Object} data - Form data
     * @returns {boolean} - Validation result
     */
    function validateForm(data) {
        let isValid = true;
        
        // Validate email
        if (!patterns.email.test(data.email)) {
            showError('email', 'Please enter a valid email address');
            isValid = false;
        } else {
            hideError('email');
        }
        
        // Validate password (just check if it's not empty)
        if (!data.password) {
            showError('password', 'Please enter your password');
            isValid = false;
        } else {
            hideError('password');
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
     * Login donor via API
     * @param {Object} data - Form data
     */
    function loginDonor(data) {
        showLoading();
        hideGlobalError();
        
        fetch('/api/donors/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        })
        .then(response => {
            if (!response.ok) {
                return response.json().then(data => {
                    throw new Error(data.message || 'Login failed. Please check your credentials.');
                });
            }
            return response.json();
        })
        .then(data => {
            // Login successful - save donor ID in localStorage
            localStorage.setItem('donorId', data.id);
            
            // Redirect to donor dashboard
            window.location.href = '/donor-dashboard';
        })
        .catch(error => {
            hideLoading();
            showGlobalError(error.message || 'Login failed. Please check your credentials.');
        })
        .finally(() => {
            hideLoading();
        });
    }
});
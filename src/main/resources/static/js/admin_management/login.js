/**
 * Admin Login JavaScript
 * Handles authentication for admin login
 */

document.addEventListener('DOMContentLoaded', function() {
    // Initialize the page
    setupEventListeners();
    setupFormValidation();
});

// API endpoint
const LOGIN_API_URL = '/api/admins/login';

// Regex patterns for validation
const PATTERNS = {
    email: /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/
};

/**
 * Setup event listeners for form and buttons
 */
function setupEventListeners() {
    // Login form submission
    document.getElementById('loginForm').addEventListener('submit', function(e) {
        e.preventDefault();
        if (validateLoginForm()) {
            loginAdmin();
        }
    });
    
    // Toggle password visibility
    document.getElementById('togglePassword').addEventListener('click', function() {
        const passwordInput = document.getElementById('password');
        const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
        passwordInput.setAttribute('type', type);
        
        // Toggle eye icon
        this.classList.toggle('fa-eye');
        this.classList.toggle('fa-eye-slash');
    });
}

/**
 * Setup form validation
 */
function setupFormValidation() {
    document.getElementById('email').addEventListener('blur', function() {
        validateField(this, 'emailError', PATTERNS.email);
    });
    
    document.getElementById('password').addEventListener('blur', function() {
        validateField(this, 'passwordError');
    });
}

/**
 * Login admin
 */
function loginAdmin() {
    const loginData = {
        email: document.getElementById('email').value,
        password: document.getElementById('password').value
    };
    
    showLoading(true);
    hideError();
    
    fetch(LOGIN_API_URL, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(loginData)
    })
    .then(response => {
        if (!response.ok) {
            return response.text().then(text => {
                throw new Error(text || 'Invalid email or password');
            });
        }
        return response.json();
    })
    .then(data => {
        showLoading(false);
        
        // Store admin data in session storage
        sessionStorage.setItem('adminId', data.id);
        sessionStorage.setItem('adminName', `${data.firstName} ${data.lastName}`);
        sessionStorage.setItem('adminEmail', data.email);
        
        // Redirect to dashboard
        window.location.href = '/dashboard';
    })
    .catch(error => {
        showLoading(false);
        showError(error.message);
    });
}

/**
 * Validate a form field
 */
function validateField(field, errorId, pattern = null) {
    const errorElement = document.getElementById(errorId);
    
    if (!field.value.trim()) {
        errorElement.textContent = `${field.placeholder.replace('Enter your ', '')} is required.`;
        errorElement.classList.remove('hidden');
        return false;
    }
    
    if (pattern && !pattern.test(field.value)) {
        errorElement.classList.remove('hidden');
        return false;
    }
    
    errorElement.classList.add('hidden');
    return true;
}

/**
 * Validate login form
 */
function validateLoginForm() {
    const emailValid = validateField(document.getElementById('email'), 'emailError', PATTERNS.email);
    const passwordValid = validateField(document.getElementById('password'), 'passwordError');
    
    return emailValid && passwordValid;
}

/**
 * Show/hide loading indicator
 */
function showLoading(show) {
    if (show) {
        document.getElementById('loadingIndicator').classList.remove('hidden');
    } else {
        document.getElementById('loadingIndicator').classList.add('hidden');
    }
}

/**
 * Show error message
 */
function showError(message) {
    const errorElement = document.getElementById('errorMessage');
    document.getElementById('errorText').textContent = message;
    errorElement.classList.remove('hidden');
}

/**
 * Hide error message
 */
function hideError() {
    document.getElementById('errorMessage').classList.add('hidden');
}
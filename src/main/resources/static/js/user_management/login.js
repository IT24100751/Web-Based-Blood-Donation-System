/**
 * Login functionality for Blood Donation System
 */
document.addEventListener('DOMContentLoaded', function() {
    // DOM Elements
    const loginForm = document.getElementById('loginForm');
    const mobileMenuBtn = document.getElementById('mobileMenuBtn');
    const mobileMenu = document.getElementById('mobileMenu');
    const errorAlert = document.getElementById('errorAlert');
    const errorMessage = document.getElementById('errorMessage');
    const loginBtn = document.getElementById('loginBtn');
    const loginBtnText = document.getElementById('loginBtnText');
    const loginBtnLoading = document.getElementById('loginBtnLoading');
    
    // Form fields
    const email = document.getElementById('email');
    const password = document.getElementById('password');
    
    // Error message elements
    const emailError = document.getElementById('emailError');
    const passwordError = document.getElementById('passwordError');
    
    // Mobile menu toggle
    if (mobileMenuBtn) {
        mobileMenuBtn.addEventListener('click', function() {
            mobileMenu.classList.toggle('hidden');
        });
    }
    
    // Validation patterns
    const patterns = {
        email: /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/
    };
    
    // Validation functions
    function validateEmail(email, errorElement) {
        if (!patterns.email.test(email.value.trim())) {
            errorElement.classList.remove('hidden');
            email.classList.add('border-red-500');
            return false;
        } else {
            errorElement.classList.add('hidden');
            email.classList.remove('border-red-500');
            return true;
        }
    }
    
    function validatePassword(password, errorElement) {
        if (password.value.trim() === '') {
            errorElement.classList.remove('hidden');
            password.classList.add('border-red-500');
            return false;
        } else {
            errorElement.classList.add('hidden');
            password.classList.remove('border-red-500');
            return true;
        }
    }
    
    // Add input event listeners for real-time validation
    email.addEventListener('input', () => validateEmail(email, emailError));
    password.addEventListener('input', () => validatePassword(password, passwordError));
    
    // Form submission
    loginForm.addEventListener('submit', function(e) {
        e.preventDefault();
        
        // Hide any previous alerts
        errorAlert.classList.add('hidden');
        
        // Validate all fields
        const isEmailValid = validateEmail(email, emailError);
        const isPasswordValid = validatePassword(password, passwordError);
        
        // If all validations pass, submit the form
        if (isEmailValid && isPasswordValid) {
            
            // Show loading state
            loginBtnText.classList.add('hidden');
            loginBtnLoading.classList.remove('hidden');
            loginBtn.disabled = true;
            
            // Prepare data for API
            const loginData = {
                email: email.value.trim(),
                password: password.value
            };
            
            // Send login request
            fetch('/api/users/login', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(loginData)
            })
            .then(response => {
                if (!response.ok) {
                    return response.json().then(data => {
                        throw new Error(data.message || 'Invalid email or password. Please try again.');
                    });
                }
                return response.json();
            })
            .then(data => {
                // Save user ID in localStorage
                localStorage.setItem('normalUserId', data.id);
                
                // Redirect to home page
                window.location.href = '/';
            })
            .catch(error => {
                // Show error message
                errorMessage.textContent = error.message;
                errorAlert.classList.remove('hidden');
                
                // Scroll to error message
                errorAlert.scrollIntoView({ behavior: 'smooth' });
            })
            .finally(() => {
                // Reset button state
                loginBtnText.classList.remove('hidden');
                loginBtnLoading.classList.add('hidden');
                loginBtn.disabled = false;
            });
        } else {
            // Scroll to the first error
            const firstError = document.querySelector('.text-red-500:not(.hidden)');
            if (firstError) {
                firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
            }
        }
    });
});
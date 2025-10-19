/**
 * Registration functionality for Blood Donation System
 */
document.addEventListener('DOMContentLoaded', function() {
    // DOM Elements
    const registrationForm = document.getElementById('registrationForm');
    const mobileMenuBtn = document.getElementById('mobileMenuBtn');
    const mobileMenu = document.getElementById('mobileMenu');
    const errorAlert = document.getElementById('errorAlert');
    const errorMessage = document.getElementById('errorMessage');
    const successAlert = document.getElementById('successAlert');
    const registerBtn = document.getElementById('registerBtn');
    const registerBtnText = document.getElementById('registerBtnText');
    const registerBtnLoading = document.getElementById('registerBtnLoading');
    
    // Form fields
    const firstName = document.getElementById('firstName');
    const lastName = document.getElementById('lastName');
    const email = document.getElementById('email');
    const contactNumber = document.getElementById('contactNumber');
    const password = document.getElementById('password');
    const confirmPassword = document.getElementById('confirmPassword');
    const gender = document.getElementById('gender');
    const age = document.getElementById('age');
    const terms = document.getElementById('terms');
    
    // Error message elements
    const firstNameError = document.getElementById('firstNameError');
    const lastNameError = document.getElementById('lastNameError');
    const emailError = document.getElementById('emailError');
    const contactNumberError = document.getElementById('contactNumberError');
    const passwordError = document.getElementById('passwordError');
    const confirmPasswordError = document.getElementById('confirmPasswordError');
    const genderError = document.getElementById('genderError');
    const ageError = document.getElementById('ageError');
    const termsError = document.getElementById('termsError');
    
    // Mobile menu toggle
    if (mobileMenuBtn) {
        mobileMenuBtn.addEventListener('click', function() {
            mobileMenu.classList.toggle('hidden');
        });
    }
    
    // Validation patterns
    const patterns = {
        name: /^[a-zA-Z\s]{2,30}$/,
        email: /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/,
        contactNumber: /^[0-9]{10}$/,
        password: /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*#?&]{8,}$/
    };
    
    // Validation functions
    function validateName(name, errorElement) {
        if (!patterns.name.test(name.value.trim())) {
            errorElement.classList.remove('hidden');
            name.classList.add('border-red-500');
            return false;
        } else {
            errorElement.classList.add('hidden');
            name.classList.remove('border-red-500');
            return true;
        }
    }
    
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
    
    function validateContactNumber(contactNumber, errorElement) {
        if (!patterns.contactNumber.test(contactNumber.value.trim())) {
            errorElement.classList.remove('hidden');
            contactNumber.classList.add('border-red-500');
            return false;
        } else {
            errorElement.classList.add('hidden');
            contactNumber.classList.remove('border-red-500');
            return true;
        }
    }
    
    function validatePassword(password, errorElement) {
        if (!patterns.password.test(password.value)) {
            errorElement.classList.remove('hidden');
            password.classList.add('border-red-500');
            return false;
        } else {
            errorElement.classList.add('hidden');
            password.classList.remove('border-red-500');
            return true;
        }
    }
    
    function validateConfirmPassword(password, confirmPassword, errorElement) {
        if (password.value !== confirmPassword.value) {
            errorElement.classList.remove('hidden');
            confirmPassword.classList.add('border-red-500');
            return false;
        } else {
            errorElement.classList.add('hidden');
            confirmPassword.classList.remove('border-red-500');
            return true;
        }
    }
    
    function validateGender(gender, errorElement) {
        if (gender.value === '') {
            errorElement.classList.remove('hidden');
            gender.classList.add('border-red-500');
            return false;
        } else {
            errorElement.classList.add('hidden');
            gender.classList.remove('border-red-500');
            return true;
        }
    }
    
    function validateAge(age, errorElement) {
        const ageValue = parseInt(age.value);
        if (isNaN(ageValue) || ageValue < 18 || ageValue > 65) {
            errorElement.classList.remove('hidden');
            age.classList.add('border-red-500');
            return false;
        } else {
            errorElement.classList.add('hidden');
            age.classList.remove('border-red-500');
            return true;
        }
    }
    
    function validateTerms(terms, errorElement) {
        if (!terms.checked) {
            errorElement.classList.remove('hidden');
            return false;
        } else {
            errorElement.classList.add('hidden');
            return true;
        }
    }
    
    // Add input event listeners for real-time validation
    firstName.addEventListener('input', () => validateName(firstName, firstNameError));
    lastName.addEventListener('input', () => validateName(lastName, lastNameError));
    email.addEventListener('input', () => validateEmail(email, emailError));
    contactNumber.addEventListener('input', () => validateContactNumber(contactNumber, contactNumberError));
    password.addEventListener('input', () => validatePassword(password, passwordError));
    confirmPassword.addEventListener('input', () => validateConfirmPassword(password, confirmPassword, confirmPasswordError));
    gender.addEventListener('change', () => validateGender(gender, genderError));
    age.addEventListener('input', () => validateAge(age, ageError));
    terms.addEventListener('change', () => validateTerms(terms, termsError));
    
    // Form submission
    registrationForm.addEventListener('submit', function(e) {
        e.preventDefault();
        
        // Hide any previous alerts
        errorAlert.classList.add('hidden');
        successAlert.classList.add('hidden');
        
        // Validate all fields
        const isFirstNameValid = validateName(firstName, firstNameError);
        const isLastNameValid = validateName(lastName, lastNameError);
        const isEmailValid = validateEmail(email, emailError);
        const isContactNumberValid = validateContactNumber(contactNumber, contactNumberError);
        const isPasswordValid = validatePassword(password, passwordError);
        const isConfirmPasswordValid = validateConfirmPassword(password, confirmPassword, confirmPasswordError);
        const isGenderValid = validateGender(gender, genderError);
        const isAgeValid = validateAge(age, ageError);
        const isTermsChecked = validateTerms(terms, termsError);
        
        // If all validations pass, submit the form
        if (isFirstNameValid && isLastNameValid && isEmailValid && isContactNumberValid && 
            isPasswordValid && isConfirmPasswordValid && isGenderValid && isAgeValid && isTermsChecked) {
            
            // Show loading state
            registerBtnText.classList.add('hidden');
            registerBtnLoading.classList.remove('hidden');
            registerBtn.disabled = true;
            
            // Prepare data for API
            const userData = {
                firstName: firstName.value.trim(),
                lastName: lastName.value.trim(),
                email: email.value.trim(),
                contactNumber: contactNumber.value.trim(),
                password: password.value,
                gender: gender.value,
                age: parseInt(age.value),
                role: document.getElementById('role').value // Hidden field with "User" value
            };
            
            // Send registration request
            fetch('/api/users', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(userData)
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
                // Show success message
                successAlert.classList.remove('hidden');
                
                // Reset form
                registrationForm.reset();
                
                // Redirect to login page after 2 seconds
                setTimeout(() => {
                    window.location.href = '/login';
                }, 2000);
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
                registerBtnText.classList.remove('hidden');
                registerBtnLoading.classList.add('hidden');
                registerBtn.disabled = false;
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
/**
 * User Profile JavaScript
 * Handles user profile functionality including:
 * - Loading user data
 * - Updating user profile
 * - Deleting user account
 * - Logging out
 */

document.addEventListener('DOMContentLoaded', function() {
    // DOM Elements
    const userProfileForm = document.getElementById('userProfileForm');
    const updateProfileBtn = document.getElementById('updateProfileBtn');
    const deleteAccountBtn = document.getElementById('deleteAccountBtn');
    const logoutBtn = document.getElementById('logoutBtn');
    const deleteModal = document.getElementById('deleteModal');
    const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');
    const cancelDeleteBtn = document.getElementById('cancelDeleteBtn');
    const loadingSpinner = document.getElementById('loadingSpinner');
    const successAlert = document.getElementById('successAlert');
    const errorAlert = document.getElementById('errorAlert');
    const successMessage = document.getElementById('successMessage');
    const errorMessage = document.getElementById('errorMessage');

    // Form fields
    const firstNameInput = document.getElementById('firstName');
    const lastNameInput = document.getElementById('lastName');
    const emailInput = document.getElementById('email');
    const contactNumberInput = document.getElementById('contactNumber');
    const roleInput = document.getElementById('role');
    const genderInput = document.getElementById('gender');
    const ageInput = document.getElementById('age');

    // Error message elements
    const firstNameError = document.getElementById('firstNameError');
    const lastNameError = document.getElementById('lastNameError');
    const emailError = document.getElementById('emailError');
    const contactNumberError = document.getElementById('contactNumberError');
    const genderError = document.getElementById('genderError');
    const ageError = document.getElementById('ageError');

    // Get userId from localStorage
    const userId = localStorage.getItem('normalUserId');
    
    // Redirect to login if no userId found
    if (!userId) {
        window.location.href = '/login';
        return;
    }

    // Load user data
    loadUserData();

    // Event Listeners
    userProfileForm.addEventListener('submit', handleUpdateProfile);
    deleteAccountBtn.addEventListener('click', showDeleteModal);
    confirmDeleteBtn.addEventListener('click', handleDeleteAccount);
    cancelDeleteBtn.addEventListener('click', hideDeleteModal);
    logoutBtn.addEventListener('click', handleLogout);

    /**
     * Load user data from API
     */
    function loadUserData() {
        showLoading();
        
        fetch(`/api/users/${userId}`)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Failed to load user data');
                }
                return response.json();
            })
            .then(userData => {
                populateUserForm(userData);
                hideLoading();
            })
            .catch(error => {
                showError('Error loading user data: ' + error.message);
                hideLoading();
            });
    }

    /**
     * Populate form with user data
     */
    function populateUserForm(userData) {
        firstNameInput.value = userData.firstName || '';
        lastNameInput.value = userData.lastName || '';
        emailInput.value = userData.email || '';
        contactNumberInput.value = userData.contactNumber || '';
        roleInput.value = userData.role || '';
        genderInput.value = userData.gender || '';
        ageInput.value = userData.age || '';
    }

    /**
     * Handle update profile form submission
     */
    function handleUpdateProfile(event) {
        event.preventDefault();
        
        // Reset error messages
        resetErrors();
        
        // Validate form
        if (!validateForm()) {
            return;
        }
        
        // Prepare update data
        const updateData = {
            firstName: firstNameInput.value.trim(),
            lastName: lastNameInput.value.trim(),
            email: emailInput.value.trim(),
            contactNumber: contactNumberInput.value.trim(),
            gender: genderInput.value,
            age: parseInt(ageInput.value)
        };
        
        // Send update request
        showLoading();
        
        fetch(`/api/users/${userId}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(updateData)
        })
        .then(response => {
            if (!response.ok) {
                return response.text().then(text => {
                    throw new Error(text || 'Failed to update profile');
                });
            }
            return response.json();
        })
        .then(updatedUser => {
            showSuccess('Profile updated successfully');
            populateUserForm(updatedUser);
            hideLoading();
        })
        .catch(error => {
            showError('Error updating profile: ' + error.message);
            hideLoading();
        });
    }

    /**
     * Handle delete account
     */
    function handleDeleteAccount() {
        showLoading();
        hideDeleteModal();
        
        fetch(`/api/users/${userId}`, {
            method: 'DELETE'
        })
        .then(response => {
            if (!response.ok) {
                return response.text().then(text => {
                    throw new Error(text || 'Failed to delete account');
                });
            }
            return response.text();
        })
        .then(() => {
            // Clear localStorage and redirect to home
            localStorage.removeItem('normalUserId');
            showSuccess('Account deleted successfully');
            
            // Redirect after a short delay
            setTimeout(() => {
                window.location.href = '/';
            }, 1500);
        })
        .catch(error => {
            showError('Error deleting account: ' + error.message);
            hideLoading();
        });
    }

    /**
     * Handle logout
     */
    function handleLogout() {
        // Clear localStorage
        localStorage.removeItem('normalUserId');
        
        // Redirect to home
        window.location.href = '/';
    }

    /**
     * Form validation
     */
    function validateForm() {
        let isValid = true;
        
        // First Name validation
        if (!firstNameInput.value.trim()) {
            showFieldError(firstNameError, 'First name is required');
            isValid = false;
        } else if (!/^[A-Za-z\s]{2,50}$/.test(firstNameInput.value.trim())) {
            showFieldError(firstNameError, 'First name should contain only letters and be 2-50 characters long');
            isValid = false;
        }
        
        // Last Name validation
        if (!lastNameInput.value.trim()) {
            showFieldError(lastNameError, 'Last name is required');
            isValid = false;
        } else if (!/^[A-Za-z\s]{2,50}$/.test(lastNameInput.value.trim())) {
            showFieldError(lastNameError, 'Last name should contain only letters and be 2-50 characters long');
            isValid = false;
        }
        
        // Email validation
        if (!emailInput.value.trim()) {
            showFieldError(emailError, 'Email is required');
            isValid = false;
        } else if (!/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(emailInput.value.trim())) {
            showFieldError(emailError, 'Please enter a valid email address');
            isValid = false;
        }
        
        // Contact Number validation
        if (!contactNumberInput.value.trim()) {
            showFieldError(contactNumberError, 'Contact number is required');
            isValid = false;
        } else if (!/^[0-9]{10}$/.test(contactNumberInput.value.trim())) {
            showFieldError(contactNumberError, 'Contact number should be 10 digits');
            isValid = false;
        }
        
        // Gender validation
        if (!genderInput.value) {
            showFieldError(genderError, 'Please select a gender');
            isValid = false;
        }
        
        // Age validation
        if (!ageInput.value) {
            showFieldError(ageError, 'Age is required');
            isValid = false;
        } else {
            const age = parseInt(ageInput.value);
            if (isNaN(age) || age < 18 || age > 65) {
                showFieldError(ageError, 'Age must be between 18 and 65');
                isValid = false;
            }
        }
        
        return isValid;
    }

    /**
     * Show field error
     */
    function showFieldError(element, message) {
        element.textContent = message;
        element.classList.remove('hidden');
    }

    /**
     * Reset all error messages
     */
    function resetErrors() {
        const errorElements = [
            firstNameError, lastNameError, emailError, 
            contactNumberError, genderError, ageError
        ];
        
        errorElements.forEach(element => {
            element.textContent = '';
            element.classList.add('hidden');
        });
        
        errorAlert.classList.add('hidden');
    }

    /**
     * Show delete confirmation modal
     */
    function showDeleteModal() {
        deleteModal.classList.remove('hidden');
    }

    /**
     * Hide delete confirmation modal
     */
    function hideDeleteModal() {
        deleteModal.classList.add('hidden');
    }

    /**
     * Show loading spinner
     */
    function showLoading() {
        loadingSpinner.classList.remove('hidden');
    }

    /**
     * Hide loading spinner
     */
    function hideLoading() {
        loadingSpinner.classList.add('hidden');
    }

    /**
     * Show success message
     */
    function showSuccess(message) {
        successMessage.textContent = message;
        successAlert.classList.remove('hidden');
        
        // Auto hide after 5 seconds
        setTimeout(() => {
            successAlert.classList.add('hidden');
        }, 5000);
    }

    /**
     * Show error message
     */
    function showError(message) {
        errorMessage.textContent = message;
        errorAlert.classList.remove('hidden');
        
        // Auto hide after 5 seconds
        setTimeout(() => {
            errorAlert.classList.add('hidden');
        }, 5000);
    }
});
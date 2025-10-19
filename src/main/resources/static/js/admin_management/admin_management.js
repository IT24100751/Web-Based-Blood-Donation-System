/**
 * Admin Management JavaScript
 * Handles CRUD operations for admin management
 */

document.addEventListener('DOMContentLoaded', function() {
    // Initialize the page
    loadAdmins();
    setupEventListeners();
    setupFormValidation();
});

// API endpoints
const API_URL = '/api/admins';

// Regex patterns for validation
const PATTERNS = {
    name: /^[A-Za-z\s]{2,50}$/,
    email: /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/,
    password: /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/
};

/**
 * Setup event listeners for buttons and forms
 */
function setupEventListeners() {
    // Add admin button
    document.getElementById('addAdminBtn').addEventListener('click', function() {
        openModal('createAdminModal');
    });
    
    // Create admin form submission
    document.getElementById('createAdminForm').addEventListener('submit', function(e) {
        e.preventDefault();
        if (validateCreateForm()) {
            createAdmin();
        }
    });
    
    // Update admin form submission
    document.getElementById('updateAdminForm').addEventListener('submit', function(e) {
        e.preventDefault();
        if (validateUpdateForm()) {
            updateAdmin();
        }
    });
    
    // Reset password form submission
    document.getElementById('resetPasswordForm').addEventListener('submit', function(e) {
        e.preventDefault();
        if (validatePasswordForm()) {
            resetPassword();
        }
    });
    
    // Confirm delete button
    document.getElementById('confirmDeleteBtn').addEventListener('click', function() {
        deleteAdmin();
    });
    
    // Close modal buttons
    document.querySelectorAll('.modal-close').forEach(function(button) {
        button.addEventListener('click', function() {
            closeAllModals();
        });
    });
    
    // Modal overlay click to close
    document.querySelectorAll('.modal-overlay').forEach(function(overlay) {
        overlay.addEventListener('click', function() {
            closeAllModals();
        });
    });
    
    // Search input
    document.getElementById('searchInput').addEventListener('keyup', function() {
        filterAdmins();
    });
}

/**
 * Setup form validation for all forms
 */
function setupFormValidation() {
    // Create form validation
    document.getElementById('firstName').addEventListener('blur', function() {
        validateField(this, 'firstNameError', PATTERNS.name);
    });
    
    document.getElementById('lastName').addEventListener('blur', function() {
        validateField(this, 'lastNameError', PATTERNS.name);
    });
    
    document.getElementById('email').addEventListener('blur', function() {
        validateField(this, 'emailError', PATTERNS.email);
    });
    
    document.getElementById('password').addEventListener('blur', function() {
        validateField(this, 'passwordError', PATTERNS.password);
    });
    
    // Update form validation
    document.getElementById('updateFirstName').addEventListener('blur', function() {
        validateField(this, 'updateFirstNameError', PATTERNS.name);
    });
    
    document.getElementById('updateLastName').addEventListener('blur', function() {
        validateField(this, 'updateLastNameError', PATTERNS.name);
    });
    
    document.getElementById('updateEmail').addEventListener('blur', function() {
        validateField(this, 'updateEmailError', PATTERNS.email);
    });
    
    // Reset password form validation
    document.getElementById('newPassword').addEventListener('blur', function() {
        validateField(this, 'newPasswordError', PATTERNS.password);
    });
}

/**
 * Load all admins from the API
 */
function loadAdmins() {
    showLoading(true);
    hideError();
    
    fetch(API_URL)
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to load admins');
            }
            return response.json();
        })
        .then(data => {
            renderAdminTable(data);
            showLoading(false);
        })
        .catch(error => {
            showError('Error loading admins: ' + error.message);
            showLoading(false);
        });
}

/**
 * Render the admin table with data
 */
function renderAdminTable(admins) {
    const tableBody = document.getElementById('adminTableBody');
    tableBody.innerHTML = '';
    
    if (admins.length === 0) {
        document.getElementById('noDataMessage').classList.remove('hidden');
        return;
    }
    
    document.getElementById('noDataMessage').classList.add('hidden');
    
    admins.forEach(admin => {
        const row = document.createElement('tr');
        
        row.innerHTML = `
            <td class="px-6 py-4 whitespace-nowrap">
                <div class="text-sm text-gray-900">${admin.adminId || 'N/A'}</div>
            </td>
            <td class="px-6 py-4 whitespace-nowrap">
                <div class="text-sm text-gray-900">${admin.firstName} ${admin.lastName}</div>
            </td>
            <td class="px-6 py-4 whitespace-nowrap">
                <div class="text-sm text-gray-900">${admin.email}</div>
            </td>
            <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                <button class="text-blue-600 hover:text-blue-900 mr-3 edit-btn" data-id="${admin.id}">
                    <i class="fas fa-edit"></i>
                </button>
                <button class="text-red-600 hover:text-red-900 mr-3 delete-btn" data-id="${admin.id}">
                    <i class="fas fa-trash-alt"></i>
                </button>
                <button class="text-green-600 hover:text-green-900 reset-password-btn" data-id="${admin.id}">
                    <i class="fas fa-key"></i>
                </button>
            </td>
        `;
        
        tableBody.appendChild(row);
    });
    
    // Add event listeners to action buttons
    document.querySelectorAll('.edit-btn').forEach(button => {
        button.addEventListener('click', function() {
            const adminId = this.getAttribute('data-id');
            openEditModal(adminId);
        });
    });
    
    document.querySelectorAll('.delete-btn').forEach(button => {
        button.addEventListener('click', function() {
            const adminId = this.getAttribute('data-id');
            openDeleteModal(adminId);
        });
    });
    
    document.querySelectorAll('.reset-password-btn').forEach(button => {
        button.addEventListener('click', function() {
            const adminId = this.getAttribute('data-id');
            openResetPasswordModal(adminId);
        });
    });
}

/**
 * Create a new admin
 */
function createAdmin() {
    const adminData = {
        firstName: document.getElementById('firstName').value,
        lastName: document.getElementById('lastName').value,
        email: document.getElementById('email').value,
        password: document.getElementById('password').value
    };
    
    showLoading(true);
    
    fetch(API_URL, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(adminData)
    })
    .then(response => {
        if (!response.ok) {
            return response.text().then(text => {
                throw new Error(text || 'Failed to create admin');
            });
        }
        return response.json();
    })
    .then(data => {
        showLoading(false);
        closeAllModals();
        loadAdmins();
        resetForm('createAdminForm');
    })
    .catch(error => {
        showLoading(false);
        showError('Error creating admin: ' + error.message);
    });
}

/**
 * Open edit modal and populate with admin data
 */
function openEditModal(adminId) {
    showLoading(true);
    
    fetch(`${API_URL}/${adminId}`)
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to load admin details');
            }
            return response.json();
        })
        .then(admin => {
            document.getElementById('updateAdminId').value = admin.id;
            document.getElementById('updateFirstName').value = admin.firstName;
            document.getElementById('updateLastName').value = admin.lastName;
            document.getElementById('updateEmail').value = admin.email;
            
            openModal('updateAdminModal');
            showLoading(false);
        })
        .catch(error => {
            showLoading(false);
            showError('Error loading admin details: ' + error.message);
        });
}

/**
 * Update an existing admin
 */
function updateAdmin() {
    const adminId = document.getElementById('updateAdminId').value;
    const adminData = {
        firstName: document.getElementById('updateFirstName').value,
        lastName: document.getElementById('updateLastName').value,
        email: document.getElementById('updateEmail').value
    };
    
    showLoading(true);
    
    fetch(`${API_URL}/${adminId}`, {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(adminData)
    })
    .then(response => {
        if (!response.ok) {
            return response.text().then(text => {
                throw new Error(text || 'Failed to update admin');
            });
        }
        return response.json();
    })
    .then(data => {
        showLoading(false);
        closeAllModals();
        loadAdmins();
    })
    .catch(error => {
        showLoading(false);
        showError('Error updating admin: ' + error.message);
    });
}

/**
 * Open delete confirmation modal
 */
function openDeleteModal(adminId) {
    document.getElementById('deleteAdminId').value = adminId;
    openModal('deleteConfirmModal');
}

/**
 * Delete an admin
 */
function deleteAdmin() {
    const adminId = document.getElementById('deleteAdminId').value;
    
    showLoading(true);
    
    fetch(`${API_URL}/${adminId}`, {
        method: 'DELETE'
    })
    .then(response => {
        if (!response.ok) {
            return response.text().then(text => {
                throw new Error(text || 'Failed to delete admin');
            });
        }
        return response.text();
    })
    .then(() => {
        showLoading(false);
        closeAllModals();
        loadAdmins();
    })
    .catch(error => {
        showLoading(false);
        showError('Error deleting admin: ' + error.message);
    });
}

/**
 * Open reset password modal
 */
function openResetPasswordModal(adminId) {
    document.getElementById('resetPasswordAdminId').value = adminId;
    openModal('resetPasswordModal');
}

/**
 * Reset admin password
 */
function resetPassword() {
    const adminId = document.getElementById('resetPasswordAdminId').value;
    const passwordData = {
        newPassword: document.getElementById('newPassword').value
    };
    
    showLoading(true);
    
    fetch(`${API_URL}/${adminId}/reset-password`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(passwordData)
    })
    .then(response => {
        if (!response.ok) {
            return response.text().then(text => {
                throw new Error(text || 'Failed to reset password');
            });
        }
        return response.text();
    })
    .then(() => {
        showLoading(false);
        closeAllModals();
        resetForm('resetPasswordForm');
    })
    .catch(error => {
        showLoading(false);
        showError('Error resetting password: ' + error.message);
    });
}

/**
 * Filter admins based on search input
 */
function filterAdmins() {
    const searchText = document.getElementById('searchInput').value.toLowerCase();
    const rows = document.querySelectorAll('#adminTableBody tr');
    let hasVisibleRows = false;
    
    rows.forEach(row => {
        const adminId = row.querySelector('td:nth-child(1)').textContent.toLowerCase();
        const name = row.querySelector('td:nth-child(2)').textContent.toLowerCase();
        const email = row.querySelector('td:nth-child(3)').textContent.toLowerCase();
        
        if (adminId.includes(searchText) || name.includes(searchText) || email.includes(searchText)) {
            row.style.display = '';
            hasVisibleRows = true;
        } else {
            row.style.display = 'none';
        }
    });
    
    // Show/hide no data message
    if (hasVisibleRows) {
        document.getElementById('noDataMessage').classList.add('hidden');
    } else {
        document.getElementById('noDataMessage').classList.remove('hidden');
    }
}

/**
 * Validate a form field
 */
function validateField(field, errorId, pattern) {
    const errorElement = document.getElementById(errorId);
    
    if (!field.value.trim()) {
        errorElement.textContent = `${field.placeholder} is required.`;
        errorElement.classList.remove('hidden');
        return false;
    }
    
    if (!pattern.test(field.value)) {
        errorElement.classList.remove('hidden');
        return false;
    }
    
    errorElement.classList.add('hidden');
    return true;
}

/**
 * Validate create admin form
 */
function validateCreateForm() {
    const firstNameValid = validateField(document.getElementById('firstName'), 'firstNameError', PATTERNS.name);
    const lastNameValid = validateField(document.getElementById('lastName'), 'lastNameError', PATTERNS.name);
    const emailValid = validateField(document.getElementById('email'), 'emailError', PATTERNS.email);
    const passwordValid = validateField(document.getElementById('password'), 'passwordError', PATTERNS.password);
    
    return firstNameValid && lastNameValid && emailValid && passwordValid;
}

/**
 * Validate update admin form
 */
function validateUpdateForm() {
    const firstNameValid = validateField(document.getElementById('updateFirstName'), 'updateFirstNameError', PATTERNS.name);
    const lastNameValid = validateField(document.getElementById('updateLastName'), 'updateLastNameError', PATTERNS.name);
    const emailValid = validateField(document.getElementById('updateEmail'), 'updateEmailError', PATTERNS.email);
    
    return firstNameValid && lastNameValid && emailValid;
}

/**
 * Validate reset password form
 */
function validatePasswordForm() {
    return validateField(document.getElementById('newPassword'), 'newPasswordError', PATTERNS.password);
}

/**
 * Reset form fields
 */
function resetForm(formId) {
    document.getElementById(formId).reset();
    
    // Hide all error messages
    document.querySelectorAll(`#${formId} .text-red-500`).forEach(element => {
        element.classList.add('hidden');
    });
}

/**
 * Open a modal
 */
function openModal(modalId) {
    const modal = document.getElementById(modalId);
    modal.classList.remove('opacity-0', 'pointer-events-none');
    document.body.classList.add('modal-active');
}

/**
 * Close all modals
 */
function closeAllModals() {
    document.querySelectorAll('.modal').forEach(modal => {
        modal.classList.add('opacity-0', 'pointer-events-none');
    });
    document.body.classList.remove('modal-active');
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
document.addEventListener('DOMContentLoaded', function() {
    // Initialize
    loadUsers();
    
    // Event Listeners
    document.getElementById('createUserBtn').addEventListener('click', function() {
        openModal('createUserModal');
    });
    
    document.getElementById('createUserForm').addEventListener('submit', function(e) {
        e.preventDefault();
        if (validateCreateForm()) {
            createUser();
        }
    });
    
    document.getElementById('updateUserForm').addEventListener('submit', function(e) {
        e.preventDefault();
        if (validateUpdateForm()) {
            updateUser();
        }
    });
    
    document.getElementById('resetPasswordForm').addEventListener('submit', function(e) {
        e.preventDefault();
        if (validateResetPasswordForm()) {
            resetPassword();
        }
    });
    
    document.getElementById('confirmDeleteBtn').addEventListener('click', deleteUser);
    
    document.getElementById('searchInput').addEventListener('input', function() {
        filterUsers(this.value);
    });
    
    // Add event listeners for password visibility toggles
    setupPasswordToggles();
});

// Regex patterns for validation
const patterns = {
    name: /^[A-Za-z\s]{2,30}$/,
    email: /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/,
    password: /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*#?&]{8,}$/,
    contactNumber: /^[0-9]{10}$/,
    age: /^(1[8-9]|[2-9][0-9]|100)$/
};

// Load all users
function loadUsers() {
    showLoading(true);
    hideError();
    
    fetch('/api/users')
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to load users');
            }
            return response.json();
        })
        .then(data => {
            renderUsers(data);
            showLoading(false);
        })
        .catch(error => {
            showError(error.message);
            showLoading(false);
        });
}

// Render users in the table
function renderUsers(users) {
    const tableBody = document.getElementById('userTableBody');
    const noDataMessage = document.getElementById('noDataMessage');
    
    tableBody.innerHTML = '';
    
    if (users.length === 0) {
        noDataMessage.classList.remove('hidden');
        return;
    }
    
    noDataMessage.classList.add('hidden');
    
    users.forEach(user => {
        const row = document.createElement('tr');
        row.className = 'hover:bg-gray-50';
        
        const fullName = `${user.firstName} ${user.lastName}`;
        
        row.innerHTML = `
            <td class="py-3 px-4 border-b">${user.id}</td>
            <td class="py-3 px-4 border-b">${fullName}</td>
            <td class="py-3 px-4 border-b">${user.email}</td>
            <td class="py-3 px-4 border-b">${user.contactNumber}</td>
            <td class="py-3 px-4 border-b">${capitalizeFirstLetter(user.role)}</td>
            <td class="py-3 px-4 border-b">${capitalizeFirstLetter(user.gender)}</td>
            <td class="py-3 px-4 border-b">${user.age}</td>
            <td class="py-3 px-4 border-b">
                <div class="flex space-x-2">
                    <button class="text-blue-600 hover:text-blue-800" onclick="openUpdateModal(${user.id})">
                        <i class="fas fa-edit"></i>
                    </button>
                    <button class="text-green-600 hover:text-green-800" onclick="openResetPasswordModal(${user.id})">
                        <i class="fas fa-key"></i>
                    </button>
                    <button class="text-red-600 hover:text-red-800" onclick="openDeleteModal(${user.id})">
                        <i class="fas fa-trash"></i>
                    </button>
                </div>
            </td>
        `;
        
        tableBody.appendChild(row);
    });
}

// Create a new user
function createUser() {
    showLoading(true);
    hideError();
    
    const userData = {
        firstName: document.getElementById('createFirstName').value,
        lastName: document.getElementById('createLastName').value,
        email: document.getElementById('createEmail').value,
        password: document.getElementById('createPassword').value,
        contactNumber: document.getElementById('createContactNumber').value,
        role: document.getElementById('createRole').value,
        gender: document.getElementById('createGender').value,
        age: parseInt(document.getElementById('createAge').value)
    };
    
    fetch('/api/users', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(userData)
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Failed to create user');
        }
        return response.json();
    })
    .then(() => {
        closeModal('createUserModal');
        resetForm('createUserForm');
        loadUsers();
        showLoading(false);
    })
    .catch(error => {
        showError(error.message);
        showLoading(false);
    });
}

// Open update modal and populate with user data
function openUpdateModal(userId) {
    showLoading(true);
    hideError();
    
    fetch(`/api/users/${userId}`)
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to fetch user details');
            }
            return response.json();
        })
        .then(user => {
            document.getElementById('updateUserId').value = user.id;
            document.getElementById('updateFirstName').value = user.firstName;
            document.getElementById('updateLastName').value = user.lastName;
            document.getElementById('updateEmail').value = user.email;
            document.getElementById('updateContactNumber').value = user.contactNumber;
            document.getElementById('updateRole').value = user.role;
            document.getElementById('updateGender').value = user.gender;
            document.getElementById('updateAge').value = user.age;
            
            openModal('updateUserModal');
            showLoading(false);
        })
        .catch(error => {
            showError(error.message);
            showLoading(false);
        });
}

// Update an existing user
function updateUser() {
    showLoading(true);
    hideError();
    
    const userId = document.getElementById('updateUserId').value;
    const userData = {
        firstName: document.getElementById('updateFirstName').value,
        lastName: document.getElementById('updateLastName').value,
        email: document.getElementById('updateEmail').value,
        contactNumber: document.getElementById('updateContactNumber').value,
        role: document.getElementById('updateRole').value,
        gender: document.getElementById('updateGender').value,
        age: parseInt(document.getElementById('updateAge').value)
    };
    
    fetch(`/api/users/${userId}`, {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(userData)
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Failed to update user');
        }
        return response.json();
    })
    .then(() => {
        closeModal('updateUserModal');
        loadUsers();
        showLoading(false);
    })
    .catch(error => {
        showError(error.message);
        showLoading(false);
    });
}

// Open reset password modal
function openResetPasswordModal(userId) {
    document.getElementById('resetPasswordUserId').value = userId;
    openModal('resetPasswordModal');
}

// Reset user password
function resetPassword() {
    showLoading(true);
    hideError();
    
    const userId = document.getElementById('resetPasswordUserId').value;
    const newPassword = document.getElementById('newPassword').value;
    
    fetch(`/api/users/${userId}/reset-password`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ password: newPassword })
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Failed to reset password');
        }
        return response.json();
    })
    .then(() => {
        closeModal('resetPasswordModal');
        resetForm('resetPasswordForm');
        showLoading(false);
    })
    .catch(error => {
        showError(error.message);
        showLoading(false);
    });
}

// Open delete confirmation modal
function openDeleteModal(userId) {
    document.getElementById('deleteUserId').value = userId;
    openModal('deleteConfirmModal');
}

// Delete a user
function deleteUser() {
    showLoading(true);
    hideError();
    
    const userId = document.getElementById('deleteUserId').value;
    
    fetch(`/api/users/${userId}`, {
        method: 'DELETE'
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Failed to delete user');
        }
        return response.json();
    })
    .then(() => {
        closeModal('deleteConfirmModal');
        loadUsers();
        showLoading(false);
    })
    .catch(error => {
        showError(error.message);
        showLoading(false);
    });
}

// Filter users based on search input
function filterUsers(searchTerm) {
    if (!searchTerm) {
        loadUsers();
        return;
    }
    
    searchTerm = searchTerm.toLowerCase();
    
    const tableBody = document.getElementById('userTableBody');
    const rows = tableBody.getElementsByTagName('tr');
    const noDataMessage = document.getElementById('noDataMessage');
    
    let visibleCount = 0;
    
    for (let i = 0; i < rows.length; i++) {
        const name = rows[i].cells[1].textContent.toLowerCase();
        const email = rows[i].cells[2].textContent.toLowerCase();
        const role = rows[i].cells[4].textContent.toLowerCase();
        
        if (name.includes(searchTerm) || email.includes(searchTerm) || role.includes(searchTerm)) {
            rows[i].style.display = '';
            visibleCount++;
        } else {
            rows[i].style.display = 'none';
        }
    }
    
    if (visibleCount === 0) {
        noDataMessage.classList.remove('hidden');
    } else {
        noDataMessage.classList.add('hidden');
    }
}

// Validate create user form
function validateCreateForm() {
    let isValid = true;
    
    // First Name validation
    const firstName = document.getElementById('createFirstName');
    if (!patterns.name.test(firstName.value)) {
        showValidationError('createFirstNameError', true);
        isValid = false;
    } else {
        showValidationError('createFirstNameError', false);
    }
    
    // Last Name validation
    const lastName = document.getElementById('createLastName');
    if (!patterns.name.test(lastName.value)) {
        showValidationError('createLastNameError', true);
        isValid = false;
    } else {
        showValidationError('createLastNameError', false);
    }
    
    // Email validation
    const email = document.getElementById('createEmail');
    if (!patterns.email.test(email.value)) {
        showValidationError('createEmailError', true);
        isValid = false;
    } else {
        showValidationError('createEmailError', false);
    }
    
    // Password validation
    const password = document.getElementById('createPassword');
    if (!patterns.password.test(password.value)) {
        showValidationError('createPasswordError', true);
        isValid = false;
    } else {
        showValidationError('createPasswordError', false);
    }
    
    // Contact Number validation
    const contactNumber = document.getElementById('createContactNumber');
    if (!patterns.contactNumber.test(contactNumber.value)) {
        showValidationError('createContactNumberError', true);
        isValid = false;
    } else {
        showValidationError('createContactNumberError', false);
    }
    
    // Role validation
    const role = document.getElementById('createRole');
    if (!role.value) {
        showValidationError('createRoleError', true);
        isValid = false;
    } else {
        showValidationError('createRoleError', false);
    }
    
    // Gender validation
    const gender = document.getElementById('createGender');
    if (!gender.value) {
        showValidationError('createGenderError', true);
        isValid = false;
    } else {
        showValidationError('createGenderError', false);
    }
    
    // Age validation
    const age = document.getElementById('createAge');
    if (!patterns.age.test(age.value)) {
        showValidationError('createAgeError', true);
        isValid = false;
    } else {
        showValidationError('createAgeError', false);
    }
    
    return isValid;
}

// Validate update user form
function validateUpdateForm() {
    let isValid = true;
    
    // First Name validation
    const firstName = document.getElementById('updateFirstName');
    if (!patterns.name.test(firstName.value)) {
        showValidationError('updateFirstNameError', true);
        isValid = false;
    } else {
        showValidationError('updateFirstNameError', false);
    }
    
    // Last Name validation
    const lastName = document.getElementById('updateLastName');
    if (!patterns.name.test(lastName.value)) {
        showValidationError('updateLastNameError', true);
        isValid = false;
    } else {
        showValidationError('updateLastNameError', false);
    }
    
    // Email validation
    const email = document.getElementById('updateEmail');
    if (!patterns.email.test(email.value)) {
        showValidationError('updateEmailError', true);
        isValid = false;
    } else {
        showValidationError('updateEmailError', false);
    }
    
    // Contact Number validation
    const contactNumber = document.getElementById('updateContactNumber');
    if (!patterns.contactNumber.test(contactNumber.value)) {
        showValidationError('updateContactNumberError', true);
        isValid = false;
    } else {
        showValidationError('updateContactNumberError', false);
    }
    
    // Role validation
    const role = document.getElementById('updateRole');
    if (!role.value) {
        showValidationError('updateRoleError', true);
        isValid = false;
    } else {
        showValidationError('updateRoleError', false);
    }
    
    // Gender validation
    const gender = document.getElementById('updateGender');
    if (!gender.value) {
        showValidationError('updateGenderError', true);
        isValid = false;
    } else {
        showValidationError('updateGenderError', false);
    }
    
    // Age validation
    const age = document.getElementById('updateAge');
    if (!patterns.age.test(age.value)) {
        showValidationError('updateAgeError', true);
        isValid = false;
    } else {
        showValidationError('updateAgeError', false);
    }
    
    return isValid;
}

// Validate reset password form
function validateResetPasswordForm() {
    let isValid = true;
    
    // New Password validation
    const newPassword = document.getElementById('newPassword');
    if (!patterns.password.test(newPassword.value)) {
        showValidationError('newPasswordError', true);
        isValid = false;
    } else {
        showValidationError('newPasswordError', false);
    }
    
    // Confirm Password validation
    const confirmPassword = document.getElementById('confirmPassword');
    if (newPassword.value !== confirmPassword.value) {
        showValidationError('confirmPasswordError', true);
        isValid = false;
    } else {
        showValidationError('confirmPasswordError', false);
    }
    
    return isValid;
}

// Show/hide validation error message
function showValidationError(elementId, show) {
    const element = document.getElementById(elementId);
    if (show) {
        element.classList.remove('hidden');
    } else {
        element.classList.add('hidden');
    }
}

// Reset form fields
function resetForm(formId) {
    document.getElementById(formId).reset();
    
    // Hide all error messages
    const errorElements = document.getElementById(formId).querySelectorAll('[id$="Error"]');
    errorElements.forEach(element => {
        element.classList.add('hidden');
    });
}

// Open modal
function openModal(modalId) {
    const modal = document.getElementById(modalId);
    modal.classList.remove('hidden');
    modal.classList.add('flex');
}

// Close modal
function closeModal(modalId) {
    const modal = document.getElementById(modalId);
    modal.classList.remove('flex');
    modal.classList.add('hidden');
}

// Show/hide loading indicator
function showLoading(show) {
    const loadingIndicator = document.getElementById('loadingIndicator');
    if (show) {
        loadingIndicator.classList.remove('hidden');
        loadingIndicator.classList.add('flex');
    } else {
        loadingIndicator.classList.remove('flex');
        loadingIndicator.classList.add('hidden');
    }
}

// Show error message
function showError(message) {
    const errorMessage = document.getElementById('errorMessage');
    const errorText = document.getElementById('errorText');
    
    errorText.textContent = message;
    errorMessage.classList.remove('hidden');
}

// Hide error message
function hideError() {
    const errorMessage = document.getElementById('errorMessage');
    errorMessage.classList.add('hidden');
}

// Toggle password visibility
function togglePasswordVisibility(inputId, toggleId) {
    const input = document.getElementById(inputId);
    const toggle = document.getElementById(toggleId);
    
    if (input.type === 'password') {
        input.type = 'text';
        toggle.classList.remove('fa-eye');
        toggle.classList.add('fa-eye-slash');
    } else {
        input.type = 'password';
        toggle.classList.remove('fa-eye-slash');
        toggle.classList.add('fa-eye');
    }
}

// Setup password visibility toggles
function setupPasswordToggles() {
    const passwordFields = [
        { input: 'createPassword', toggle: 'createPasswordToggle' },
        { input: 'newPassword', toggle: 'newPasswordToggle' },
        { input: 'confirmPassword', toggle: 'confirmPasswordToggle' }
    ];
    
    passwordFields.forEach(field => {
        const toggleButton = document.getElementById(field.toggle).parentElement;
        toggleButton.addEventListener('click', function() {
            togglePasswordVisibility(field.input, field.toggle);
        });
    });
}

// Capitalize first letter of a string
function capitalizeFirstLetter(string) {
    if (!string) return '';
    return string.charAt(0).toUpperCase() + string.slice(1);
}
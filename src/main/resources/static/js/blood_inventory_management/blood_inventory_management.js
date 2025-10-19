/**
 * Blood Inventory Management JavaScript
 * Handles CRUD operations for blood inventory
 */

document.addEventListener('DOMContentLoaded', function() {
    // Initialize the page
    setupEventListeners();
    loadBloodInventory();
    setupDateValidation();
    displayAdminName();
});

// API endpoints
const API_BASE_URL = '/api/blood-inventory';

// Regex patterns for validation
const PATTERNS = {
    positiveNumber: /^[1-9]\d*$/
};

/**
 * Setup event listeners for buttons and forms
 */
function setupEventListeners() {
    // Create inventory button
    document.getElementById('createInventoryBtn').addEventListener('click', function() {
        openModal('createInventoryModal');
    });

    // Create inventory form submission
    document.getElementById('createInventoryForm').addEventListener('submit', function(e) {
        e.preventDefault();
        if (validateCreateForm()) {
            createBloodInventory();
        }
    });

    // Update inventory form submission
    document.getElementById('updateInventoryForm').addEventListener('submit', function(e) {
        e.preventDefault();
        if (validateUpdateForm()) {
            updateBloodInventory();
        }
    });

    // Confirm delete button
    document.getElementById('confirmDeleteBtn').addEventListener('click', function() {
        deleteBloodInventory();
    });

    // Search input
    document.getElementById('searchInput').addEventListener('input', function() {
        filterTable();
    });

    // Blood type filter
    document.getElementById('bloodTypeFilter').addEventListener('change', function() {
        filterTable();
    });
}

/**
 * Setup date validation to prevent past dates
 */
function setupDateValidation() {
    const today = new Date().toISOString().split('T')[0];
    
    // Set min date for create form
    const createDateInput = document.getElementById('createExpiryDate');
    createDateInput.min = today;
    
    // Set min date for update form
    const updateDateInput = document.getElementById('updateExpiryDate');
    updateDateInput.min = today;
}

/**
 * Display admin name from session storage
 */
function displayAdminName() {
    const adminNameElement = document.getElementById('adminName');
    const adminName = sessionStorage.getItem('adminName');
    
    if (adminName) {
        adminNameElement.textContent = adminName;
        adminNameElement.classList.remove('hidden');
    }
}

/**
 * Load all blood inventory records
 */
function loadBloodInventory() {
    showLoading(true);
    hideError();
    
    fetch(API_BASE_URL)
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to load blood inventory data');
            }
            return response.json();
        })
        .then(data => {
            renderBloodInventoryTable(data);
            showLoading(false);
        })
        .catch(error => {
            showError(error.message);
            showLoading(false);
        });
}

/**
 * Load blood inventory by blood type
 */
function loadBloodInventoryByType(bloodType) {
    if (!bloodType) {
        loadBloodInventory();
        return;
    }
    
    showLoading(true);
    hideError();
    
    fetch(`${API_BASE_URL}/type/${bloodType}`)
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to load blood inventory data');
            }
            return response.json();
        })
        .then(data => {
            renderBloodInventoryTable(data);
            showLoading(false);
        })
        .catch(error => {
            showError(error.message);
            showLoading(false);
        });
}

/**
 * Render blood inventory table
 */
function renderBloodInventoryTable(inventoryList) {
    const tableBody = document.getElementById('inventoryTableBody');
    const noDataMessage = document.getElementById('noDataMessage');
    
    tableBody.innerHTML = '';
    
    if (inventoryList.length === 0) {
        noDataMessage.classList.remove('hidden');
        return;
    }
    
    noDataMessage.classList.add('hidden');
    
    inventoryList.forEach(inventory => {
        const row = document.createElement('tr');
        row.className = 'hover:bg-gray-50';
        row.setAttribute('data-id', inventory.id);
        row.setAttribute('data-blood-type', inventory.bloodType);
        
        // Format date for display
        const expiryDate = new Date(inventory.expiryDate).toLocaleDateString();
        
        row.innerHTML = `
            <td class="py-3 px-4 border-b">${inventory.id}</td>
            <td class="py-3 px-4 border-b">${inventory.bloodType}</td>
            <td class="py-3 px-4 border-b">${inventory.instockAmount}</td>
            <td class="py-3 px-4 border-b">${expiryDate}</td>
            <td class="py-3 px-4 border-b">
                <div class="flex space-x-2">
                    <button class="text-blue-600 hover:text-blue-800" onclick="openUpdateModal(${inventory.id})">
                        <i class="fas fa-edit"></i>
                    </button>
                    <button class="text-red-600 hover:text-red-800" onclick="openDeleteModal(${inventory.id})">
                        <i class="fas fa-trash-alt"></i>
                    </button>
                </div>
            </td>
        `;
        
        tableBody.appendChild(row);
    });
}

/**
 * Create new blood inventory
 */
function createBloodInventory() {
    const bloodType = document.getElementById('createBloodType').value;
    const instockAmount = parseInt(document.getElementById('createInstockAmount').value);
    const expiryDate = document.getElementById('createExpiryDate').value;
    
    const inventoryData = {
        bloodType: bloodType,
        instockAmount: instockAmount,
        expiryDate: expiryDate
    };
    
    showLoading(true);
    hideError();
    
    fetch(API_BASE_URL, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(inventoryData)
    })
    .then(response => {
        if (!response.ok) {
            return response.text().then(text => {
                throw new Error(text || 'Failed to create blood inventory');
            });
        }
        return response.json();
    })
    .then(data => {
        showLoading(false);
        closeModal('createInventoryModal');
        resetCreateForm();
        loadBloodInventory();
    })
    .catch(error => {
        showLoading(false);
        showError(error.message);
    });
}

/**
 * Open update modal and populate form
 */
function openUpdateModal(inventoryId) {
    showLoading(true);
    hideError();
    
    fetch(`${API_BASE_URL}/${inventoryId}`)
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to load blood inventory data');
            }
            return response.json();
        })
        .then(inventory => {
            document.getElementById('updateInventoryId').value = inventory.id;
            document.getElementById('updateBloodType').value = inventory.bloodType;
            document.getElementById('updateInstockAmount').value = inventory.instockAmount;
            
            // Format date for input field (YYYY-MM-DD)
            const expiryDate = new Date(inventory.expiryDate);
            const formattedDate = expiryDate.toISOString().split('T')[0];
            document.getElementById('updateExpiryDate').value = formattedDate;
            
            showLoading(false);
            openModal('updateInventoryModal');
        })
        .catch(error => {
            showLoading(false);
            showError(error.message);
        });
}

/**
 * Update blood inventory
 */
function updateBloodInventory() {
    const inventoryId = document.getElementById('updateInventoryId').value;
    const bloodType = document.getElementById('updateBloodType').value;
    const instockAmount = parseInt(document.getElementById('updateInstockAmount').value);
    const expiryDate = document.getElementById('updateExpiryDate').value;
    
    const inventoryData = {
        bloodType: bloodType,
        instockAmount: instockAmount,
        expiryDate: expiryDate
    };
    
    showLoading(true);
    hideError();
    
    fetch(`${API_BASE_URL}/${inventoryId}`, {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(inventoryData)
    })
    .then(response => {
        if (!response.ok) {
            return response.text().then(text => {
                throw new Error(text || 'Failed to update blood inventory');
            });
        }
        return response.json();
    })
    .then(data => {
        showLoading(false);
        closeModal('updateInventoryModal');
        loadBloodInventory();
    })
    .catch(error => {
        showLoading(false);
        showError(error.message);
    });
}

/**
 * Open delete confirmation modal
 */
function openDeleteModal(inventoryId) {
    document.getElementById('deleteInventoryId').value = inventoryId;
    openModal('deleteConfirmModal');
}

/**
 * Delete blood inventory
 */
function deleteBloodInventory() {
    const inventoryId = document.getElementById('deleteInventoryId').value;
    
    showLoading(true);
    hideError();
    
    fetch(`${API_BASE_URL}/${inventoryId}`, {
        method: 'DELETE'
    })
    .then(response => {
        if (!response.ok) {
            return response.text().then(text => {
                throw new Error(text || 'Failed to delete blood inventory');
            });
        }
        return response.text();
    })
    .then(() => {
        showLoading(false);
        closeModal('deleteConfirmModal');
        loadBloodInventory();
    })
    .catch(error => {
        showLoading(false);
        showError(error.message);
    });
}

/**
 * Filter table based on search input and blood type filter
 */
function filterTable() {
    const searchTerm = document.getElementById('searchInput').value.toLowerCase();
    const bloodTypeFilter = document.getElementById('bloodTypeFilter').value;
    
    // If blood type filter is set, load from API
    if (bloodTypeFilter && !searchTerm) {
        loadBloodInventoryByType(bloodTypeFilter);
        return;
    }
    
    // If no filters or only search term, load all and filter client-side
    if (!bloodTypeFilter) {
        loadBloodInventory();
    }
    
    // Client-side filtering for search term
    if (searchTerm) {
        const rows = document.querySelectorAll('#inventoryTableBody tr');
        const noDataMessage = document.getElementById('noDataMessage');
        let visibleCount = 0;
        
        rows.forEach(row => {
            const id = row.cells[0].textContent.toLowerCase();
            const bloodType = row.cells[1].textContent.toLowerCase();
            const amount = row.cells[2].textContent.toLowerCase();
            const expiryDate = row.cells[3].textContent.toLowerCase();
            
            const matchesSearch = id.includes(searchTerm) || 
                                 bloodType.includes(searchTerm) || 
                                 amount.includes(searchTerm) || 
                                 expiryDate.includes(searchTerm);
            
            const matchesBloodType = !bloodTypeFilter || row.getAttribute('data-blood-type') === bloodTypeFilter;
            
            if (matchesSearch && matchesBloodType) {
                row.classList.remove('hidden');
                visibleCount++;
            } else {
                row.classList.add('hidden');
            }
        });
        
        if (visibleCount === 0) {
            noDataMessage.classList.remove('hidden');
        } else {
            noDataMessage.classList.add('hidden');
        }
    }
}

/**
 * Validate create form
 */
function validateCreateForm() {
    const bloodType = validateField('createBloodType', 'createBloodTypeError');
    const instockAmount = validateField('createInstockAmount', 'createInstockAmountError', PATTERNS.positiveNumber);
    const expiryDate = validateExpiryDate('createExpiryDate', 'createExpiryDateError');
    
    return bloodType && instockAmount && expiryDate;
}

/**
 * Validate update form
 */
function validateUpdateForm() {
    const bloodType = validateField('updateBloodType', 'updateBloodTypeError');
    const instockAmount = validateField('updateInstockAmount', 'updateInstockAmountError', PATTERNS.positiveNumber);
    const expiryDate = validateExpiryDate('updateExpiryDate', 'updateExpiryDateError');
    
    return bloodType && instockAmount && expiryDate;
}

/**
 * Validate a form field
 */
function validateField(fieldId, errorId, pattern = null) {
    const field = document.getElementById(fieldId);
    const errorElement = document.getElementById(errorId);
    
    if (!field.value.trim()) {
        errorElement.textContent = 'This field is required.';
        errorElement.classList.remove('hidden');
        return false;
    }
    
    if (pattern && !pattern.test(field.value)) {
        errorElement.textContent = 'Please enter a valid value.';
        errorElement.classList.remove('hidden');
        return false;
    }
    
    errorElement.classList.add('hidden');
    return true;
}

/**
 * Validate expiry date (must be future date)
 */
function validateExpiryDate(fieldId, errorId) {
    const field = document.getElementById(fieldId);
    const errorElement = document.getElementById(errorId);
    
    if (!field.value) {
        errorElement.textContent = 'Expiry date is required.';
        errorElement.classList.remove('hidden');
        return false;
    }
    
    const selectedDate = new Date(field.value);
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    
    if (selectedDate < today) {
        errorElement.textContent = 'Expiry date must be a future date.';
        errorElement.classList.remove('hidden');
        return false;
    }
    
    errorElement.classList.add('hidden');
    return true;
}

/**
 * Reset create form
 */
function resetCreateForm() {
    document.getElementById('createInventoryForm').reset();
    document.getElementById('createBloodTypeError').classList.add('hidden');
    document.getElementById('createInstockAmountError').classList.add('hidden');
    document.getElementById('createExpiryDateError').classList.add('hidden');
}

/**
 * Open modal
 */
function openModal(modalId) {
    const modal = document.getElementById(modalId);
    modal.classList.remove('hidden');
    modal.classList.add('flex');
}

/**
 * Close modal
 */
function closeModal(modalId) {
    const modal = document.getElementById(modalId);
    modal.classList.add('hidden');
    modal.classList.remove('flex');
}

/**
 * Show/hide loading indicator
 */
function showLoading(show) {
    const loadingIndicator = document.getElementById('loadingIndicator');
    
    if (show) {
        loadingIndicator.classList.remove('hidden');
    } else {
        loadingIndicator.classList.add('hidden');
    }
}

/**
 * Show error message
 */
function showError(message) {
    const errorElement = document.getElementById('errorMessage');
    const errorText = document.getElementById('errorText');
    
    errorText.textContent = message;
    errorElement.classList.remove('hidden');
}

/**
 * Hide error message
 */
function hideError() {
    const errorElement = document.getElementById('errorMessage');
    errorElement.classList.add('hidden');
}
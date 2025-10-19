<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Management</title>
    <!-- Tailwind CSS -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .modal {
            transition: opacity 0.25s ease;
        }
        body.modal-active {
            overflow-x: hidden;
            overflow-y: visible !important;
        }
        .spinner {
            border: 4px solid rgba(0, 0, 0, 0.1);
            width: 36px;
            height: 36px;
            border-radius: 50%;
            border-left-color: #e53e3e;
            animation: spin 1s linear infinite;
        }
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body class="bg-white">
    <div class="container mx-auto px-4 py-8">
        <h1 class="text-3xl font-bold text-red-600 mb-6">Admin Management</h1>
        
        <!-- Search and Add Admin Section -->
        <div class="flex justify-between items-center mb-6">
            <div class="relative w-64">
                <input id="searchInput" type="text" placeholder="Search admins..." 
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-red-500">
                <i class="fas fa-search absolute right-3 top-3 text-gray-400"></i>
            </div>
            <button id="addAdminBtn" class="bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded-lg flex items-center">
                <i class="fas fa-plus mr-2"></i> Add Admin
            </button>
        </div>
        
        <!-- Loading Indicator -->
        <div id="loadingIndicator" class="hidden flex justify-center my-8">
            <div class="spinner"></div>
        </div>
        
        <!-- Error Message -->
        <div id="errorMessage" class="hidden bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-6">
            <span id="errorText">Error loading admins.</span>
            <span class="absolute top-0 bottom-0 right-0 px-4 py-3">
                <i class="fas fa-times cursor-pointer" onclick="document.getElementById('errorMessage').classList.add('hidden')"></i>
            </span>
        </div>
        
        <!-- Admin Table -->
        <div class="overflow-x-auto bg-white rounded-lg shadow overflow-y-auto">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50">
                    <tr>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Admin ID</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Name</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Email</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                    </tr>
                </thead>
                <tbody id="adminTableBody" class="bg-white divide-y divide-gray-200">
                    <!-- Admin data will be populated here -->
                </tbody>
            </table>
        </div>
        
        <!-- No Data Message -->
        <div id="noDataMessage" class="hidden text-center py-8 text-gray-500">
            <i class="fas fa-inbox text-4xl mb-2"></i>
            <p>No admins found.</p>
        </div>
    </div>
    
    <!-- Create Admin Modal -->
    <div id="createAdminModal" class="modal opacity-0 pointer-events-none fixed w-full h-full top-0 left-0 flex items-center justify-center z-50">
        <div class="modal-overlay absolute w-full h-full bg-gray-900 opacity-50"></div>
        
        <div class="modal-container bg-white w-11/12 md:max-w-md mx-auto rounded shadow-lg z-50 overflow-y-auto">
            <div class="modal-content py-4 text-left px-6">
                <!-- Modal Header -->
                <div class="flex justify-between items-center pb-3">
                    <p class="text-2xl font-bold text-red-600">Add New Admin</p>
                    <div class="modal-close cursor-pointer z-50">
                        <i class="fas fa-times text-red-600"></i>
                    </div>
                </div>
                
                <!-- Modal Body -->
                <form id="createAdminForm">
                    <div class="mb-4">
                        <label class="block text-gray-700 text-sm font-bold mb-2" for="firstName">First Name</label>
                        <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" 
                               id="firstName" type="text" placeholder="First Name" required>
                        <p id="firstNameError" class="text-red-500 text-xs italic hidden">Please enter a valid first name.</p>
                    </div>
                    
                    <div class="mb-4">
                        <label class="block text-gray-700 text-sm font-bold mb-2" for="lastName">Last Name</label>
                        <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" 
                               id="lastName" type="text" placeholder="Last Name" required>
                        <p id="lastNameError" class="text-red-500 text-xs italic hidden">Please enter a valid last name.</p>
                    </div>
                    
                    <div class="mb-4">
                        <label class="block text-gray-700 text-sm font-bold mb-2" for="email">Email</label>
                        <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" 
                               id="email" type="email" placeholder="Email" required>
                        <p id="emailError" class="text-red-500 text-xs italic hidden">Please enter a valid email address.</p>
                    </div>
                    
                    <div class="mb-6">
                        <label class="block text-gray-700 text-sm font-bold mb-2" for="password">Password</label>
                        <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" 
                               id="password" type="password" placeholder="Password" required>
                        <p id="passwordError" class="text-red-500 text-xs italic hidden">Password must be at least 8 characters with letters, numbers, and special characters.</p>
                    </div>
                    
                    <div class="flex items-center justify-end pt-2">
                        <button type="button" class="modal-close px-4 bg-gray-200 p-3 rounded-lg text-gray-600 hover:bg-gray-300 mr-2">Cancel</button>
                        <button type="submit" class="px-4 bg-red-600 p-3 rounded-lg text-white hover:bg-red-700">Create Admin</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <!-- Update Admin Modal -->
    <div id="updateAdminModal" class="modal opacity-0 pointer-events-none fixed w-full h-full top-0 left-0 flex items-center justify-center z-50">
        <div class="modal-overlay absolute w-full h-full bg-gray-900 opacity-50"></div>
        
        <div class="modal-container bg-white w-11/12 md:max-w-md mx-auto rounded shadow-lg z-50 overflow-y-auto">
            <div class="modal-content py-4 text-left px-6">
                <!-- Modal Header -->
                <div class="flex justify-between items-center pb-3">
                    <p class="text-2xl font-bold text-red-600">Update Admin</p>
                    <div class="modal-close cursor-pointer z-50">
                        <i class="fas fa-times text-red-600"></i>
                    </div>
                </div>
                
                <!-- Modal Body -->
                <form id="updateAdminForm">
                    <input type="hidden" id="updateAdminId">
                    
                    <div class="mb-4">
                        <label class="block text-gray-700 text-sm font-bold mb-2" for="updateFirstName">First Name</label>
                        <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" 
                               id="updateFirstName" type="text" placeholder="First Name" required>
                        <p id="updateFirstNameError" class="text-red-500 text-xs italic hidden">Please enter a valid first name.</p>
                    </div>
                    
                    <div class="mb-4">
                        <label class="block text-gray-700 text-sm font-bold mb-2" for="updateLastName">Last Name</label>
                        <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" 
                               id="updateLastName" type="text" placeholder="Last Name" required>
                        <p id="updateLastNameError" class="text-red-500 text-xs italic hidden">Please enter a valid last name.</p>
                    </div>
                    
                    <div class="mb-6">
                        <label class="block text-gray-700 text-sm font-bold mb-2" for="updateEmail">Email</label>
                        <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" 
                               id="updateEmail" type="email" placeholder="Email" required>
                        <p id="updateEmailError" class="text-red-500 text-xs italic hidden">Please enter a valid email address.</p>
                    </div>
                    
                    <div class="flex items-center justify-end pt-2">
                        <button type="button" class="modal-close px-4 bg-gray-200 p-3 rounded-lg text-gray-600 hover:bg-gray-300 mr-2">Cancel</button>
                        <button type="submit" class="px-4 bg-red-600 p-3 rounded-lg text-white hover:bg-red-700">Update Admin</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <!-- Reset Password Modal -->
    <div id="resetPasswordModal" class="modal opacity-0 pointer-events-none fixed w-full h-full top-0 left-0 flex items-center justify-center z-50">
        <div class="modal-overlay absolute w-full h-full bg-gray-900 opacity-50"></div>
        
        <div class="modal-container bg-white w-11/12 md:max-w-md mx-auto rounded shadow-lg z-50 overflow-y-auto">
            <div class="modal-content py-4 text-left px-6">
                <!-- Modal Header -->
                <div class="flex justify-between items-center pb-3">
                    <p class="text-2xl font-bold text-red-600">Reset Password</p>
                    <div class="modal-close cursor-pointer z-50">
                        <i class="fas fa-times text-red-600"></i>
                    </div>
                </div>
                
                <!-- Modal Body -->
                <form id="resetPasswordForm">
                    <input type="hidden" id="resetPasswordAdminId">
                    
                    <div class="mb-6">
                        <label class="block text-gray-700 text-sm font-bold mb-2" for="newPassword">New Password</label>
                        <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" 
                               id="newPassword" type="password" placeholder="New Password" required>
                        <p id="newPasswordError" class="text-red-500 text-xs italic hidden">Password must be at least 8 characters with letters, numbers, and special characters.</p>
                    </div>
                    
                    <div class="flex items-center justify-end pt-2">
                        <button type="button" class="modal-close px-4 bg-gray-200 p-3 rounded-lg text-gray-600 hover:bg-gray-300 mr-2">Cancel</button>
                        <button type="submit" class="px-4 bg-red-600 p-3 rounded-lg text-white hover:bg-red-700">Reset Password</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <!-- Delete Confirmation Modal -->
    <div id="deleteConfirmModal" class="modal opacity-0 pointer-events-none fixed w-full h-full top-0 left-0 flex items-center justify-center z-50">
        <div class="modal-overlay absolute w-full h-full bg-gray-900 opacity-50"></div>
        
        <div class="modal-container bg-white w-11/12 md:max-w-md mx-auto rounded shadow-lg z-50 overflow-y-auto">
            <div class="modal-content py-4 text-left px-6">
                <!-- Modal Header -->
                <div class="flex justify-between items-center pb-3">
                    <p class="text-2xl font-bold text-red-600">Confirm Delete</p>
                    <div class="modal-close cursor-pointer z-50">
                        <i class="fas fa-times text-red-600"></i>
                    </div>
                </div>
                
                <!-- Modal Body -->
                <div class="mb-6">
                    <p>Are you sure you want to delete this admin? This action cannot be undone.</p>
                    <input type="hidden" id="deleteAdminId">
                </div>
                
                <div class="flex items-center justify-end pt-2">
                    <button type="button" class="modal-close px-4 bg-gray-200 p-3 rounded-lg text-gray-600 hover:bg-gray-300 mr-2">Cancel</button>
                    <button id="confirmDeleteBtn" class="px-4 bg-red-600 p-3 rounded-lg text-white hover:bg-red-700">Delete</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/js/admin_management/admin_management.js"></script>
</body>
</html>
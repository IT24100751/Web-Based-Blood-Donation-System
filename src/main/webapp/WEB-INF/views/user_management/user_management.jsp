<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management</title>
    <!-- Tailwind CSS -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body class="bg-white">
    <!-- Header -->
    <header class="bg-red-600 text-white p-4 shadow-md">
        <div class="container mx-auto flex justify-between items-center">
            <h1 class="text-2xl font-bold">Blood Donation System</h1>
            <div class="flex items-center space-x-4">
                <span id="adminName" class="hidden md:inline-block">Admin</span>
                <a href="/logout" class="hover:underline">
                    <i class="fas fa-sign-out-alt mr-1"></i> Logout
                </a>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="container mx-auto p-4">
        <div class="bg-white rounded-lg shadow-md p-6 mb-6">
            <div class="flex justify-between items-center mb-6">
                <h2 class="text-2xl font-bold text-gray-800">User Management</h2>
                <button id="createUserBtn" class="bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded-md transition duration-300 flex items-center">
                    <i class="fas fa-plus mr-2"></i> Add New User
                </button>
            </div>

            <!-- Search Section -->
            <div class="mb-6">
                <div class="relative">
                    <input type="text" id="searchInput" placeholder="Search by name, email, or role..." class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-red-500">
                    <i class="fas fa-search absolute right-3 top-3 text-gray-400"></i>
                </div>
            </div>

            <!-- Loading and Error Messages -->
            <div id="loadingIndicator" class="hidden flex justify-center items-center p-4">
                <i class="fas fa-spinner fa-spin text-red-600 text-2xl mr-2"></i>
                <span>Loading...</span>
            </div>
            
            <div id="errorMessage" class="hidden bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-4">
                <div class="flex items-center">
                    <i class="fas fa-exclamation-circle mr-2"></i>
                    <span id="errorText">Error message here</span>
                </div>
            </div>

            <!-- User Table -->
            <div class="overflow-x-auto">
                <table class="min-w-full bg-white border border-gray-200">
                    <thead class="bg-gray-100">
                        <tr>
                            <th class="py-3 px-4 border-b text-left">ID</th>
                            <th class="py-3 px-4 border-b text-left">Name</th>
                            <th class="py-3 px-4 border-b text-left">Email</th>
                            <th class="py-3 px-4 border-b text-left">Contact</th>
                            <th class="py-3 px-4 border-b text-left">Role</th>
                            <th class="py-3 px-4 border-b text-left">Gender</th>
                            <th class="py-3 px-4 border-b text-left">Age</th>
                            <th class="py-3 px-4 border-b text-left">Actions</th>
                        </tr>
                    </thead>
                    <tbody id="userTableBody">
                        <!-- Table rows will be populated by JavaScript -->
                    </tbody>
                </table>
            </div>
            
            <!-- No Data Message -->
            <div id="noDataMessage" class="hidden text-center py-4">
                <i class="fas fa-info-circle text-gray-500 mr-2"></i>
                <span>No user records found.</span>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="bg-gray-100 text-center p-4 mt-auto">
        <p class="text-gray-600">© 2023 Blood Donation System. All rights reserved.</p>
    </footer>

    <!-- Create User Modal -->
    <div id="createUserModal" class="fixed inset-0 bg-black bg-opacity-50 hidden flex items-center justify-center z-50">
        <div class="bg-white rounded-lg shadow-lg w-full max-w-md p-6 relative">
            <button type="button" class="absolute top-4 right-4 text-gray-500 hover:text-gray-700" onclick="closeModal('createUserModal')">
                <i class="fas fa-times"></i>
            </button>
            <h3 class="text-xl font-bold mb-4">Add New User</h3>
            <form id="createUserForm">
                <div class="grid grid-cols-2 gap-4">
                    <div class="mb-4">
                        <label for="createFirstName" class="block text-gray-700 font-medium mb-2">First Name</label>
                        <input type="text" id="createFirstName" name="firstName" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-red-500" required>
                        <p id="createFirstNameError" class="text-red-500 text-sm mt-1 hidden">Please enter a valid first name.</p>
                    </div>
                    <div class="mb-4">
                        <label for="createLastName" class="block text-gray-700 font-medium mb-2">Last Name</label>
                        <input type="text" id="createLastName" name="lastName" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-red-500" required>
                        <p id="createLastNameError" class="text-red-500 text-sm mt-1 hidden">Please enter a valid last name.</p>
                    </div>
                </div>
                <div class="mb-4">
                    <label for="createEmail" class="block text-gray-700 font-medium mb-2">Email</label>
                    <input type="email" id="createEmail" name="email" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-red-500" required>
                    <p id="createEmailError" class="text-red-500 text-sm mt-1 hidden">Please enter a valid email address.</p>
                </div>
                <div class="mb-4">
                    <label for="createPassword" class="block text-gray-700 font-medium mb-2">Password</label>
                    <div class="relative">
                        <input type="password" id="createPassword" name="password" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-red-500" required>
                        <button type="button" class="absolute right-3 top-2 text-gray-500" onclick="togglePasswordVisibility('createPassword', 'createPasswordToggle')">
                            <i id="createPasswordToggle" class="fas fa-eye"></i>
                        </button>
                    </div>
                    <p id="createPasswordError" class="text-red-500 text-sm mt-1 hidden">Password must be at least 8 characters with letters and numbers.</p>
                </div>
                <div class="mb-4">
                    <label for="createContactNumber" class="block text-gray-700 font-medium mb-2">Contact Number</label>
                    <input type="text" id="createContactNumber" name="contactNumber" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-red-500" required>
                    <p id="createContactNumberError" class="text-red-500 text-sm mt-1 hidden">Please enter a valid contact number.</p>
                </div>
                <div class="grid grid-cols-2 gap-4">
                    <div class="mb-4">
                        <label for="createRole" class="block text-gray-700 font-medium mb-2">Role</label>
                        <select id="createRole" name="role" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-red-500" required>
                            <option value="">Select Role</option>
                            <option value="doctor">Doctor</option>
                            <option value="nurse">Nurse</option>
                            <option value="attendance">Attendance</option>
                            <option value="other staff">Other Staff</option>
                        </select>
                        <p id="createRoleError" class="text-red-500 text-sm mt-1 hidden">Please select a role.</p>
                    </div>
                    <div class="mb-4">
                        <label for="createGender" class="block text-gray-700 font-medium mb-2">Gender</label>
                        <select id="createGender" name="gender" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-red-500" required>
                            <option value="">Select Gender</option>
                            <option value="male">Male</option>
                            <option value="female">Female</option>
                            <option value="other">Other</option>
                        </select>
                        <p id="createGenderError" class="text-red-500 text-sm mt-1 hidden">Please select a gender.</p>
                    </div>
                </div>
                <div class="mb-4">
                    <label for="createAge" class="block text-gray-700 font-medium mb-2">Age</label>
                    <input type="number" id="createAge" name="age" min="18" max="100" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-red-500" required>
                    <p id="createAgeError" class="text-red-500 text-sm mt-1 hidden">Please enter a valid age (18-100).</p>
                </div>
                <div class="flex justify-end space-x-3 mt-6">
                    <button type="button" class="px-4 py-2 bg-gray-300 text-gray-700 rounded-md hover:bg-gray-400 transition duration-300" onclick="closeModal('createUserModal')">Cancel</button>
                    <button type="submit" class="px-4 py-2 bg-red-600 text-white rounded-md hover:bg-red-700 transition duration-300">Save</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Update User Modal -->
    <div id="updateUserModal" class="fixed inset-0 bg-black bg-opacity-50 hidden flex items-center justify-center z-50">
        <div class="bg-white rounded-lg shadow-lg w-full max-w-md p-6 relative">
            <button type="button" class="absolute top-4 right-4 text-gray-500 hover:text-gray-700" onclick="closeModal('updateUserModal')">
                <i class="fas fa-times"></i>
            </button>
            <h3 class="text-xl font-bold mb-4">Update User</h3>
            <form id="updateUserForm">
                <input type="hidden" id="updateUserId">
                <div class="grid grid-cols-2 gap-4">
                    <div class="mb-4">
                        <label for="updateFirstName" class="block text-gray-700 font-medium mb-2">First Name</label>
                        <input type="text" id="updateFirstName" name="firstName" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-red-500" required>
                        <p id="updateFirstNameError" class="text-red-500 text-sm mt-1 hidden">Please enter a valid first name.</p>
                    </div>
                    <div class="mb-4">
                        <label for="updateLastName" class="block text-gray-700 font-medium mb-2">Last Name</label>
                        <input type="text" id="updateLastName" name="lastName" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-red-500" required>
                        <p id="updateLastNameError" class="text-red-500 text-sm mt-1 hidden">Please enter a valid last name.</p>
                    </div>
                </div>
                <div class="mb-4">
                    <label for="updateEmail" class="block text-gray-700 font-medium mb-2">Email</label>
                    <input type="email" id="updateEmail" name="email" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-red-500" required>
                    <p id="updateEmailError" class="text-red-500 text-sm mt-1 hidden">Please enter a valid email address.</p>
                </div>
                <div class="mb-4">
                    <label for="updateContactNumber" class="block text-gray-700 font-medium mb-2">Contact Number</label>
                    <input type="text" id="updateContactNumber" name="contactNumber" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-red-500" required>
                    <p id="updateContactNumberError" class="text-red-500 text-sm mt-1 hidden">Please enter a valid contact number.</p>
                </div>
                <div class="grid grid-cols-2 gap-4">
                    <div class="mb-4">
                        <label for="updateRole" class="block text-gray-700 font-medium mb-2">Role</label>
                        <select id="updateRole" name="role" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-red-500" required>
                            <option value="">Select Role</option>
                            <option value="doctor">Doctor</option>
                            <option value="nurse">Nurse</option>
                            <option value="attendance">Attendance</option>
                            <option value="other staff">Other Staff</option>
                        </select>
                        <p id="updateRoleError" class="text-red-500 text-sm mt-1 hidden">Please select a role.</p>
                    </div>
                    <div class="mb-4">
                        <label for="updateGender" class="block text-gray-700 font-medium mb-2">Gender</label>
                        <select id="updateGender" name="gender" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-red-500" required>
                            <option value="">Select Gender</option>
                            <option value="male">Male</option>
                            <option value="female">Female</option>
                            <option value="other">Other</option>
                        </select>
                        <p id="updateGenderError" class="text-red-500 text-sm mt-1 hidden">Please select a gender.</p>
                    </div>
                </div>
                <div class="mb-4">
                    <label for="updateAge" class="block text-gray-700 font-medium mb-2">Age</label>
                    <input type="number" id="updateAge" name="age" min="18" max="100" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-red-500" required>
                    <p id="updateAgeError" class="text-red-500 text-sm mt-1 hidden">Please enter a valid age (18-100).</p>
                </div>
                <div class="flex justify-end space-x-3 mt-6">
                    <button type="button" class="px-4 py-2 bg-gray-300 text-gray-700 rounded-md hover:bg-gray-400 transition duration-300" onclick="closeModal('updateUserModal')">Cancel</button>
                    <button type="submit" class="px-4 py-2 bg-red-600 text-white rounded-md hover:bg-red-700 transition duration-300">Update</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Reset Password Modal -->
    <div id="resetPasswordModal" class="fixed inset-0 bg-black bg-opacity-50 hidden flex items-center justify-center z-50">
        <div class="bg-white rounded-lg shadow-lg w-full max-w-md p-6 relative">
            <button type="button" class="absolute top-4 right-4 text-gray-500 hover:text-gray-700" onclick="closeModal('resetPasswordModal')">
                <i class="fas fa-times"></i>
            </button>
            <h3 class="text-xl font-bold mb-4">Reset Password</h3>
            <form id="resetPasswordForm">
                <input type="hidden" id="resetPasswordUserId">
                <div class="mb-4">
                    <label for="newPassword" class="block text-gray-700 font-medium mb-2">New Password</label>
                    <div class="relative">
                        <input type="password" id="newPassword" name="newPassword" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-red-500" required>
                        <button type="button" class="absolute right-3 top-2 text-gray-500" onclick="togglePasswordVisibility('newPassword', 'newPasswordToggle')">
                            <i id="newPasswordToggle" class="fas fa-eye"></i>
                        </button>
                    </div>
                    <p id="newPasswordError" class="text-red-500 text-sm mt-1 hidden">Password must be at least 8 characters with letters and numbers.</p>
                </div>
                <div class="mb-4">
                    <label for="confirmPassword" class="block text-gray-700 font-medium mb-2">Confirm Password</label>
                    <div class="relative">
                        <input type="password" id="confirmPassword" name="confirmPassword" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-red-500" required>
                        <button type="button" class="absolute right-3 top-2 text-gray-500" onclick="togglePasswordVisibility('confirmPassword', 'confirmPasswordToggle')">
                            <i id="confirmPasswordToggle" class="fas fa-eye"></i>
                        </button>
                    </div>
                    <p id="confirmPasswordError" class="text-red-500 text-sm mt-1 hidden">Passwords do not match.</p>
                </div>
                <div class="flex justify-end space-x-3 mt-6">
                    <button type="button" class="px-4 py-2 bg-gray-300 text-gray-700 rounded-md hover:bg-gray-400 transition duration-300" onclick="closeModal('resetPasswordModal')">Cancel</button>
                    <button type="submit" class="px-4 py-2 bg-red-600 text-white rounded-md hover:bg-red-700 transition duration-300">Reset Password</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div id="deleteConfirmModal" class="fixed inset-0 bg-black bg-opacity-50 hidden flex items-center justify-center z-50">
        <div class="bg-white rounded-lg shadow-lg w-full max-w-md p-6">
            <h3 class="text-xl font-bold mb-4">Confirm Deletion</h3>
            <p class="mb-6">Are you sure you want to delete this user? This action cannot be undone.</p>
            <input type="hidden" id="deleteUserId">
            <div class="flex justify-end space-x-3">
                <button type="button" class="px-4 py-2 bg-gray-300 text-gray-700 rounded-md hover:bg-gray-400 transition duration-300" onclick="closeModal('deleteConfirmModal')">Cancel</button>
                <button type="button" id="confirmDeleteBtn" class="px-4 py-2 bg-red-600 text-white rounded-md hover:bg-red-700 transition duration-300">Delete</button>
            </div>
        </div>
    </div>

    <!-- JavaScript -->
    <script src="/js/user_management/user_management.js"></script>
</body>
</html>
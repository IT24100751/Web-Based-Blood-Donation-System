<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile - Blood Donation System</title>
    <!-- Tailwind CSS -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-100">
    <!-- Navigation Bar -->
    <nav class="bg-red-600 text-white p-4 shadow-md">
        <div class="container mx-auto flex justify-between items-center">
            <a href="/" class="text-2xl font-bold">Blood Donation System</a>
            <div class="space-x-4">
                <a href="/" class="hover:text-red-200"><i class="fas fa-home mr-1"></i> Home</a>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container mx-auto py-8 px-4">
        <div class="max-w-4xl mx-auto bg-white rounded-lg shadow-md p-6">
            <h1 class="text-2xl font-bold text-red-600 mb-6 flex items-center">
                <i class="fas fa-user-circle text-3xl mr-2"></i> User Profile
            </h1>

            <!-- Alert Messages -->
            <div id="successAlert" class="hidden bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative mb-4">
                <span class="block sm:inline" id="successMessage"></span>
                <button type="button" class="absolute top-0 right-0 px-4 py-3" onclick="document.getElementById('successAlert').classList.add('hidden')">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            
            <div id="errorAlert" class="hidden bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4">
                <span class="block sm:inline" id="errorMessage"></span>
                <button type="button" class="absolute top-0 right-0 px-4 py-3" onclick="document.getElementById('errorAlert').classList.add('hidden')">
                    <i class="fas fa-times"></i>
                </button>
            </div>

            <!-- User Profile Form -->
            <form id="userProfileForm" class="space-y-6">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <!-- Personal Information -->
                    <div class="space-y-4">
                        <h2 class="text-xl font-semibold text-gray-700 border-b pb-2">
                            <i class="fas fa-id-card mr-2"></i> Personal Information
                        </h2>
                        
                        <div class="form-group">
                            <label for="firstName" class="block text-gray-700 font-medium mb-1">First Name</label>
                            <input type="text" id="firstName" name="firstName" class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-red-500">
                            <p id="firstNameError" class="text-red-500 text-sm mt-1 hidden"></p>
                        </div>
                        
                        <div class="form-group">
                            <label for="lastName" class="block text-gray-700 font-medium mb-1">Last Name</label>
                            <input type="text" id="lastName" name="lastName" class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-red-500">
                            <p id="lastNameError" class="text-red-500 text-sm mt-1 hidden"></p>
                        </div>
                        
                        <div class="form-group">
                            <label for="gender" class="block text-gray-700 font-medium mb-1">Gender</label>
                            <select id="gender" name="gender" class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-red-500">
                                <option value="">Select Gender</option>
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                                <option value="Other">Other</option>
                            </select>
                            <p id="genderError" class="text-red-500 text-sm mt-1 hidden"></p>
                        </div>
                        
                        <div class="form-group">
                            <label for="age" class="block text-gray-700 font-medium mb-1">Age</label>
                            <input type="number" id="age" name="age" min="18" max="65" class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-red-500">
                            <p id="ageError" class="text-red-500 text-sm mt-1 hidden"></p>
                        </div>
                    </div>
                    
                    <!-- Contact Information -->
                    <div class="space-y-4">
                        <h2 class="text-xl font-semibold text-gray-700 border-b pb-2">
                            <i class="fas fa-address-book mr-2"></i> Contact Information
                        </h2>
                        
                        <div class="form-group">
                            <label for="email" class="block text-gray-700 font-medium mb-1">Email</label>
                            <input type="email" id="email" name="email" class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-red-500">
                            <p id="emailError" class="text-red-500 text-sm mt-1 hidden"></p>
                        </div>
                        
                        <div class="form-group">
                            <label for="contactNumber" class="block text-gray-700 font-medium mb-1">Contact Number</label>
                            <input type="tel" id="contactNumber" name="contactNumber" class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-red-500">
                            <p id="contactNumberError" class="text-red-500 text-sm mt-1 hidden"></p>
                        </div>
                        
                        <div class="form-group">
                            <label for="role" class="block text-gray-700 font-medium mb-1">Role</label>
                            <input type="text" id="role" name="role" class="w-full px-4 py-2 border rounded-lg bg-gray-100" readonly>
                        </div>
                    </div>
                </div>
                
                <!-- Action Buttons -->
                <div class="flex flex-col sm:flex-row justify-between space-y-4 sm:space-y-0 sm:space-x-4 pt-4 border-t">
                    <div>
                        <button type="submit" id="updateProfileBtn" class="bg-red-600 hover:bg-red-700 text-white font-bold py-2 px-6 rounded-lg transition duration-300 flex items-center">
                            <i class="fas fa-save mr-2"></i> Update Profile
                        </button>
                    </div>
                    <div class="flex space-x-4">
                        <button type="button" id="logoutBtn" class="bg-gray-600 hover:bg-gray-700 text-white font-bold py-2 px-6 rounded-lg transition duration-300 flex items-center">
                            <i class="fas fa-sign-out-alt mr-2"></i> Logout
                        </button>
                        <button type="button" id="deleteAccountBtn" class="bg-red-500 hover:bg-red-600 text-white font-bold py-2 px-6 rounded-lg transition duration-300 flex items-center">
                            <i class="fas fa-user-times mr-2"></i> Delete Account
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div id="deleteModal" class="fixed inset-0 bg-gray-900 bg-opacity-50 flex items-center justify-center z-50 hidden">
        <div class="bg-white rounded-lg shadow-lg p-6 max-w-md w-full">
            <div class="text-center">
                <i class="fas fa-exclamation-triangle text-red-500 text-5xl mb-4"></i>
                <h3 class="text-xl font-bold text-gray-900 mb-2">Delete Account</h3>
                <p class="text-gray-600 mb-6">Are you sure you want to delete your account? This action cannot be undone.</p>
                <div class="flex justify-center space-x-4">
                    <button id="cancelDeleteBtn" class="bg-gray-500 hover:bg-gray-600 text-white font-bold py-2 px-6 rounded-lg transition duration-300">
                        Cancel
                    </button>
                    <button id="confirmDeleteBtn" class="bg-red-600 hover:bg-red-700 text-white font-bold py-2 px-6 rounded-lg transition duration-300">
                        Delete
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Loading Spinner -->
    <div id="loadingSpinner" class="fixed inset-0 bg-gray-900 bg-opacity-50 flex items-center justify-center z-50 hidden">
        <div class="bg-white rounded-lg shadow-lg p-6">
            <div class="flex items-center space-x-3">
                <div class="animate-spin rounded-full h-8 w-8 border-b-2 border-red-600"></div>
                <p class="text-gray-700">Processing...</p>
            </div>
        </div>
    </div>

    <!-- JavaScript -->
    <script src="${pageContext.request.contextPath}/js/user_management/user_profile.js"></script>
</body>
</html>
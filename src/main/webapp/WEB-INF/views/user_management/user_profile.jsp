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
            <div class="absolute top-4 right-6 flex items-center space-x-6 text-white font-semibold">
                <a href="/" class="hover:text-gray-300 flex items-center">
                    <i class="fas fa-home mr-2"></i> Home
                </a>
                <button type="button" id="logoutBtn" class="hover:text-gray-300 flex items-center">
                    <i class="fas fa-sign-out-alt mr-2"></i> Logout
                </button>
            </div>

        </div>
    </nav>

    <!-- Main Content -->
    <div class="container mx-auto py-10 px-6">
        <div class="max-w-5xl mx-auto bg-white/90 backdrop-blur-md border border-gray-200 shadow-lg rounded-2xl p-8">
            <!-- Header -->
            <div class="flex items-center mb-8">
                <div class="bg-red-100 text-red-600 p-3 rounded-full mr-3">
                    <i class="fas fa-user-circle text-3xl"></i>
                </div>
                <h1 class="text-3xl font-bold text-gray-800">User Profile</h1>
            </div>

            <!-- Alert Messages -->
            <div id="successAlert"
                 class="hidden bg-green-50 border border-green-300 text-green-800 px-5 py-3 rounded-lg mb-4 flex justify-between items-center shadow-sm">
                <span id="successMessage"></span>
                <button type="button" onclick="document.getElementById('successAlert').classList.add('hidden')">
                    <i class="fas fa-times"></i>
                </button>
            </div>

            <div id="errorAlert"
                 class="hidden bg-red-50 border border-red-300 text-red-800 px-5 py-3 rounded-lg mb-4 flex justify-between items-center shadow-sm">
                <span id="errorMessage"></span>
                <button type="button" onclick="document.getElementById('errorAlert').classList.add('hidden')">
                    <i class="fas fa-times"></i>
                </button>
            </div>

            <!-- User Profile Form -->
            <form id="userProfileForm" class="space-y-10">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-10">
                    <!-- Personal Information -->
                    <div class="space-y-5">
                        <h2 class="text-xl font-semibold text-gray-700 border-b pb-2 flex items-center gap-2">
                            <i class="fas fa-id-card text-red-500"></i> Personal Information
                        </h2>

                        <div>
                            <label for="firstName" class="block text-sm font-medium text-gray-600 mb-1">First Name</label>
                            <input type="text" id="firstName" name="firstName"
                                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-red-500 focus:border-transparent">
                            <p id="firstNameError" class="text-red-500 text-xs mt-1 hidden"></p>
                        </div>

                        <div>
                            <label for="lastName" class="block text-sm font-medium text-gray-600 mb-1">Last Name</label>
                            <input type="text" id="lastName" name="lastName"
                                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-red-500 focus:border-transparent">
                            <p id="lastNameError" class="text-red-500 text-xs mt-1 hidden"></p>
                        </div>

                        <div>
                            <label for="gender" class="block text-sm font-medium text-gray-600 mb-1">Gender</label>
                            <select id="gender" name="gender"
                                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-red-500 focus:border-transparent">
                                <option value="">Select Gender</option>
                                <option>Male</option>
                                <option>Female</option>
                                <option>Other</option>
                            </select>
                            <p id="genderError" class="text-red-500 text-xs mt-1 hidden"></p>
                        </div>

                        <div>
                            <label for="age" class="block text-sm font-medium text-gray-600 mb-1">Age</label>
                            <input type="number" id="age" name="age" min="18" max="65"
                                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-red-500 focus:border-transparent">
                            <p id="ageError" class="text-red-500 text-xs mt-1 hidden"></p>
                        </div>
                    </div>

                    <!-- Contact Information -->
                    <div class="space-y-5">
                        <h2 class="text-xl font-semibold text-gray-700 border-b pb-2 flex items-center gap-2">
                            <i class="fas fa-address-book text-red-500"></i> Contact Information
                        </h2>

                        <div>
                            <label for="email" class="block text-sm font-medium text-gray-600 mb-1">Email</label>
                            <input type="email" id="email" name="email"
                                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-red-500 focus:border-transparent">
                            <p id="emailError" class="text-red-500 text-xs mt-1 hidden"></p>
                        </div>

                        <div>
                            <label for="contactNumber" class="block text-sm font-medium text-gray-600 mb-1">Contact Number</label>
                            <input type="tel" id="contactNumber" name="contactNumber"
                                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-red-500 focus:border-transparent">
                            <p id="contactNumberError" class="text-red-500 text-xs mt-1 hidden"></p>
                        </div>

                        <div>
                            <label for="role" class="block text-sm font-medium text-gray-600 mb-1">Role</label>
                            <input type="text" id="role" name="role"
                                   class="w-full px-4 py-2 border border-gray-200 bg-gray-50 text-gray-600 rounded-lg cursor-not-allowed" readonly>
                        </div>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="flex flex-col sm:flex-row justify-end items-center gap-4 border-t pt-6">
                    <button type="submit" id="updateProfileBtn"
                            class="bg-red-600 hover:bg-red-700 text-white font-semibold py-2 px-6 rounded-lg flex items-center gap-2 shadow transition">
                        <i class="fas fa-save"></i> Update Profile
                    </button>
                    <button type="button" id="deleteAccountBtn"
                            class="bg-gray-100 hover:bg-red-50 text-red-600 font-semibold py-2 px-6 rounded-lg flex items-center gap-2 border border-red-200 transition">
                        <i class="fas fa-user-times"></i> Delete Account
                    </button>
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
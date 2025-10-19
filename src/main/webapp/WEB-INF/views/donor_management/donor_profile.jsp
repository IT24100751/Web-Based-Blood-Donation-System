<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Donor Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body class="bg-white">
    <div class="min-h-screen flex flex-col">
        <!-- Header -->
        <header class="bg-red-600 text-white shadow-md">
            <div class="container mx-auto px-4 py-4 flex justify-between items-center">
                <h1 class="text-2xl font-bold">Blood Donation System</h1>
                <a href="/donor-dashboard" class="text-white hover:text-red-200">
                    <i class="fas fa-arrow-left mr-2"></i>Back to Dashboard
                </a>
            </div>
        </header>

        <!-- Main Content -->
        <main class="flex-grow container mx-auto px-4 py-8">
            <div class="max-w-3xl mx-auto bg-white rounded-lg shadow-md overflow-hidden">
                <div class="bg-red-600 text-white px-6 py-4">
                    <h2 class="text-xl font-semibold">Donor Profile</h2>
                </div>

                <!-- Loading and Error Messages -->
                <div id="loadingMessage" class="hidden bg-blue-100 text-blue-700 px-6 py-4">
                    <i class="fas fa-spinner fa-spin mr-2"></i> Loading your profile information...
                </div>
                <div id="errorMessage" class="hidden bg-red-100 text-red-700 px-6 py-4"></div>
                <div id="successMessage" class="hidden bg-green-100 text-green-700 px-6 py-4"></div>

                <!-- Profile Form -->
                <form id="profileForm" class="px-6 py-4 space-y-4">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <!-- First Name -->
                        <div>
                            <label for="firstName" class="block text-gray-700 font-medium mb-2">First Name</label>
                            <input type="text" id="firstName" name="firstName" class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-red-500">
                            <p class="error-message text-red-500 text-sm mt-1 hidden"></p>
                        </div>

                        <!-- Last Name -->
                        <div>
                            <label for="lastName" class="block text-gray-700 font-medium mb-2">Last Name</label>
                            <input type="text" id="lastName" name="lastName" class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-red-500">
                            <p class="error-message text-red-500 text-sm mt-1 hidden"></p>
                        </div>

                        <!-- Email -->
                        <div>
                            <label for="email" class="block text-gray-700 font-medium mb-2">Email</label>
                            <input type="email" id="email" name="email" class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-red-500">
                            <p class="error-message text-red-500 text-sm mt-1 hidden"></p>
                        </div>

                        <!-- Contact Number -->
                        <div>
                            <label for="contactNumber" class="block text-gray-700 font-medium mb-2">Contact Number</label>
                            <input type="text" id="contactNumber" name="contactNumber" class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-red-500">
                            <p class="error-message text-red-500 text-sm mt-1 hidden"></p>
                        </div>

                        <!-- Blood Type -->
                        <div>
                            <label for="bloodType" class="block text-gray-700 font-medium mb-2">Blood Type</label>
                            <select id="bloodType" name="bloodType" class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-red-500">
                                <option value="">Select Blood Type</option>
                                <option value="A+">A+</option>
                                <option value="A-">A-</option>
                                <option value="B+">B+</option>
                                <option value="B-">B-</option>
                                <option value="AB+">AB+</option>
                                <option value="AB-">AB-</option>
                                <option value="O+">O+</option>
                                <option value="O-">O-</option>
                            </select>
                            <p class="error-message text-red-500 text-sm mt-1 hidden"></p>
                        </div>

                        <!-- Gender -->
                        <div>
                            <label for="gender" class="block text-gray-700 font-medium mb-2">Gender</label>
                            <select id="gender" name="gender" class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-red-500">
                                <option value="">Select Gender</option>
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                                <option value="Other">Other</option>
                            </select>
                            <p class="error-message text-red-500 text-sm mt-1 hidden"></p>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="flex flex-col sm:flex-row justify-between pt-4 space-y-3 sm:space-y-0">
                        <div class="flex flex-col sm:flex-row space-y-3 sm:space-y-0 sm:space-x-3">
                            <button type="submit" id="updateProfileBtn" class="bg-red-600 text-white px-6 py-2 rounded-lg hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-red-500 focus:ring-opacity-50">
                                <span id="updateSubmitText">Update Profile</span>
                                <span id="updateSubmitLoading" class="hidden">
                                    <i class="fas fa-spinner fa-spin"></i> Updating...
                                </span>
                            </button>
                            <button type="button" id="logoutBtn" class="bg-gray-600 text-white px-6 py-2 rounded-lg hover:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-opacity-50">
                                <i class="fas fa-sign-out-alt mr-2"></i>Logout
                            </button>
                        </div>
                        <button type="button" id="deleteAccountBtn" class="bg-red-100 text-red-600 px-6 py-2 rounded-lg hover:bg-red-200 focus:outline-none focus:ring-2 focus:ring-red-500 focus:ring-opacity-50">
                            <i class="fas fa-trash-alt mr-2"></i>Delete Account
                        </button>
                    </div>
                </form>
            </div>
        </main>

        <!-- Footer -->
        <footer class="bg-gray-100 py-4">
            <div class="container mx-auto px-4 text-center text-gray-600">
                <p>&copy; 2023 Blood Donation System. All rights reserved.</p>
            </div>
        </footer>
    </div>

    <!-- Delete Confirmation Modal -->
    <div id="deleteConfirmationModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 hidden">
        <div class="bg-white rounded-lg shadow-lg max-w-md w-full p-6">
            <h3 class="text-xl font-semibold text-gray-900 mb-4">Confirm Account Deletion</h3>
            <p class="text-gray-700 mb-6">Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently removed.</p>
            <div class="flex justify-end space-x-4">
                <button type="button" class="closeModal bg-gray-200 text-gray-800 px-4 py-2 rounded-lg hover:bg-gray-300 focus:outline-none">
                    Cancel
                </button>
                <button type="button" id="confirmDeleteBtn" class="bg-red-600 text-white px-4 py-2 rounded-lg hover:bg-red-700 focus:outline-none">
                    <span id="deleteSubmitText">Delete Account</span>
                    <span id="deleteSubmitLoading" class="hidden">
                        <i class="fas fa-spinner fa-spin"></i> Deleting...
                    </span>
                </button>
            </div>
        </div>
    </div>

    <!-- JavaScript -->
    <script src="/js/donor_management/donor_profile.js"></script>
</body>
</html>
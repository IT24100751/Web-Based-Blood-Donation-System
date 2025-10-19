<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Donor Registration</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body class="bg-gray-100">
    <div class="min-h-screen flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8">
        <div class="max-w-md w-full space-y-8 bg-white p-10 rounded-xl shadow-md">
            <div>
                <h2 class="mt-6 text-center text-3xl font-extrabold text-gray-900">
                    Donor Registration
                </h2>
                <p class="mt-2 text-center text-sm text-gray-600">
                    Join our blood donation community
                </p>
            </div>
            
            <!-- Loading Indicator -->
            <div id="loadingIndicator" class="hidden">
                <div class="flex justify-center items-center">
                    <div class="animate-spin rounded-full h-10 w-10 border-b-2 border-red-700"></div>
                </div>
                <p class="text-center text-sm text-gray-500 mt-2">Processing your registration...</p>
            </div>
            
            <!-- Error Message -->
            <div id="errorMessage" class="hidden bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative" role="alert">
                <span id="errorText" class="block sm:inline"></span>
            </div>
            
            <form id="donorRegistrationForm" class="mt-8 space-y-6">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <!-- First Name -->
                    <div>
                        <label for="firstName" class="block text-sm font-medium text-gray-700">First Name</label>
                        <input id="firstName" name="firstName" type="text" required class="mt-1 focus:ring-red-500 focus:border-red-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md p-2 border">
                        <p id="firstNameError" class="text-red-500 text-xs mt-1 hidden">Please enter a valid first name</p>
                    </div>
                    
                    <!-- Last Name -->
                    <div>
                        <label for="lastName" class="block text-sm font-medium text-gray-700">Last Name</label>
                        <input id="lastName" name="lastName" type="text" required class="mt-1 focus:ring-red-500 focus:border-red-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md p-2 border">
                        <p id="lastNameError" class="text-red-500 text-xs mt-1 hidden">Please enter a valid last name</p>
                    </div>
                </div>
                
                <!-- Email -->
                <div>
                    <label for="email" class="block text-sm font-medium text-gray-700">Email</label>
                    <input id="email" name="email" type="email" required class="mt-1 focus:ring-red-500 focus:border-red-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md p-2 border">
                    <p id="emailError" class="text-red-500 text-xs mt-1 hidden">Please enter a valid email address</p>
                </div>
                
                <!-- Password -->
                <div class="relative">
                    <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
                    <div class="flex items-center">
                        <input id="password" name="password" type="password" required class="mt-1 focus:ring-red-500 focus:border-red-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md p-2 border">
                        <button type="button" id="togglePassword" class="absolute right-2 top-8 text-gray-500">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                    <p id="passwordError" class="text-red-500 text-xs mt-1 hidden">Password must be at least 8 characters with letters and numbers</p>
                </div>
                
                <!-- Blood Type -->
                <div>
                    <label for="bloodType" class="block text-sm font-medium text-gray-700">Blood Type</label>
                    <select id="bloodType" name="bloodType" required class="mt-1 focus:ring-red-500 focus:border-red-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md p-2 border">
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
                    <p id="bloodTypeError" class="text-red-500 text-xs mt-1 hidden">Please select a blood type</p>
                </div>
                
                <!-- Gender -->
                <div>
                    <label for="gender" class="block text-sm font-medium text-gray-700">Gender</label>
                    <select id="gender" name="gender" required class="mt-1 focus:ring-red-500 focus:border-red-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md p-2 border">
                        <option value="">Select Gender</option>
                        <option value="Male">Male</option>
                        <option value="Female">Female</option>
                        <option value="Other">Other</option>
                    </select>
                    <p id="genderError" class="text-red-500 text-xs mt-1 hidden">Please select a gender</p>
                </div>
                
                <!-- Contact Number -->
                <div>
                    <label for="contactNumber" class="block text-sm font-medium text-gray-700">Contact Number</label>
                    <input id="contactNumber" name="contactNumber" type="text" required class="mt-1 focus:ring-red-500 focus:border-red-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md p-2 border">
                    <p id="contactNumberError" class="text-red-500 text-xs mt-1 hidden">Please enter a valid contact number</p>
                </div>
                
                <div>
                    <button type="submit" class="group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500">
                        Register
                    </button>
                </div>
                
                <div class="text-center">
                    <p class="text-sm text-gray-600">
                        Already have an account? 
                        <a href="/donor-login" class="font-medium text-red-600 hover:text-red-500">
                            Login here
                        </a>
                    </p>
                </div>
            </form>
        </div>
    </div>
    
    <script src="/js/donor_management/donor_register.js"></script>
</body>
</html>
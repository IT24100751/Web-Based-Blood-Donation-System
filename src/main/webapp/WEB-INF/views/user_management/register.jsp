<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration - Blood Donation System</title>
    <!-- Tailwind CSS -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body class="bg-gray-100 min-h-screen">
    <!-- Navigation Bar -->
    <nav class="bg-red-600 text-white shadow-lg">
        <div class="container mx-auto px-4 py-3 flex justify-between items-center">
            <div class="flex items-center">
                <i class="fas fa-heartbeat text-2xl mr-2"></i>
                <h1 class="text-xl font-bold">Blood Donation System</h1>
            </div>
            <div class="hidden md:flex space-x-4">
                <a href="/" class="hover:text-red-200 transition">Home</a>
                <a href="/login" class="hover:text-red-200 transition">Login</a>
            </div>
            <button id="mobileMenuBtn" class="md:hidden text-white focus:outline-none">
                <i class="fas fa-bars text-xl"></i>
            </button>
        </div>
        <!-- Mobile Menu -->
        <div id="mobileMenu" class="hidden md:hidden bg-red-700 px-4 py-2">
            <a href="/" class="block py-2 hover:bg-red-800 transition">Home</a>
            <a href="/login" class="block py-2 hover:bg-red-800 transition">Login</a>
        </div>
    </nav>

    <!-- Registration Form -->
    <div class="container mx-auto px-4 py-8">
        <div class="max-w-4xl mx-auto bg-white rounded-lg shadow-md overflow-hidden">
            <div class="bg-red-600 text-white py-4 px-6">
                <h2 class="text-2xl font-bold"><i class="fas fa-user-plus mr-2"></i>User Registration</h2>
                <p class="text-sm mt-1">Join our community and become a blood donor</p>
            </div>
            
            <!-- Alert Messages -->
            <div id="errorAlert" class="hidden bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-4 mx-6 mt-4" role="alert">
                <p class="font-bold">Error</p>
                <p id="errorMessage">Something went wrong. Please try again.</p>
            </div>
            
            <div id="successAlert" class="hidden bg-green-100 border-l-4 border-green-500 text-green-700 p-4 mb-4 mx-6 mt-4" role="alert">
                <p class="font-bold">Success!</p>
                <p>Your account has been created successfully. Redirecting to login page...</p>
            </div>
            
            <!-- Registration Form -->
            <form id="registrationForm" class="p-6">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <!-- First Name -->
                    <div>
                        <label for="firstName" class="block text-gray-700 font-medium mb-2">First Name <span class="text-red-600">*</span></label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-user text-gray-400"></i>
                            </div>
                            <input type="text" id="firstName" name="firstName" class="block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-red-500 focus:border-red-500" required>
                        </div>
                        <p id="firstNameError" class="hidden text-red-500 text-sm mt-1">Please enter a valid first name</p>
                    </div>
                    
                    <!-- Last Name -->
                    <div>
                        <label for="lastName" class="block text-gray-700 font-medium mb-2">Last Name <span class="text-red-600">*</span></label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-user text-gray-400"></i>
                            </div>
                            <input type="text" id="lastName" name="lastName" class="block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-red-500 focus:border-red-500" required>
                        </div>
                        <p id="lastNameError" class="hidden text-red-500 text-sm mt-1">Please enter a valid last name</p>
                    </div>
                    
                    <!-- Email -->
                    <div>
                        <label for="email" class="block text-gray-700 font-medium mb-2">Email <span class="text-red-600">*</span></label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-envelope text-gray-400"></i>
                            </div>
                            <input type="email" id="email" name="email" class="block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-red-500 focus:border-red-500" required>
                        </div>
                        <p id="emailError" class="hidden text-red-500 text-sm mt-1">Please enter a valid email address</p>
                    </div>
                    
                    <!-- Contact Number -->
                    <div>
                        <label for="contactNumber" class="block text-gray-700 font-medium mb-2">Contact Number <span class="text-red-600">*</span></label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-phone text-gray-400"></i>
                            </div>
                            <input type="tel" id="contactNumber" name="contactNumber" class="block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-red-500 focus:border-red-500" required>
                        </div>
                        <p id="contactNumberError" class="hidden text-red-500 text-sm mt-1">Please enter a valid contact number</p>
                    </div>
                    
                    <!-- Password -->
                    <div>
                        <label for="password" class="block text-gray-700 font-medium mb-2">Password <span class="text-red-600">*</span></label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-lock text-gray-400"></i>
                            </div>
                            <input type="password" id="password" name="password" class="block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-red-500 focus:border-red-500" required>
                        </div>
                        <p id="passwordError" class="hidden text-red-500 text-sm mt-1">Password must be at least 8 characters with letters and numbers</p>
                    </div>
                    
                    <!-- Confirm Password -->
                    <div>
                        <label for="confirmPassword" class="block text-gray-700 font-medium mb-2">Confirm Password <span class="text-red-600">*</span></label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-lock text-gray-400"></i>
                            </div>
                            <input type="password" id="confirmPassword" name="confirmPassword" class="block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-red-500 focus:border-red-500" required>
                        </div>
                        <p id="confirmPasswordError" class="hidden text-red-500 text-sm mt-1">Passwords do not match</p>
                    </div>
                    
                    <!-- Gender -->
                    <div>
                        <label for="gender" class="block text-gray-700 font-medium mb-2">Gender <span class="text-red-600">*</span></label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-venus-mars text-gray-400"></i>
                            </div>
                            <select id="gender" name="gender" class="block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-red-500 focus:border-red-500" required>
                                <option value="">Select Gender</option>
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>
                        <p id="genderError" class="hidden text-red-500 text-sm mt-1">Please select a gender</p>
                    </div>
                    
                    <!-- Age -->
                    <div>
                        <label for="age" class="block text-gray-700 font-medium mb-2">Age <span class="text-red-600">*</span></label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-birthday-cake text-gray-400"></i>
                            </div>
                            <input type="number" id="age" name="age" min="18" max="65" class="block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-red-500 focus:border-red-500" required>
                        </div>
                        <p id="ageError" class="hidden text-red-500 text-sm mt-1">Age must be between 18 and 65</p>
                    </div>
                    
                    <!-- Hidden Role Field -->
                    <input type="hidden" id="role" name="role" value="User">
                </div>
                
                <!-- Terms and Conditions -->
                <div class="mt-6">
                    <div class="flex items-start">
                        <div class="flex items-center h-5">
                            <input id="terms" name="terms" type="checkbox" class="focus:ring-red-500 h-4 w-4 text-red-600 border-gray-300 rounded" required>
                        </div>
                        <div class="ml-3 text-sm">
                            <label for="terms" class="font-medium text-gray-700">I agree to the <a href="#" class="text-red-600 hover:text-red-500">Terms and Conditions</a> and <a href="#" class="text-red-600 hover:text-red-500">Privacy Policy</a></label>
                        </div>
                    </div>
                    <p id="termsError" class="hidden text-red-500 text-sm mt-1">You must agree to the terms and conditions</p>
                </div>
                
                <!-- Submit Button -->
                <div class="mt-6">
                    <button type="submit" id="registerBtn" class="w-full flex justify-center py-3 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500">
                        <span id="registerBtnText">Register</span>
                        <span id="registerBtnLoading" class="hidden">
                            <i class="fas fa-spinner fa-spin mr-2"></i> Processing...
                        </span>
                    </button>
                </div>
                
                <!-- Login Link -->
                <div class="mt-4 text-center">
                    <p class="text-sm text-gray-600">
                        Already have an account? <a href="/login" class="font-medium text-red-600 hover:text-red-500">Login here</a>
                    </p>
                </div>
            </form>
        </div>
    </div>
    
    <!-- Footer -->
    <footer class="bg-gray-800 text-white py-8 mt-12">
        <div class="container mx-auto px-4">
            <div class="flex flex-col md:flex-row justify-between items-center">
                <div class="mb-4 md:mb-0">
                    <h3 class="text-xl font-bold mb-2">Blood Donation System</h3>
                    <p class="text-gray-400">Connecting donors with those in need</p>
                </div>
                <div class="flex space-x-4">
                    <a href="#" class="text-gray-400 hover:text-white transition">
                        <i class="fab fa-facebook-f"></i>
                    </a>
                    <a href="#" class="text-gray-400 hover:text-white transition">
                        <i class="fab fa-twitter"></i>
                    </a>
                    <a href="#" class="text-gray-400 hover:text-white transition">
                        <i class="fab fa-instagram"></i>
                    </a>
                </div>
            </div>
            <hr class="border-gray-700 my-6">
            <p class="text-center text-gray-400">© 2023 Blood Donation System. All rights reserved.</p>
        </div>
    </footer>
    
    <!-- JavaScript -->
    <script src="${pageContext.request.contextPath}/js/user_management/register.js"></script>
</body>
</html>
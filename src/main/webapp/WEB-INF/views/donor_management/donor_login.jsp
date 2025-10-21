<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Donor Login</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body class="bg-white">
    <div class="min-h-screen flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8">
        <div class="max-w-lg w-full space-y-8 bg-white p-10 rounded-xl shadow-md">
            <div>
                <h2 class="mt-6 text-center text-3xl font-extrabold text-gray-900">
                    Donor Login
                </h2>
                <p class="mt-2 text-center text-sm text-gray-600">
                    Sign in to your donor account
                </p>
            </div>
            
            <!-- Loading Indicator -->
            <div id="loadingIndicator" class="hidden">
                <div class="flex justify-center items-center">
                    <div class="animate-spin rounded-full h-10 w-10 border-b-2 border-red-700"></div>
                </div>
                <p class="text-center text-sm text-gray-500 mt-2">Logging in...</p>
            </div>
            
            <!-- Error Message -->
            <div id="errorMessage" class="hidden bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative" role="alert">
                <span id="errorText" class="block sm:inline"></span>
            </div>
            
            <!-- Success Message (for registration success) -->
            <div id="successMessage" class="hidden bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative" role="alert">
                <span id="successText" class="block sm:inline">Registration successful! Please login with your credentials.</span>
            </div>
            
            <form id="donorLoginForm" class="mt-8 space-y-6">
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
                    <p id="passwordError" class="text-red-500 text-xs mt-1 hidden">Please enter your password</p>
                </div>
                
                <div>
                    <button type="submit" class="group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500">
                        Login
                    </button>
                </div>
                
                <div class="text-center">
                    <p class="text-sm text-gray-600">
                        Don't have an account? 
                        <a href="/donor-register" class="font-medium text-red-600 hover:text-red-500">
                            Register here
                        </a>
                    </p>
                </div>
            </form>
        </div>
    </div>
    
    <script src="/js/donor_management/donor_login.js"></script>
</body>
</html>
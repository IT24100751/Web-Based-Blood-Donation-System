<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
    <!-- Tailwind CSS -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
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
    <div class="min-h-screen flex items-center justify-center">
        <div class="bg-white p-8 rounded-lg shadow-lg w-full max-w-md">
            <div class="text-center mb-8">
                <h1 class="text-3xl font-bold text-red-600">Admin Login</h1>
                <p class="text-gray-600 mt-2">Enter your credentials to access the admin dashboard</p>
            </div>
            
            <!-- Loading Indicator -->
            <div id="loadingIndicator" class="hidden flex justify-center my-4">
                <div class="spinner"></div>
            </div>
            
            <!-- Error Message -->
            <div id="errorMessage" class="hidden bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-6">
                <span id="errorText">Invalid email or password.</span>
                <span class="absolute top-0 bottom-0 right-0 px-4 py-3">
                    <i class="fas fa-times cursor-pointer" onclick="document.getElementById('errorMessage').classList.add('hidden')"></i>
                </span>
            </div>
            
            <!-- Login Form -->
            <form id="loginForm" class="space-y-6">
                <div>
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="email">Email</label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <i class="fas fa-envelope text-gray-400"></i>
                        </div>
                        <input id="email" type="email" placeholder="Enter your email" 
                               class="pl-10 w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-red-500" required>
                    </div>
                    <p id="emailError" class="text-red-500 text-xs italic hidden mt-1">Please enter a valid email address.</p>
                </div>
                
                <div>
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="password">Password</label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <i class="fas fa-lock text-gray-400"></i>
                        </div>
                        <input id="password" type="password" placeholder="Enter your password" 
                               class="pl-10 w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-red-500" required>
                        <div class="absolute inset-y-0 right-0 pr-3 flex items-center">
                            <i id="togglePassword" class="fas fa-eye text-gray-400 cursor-pointer"></i>
                        </div>
                    </div>
                    <p id="passwordError" class="text-red-500 text-xs italic hidden mt-1">Password is required.</p>
                </div>
                
                <div>
                    <button type="submit" class="w-full bg-red-600 hover:bg-red-700 text-white font-bold py-2 px-4 rounded-lg focus:outline-none focus:shadow-outline flex items-center justify-center">
                        <i class="fas fa-sign-in-alt mr-2"></i> Login
                    </button>
                </div>
            </form>
        </div>
    </div>
    
    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/js/admin_management/login.js"></script>
</body>
</html>
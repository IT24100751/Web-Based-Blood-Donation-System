<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Blood Donation System</title>
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
                <a href="/register" class="hover:text-red-200 transition">Register</a>
            </div>
            <button id="mobileMenuBtn" class="md:hidden text-white focus:outline-none">
                <i class="fas fa-bars text-xl"></i>
            </button>
        </div>
        <!-- Mobile Menu -->
        <div id="mobileMenu" class="hidden md:hidden bg-red-700 px-4 py-2">
            <a href="/" class="block py-2 hover:bg-red-800 transition">Home</a>
            <a href="/register" class="block py-2 hover:bg-red-800 transition">Register</a>
        </div>
    </nav>

    <!-- Login Form -->
    <div class="container mx-auto px-4 py-12">
        <div class="max-w-md mx-auto bg-white rounded-lg shadow-md overflow-hidden">
            <div class="bg-red-600 text-white py-4 px-6">
                <h2 class="text-2xl font-bold"><i class="fas fa-sign-in-alt mr-2"></i>Login</h2>
                <p class="text-sm mt-1">Access your account</p>
            </div>
            
            <!-- Alert Messages -->
            <div id="errorAlert" class="hidden bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-4 mx-6 mt-4" role="alert">
                <p class="font-bold">Error</p>
                <p id="errorMessage">Invalid email or password. Please try again.</p>
            </div>
            
            <!-- Login Form -->
            <form id="loginForm" class="p-6">
                <!-- Email -->
                <div class="mb-4">
                    <label for="email" class="block text-gray-700 font-medium mb-2">Email <span class="text-red-600">*</span></label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <i class="fas fa-envelope text-gray-400"></i>
                        </div>
                        <input type="email" id="email" name="email" class="block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-red-500 focus:border-red-500" required>
                    </div>
                    <p id="emailError" class="hidden text-red-500 text-sm mt-1">Please enter a valid email address</p>
                </div>
                
                <!-- Password -->
                <div class="mb-6">
                    <label for="password" class="block text-gray-700 font-medium mb-2">Password <span class="text-red-600">*</span></label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <i class="fas fa-lock text-gray-400"></i>
                        </div>
                        <input type="password" id="password" name="password" class="block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-red-500 focus:border-red-500" required>
                    </div>
                    <p id="passwordError" class="hidden text-red-500 text-sm mt-1">Please enter your password</p>
                </div>
                
                <!-- Remember Me & Forgot Password -->
                <div class="flex items-center justify-between mb-6">
                    <div class="flex items-center">
                        <input id="remember" name="remember" type="checkbox" class="h-4 w-4 text-red-600 focus:ring-red-500 border-gray-300 rounded">
                        <label for="remember" class="ml-2 block text-sm text-gray-700">Remember me</label>
                    </div>
                    <div class="text-sm">
                        <a href="#" class="font-medium text-red-600 hover:text-red-500">Forgot your password?</a>
                    </div>
                </div>
                
                <!-- Submit Button -->
                <div>
                    <button type="submit" id="loginBtn" class="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500">
                        <span id="loginBtnText">Sign In</span>
                        <span id="loginBtnLoading" class="hidden">
                            <i class="fas fa-spinner fa-spin mr-2"></i> Processing...
                        </span>
                    </button>
                </div>
                
                <!-- Register Link -->
                <div class="mt-4 text-center">
                    <p class="text-sm text-gray-600">
                        Don't have an account? <a href="/register" class="font-medium text-red-600 hover:text-red-500">Register here</a>
                    </p>
                </div>
            </form>
        </div>
    </div>
    
    <!-- Footer -->
    <footer class="bg-gray-800 text-white py-8 mt-auto">
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
            <p class="text-center text-gray-400">© 2025 Blood Donation System. All rights reserved.</p>
        </div>
    </footer>
    
    <!-- JavaScript -->
    <script src="${pageContext.request.contextPath}/js/user_management/login.js"></script>
</body>
</html>
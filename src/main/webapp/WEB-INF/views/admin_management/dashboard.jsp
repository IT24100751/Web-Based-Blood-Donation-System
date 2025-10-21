<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Blood Donation System</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- FontAwesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#dc2626', // red-600
                        secondary: '#f8fafc', // slate-50
                        accent: '#b91c1c', // red-700
                    }
                }
            }
        }
    </script>
    <style>
        .card-hover:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 15px -3px rgba(220, 38, 38, 0.1), 0 4px 6px -2px rgba(220, 38, 38, 0.05);
        }
    </style>
</head>
<body class="bg-white">
    <div class="min-h-screen">
        <!-- Header -->
        <header class="bg-primary text-white shadow-lg">
            <div class="container mx-auto px-4 py-6">
                <div class="flex justify-between items-center">
                    <h1 class="text-3xl font-bold">Blood Donation System</h1>
                    <div class="flex items-center space-x-4">
                        <span class="text-lg">Welcome, Admin</span>
                        <a href="/admin-login" class="bg-white text-primary px-4 py-2 rounded-lg font-medium hover:bg-gray-100 transition duration-300">
                            <i class="fas fa-sign-out-alt mr-2"></i>Logout
                        </a>
                    </div>
                </div>
            </div>
        </header>

        <!-- Main Content -->
        <main class="container mx-auto px-4 py-8">
            <h2 class="text-2xl font-bold text-gray-800 mb-8">Admin Dashboard</h2>
            
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                <!-- Admin Management Card -->
                <a href="/admin-management" class="bg-white rounded-lg shadow-md p-6 border-l-4 border-primary transition-all duration-300 card-hover">
                    <div class="flex items-center">
                        <div class="bg-red-100 p-3 rounded-full">
                            <i class="fas fa-user-shield text-2xl text-primary"></i>
                        </div>
                        <div class="ml-4">
                            <h3 class="text-xl font-semibold text-gray-800">Admin Management</h3>
                            <p class="text-gray-600 mt-1">Manage admin accounts and permissions</p>
                        </div>
                    </div>
                    <div class="mt-4 flex justify-end">
                        <span class="text-primary">
                            <i class="fas fa-arrow-right"></i>
                        </span>
                    </div>
                </a>

                <!-- User Management Card -->
                <a href="/user-management" class="bg-white rounded-lg shadow-md p-6 border-l-4 border-primary transition-all duration-300 card-hover">
                    <div class="flex items-center">
                        <div class="bg-red-100 p-3 rounded-full">
                            <i class="fas fa-users text-2xl text-primary"></i>
                        </div>
                        <div class="ml-4">
                            <h3 class="text-xl font-semibold text-gray-800">User Management</h3>
                            <p class="text-gray-600 mt-1">Manage user accounts and profiles</p>
                        </div>
                    </div>
                    <div class="mt-4 flex justify-end">
                        <span class="text-primary">
                            <i class="fas fa-arrow-right"></i>
                        </span>
                    </div>
                </a>

                <!-- Donor Management Card -->
                <a href="/donor-management" class="bg-white rounded-lg shadow-md p-6 border-l-4 border-primary transition-all duration-300 card-hover">
                    <div class="flex items-center">
                        <div class="bg-red-100 p-3 rounded-full">
                            <i class="fas fa-hand-holding-heart text-2xl text-primary"></i>
                        </div>
                        <div class="ml-4">
                            <h3 class="text-xl font-semibold text-gray-800">Donor Management</h3>
                            <p class="text-gray-600 mt-1">Manage blood donors and donations</p>
                        </div>
                    </div>
                    <div class="mt-4 flex justify-end">
                        <span class="text-primary">
                            <i class="fas fa-arrow-right"></i>
                        </span>
                    </div>
                </a>

                <!-- Request Management Card -->
                <a href="/request-management" class="bg-white rounded-lg shadow-md p-6 border-l-4 border-primary transition-all duration-300 card-hover">
                    <div class="flex items-center">
                        <div class="bg-red-100 p-3 rounded-full">
                            <i class="fas fa-clipboard-list text-2xl text-primary"></i>
                        </div>
                        <div class="ml-4">
                            <h3 class="text-xl font-semibold text-gray-800">Request Management</h3>
                            <p class="text-gray-600 mt-1">Manage blood requests and fulfillment</p>
                        </div>
                    </div>
                    <div class="mt-4 flex justify-end">
                        <span class="text-primary">
                            <i class="fas fa-arrow-right"></i>
                        </span>
                    </div>
                </a>

                <!-- Appointment Management Card -->
                <a href="/appointment-management" class="bg-white rounded-lg shadow-md p-6 border-l-4 border-primary transition-all duration-300 card-hover">
                    <div class="flex items-center">
                        <div class="bg-red-100 p-3 rounded-full">
                            <i class="fas fa-calendar-check text-2xl text-primary"></i>
                        </div>
                        <div class="ml-4">
                            <h3 class="text-xl font-semibold text-gray-800">Appointment Management</h3>
                            <p class="text-gray-600 mt-1">Manage donation appointments</p>
                        </div>
                    </div>
                    <div class="mt-4 flex justify-end">
                        <span class="text-primary">
                            <i class="fas fa-arrow-right"></i>
                        </span>
                    </div>
                </a>

                <!-- Blood Inventory Management Card -->
                <a href="/blood-inventory-management" class="bg-white rounded-lg shadow-md p-6 border-l-4 border-primary transition-all duration-300 card-hover">
                    <div class="flex items-center">
                        <div class="bg-red-100 p-3 rounded-full">
                            <i class="fas fa-vial text-2xl text-primary"></i>
                        </div>
                        <div class="ml-4">
                            <h3 class="text-xl font-semibold text-gray-800">Blood Inventory Management</h3>
                            <p class="text-gray-600 mt-1">Manage blood stock and inventory</p>
                        </div>
                    </div>
                    <div class="mt-4 flex justify-end">
                        <span class="text-primary">
                            <i class="fas fa-arrow-right"></i>
                        </span>
                    </div>
                </a>
            </div>
        </main>

        <!-- Footer -->
        <footer class="bg-gray-100 mt-12">
            <div class="container mx-auto px-4 py-6">
                <p class="text-center text-gray-600">© 2025 Blood Donation System. All rights reserved.</p>
            </div>
        </footer>
    </div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Donor Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .card-hover:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }
        .card-hover {
            transition: all 0.3s ease;
        }
    </style>
</head>
<body class="bg-white">
    <div class="container mx-auto px-4 py-8">
        <header class="mb-8">
            <h1 class="text-3xl font-bold text-gray-800 mb-2">Donor Dashboard</h1>
            <p class="text-gray-600">Welcome to your donor portal. Manage your appointments and profile.</p>
        </header>
        
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <!-- Appointment Management Card -->
            <a href="/appointment-management-donor" class="block">
                <div class="bg-white rounded-lg border border-gray-200 p-6 card-hover">
                    <div class="flex items-center justify-between mb-4">
                        <div class="bg-red-100 p-3 rounded-full">
                            <i class="fas fa-calendar-check text-red-600 text-2xl"></i>
                        </div>
                        <div class="bg-gray-100 px-3 py-1 rounded-full">
                            <span class="text-sm text-gray-600">Manage</span>
                        </div>
                    </div>
                    <h2 class="text-xl font-semibold text-gray-800 mb-2">Appointment Management</h2>
                    <p class="text-gray-600 mb-4">Schedule, view, and manage your blood donation appointments.</p>
                    <div class="flex items-center text-red-600">
                        <span class="mr-2">View appointments</span>
                        <i class="fas fa-arrow-right"></i>
                    </div>
                </div>
            </a>
            
            <!-- Profile Card -->
            <a href="/profile" class="block">
                <div class="bg-white rounded-lg border border-gray-200 p-6 card-hover">
                    <div class="flex items-center justify-between mb-4">
                        <div class="bg-red-100 p-3 rounded-full">
                            <i class="fas fa-user text-red-600 text-2xl"></i>
                        </div>
                        <div class="bg-gray-100 px-3 py-1 rounded-full">
                            <span class="text-sm text-gray-600">Edit</span>
                        </div>
                    </div>
                    <h2 class="text-xl font-semibold text-gray-800 mb-2">Profile</h2>
                    <p class="text-gray-600 mb-4">View and update your personal information and preferences.</p>
                    <div class="flex items-center text-red-600">
                        <span class="mr-2">Manage profile</span>
                        <i class="fas fa-arrow-right"></i>
                    </div>
                </div>
            </a>
        </div>
        
        <!-- Quick Stats Section -->
        <div class="mt-10 bg-gray-50 rounded-lg p-6">
            <h2 class="text-xl font-semibold text-gray-800 mb-4">Your Donation Stats</h2>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                <div class="bg-white p-4 rounded-lg border border-gray-200">
                    <div class="flex items-center">
                        <div class="bg-red-100 p-2 rounded-full mr-3">
                            <i class="fas fa-tint text-red-600"></i>
                        </div>
                        <div>
                            <p class="text-gray-600 text-sm">Total Donations</p>
                            <p class="text-xl font-bold text-gray-800" id="totalDonations">-</p>
                        </div>
                    </div>
                </div>
                <div class="bg-white p-4 rounded-lg border border-gray-200">
                    <div class="flex items-center">
                        <div class="bg-red-100 p-2 rounded-full mr-3">
                            <i class="fas fa-calendar-alt text-red-600"></i>
                        </div>
                        <div>
                            <p class="text-gray-600 text-sm">Last Donation</p>
                            <p class="text-xl font-bold text-gray-800" id="lastDonation">-</p>
                        </div>
                    </div>
                </div>
                <div class="bg-white p-4 rounded-lg border border-gray-200">
                    <div class="flex items-center">
                        <div class="bg-red-100 p-2 rounded-full mr-3">
                            <i class="fas fa-clock text-red-600"></i>
                        </div>
                        <div>
                            <p class="text-gray-600 text-sm">Next Eligible Date</p>
                            <p class="text-xl font-bold text-gray-800" id="nextEligible">-</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Logout Button -->
        <div class="mt-8 text-center">
            <button id="logoutBtn" class="bg-red-600 hover:bg-red-700 text-white font-medium py-2 px-6 rounded-lg transition duration-300 flex items-center mx-auto">
                <i class="fas fa-sign-out-alt mr-2"></i> Logout
            </button>
        </div>
    </div>
    
    <script src="/js/donor_management/donor_dashboard.js"></script>
</body>
</html>
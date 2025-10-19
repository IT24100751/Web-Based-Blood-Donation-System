<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Donor Management</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.25/jspdf.plugin.autotable.min.js"></script>
</head>
<body class="bg-white text-black">
    <div class="container mx-auto px-4 py-8">
        <div class="flex justify-between items-center mb-6">
            <h1 class="text-3xl font-bold">Donor Management</h1>
            <div class="flex space-x-4">
                <div class="relative">
                    <input type="text" id="searchInput" placeholder="Search donors..." 
                           class="px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-red-500">
                    <button id="searchButton" class="absolute right-2 top-2 text-gray-500">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
                <select id="searchField" class="px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-red-500">
                    <option value="all">All Fields</option>
                    <option value="firstName">First Name</option>
                    <option value="lastName">Last Name</option>
                    <option value="email">Email</option>
                    <option value="bloodType">Blood Type</option>
                    <option value="contactNumber">Contact Number</option>
                </select>
                <button id="exportPdfBtn" class="bg-red-600 text-white px-4 py-2 rounded-lg hover:bg-red-700 transition">
                    <i class="fas fa-file-pdf mr-2"></i>Export PDF
                </button>
            </div>
        </div>
        
        <!-- Loading and Error Messages -->
        <div id="loadingMessage" class="hidden bg-blue-100 text-blue-700 p-4 rounded-lg mb-4">
            <i class="fas fa-spinner fa-spin mr-2"></i> Loading donors...
        </div>
        <div id="errorMessage" class="hidden bg-red-100 text-red-700 p-4 rounded-lg mb-4"></div>
        
        <!-- Donors Table -->
        <div class="overflow-x-auto bg-white rounded-lg shadow">
            <table id="donorsTable" class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50">
                    <tr>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Name</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Email</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Blood Type</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Gender</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Contact</th>
                    </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200" id="donorsTableBody">
                    <!-- Donor rows will be inserted here by JavaScript -->
                </tbody>
            </table>
        </div>
        
        <!-- No Results Message -->
        <div id="noResultsMessage" class="hidden text-center py-8 text-gray-500">
            No donors found matching your search criteria.
        </div>
    </div>
    
    <script src="/js/donor_management/donor_management.js"></script>
</body>
</html>
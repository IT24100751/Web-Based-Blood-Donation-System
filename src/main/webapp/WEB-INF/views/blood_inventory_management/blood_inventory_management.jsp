<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blood Inventory Management</title>
    <!-- Tailwind CSS -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body class="bg-white">
    <!-- Header -->
    <header class="bg-red-600 text-white p-4 shadow-md">
        <div class="container mx-auto flex justify-between items-center">
            <h1 class="text-2xl font-bold">Blood Donation System</h1>
            <div class="flex items-center space-x-4">
                <span id="adminName" class="hidden md:inline-block">Admin</span>
                <a href="/logout" class="hover:underline">
                    <i class="fas fa-sign-out-alt mr-1"></i> Logout
                </a>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="container mx-auto p-4">
        <div class="bg-white rounded-lg shadow-md p-6 mb-6">
            <div class="flex justify-between items-center mb-6">
                <h2 class="text-2xl font-bold text-gray-800">Blood Inventory Management</h2>
                <button id="createInventoryBtn" class="bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded-md transition duration-300 flex items-center">
                    <i class="fas fa-plus mr-2"></i> Add New Inventory
                </button>
            </div>

            <!-- Search and Filter Section -->
            <div class="mb-6 flex flex-col md:flex-row justify-between items-center space-y-4 md:space-y-0">
                <div class="w-full md:w-1/3">
                    <div class="relative">
                        <input type="text" id="searchInput" placeholder="Search..." class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-red-500">
                        <i class="fas fa-search absolute right-3 top-3 text-gray-400"></i>
                    </div>
                </div>
                <div class="w-full md:w-1/3">
                    <select id="bloodTypeFilter" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-red-500">
                        <option value="">All Blood Types</option>
                        <option value="A+">A+</option>
                        <option value="A-">A-</option>
                        <option value="B+">B+</option>
                        <option value="B-">B-</option>
                        <option value="AB+">AB+</option>
                        <option value="AB-">AB-</option>
                        <option value="O+">O+</option>
                        <option value="O-">O-</option>
                    </select>
                </div>
            </div>

            <!-- Loading and Error Messages -->
            <div id="loadingIndicator" class="hidden flex justify-center items-center p-4">
                <i class="fas fa-spinner fa-spin text-red-600 text-2xl mr-2"></i>
                <span>Loading...</span>
            </div>
            
            <div id="errorMessage" class="hidden bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-4">
                <div class="flex items-center">
                    <i class="fas fa-exclamation-circle mr-2"></i>
                    <span id="errorText">Error message here</span>
                </div>
            </div>

            <!-- Inventory Table -->
            <div class="overflow-x-auto">
                <table class="min-w-full bg-white border border-gray-200">
                    <thead class="bg-gray-100">
                        <tr>
                            <th class="py-3 px-4 border-b text-left">ID</th>
                            <th class="py-3 px-4 border-b text-left">Blood Type</th>
                            <th class="py-3 px-4 border-b text-left">In-stock Amount</th>
                            <th class="py-3 px-4 border-b text-left">Expiry Date</th>
                            <th class="py-3 px-4 border-b text-left">Actions</th>
                        </tr>
                    </thead>
                    <tbody id="inventoryTableBody">
                        <!-- Table rows will be populated by JavaScript -->
                    </tbody>
                </table>
            </div>
            
            <!-- No Data Message -->
            <div id="noDataMessage" class="hidden text-center py-4">
                <i class="fas fa-info-circle text-gray-500 mr-2"></i>
                <span>No blood inventory records found.</span>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="bg-gray-100 text-center p-4 mt-auto">
        <p class="text-gray-600">© 2023 Blood Donation System. All rights reserved.</p>
    </footer>

    <!-- Create Inventory Modal -->
    <div id="createInventoryModal" class="fixed inset-0 bg-black bg-opacity-50 hidden flex items-center justify-center z-50">
        <div class="bg-white rounded-lg shadow-lg w-full max-w-md p-6 relative">
            <button type="button" class="absolute top-4 right-4 text-gray-500 hover:text-gray-700" onclick="closeModal('createInventoryModal')">
                <i class="fas fa-times"></i>
            </button>
            <h3 class="text-xl font-bold mb-4">Add New Blood Inventory</h3>
            <form id="createInventoryForm">
                <div class="mb-4">
                    <label for="createBloodType" class="block text-gray-700 font-medium mb-2">Blood Type</label>
                    <select id="createBloodType" name="bloodType" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-red-500" required>
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
                    <p id="createBloodTypeError" class="text-red-500 text-sm mt-1 hidden">Please select a blood type.</p>
                </div>
                <div class="mb-4">
                    <label for="createInstockAmount" class="block text-gray-700 font-medium mb-2">In-stock Amount</label>
                    <input type="number" id="createInstockAmount" name="instockAmount" min="0" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-red-500" required>
                    <p id="createInstockAmountError" class="text-red-500 text-sm mt-1 hidden">Please enter a valid amount (must be a positive number).</p>
                </div>
                <div class="mb-4">
                    <label for="createExpiryDate" class="block text-gray-700 font-medium mb-2">Expiry Date</label>
                    <input type="date" id="createExpiryDate" name="expiryDate" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-red-500" required>
                    <p id="createExpiryDateError" class="text-red-500 text-sm mt-1 hidden">Please select a valid future date.</p>
                </div>
                <div class="flex justify-end space-x-3 mt-6">
                    <button type="button" class="px-4 py-2 bg-gray-300 text-gray-700 rounded-md hover:bg-gray-400 transition duration-300" onclick="closeModal('createInventoryModal')">Cancel</button>
                    <button type="submit" class="px-4 py-2 bg-red-600 text-white rounded-md hover:bg-red-700 transition duration-300">Save</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Update Inventory Modal -->
    <div id="updateInventoryModal" class="fixed inset-0 bg-black bg-opacity-50 hidden flex items-center justify-center z-50">
        <div class="bg-white rounded-lg shadow-lg w-full max-w-md p-6 relative">
            <button type="button" class="absolute top-4 right-4 text-gray-500 hover:text-gray-700" onclick="closeModal('updateInventoryModal')">
                <i class="fas fa-times"></i>
            </button>
            <h3 class="text-xl font-bold mb-4">Update Blood Inventory</h3>
            <form id="updateInventoryForm">
                <input type="hidden" id="updateInventoryId">
                <div class="mb-4">
                    <label for="updateBloodType" class="block text-gray-700 font-medium mb-2">Blood Type</label>
                    <select id="updateBloodType" name="bloodType" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-red-500" required>
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
                    <p id="updateBloodTypeError" class="text-red-500 text-sm mt-1 hidden">Please select a blood type.</p>
                </div>
                <div class="mb-4">
                    <label for="updateInstockAmount" class="block text-gray-700 font-medium mb-2">In-stock Amount</label>
                    <input type="number" id="updateInstockAmount" name="instockAmount" min="0" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-red-500" required>
                    <p id="updateInstockAmountError" class="text-red-500 text-sm mt-1 hidden">Please enter a valid amount (must be a positive number).</p>
                </div>
                <div class="mb-4">
                    <label for="updateExpiryDate" class="block text-gray-700 font-medium mb-2">Expiry Date</label>
                    <input type="date" id="updateExpiryDate" name="expiryDate" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-red-500" required>
                    <p id="updateExpiryDateError" class="text-red-500 text-sm mt-1 hidden">Please select a valid future date.</p>
                </div>
                <div class="flex justify-end space-x-3 mt-6">
                    <button type="button" class="px-4 py-2 bg-gray-300 text-gray-700 rounded-md hover:bg-gray-400 transition duration-300" onclick="closeModal('updateInventoryModal')">Cancel</button>
                    <button type="submit" class="px-4 py-2 bg-red-600 text-white rounded-md hover:bg-red-700 transition duration-300">Update</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div id="deleteConfirmModal" class="fixed inset-0 bg-black bg-opacity-50 hidden flex items-center justify-center z-50">
        <div class="bg-white rounded-lg shadow-lg w-full max-w-md p-6">
            <h3 class="text-xl font-bold mb-4">Confirm Deletion</h3>
            <p class="mb-6">Are you sure you want to delete this blood inventory record? This action cannot be undone.</p>
            <input type="hidden" id="deleteInventoryId">
            <div class="flex justify-end space-x-3">
                <button type="button" class="px-4 py-2 bg-gray-300 text-gray-700 rounded-md hover:bg-gray-400 transition duration-300" onclick="closeModal('deleteConfirmModal')">Cancel</button>
                <button type="button" id="confirmDeleteBtn" class="px-4 py-2 bg-red-600 text-white rounded-md hover:bg-red-700 transition duration-300">Delete</button>
            </div>
        </div>
    </div>

    <!-- JavaScript -->
    <script src="/js/blood_inventory_management/blood_inventory_management.js"></script>
</body>
</html>
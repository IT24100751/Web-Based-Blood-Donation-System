<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Blood Request Management</title>
    <!-- Tailwind CSS -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- jsPDF and jsPDF-AutoTable -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.28/jspdf.plugin.autotable.min.js"></script>
</head>
<body class="bg-gray-100">
    <div class="container mx-auto px-4 py-8">
        <h1 class="text-3xl font-bold text-red-600 mb-6">Blood Request Management - Admin</h1>
        
        <!-- Filter and Actions Section -->
        <div class="flex flex-wrap justify-between items-center mb-6">
            <div class="flex items-center space-x-4 mb-4 md:mb-0">
                <label for="bloodTypeFilter" class="font-medium">Filter by Blood Type:</label>
                <select id="bloodTypeFilter" class="border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-red-500">
                    <option value="">All Types</option>
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
            <div>
                <button id="generatePdfBtn" class="bg-green-600 hover:bg-green-700 text-white font-medium py-2 px-4 rounded flex items-center">
                    <i class="fas fa-file-pdf mr-2"></i> Generate PDF
                </button>
            </div>
        </div>
        
        <!-- Loading Spinner -->
        <div id="loadingSpinner" class="hidden flex justify-center my-8">
            <div class="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-red-600"></div>
        </div>
        
        <!-- Alert Messages -->
        <div id="successAlert" class="hidden bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative mb-4">
            <span class="block sm:inline" id="successMessage"></span>
            <button class="absolute top-0 bottom-0 right-0 px-4 py-3" onclick="document.getElementById('successAlert').classList.add('hidden')">
                <i class="fas fa-times"></i>
            </button>
        </div>
        
        <div id="errorAlert" class="hidden bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4">
            <span class="block sm:inline" id="errorMessage"></span>
            <button class="absolute top-0 bottom-0 right-0 px-4 py-3" onclick="document.getElementById('errorAlert').classList.add('hidden')">
                <i class="fas fa-times"></i>
            </button>
        </div>
        
        <!-- Requests Table -->
        <div class="bg-white shadow-md rounded-lg overflow-hidden mb-8">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50">
                    <tr>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">User</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Blood Type</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Units</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Urgency</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Created At</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                    </tr>
                </thead>
                <tbody id="requestsTableBody" class="bg-white divide-y divide-gray-200">
                    <!-- Table rows will be populated by JavaScript -->
                </tbody>
            </table>
        </div>
        
        <!-- No Requests Message -->
        <div id="noRequestsMessage" class="hidden text-center py-8">
            <p class="text-gray-500 text-lg">No blood requests found.</p>
        </div>
    </div>
    
    <!-- Update Status Modal -->
    <div id="updateStatusModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 hidden flex items-center justify-center">
        <div class="bg-white rounded-lg shadow-xl p-6 w-full max-w-md">
            <div class="flex justify-between items-center mb-4">
                <h3 class="text-xl font-bold text-gray-900">Update Request Status</h3>
                <button id="closeUpdateStatusModal" class="text-gray-500 hover:text-gray-700">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <form id="updateStatusForm">
                <input type="hidden" id="updateRequestId">
                <div class="mb-4">
                    <label for="requestStatus" class="block text-gray-700 font-medium mb-2">Status</label>
                    <select id="requestStatus" class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-red-500" required>
                        <option value="Pending">Pending</option>
                        <option value="Approved">Approved</option>
                        <option value="Rejected">Rejected</option>
                        <option value="Completed">Completed</option>
                    </select>
                </div>
                <div class="flex justify-end">
                    <button type="button" id="cancelUpdateStatus" class="bg-gray-300 hover:bg-gray-400 text-gray-800 font-medium py-2 px-4 rounded mr-2">
                        Cancel
                    </button>
                    <button type="submit" class="bg-red-600 hover:bg-red-700 text-white font-medium py-2 px-4 rounded">
                        Update Status
                    </button>
                </div>
            </form>
        </div>
    </div>
    
    <!-- JavaScript -->
    <script src="js/admin_request_management/admin_request_management.js"></script>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Appointment Management</title>
    <!-- Tailwind CSS -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- jsPDF and jsPDF-AutoTable -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.25/jspdf.plugin.autotable.min.js"></script>
</head>
<body class="bg-gray-100">
    <div class="container mx-auto px-4 py-8">
        <h1 class="text-3xl font-bold text-red-600 mb-6">Appointment Management</h1>
        
        <!-- Search and Filter Section -->
        <div class="flex flex-col md:flex-row justify-between items-center mb-6 gap-4">
            <div class="flex flex-col md:flex-row gap-2 w-full md:w-auto">
                <input type="text" id="searchInput" placeholder="Search appointments..." 
                    class="px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-red-500">
                
                <select id="statusFilter" class="px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-red-500">
                    <option value="all">All Statuses</option>
                    <option value="pending">Pending</option>
                    <option value="confirmed">Confirmed</option>
                    <option value="completed">Completed</option>
                    <option value="cancelled">Cancelled</option>
                </select>
                
                <button id="searchBtn" class="bg-red-600 text-white px-4 py-2 rounded-md hover:bg-red-700 transition">
                    <i class="fas fa-search mr-2"></i>Search
                </button>
            </div>
            
            <button id="exportPdfBtn" class="bg-green-600 text-white px-4 py-2 rounded-md hover:bg-green-700 transition">
                <i class="fas fa-file-pdf mr-2"></i>Export PDF
            </button>
        </div>
        
        <!-- Loading and Error Messages -->
        <div id="loadingMessage" class="hidden bg-blue-100 text-blue-700 p-4 rounded-md mb-4">
            <i class="fas fa-spinner fa-spin mr-2"></i>Loading appointments...
        </div>
        
        <div id="errorMessage" class="hidden bg-red-100 text-red-700 p-4 rounded-md mb-4">
            <i class="fas fa-exclamation-circle mr-2"></i><span id="errorText"></span>
        </div>
        
        <!-- Appointments Table -->
        <div class="bg-white rounded-lg shadow-md overflow-hidden">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50">
                    <tr>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Donor Name</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Email</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Appointment Date</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Message</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                    </tr>
                </thead>
                <tbody id="appointmentsTableBody" class="bg-white divide-y divide-gray-200">
                    <!-- Table rows will be populated by JavaScript -->
                </tbody>
            </table>
            
            <!-- No Results Message -->
            <div id="noResultsMessage" class="hidden p-6 text-center text-gray-500">
                No appointments found.
            </div>
        </div>
    </div>
    
    <!-- Status Update Modal -->
    <div id="updateModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 hidden flex items-center justify-center">
        <div class="bg-white rounded-lg shadow-lg p-6 w-full max-w-md">
            <h2 class="text-xl font-bold mb-4">Update Appointment Status</h2>
            
            <input type="hidden" id="updateAppointmentId">
            
            <div class="mb-4">
                <label for="updateStatus" class="block text-gray-700 mb-2">Status</label>
                <select id="updateStatus" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-red-500">
                    <option value="pending">Pending</option>
                    <option value="confirmed">Confirmed</option>
                    <option value="completed">Completed</option>
                    <option value="cancelled">Cancelled</option>
                </select>
            </div>
            
            <div class="mb-4">
                <label for="updateMessage" class="block text-gray-700 mb-2">Message</label>
                <textarea id="updateMessage" rows="3" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-red-500"></textarea>
            </div>
            
            <div class="flex justify-end gap-2">
                <button id="cancelUpdateBtn" class="bg-gray-300 text-gray-700 px-4 py-2 rounded-md hover:bg-gray-400 transition">
                    Cancel
                </button>
                <button id="confirmUpdateBtn" class="bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700 transition">
                    Update
                </button>
            </div>
        </div>
    </div>
    
    <!-- Delete Confirmation Modal -->
    <div id="deleteModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 hidden flex items-center justify-center">
        <div class="bg-white rounded-lg shadow-lg p-6 w-full max-w-md">
            <h2 class="text-xl font-bold mb-4">Confirm Deletion</h2>
            <p class="mb-6">Are you sure you want to delete this appointment? This action cannot be undone.</p>
            
            <input type="hidden" id="deleteAppointmentId">
            
            <div class="flex justify-end gap-2">
                <button id="cancelDeleteBtn" class="bg-gray-300 text-gray-700 px-4 py-2 rounded-md hover:bg-gray-400 transition">
                    Cancel
                </button>
                <button id="confirmDeleteBtn" class="bg-red-600 text-white px-4 py-2 rounded-md hover:bg-red-700 transition">
                    Delete
                </button>
            </div>
        </div>
    </div>
    
    <!-- JavaScript -->
    <script src="${pageContext.request.contextPath}/js/appointment_management/appointment_management.js"></script>
</body>
</html>
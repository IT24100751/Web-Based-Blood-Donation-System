<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Appointment Management</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-white">
    <div class="container mx-auto px-4 py-8">
        <header class="mb-8">
            <div class="flex justify-between items-center">
                <h1 class="text-3xl font-bold text-gray-800">Appointment Management</h1>
                <a href="/donor-dashboard" class="flex items-center text-red-600 hover:text-red-800">
                    <i class="fas fa-arrow-left mr-2"></i> Back to Dashboard
                </a>
            </div>
            <p class="text-gray-600 mt-2">Schedule and manage your blood donation appointments.</p>
        </header>
        
        <!-- Action Button -->
        <div class="mb-6">
            <button id="createAppointmentBtn" class="bg-red-600 hover:bg-red-700 text-white font-medium py-2 px-4 rounded-lg transition duration-300 flex items-center">
                <i class="fas fa-plus-circle mr-2"></i> Schedule New Appointment
            </button>
        </div>
        
        <!-- Loading and Error Messages -->
        <div id="loadingMessage" class="hidden bg-blue-100 text-blue-700 p-4 rounded-lg mb-4 flex items-center">
            <i class="fas fa-spinner fa-spin mr-2"></i>
            <span>Loading appointments...</span>
        </div>
        
        <div id="errorMessage" class="hidden bg-red-100 text-red-700 p-4 rounded-lg mb-4">
            Error loading appointments. Please try again.
        </div>
        
        <!-- Appointments Table -->
        <div class="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50">
                    <tr>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Appointment Date
                        </th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Status
                        </th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Message
                        </th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Created At
                        </th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Actions
                        </th>
                    </tr>
                </thead>
                <tbody id="appointmentsTableBody" class="bg-white divide-y divide-gray-200">
                    <!-- Table rows will be populated by JavaScript -->
                </tbody>
            </table>
            
            <!-- No Data Message -->
            <div id="noDataMessage" class="hidden p-8 text-center text-gray-500">
                <i class="fas fa-calendar-times text-gray-400 text-4xl mb-2"></i>
                <p>No appointments found. Schedule your first appointment!</p>
            </div>
        </div>
    </div>
    
    <!-- Create Appointment Modal -->
    <div id="createAppointmentModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 hidden flex items-center justify-center z-50">
        <div class="bg-white rounded-lg shadow-xl max-w-md w-full mx-4">
            <div class="flex justify-between items-center border-b px-6 py-4">
                <h3 class="text-lg font-medium text-gray-900">Schedule New Appointment</h3>
                <button class="closeModal text-gray-400 hover:text-gray-500">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <form id="createAppointmentForm" class="px-6 py-4">
                <div class="mb-4">
                    <label for="appointmentDate" class="block text-sm font-medium text-gray-700 mb-1">Appointment Date and Time</label>
                    <input type="datetime-local" id="appointmentDate" name="appointmentDate" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-red-500 focus:border-red-500" required>
                    <p class="error-message text-red-600 text-xs mt-1 hidden"></p>
                </div>
                <div class="mb-4">
                    <label for="message" class="block text-sm font-medium text-gray-700 mb-1">Message (Optional)</label>
                    <textarea id="message" name="message" rows="3" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-red-500 focus:border-red-500"></textarea>
                </div>
                <div class="flex justify-end border-t pt-4">
                    <button type="button" class="closeModal bg-gray-200 hover:bg-gray-300 text-gray-800 font-medium py-2 px-4 rounded-lg mr-2">
                        Cancel
                    </button>
                    <button type="submit" class="bg-red-600 hover:bg-red-700 text-white font-medium py-2 px-4 rounded-lg flex items-center">
                        <span id="createSubmitText">Schedule Appointment</span>
                        <span id="createSubmitLoading" class="hidden">
                            <i class="fas fa-spinner fa-spin ml-2"></i>
                        </span>
                    </button>
                </div>
            </form>
        </div>
    </div>
    
    <!-- Update Appointment Modal -->
    <div id="updateAppointmentModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 hidden flex items-center justify-center z-50">
        <div class="bg-white rounded-lg shadow-xl max-w-md w-full mx-4">
            <div class="flex justify-between items-center border-b px-6 py-4">
                <h3 class="text-lg font-medium text-gray-900">Update Appointment</h3>
                <button class="closeModal text-gray-400 hover:text-gray-500">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <form id="updateAppointmentForm" class="px-6 py-4">
                <input type="hidden" id="updateAppointmentId">
                <div class="mb-4">
                    <label for="updateAppointmentDate" class="block text-sm font-medium text-gray-700 mb-1">Appointment Date and Time</label>
                    <input type="datetime-local" id="updateAppointmentDate" name="updateAppointmentDate" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-red-500 focus:border-red-500" required>
                    <p class="error-message text-red-600 text-xs mt-1 hidden"></p>
                </div>
                <div class="mb-4">
                    <label for="updateMessage" class="block text-sm font-medium text-gray-700 mb-1">Message (Optional)</label>
                    <textarea id="updateMessage" name="updateMessage" rows="3" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-red-500 focus:border-red-500"></textarea>
                </div>
                <div class="flex justify-end border-t pt-4">
                    <button type="button" class="closeModal bg-gray-200 hover:bg-gray-300 text-gray-800 font-medium py-2 px-4 rounded-lg mr-2">
                        Cancel
                    </button>
                    <button type="submit" class="bg-red-600 hover:bg-red-700 text-white font-medium py-2 px-4 rounded-lg flex items-center">
                        <span id="updateSubmitText">Update Appointment</span>
                        <span id="updateSubmitLoading" class="hidden">
                            <i class="fas fa-spinner fa-spin ml-2"></i>
                        </span>
                    </button>
                </div>
            </form>
        </div>
    </div>
    
    <!-- Delete Confirmation Modal -->
    <div id="deleteConfirmationModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 hidden flex items-center justify-center z-50">
        <div class="bg-white rounded-lg shadow-xl max-w-md w-full mx-4">
            <div class="flex justify-between items-center border-b px-6 py-4">
                <h3 class="text-lg font-medium text-gray-900">Confirm Cancellation</h3>
                <button class="closeModal text-gray-400 hover:text-gray-500">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <div class="px-6 py-4">
                <p class="text-gray-700">Are you sure you want to cancel this appointment? This action cannot be undone.</p>
                <input type="hidden" id="deleteAppointmentId">
            </div>
            <div class="flex justify-end border-t px-6 py-4">
                <button type="button" class="closeModal bg-gray-200 hover:bg-gray-300 text-gray-800 font-medium py-2 px-4 rounded-lg mr-2">
                    No, Keep It
                </button>
                <button id="confirmDeleteBtn" class="bg-red-600 hover:bg-red-700 text-white font-medium py-2 px-4 rounded-lg flex items-center">
                    <span id="deleteSubmitText">Yes, Cancel Appointment</span>
                    <span id="deleteSubmitLoading" class="hidden">
                        <i class="fas fa-spinner fa-spin ml-2"></i>
                    </span>
                </button>
            </div>
        </div>
    </div>
    
    <script src="/js/appointment_management/appointment_management_donor.js"></script>
</body>
</html>
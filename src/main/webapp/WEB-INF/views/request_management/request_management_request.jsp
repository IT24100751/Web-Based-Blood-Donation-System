<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blood Request Management</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body class="bg-gray-100">
    <div class="container mx-auto px-4 py-8">
        <!-- Header -->
        <div class="flex justify-between items-center mb-6">
            <h1 class="text-3xl font-bold text-red-600">My Blood Requests</h1>
            <button id="createRequestBtn" class="bg-red-600 hover:bg-red-700 text-white font-bold py-2 px-4 rounded flex items-center">
                <i class="fas fa-plus mr-2"></i> New Request
            </button>
        </div>

        <!-- Alerts -->
        <div id="successAlert" class="hidden bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative mb-4" role="alert">
            <span id="successMessage" class="block sm:inline"></span>
            <span class="absolute top-0 bottom-0 right-0 px-4 py-3">
                <i class="fas fa-times cursor-pointer" onclick="document.getElementById('successAlert').classList.add('hidden')"></i>
            </span>
        </div>
        <div id="errorAlert" class="hidden bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4" role="alert">
            <span id="errorMessage" class="block sm:inline"></span>
            <span class="absolute top-0 bottom-0 right-0 px-4 py-3">
                <i class="fas fa-times cursor-pointer" onclick="document.getElementById('errorAlert').classList.add('hidden')"></i>
            </span>
        </div>

        <!-- Loading Spinner -->
        <div id="loadingSpinner" class="hidden fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center z-50">
            <div class="bg-white p-5 rounded-lg flex items-center">
                <i class="fas fa-spinner fa-spin text-red-600 text-2xl mr-3"></i>
                <span class="text-gray-700">Loading...</span>
            </div>
        </div>

        <!-- Requests Table -->
        <div class="bg-white shadow-md rounded-lg overflow-hidden mb-6">
            <div id="requestsTableContainer" class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-50">
                        <tr>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Blood Type</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Units</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Urgency</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Created At</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                        </tr>
                    </thead>
                    <tbody id="requestsTableBody" class="bg-white divide-y divide-gray-200">
                        <!-- Table rows will be populated by JavaScript -->
                        <tr id="noRequestsRow">
                            <td colspan="7" class="px-6 py-4 text-center text-gray-500">No requests found</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Create Request Modal -->
        <div id="createRequestModal" class="hidden fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center z-50">
            <div class="bg-white rounded-lg shadow-lg p-6 w-full max-w-md">
                <div class="flex justify-between items-center mb-4">
                    <h2 class="text-xl font-bold text-red-600">Create New Blood Request</h2>
                    <button class="text-gray-500 hover:text-gray-700" onclick="toggleCreateModal(false)">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
                <form id="createRequestForm">
                    <div class="mb-4">
                        <label for="createBloodType" class="block text-gray-700 text-sm font-bold mb-2">Blood Type *</label>
                        <select id="createBloodType" name="bloodType" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
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
                        <p id="createBloodTypeError" class="text-red-500 text-xs italic hidden">Please select a blood type</p>
                    </div>
                    <div class="mb-4">
                        <label for="createUnits" class="block text-gray-700 text-sm font-bold mb-2">Units Required *</label>
                        <input type="number" id="createUnits" name="units" min="1" max="10" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
                        <p id="createUnitsError" class="text-red-500 text-xs italic hidden">Please enter a valid number of units (1-10)</p>
                    </div>
                    <div class="mb-4">
                        <label for="createUrgency" class="block text-gray-700 text-sm font-bold mb-2">Urgency *</label>
                        <select id="createUrgency" name="urgency" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
                            <option value="">Select Urgency</option>
                            <option value="High">High</option>
                            <option value="Medium">Medium</option>
                            <option value="Low">Low</option>
                        </select>
                        <p id="createUrgencyError" class="text-red-500 text-xs italic hidden">Please select urgency level</p>
                    </div>
                    <input type="hidden" id="createStatus" name="status" value="Pending">
                    <div class="flex items-center justify-end">
                        <button type="button" class="bg-gray-300 hover:bg-gray-400 text-gray-800 font-bold py-2 px-4 rounded mr-2" onclick="toggleCreateModal(false)">
                            Cancel
                        </button>
                        <button type="submit" class="bg-red-600 hover:bg-red-700 text-white font-bold py-2 px-4 rounded">
                            Submit
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Edit Request Modal -->
        <div id="editRequestModal" class="hidden fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center z-50">
            <div class="bg-white rounded-lg shadow-lg p-6 w-full max-w-md">
                <div class="flex justify-between items-center mb-4">
                    <h2 class="text-xl font-bold text-red-600">Edit Blood Request</h2>
                    <button class="text-gray-500 hover:text-gray-700" onclick="toggleEditModal(false)">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
                <form id="editRequestForm">
                    <input type="hidden" id="editRequestId" name="id">
                    <div class="mb-4">
                        <label for="editBloodType" class="block text-gray-700 text-sm font-bold mb-2">Blood Type *</label>
                        <select id="editBloodType" name="bloodType" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
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
                        <p id="editBloodTypeError" class="text-red-500 text-xs italic hidden">Please select a blood type</p>
                    </div>
                    <div class="mb-4">
                        <label for="editUnits" class="block text-gray-700 text-sm font-bold mb-2">Units Required *</label>
                        <input type="number" id="editUnits" name="units" min="1" max="10" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
                        <p id="editUnitsError" class="text-red-500 text-xs italic hidden">Please enter a valid number of units (1-10)</p>
                    </div>
                    <div class="mb-4">
                        <label for="editUrgency" class="block text-gray-700 text-sm font-bold mb-2">Urgency *</label>
                        <select id="editUrgency" name="urgency" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
                            <option value="">Select Urgency</option>
                            <option value="High">High</option>
                            <option value="Medium">Medium</option>
                            <option value="Low">Low</option>
                        </select>
                        <p id="editUrgencyError" class="text-red-500 text-xs italic hidden">Please select urgency level</p>
                    </div>
                    <input type="hidden" id="editStatus" name="status" value="Pending">
                    <div class="flex items-center justify-end">
                        <button type="button" class="bg-gray-300 hover:bg-gray-400 text-gray-800 font-bold py-2 px-4 rounded mr-2" onclick="toggleEditModal(false)">
                            Cancel
                        </button>
                        <button type="submit" class="bg-red-600 hover:bg-red-700 text-white font-bold py-2 px-4 rounded">
                            Update
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Delete Confirmation Modal -->
        <div id="deleteConfirmModal" class="hidden fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center z-50">
            <div class="bg-white rounded-lg shadow-lg p-6 w-full max-w-md">
                <div class="flex justify-between items-center mb-4">
                    <h2 class="text-xl font-bold text-red-600">Confirm Deletion</h2>
                    <button class="text-gray-500 hover:text-gray-700" onclick="toggleDeleteModal(false)">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
                <p class="mb-6 text-gray-700">Are you sure you want to delete this blood request? This action cannot be undone.</p>
                <input type="hidden" id="deleteRequestId">
                <div class="flex items-center justify-end">
                    <button type="button" class="bg-gray-300 hover:bg-gray-400 text-gray-800 font-bold py-2 px-4 rounded mr-2" onclick="toggleDeleteModal(false)">
                        Cancel
                    </button>
                    <button type="button" id="confirmDeleteBtn" class="bg-red-600 hover:bg-red-700 text-white font-bold py-2 px-4 rounded">
                        Delete
                    </button>
                </div>
            </div>
        </div>

        <!-- Back to Dashboard Button -->
        <div class="mt-6">
            <a href="/" class="inline-flex items-center text-red-600 hover:text-red-800">
                <i class="fas fa-arrow-left mr-2"></i> Back to Dashboard
            </a>
        </div>
    </div>

    <script src="/js/request_management/request_management_user.js"></script>
</body>
</html>
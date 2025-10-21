<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blood Donation System</title>
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
            <div id="navButtons" class="hidden md:block">
                <!-- Navigation buttons will be added by JavaScript -->
            </div>
            <button id="mobileMenuBtn" class="md:hidden text-white focus:outline-none">
                <i class="fas fa-bars text-xl"></i>
            </button>
        </div>
        <!-- Mobile Menu -->
        <div id="mobileMenu" class="hidden md:hidden bg-red-700 px-4 py-2">
            <!-- Mobile menu items will be added by JavaScript -->
        </div>
    </nav>

    <!-- Hero Section -->
    <div class="bg-red-500 text-white py-16">
        <div class="container mx-auto px-4 text-center">
            <h1 class="text-4xl md:text-5xl font-bold mb-4">Donate Blood, Save Lives</h1>
            <p class="text-xl mb-8">Your donation can make a difference in someone's life.</p>
            <div id="heroButtons" class="flex flex-col md:flex-row justify-center gap-4">
                <!-- Hero buttons will be added by JavaScript -->
            </div>
        </div>
    </div>

    <!-- Features Section -->
    <div class="py-16 bg-white">
        <div class="container mx-auto px-4">
            <h2 class="text-3xl font-bold text-center mb-12 text-gray-800">Why Donate Blood?</h2>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <div class="bg-gray-50 p-6 rounded-lg shadow-md text-center">
                    <div class="text-red-500 text-4xl mb-4">
                        <i class="fas fa-heart"></i>
                    </div>
                    <h3 class="text-xl font-semibold mb-2 text-gray-800">Save Lives</h3>
                    <p class="text-gray-600">One donation can save up to three lives. Your contribution matters.</p>
                </div>
                <div class="bg-gray-50 p-6 rounded-lg shadow-md text-center">
                    <div class="text-red-500 text-4xl mb-4">
                        <i class="fas fa-hospital"></i>
                    </div>
                    <h3 class="text-xl font-semibold mb-2 text-gray-800">Help Patients</h3>
                    <p class="text-gray-600">Support patients undergoing surgeries, cancer treatments, and chronic illnesses.</p>
                </div>
                <div class="bg-gray-50 p-6 rounded-lg shadow-md text-center">
                    <div class="text-red-500 text-4xl mb-4">
                        <i class="fas fa-user-md"></i>
                    </div>
                    <h3 class="text-xl font-semibold mb-2 text-gray-800">Health Benefits</h3>
                    <p class="text-gray-600">Donating blood can help reduce the risk of heart disease and reveal potential health issues.</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Call to Action -->
    <div class="bg-red-600 text-white py-12">
        <div class="container mx-auto px-4 text-center">
            <h2 class="text-3xl font-bold mb-4">Ready to Make a Difference?</h2>
            <p class="text-xl mb-8">Join our community of donors and help save lives today.</p>
            <div id="ctaButtons" class="flex flex-col md:flex-row justify-center gap-4">
                <!-- CTA buttons will be added by JavaScript -->
            </div>
        </div>
    </div>


    <!-- JavaScript -->
    <script src="${pageContext.request.contextPath}/js/home/home.js"></script>
</body>
</html>
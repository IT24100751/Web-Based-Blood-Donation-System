document.addEventListener('DOMContentLoaded', function() {
    // Check if user is logged in
    const normalUserId = localStorage.getItem('normalUserId');
    const isLoggedIn = !!normalUserId;
    
    // Navigation buttons
    const navButtons = document.getElementById('navButtons');
    const mobileMenu = document.getElementById('mobileMenu');
    const heroButtons = document.getElementById('heroButtons');
    const ctaButtons = document.getElementById('ctaButtons');
    
    // Clear existing content
    navButtons.innerHTML = '';
    mobileMenu.innerHTML = '';
    heroButtons.innerHTML = '';
    ctaButtons.innerHTML = '';
    
    // Add common navigation items
    const commonNavItems = `
        <a href="/" class="mx-2 hover:text-red-200 transition">Home</a>
        <a href="#" class="mx-2 hover:text-red-200 transition">About</a>
        <a href="#" class="mx-2 hover:text-red-200 transition">Contact</a>
    `;
    
    // Add user-specific navigation items
    if (isLoggedIn) {
        // For logged-in users
        navButtons.innerHTML = `
            ${commonNavItems}
            <a href="/user-profile" class="mx-2 hover:text-red-200 transition">My Profile</a>
            <a href="#" id="logoutBtn" class="mx-2 hover:text-red-200 transition">Logout</a>
        `;
        
        mobileMenu.innerHTML = `
            <a href="/" class="block py-2 hover:bg-red-800 transition">Home</a>
            <a href="#" class="block py-2 hover:bg-red-800 transition">About</a>
            <a href="#" class="block py-2 hover:bg-red-800 transition">Contact</a>
            <a href="/donor-profile" class="block py-2 hover:bg-red-800 transition">My Profile</a>
            <a href="#" id="mobileLogoutBtn" class="block py-2 hover:bg-red-800 transition">Logout</a>
        `;
        
        heroButtons.innerHTML = `
            <a href="/user-dashboard" class="bg-white text-red-600 font-bold px-6 py-3 rounded-md hover:bg-gray-100 transition">My Dashboard</a>
            <a href="/request" class="bg-transparent border-2 border-white text-white font-bold px-6 py-3 rounded-md hover:bg-red-700 transition">Blood Request</a>
        `;
        
        ctaButtons.innerHTML = `
            
        <a href="/request" class="bg-white text-red-600 font-bold px-6 py-3 rounded-md hover:bg-gray-100 transition">Blood Request</a>
            <a href="/user-profile" class="bg-transparent border-2 border-white text-white font-bold px-6 py-3 rounded-md hover:bg-red-700 transition">View My Profile</a>
        `;
        
        // Add logout functionality
        document.getElementById('logoutBtn').addEventListener('click', handleLogout);
        document.getElementById('mobileLogoutBtn').addEventListener('click', handleLogout);
    } else {
        // For non-logged-in users
        navButtons.innerHTML = `
            ${commonNavItems}
            <a href="/login" class="mx-2 hover:text-red-200 transition">Login</a>
            <a href="/register" class="bg-white text-red-600 px-4 py-2 rounded-md font-bold hover:bg-gray-100 transition">Register</a>
        `;
        
        mobileMenu.innerHTML = `
            <a href="/" class="block py-2 hover:bg-red-800 transition">Home</a>
            <a href="#" class="block py-2 hover:bg-red-800 transition">About</a>
            <a href="#" class="block py-2 hover:bg-red-800 transition">Contact</a>
            <a href="/login" class="block py-2 hover:bg-red-800 transition">Login</a>
            <a href="/register" class="block py-2 hover:bg-red-800 transition">Register</a>
        `;
        
        heroButtons.innerHTML = `
            <a href="/login" class="bg-white text-red-600 font-bold px-6 py-3 rounded-md hover:bg-gray-100 transition">Login</a>
            <a href="/register" class="bg-transparent border-2 border-white text-white font-bold px-6 py-3 rounded-md hover:bg-red-700 transition">Register Now</a>
        `;
        
        ctaButtons.innerHTML = `
            <a href="/register" class="bg-white text-red-600 font-bold px-6 py-3 rounded-md hover:bg-gray-100 transition">Register as Donor</a>
            <a href="/login" class="bg-transparent border-2 border-white text-white font-bold px-6 py-3 rounded-md hover:bg-red-700 transition">Login</a>
        `;
    }
    
    // Mobile menu toggle
    const mobileMenuBtn = document.getElementById('mobileMenuBtn');
    mobileMenuBtn.addEventListener('click', function() {
        const mobileMenu = document.getElementById('mobileMenu');
        if (mobileMenu.classList.contains('hidden')) {
            mobileMenu.classList.remove('hidden');
        } else {
            mobileMenu.classList.add('hidden');
        }
    });
    
    // Logout function
    function handleLogout(e) {
        e.preventDefault();
        // Clear localStorage
        localStorage.removeItem('normalUserId');
        localStorage.removeItem('donorName');
        localStorage.removeItem('donorEmail');
        // Redirect to login page
        window.location.href = '/login';
    }
});
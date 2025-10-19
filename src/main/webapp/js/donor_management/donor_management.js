document.addEventListener('DOMContentLoaded', function() {
    // DOM Elements
    const searchInput = document.getElementById('searchInput');
    const searchButton = document.getElementById('searchButton');
    const searchField = document.getElementById('searchField');
    const exportPdfBtn = document.getElementById('exportPdfBtn');
    const donorsTableBody = document.getElementById('donorsTableBody');
    const loadingMessage = document.getElementById('loadingMessage');
    const errorMessage = document.getElementById('errorMessage');
    const noResultsMessage = document.getElementById('noResultsMessage');
    
    // Store all donors for filtering
    let allDonors = [];
    
    // Fetch all donors on page load
    fetchDonors();
    
    // Event Listeners
    searchButton.addEventListener('click', filterDonors);
    searchInput.addEventListener('keyup', function(event) {
        if (event.key === 'Enter') {
            filterDonors();
        }
    });
    exportPdfBtn.addEventListener('click', exportToPdf);
    
    // Fetch donors from API
    function fetchDonors() {
        showLoading(true);
        
        fetch('/api/donors')
            .then(response => {
                if (!response.ok) {
                    throw new Error('Failed to fetch donors');
                }
                return response.json();
            })
            .then(data => {
                allDonors = data;
                renderDonorsTable(allDonors);
                showLoading(false);
            })
            .catch(error => {
                showError('Error loading donors: ' + error.message);
                showLoading(false);
            });
    }
    
    // Render donors table
    function renderDonorsTable(donors) {
        donorsTableBody.innerHTML = '';
        
        if (donors.length === 0) {
            noResultsMessage.classList.remove('hidden');
            return;
        }
        
        noResultsMessage.classList.add('hidden');
        
        donors.forEach(donor => {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td class="px-6 py-4 whitespace-nowrap">${donor.id}</td>
                <td class="px-6 py-4 whitespace-nowrap">${donor.firstName} ${donor.lastName}</td>
                <td class="px-6 py-4 whitespace-nowrap">${donor.email}</td>
                <td class="px-6 py-4 whitespace-nowrap">${donor.bloodType}</td>
                <td class="px-6 py-4 whitespace-nowrap">${donor.gender}</td>
                <td class="px-6 py-4 whitespace-nowrap">${donor.contactNumber}</td>
            `;
            donorsTableBody.appendChild(row);
        });
    }
    
    // Filter donors based on search input
    function filterDonors() {
        const searchTerm = searchInput.value.toLowerCase().trim();
        const field = searchField.value;
        
        if (!searchTerm) {
            renderDonorsTable(allDonors);
            return;
        }
        
        let filteredDonors;
        
        if (field === 'all') {
            filteredDonors = allDonors.filter(donor => 
                donor.firstName.toLowerCase().includes(searchTerm) ||
                donor.lastName.toLowerCase().includes(searchTerm) ||
                donor.email.toLowerCase().includes(searchTerm) ||
                donor.bloodType.toLowerCase().includes(searchTerm) ||
                donor.contactNumber.toLowerCase().includes(searchTerm) ||
                donor.gender.toLowerCase().includes(searchTerm)
            );
        } else {
            filteredDonors = allDonors.filter(donor => 
                donor[field] && donor[field].toLowerCase().includes(searchTerm)
            );
        }
        
        renderDonorsTable(filteredDonors);
    }
    
    // Export table to PDF
    function exportToPdf() {
        const { jsPDF } = window.jspdf;
        const doc = new jsPDF();
        
        // Add title
        doc.setFontSize(18);
        doc.text('Donor Management Report', 14, 22);
        doc.setFontSize(11);
        doc.text('Generated on: ' + new Date().toLocaleString(), 14, 30);
        
        // Get visible donors (filtered or all)
        const rows = Array.from(donorsTableBody.querySelectorAll('tr'));
        const visibleDonors = rows.map(row => {
            const cells = Array.from(row.querySelectorAll('td'));
            return [
                cells[0].textContent, // ID
                cells[1].textContent, // Name
                cells[2].textContent, // Email
                cells[3].textContent, // Blood Type
                cells[4].textContent, // Gender
                cells[5].textContent  // Contact
            ];
        });
        
        // Create table
        doc.autoTable({
            head: [['ID', 'Name', 'Email', 'Blood Type', 'Gender', 'Contact']],
            body: visibleDonors,
            startY: 40,
            theme: 'grid',
            styles: {
                fontSize: 10,
                cellPadding: 3,
                lineColor: [200, 200, 200]
            },
            headStyles: {
                fillColor: [220, 53, 69], // Red color matching the button
                textColor: 255,
                fontStyle: 'bold'
            }
        });
        
        // Save PDF
        doc.save('donor_management_report.pdf');
    }
    
    // Show/hide loading message
    function showLoading(show) {
        if (show) {
            loadingMessage.classList.remove('hidden');
        } else {
            loadingMessage.classList.add('hidden');
        }
    }
    
    // Show error message
    function showError(message) {
        errorMessage.textContent = message;
        errorMessage.classList.remove('hidden');
        
        // Hide after 5 seconds
        setTimeout(() => {
            errorMessage.classList.add('hidden');
        }, 5000);
    }
});
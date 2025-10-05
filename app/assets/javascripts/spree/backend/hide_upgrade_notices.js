// Hide all Enterprise Edition upgrade notices and popups
// This runs after page load to catch dynamically added elements

document.addEventListener('DOMContentLoaded', function() {
  // Function to hide upgrade notices
  function hideUpgradeNotices() {
    // Find all elements with text about Enterprise, upgrade, or Community Edition
    const textPatterns = [
      'Enterprise Edition',
      'Community Edition',
      'upgrade to',
      'Upgrade to',
      'please upgrade',
      'get access to all features'
    ];
    
    // Check all text-containing elements
    const allElements = document.querySelectorAll('div, p, span, a, button, .alert, .notice, .flash');
    
    allElements.forEach(element => {
      const text = element.textContent || '';
      
      // Check if element contains any upgrade-related text
      const containsUpgradeText = textPatterns.some(pattern => 
        text.toLowerCase().includes(pattern.toLowerCase())
      );
      
      if (containsUpgradeText) {
        // Hide the element and its parent containers
        element.style.display = 'none';
        
        // Also try to hide parent if it's a wrapper
        let parent = element.parentElement;
        if (parent && (parent.classList.contains('alert') || 
                       parent.classList.contains('notice') || 
                       parent.classList.contains('flash') ||
                       parent.classList.contains('banner'))) {
          parent.style.display = 'none';
        }
      }
    });
  }
  
  // Run immediately
  hideUpgradeNotices();
  
  // Run again after a short delay (catches late-loading elements)
  setTimeout(hideUpgradeNotices, 500);
  setTimeout(hideUpgradeNotices, 1000);
  setTimeout(hideUpgradeNotices, 2000);
  
  // Set up observer for dynamically added content
  const observer = new MutationObserver(function(mutations) {
    hideUpgradeNotices();
  });
  
  // Start observing
  observer.observe(document.body, {
    childList: true,
    subtree: true
  });
});

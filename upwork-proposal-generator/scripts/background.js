// Background service worker for extension functionality

// Listen for messages from popup and content scripts
chrome.runtime.onMessage.addListener((request, sender, sendResponse) => {
  // Handle any background tasks if needed
  if (request.action === 'ping') {
    sendResponse({ success: true, message: 'Background script is running' });
    return true;
  }
  
  // Future: Handle any cross-origin requests or background processing
  return false;
});

// Optional: Handle extension installation
chrome.runtime.onInstalled.addListener((details) => {
  if (details.reason === 'install') {
    console.log('Upwork Proposal Generator installed');
    // You can open a welcome page or show instructions here
  }
});


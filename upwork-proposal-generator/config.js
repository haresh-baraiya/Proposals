// Configuration file for the extension
// Change these values as needed

const CONFIG = {
  // Your Laravel API URL
  API_URL: 'http://localhost:8000',  // For local development
  
  // Alternative URLs:
  // API_URL: 'https://proposal-api.test',
  // API_URL: 'https://your-domain.com',  // For production
  
  // API endpoints (you shouldn't need to change these)
  ENDPOINTS: {
    GENERATE_PROPOSAL: '/api/v1/proposals/generate',
    GET_TEMPLATES: '/api/v1/templates',
    STORE_PROPOSAL: '/api/v1/proposals',
    GET_PROPOSALS: '/api/v1/proposals'
  }
};

// Make config available globally
window.CONFIG = CONFIG;


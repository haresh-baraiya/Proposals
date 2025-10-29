// Popup script for handling user interactions

// DOM elements
let extractBtn, copyBtn, regenerateBtn;
let templateStatus, templateStatusText;
let templateSelect;
let proposalSection, proposalContent, errorMessage, successMessage;
let extractText, loadingSpinner;
let clearHistoryBtn;

// Auth elements
let loginSection, appSection, emailInput, passwordInput, loginBtn, loginText, loginSpinner;
let userWelcome, logoutBtn, loginErrorMessage;

// Auth state
let currentUser = null;
let authToken = null;

// Store template count
let templateCount = 0;

// Job tracking for duplicate prevention
const GENERATED_JOBS_KEY = 'generatedJobs';

// Authentication functions
async function checkAuthStatus() {
  try {
    console.log('Checking authentication status...');
    const result = await chrome.storage.local.get(['authToken', 'currentUser', 'sessionExpiry']);

    if (result.authToken && result.currentUser) {
      console.log('Found stored auth token, checking expiry...');

      // Check if session has expired
      if (result.sessionExpiry) {
        const expiryDate = new Date(result.sessionExpiry);
        const now = new Date();

        if (now > expiryDate) {
          console.log('Session expired, clearing storage');
          await chrome.storage.local.remove(['authToken', 'currentUser', 'sessionExpiry']);
          showLoginSection();
          showLoginError('Session expired after 30 days. Please login again.');
          return;
        }

        // Check if session expires soon (within 3 days)
        const daysUntilExpiry = Math.ceil((expiryDate - now) / (1000 * 60 * 60 * 24));
        if (daysUntilExpiry <= 3) {
          console.log(`Session expires in ${daysUntilExpiry} days`);
        }
      }

      authToken = result.authToken;
      currentUser = result.currentUser;

      // Verify token is still valid with server
      const isValid = await verifyToken();
      if (isValid) {
        console.log('Token is valid, showing app section');
        showAppSection();
        await loadTemplates();

        // Show session info if expires soon
        if (result.sessionExpiry) {
          const expiryDate = new Date(result.sessionExpiry);
          const daysUntilExpiry = Math.ceil((expiryDate - new Date()) / (1000 * 60 * 60 * 24));
          if (daysUntilExpiry <= 3) {
            showSessionWarning(daysUntilExpiry);
          }
        }
        return;
      } else {
        console.log('Token is invalid, clearing storage');
        await chrome.storage.local.remove(['authToken', 'currentUser', 'sessionExpiry']);
      }
    }

    // Show login if no valid token
    console.log('No valid token found, showing login section');
    showLoginSection();
  } catch (error) {
    console.error('Error checking auth status:', error);
    showLoginSection();
  }
}

async function verifyToken() {
  try {
    const apiUrl = window.CONFIG.API_URL;
    const response = await fetch(`${apiUrl}/api/v1/me`, {
      headers: {
        'Authorization': `Bearer ${authToken}`,
        'Accept': 'application/json',
      }
    });

    return response.ok;
  } catch (error) {
    return false;
  }
}

async function handleLogin() {
  const email = emailInput.value.trim();
  const password = passwordInput.value.trim();

  if (!email || !password) {
    showLoginError('Please enter both email and password');
    return;
  }

  setLoginLoading(true);
  hideLoginError();

  try {
    const apiUrl = window.CONFIG.API_URL;
    const response = await fetch(`${apiUrl}/api/v1/login`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: JSON.stringify({
        email: email,
        password: password
      })
    });

    const data = await response.json();

    if (response.ok && data.success) {
      authToken = data.data.token;
      currentUser = data.data.user;

      // Calculate session expiry (30 days from now)
      const sessionExpiry = new Date();
      sessionExpiry.setDate(sessionExpiry.getDate() + 30);

      // Save to storage
      await chrome.storage.local.set({
        authToken: authToken,
        currentUser: currentUser,
        sessionExpiry: sessionExpiry.toISOString()
      });

      // Clear form
      emailInput.value = '';
      passwordInput.value = '';

      showAppSection();
      await loadTemplates();
    } else {
      throw new Error(data.message || 'Login failed');
    }
  } catch (error) {
    showLoginError(error.message);
  } finally {
    setLoginLoading(false);
  }
}

async function handleLogout() {
  try {
    if (authToken) {
      const apiUrl = window.CONFIG.API_URL;
      await fetch(`${apiUrl}/api/v1/logout`, {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${authToken}`,
          'Accept': 'application/json',
        }
      });
    }
  } catch (error) {
    console.error('Logout error:', error);
  } finally {
    // Clear local data
    authToken = null;
    currentUser = null;
    await chrome.storage.local.remove(['authToken', 'currentUser', 'sessionExpiry']);

    showLoginSection();
  }
}

function showLoginSection() {
  loginSection.style.display = 'block';
  appSection.style.display = 'none';
  hideLoginError(); // Clear any previous login errors
}

function showAppSection() {
  loginSection.style.display = 'none';
  appSection.style.display = 'block';

  if (currentUser) {
    userWelcome.textContent = `Welcome, ${currentUser.name}!`;
  }
}

function setLoginLoading(isLoading) {
  loginBtn.disabled = isLoading;
  if (isLoading) {
    loginText.style.display = 'none';
    loginSpinner.style.display = 'inline';
  } else {
    loginText.style.display = 'inline';
    loginSpinner.style.display = 'none';
  }
}

// Load saved settings
async function loadSavedSettings() {
  try {
    const result = await chrome.storage.local.get(['template_id']);

    if (result.template_id) {
      templateSelect.value = result.template_id;
    }
  } catch (error) {
    console.error('Error loading settings:', error);
  }
}

// Save settings
async function saveSettings() {
  try {
    await chrome.storage.local.set({
      template_id: templateSelect.value
    });
  } catch (error) {
    console.error('Error saving settings:', error);
  }
}

// Initialize when DOM is loaded
document.addEventListener('DOMContentLoaded', async () => {
  // Get DOM elements
  extractBtn = document.getElementById('extractBtn');
  copyBtn = document.getElementById('copyBtn');
  regenerateBtn = document.getElementById('regenerateBtn');
  templateStatus = document.getElementById('templateStatus');
  templateStatusText = document.getElementById('templateStatusText');
  templateSelect = document.getElementById('templateSelect');
  proposalSection = document.getElementById('proposalSection');
  proposalContent = document.getElementById('proposalContent');
  errorMessage = document.getElementById('errorMessage');
  successMessage = document.getElementById('successMessage');
  extractText = document.getElementById('extractText');
  loadingSpinner = document.getElementById('loadingSpinner');
  clearHistoryBtn = document.getElementById('clearHistoryBtn');

  // Auth elements
  loginSection = document.getElementById('loginSection');
  appSection = document.getElementById('appSection');
  emailInput = document.getElementById('emailInput');
  passwordInput = document.getElementById('passwordInput');
  loginBtn = document.getElementById('loginBtn');
  loginText = document.getElementById('loginText');
  loginSpinner = document.getElementById('loginSpinner');
  userWelcome = document.getElementById('userWelcome');
  logoutBtn = document.getElementById('logoutBtn');
  loginErrorMessage = document.getElementById('loginErrorMessage');

  // Check authentication status
  await checkAuthStatus();

  // Load saved settings
  await loadSavedSettings();

  // Event listeners
  extractBtn.addEventListener('click', handleExtractAndGenerate);
  copyBtn.addEventListener('click', handleCopy);
  regenerateBtn.addEventListener('click', handleRegenerate);
  templateSelect.addEventListener('change', saveSettings);

  // Auth event listeners
  loginBtn.addEventListener('click', handleLogin);
  logoutBtn.addEventListener('click', handleLogout);

  // Utility event listeners
  clearHistoryBtn.addEventListener('click', clearGeneratedJobsHistory);

  // Enter key for login
  passwordInput.addEventListener('keypress', (e) => {
    if (e.key === 'Enter') {
      handleLogin();
    }
  });
});

// Job duplicate detection functions
function generateJobId(jobDetails, currentUrl) {
  // Extract job ID from URL if possible
  const urlJobId = extractJobIdFromUrl(currentUrl);
  if (urlJobId) {
    return urlJobId;
  }

  // Fallback: create hash from job title and description
  const jobString = `${jobDetails.title || ''}_${(jobDetails.description || '').substring(0, 200)}`;
  return btoa(jobString).replace(/[^a-zA-Z0-9]/g, '').substring(0, 32);
}

function extractJobIdFromUrl(url) {
  // Extract job ID from various Upwork URL patterns
  const patterns = [
    /\/jobs\/~([a-f0-9]+)/i,                    // /jobs/~abc123
    /\/freelance-jobs\/apply\/.*_~([a-f0-9]+)/i, // /freelance-jobs/apply/title_~abc123
    /\/ab\/proposals\/job\/~([a-f0-9]+)/i,      // /ab/proposals/job/~abc123
    /\/job\/.*_~([a-f0-9]+)/i                   // /job/title_~abc123
  ];

  for (const pattern of patterns) {
    const match = url.match(pattern);
    if (match && match[1]) {
      return match[1];
    }
  }

  return null;
}

async function isJobAlreadyGenerated(jobId) {
  try {
    const result = await chrome.storage.local.get([GENERATED_JOBS_KEY]);
    const generatedJobs = result[GENERATED_JOBS_KEY] || {};
    return generatedJobs[jobId] || null;
  } catch (error) {
    console.error('Error checking generated jobs:', error);
    return null;
  }
}

async function markJobAsGenerated(jobId, jobDetails) {
  try {
    const result = await chrome.storage.local.get([GENERATED_JOBS_KEY]);
    const generatedJobs = result[GENERATED_JOBS_KEY] || {};

    generatedJobs[jobId] = {
      title: jobDetails.title,
      generatedAt: new Date().toISOString(),
      url: jobDetails.url
    };

    await chrome.storage.local.set({ [GENERATED_JOBS_KEY]: generatedJobs });
  } catch (error) {
    console.error('Error marking job as generated:', error);
  }
}

async function clearGeneratedJobsHistory() {
  try {
    await chrome.storage.local.remove([GENERATED_JOBS_KEY]);
    showSuccess('Generated jobs history cleared');
  } catch (error) {
    console.error('Error clearing generated jobs:', error);
  }
}

function showDuplicateJobWarning(existingJob, onProceed, onCancel) {
  const generatedDate = new Date(existingJob.generatedAt).toLocaleDateString();
  const generatedTime = new Date(existingJob.generatedAt).toLocaleTimeString();

  // Create modal-like warning
  const warningDiv = document.createElement('div');
  warningDiv.id = 'duplicateWarning';
  warningDiv.style.cssText = `
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.5);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1000;
  `;

  warningDiv.innerHTML = `
    <div style="
      background: white;
      padding: 24px;
      border-radius: 12px;
      max-width: 400px;
      margin: 20px;
      box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
    ">
      <div style="
        color: #dc2626;
        font-size: 16px;
        font-weight: 600;
        margin-bottom: 16px;
        text-align: center;
      ">⚠️ Duplicate Job Detected</div>
      
      <div style="
        color: #374151;
        font-size: 14px;
        line-height: 1.5;
        margin-bottom: 20px;
      ">
        You have already generated a proposal for:<br>
        <strong>"${existingJob.title}"</strong><br><br>
        Generated on: <strong>${generatedDate} at ${generatedTime}</strong><br><br>
        Do you want to generate another proposal anyway?
      </div>
      
      <div style="
        display: flex;
        gap: 12px;
        justify-content: flex-end;
      ">
        <button id="cancelDuplicate" style="
          padding: 8px 16px;
          border: 1px solid #d1d5db;
          background: white;
          color: #374151;
          border-radius: 6px;
          cursor: pointer;
          font-size: 14px;
        ">Cancel</button>
        
        <button id="proceedDuplicate" style="
          padding: 8px 16px;
          border: none;
          background: #dc2626;
          color: white;
          border-radius: 6px;
          cursor: pointer;
          font-size: 14px;
        ">Generate Anyway</button>
      </div>
    </div>
  `;

  document.body.appendChild(warningDiv);

  // Event listeners
  document.getElementById('cancelDuplicate').addEventListener('click', () => {
    document.body.removeChild(warningDiv);
    onCancel();
  });

  document.getElementById('proceedDuplicate').addEventListener('click', () => {
    document.body.removeChild(warningDiv);
    onProceed();
  });

  // Close on background click
  warningDiv.addEventListener('click', (e) => {
    if (e.target === warningDiv) {
      document.body.removeChild(warningDiv);
      onCancel();
    }
  });
}

// Load templates from API
async function loadTemplates() {
  if (!authToken) {
    templateStatusText.textContent = '❌ Please login first';
    templateStatus.className = 'template-status error';
    templateSelect.innerHTML = '<option value="">Please login first</option>';
    return;
  }

  try {
    templateStatusText.textContent = 'Loading templates...';
    templateStatus.className = 'template-status loading';
    templateSelect.innerHTML = '<option value="">Loading templates...</option>';

    const apiUrl = window.CONFIG.API_URL;
    const response = await fetch(`${apiUrl}${window.CONFIG.ENDPOINTS.GET_TEMPLATES}`, {
      headers: {
        'Authorization': `Bearer ${authToken}`,
        'Accept': 'application/json',
      }
    });

    if (response.status === 401) {
      // Token expired, logout
      await handleLogout();
      return;
    }

    if (!response.ok) {
      throw new Error('Failed to connect to API');
    }

    const data = await response.json();

    if (data.success && data.data) {
      templateCount = data.data.length;

      // Clear and populate template dropdown
      templateSelect.innerHTML = '';

      if (templateCount > 0) {
        // Add default option
        const defaultOption = document.createElement('option');
        defaultOption.value = '';
        defaultOption.textContent = 'Select a template...';
        templateSelect.appendChild(defaultOption);

        // Add template options
        data.data.forEach(template => {
          const option = document.createElement('option');
          option.value = template.id;
          option.textContent = template.name;
          if (template.description) {
            option.title = template.description;
          }
          templateSelect.appendChild(option);
        });

        templateStatusText.textContent = `✅ ${templateCount} template${templateCount > 1 ? 's' : ''} available`;
        templateStatus.className = 'template-status';

        // Load saved template selection
        await loadSavedSettings();
      } else {
        templateSelect.innerHTML = '<option value="">No templates available</option>';
        templateStatusText.textContent = '⚠️ No templates found. Create one in admin panel.';
        templateStatus.className = 'template-status error';
      }
    } else {
      throw new Error('Invalid API response');
    }
  } catch (error) {
    console.error('Error loading templates:', error);
    templateStatusText.textContent = `❌ ${error.message}`;
    templateStatus.className = 'template-status error';
    templateSelect.innerHTML = '<option value="">Error loading templates</option>';
  }
}


// Extract job details and generate proposal
async function handleExtractAndGenerate() {
  hideError();
  hideSuccess();
  hideProposal();
  setLoading(true);

  try {
    // Get current tab
    const [tab] = await chrome.tabs.query({ active: true, currentWindow: true });

    // Check if we're on Upwork
    if (!tab.url.includes('upwork.com')) {
      throw new Error('Please navigate to an Upwork job posting. Current URL: ' + tab.url);
    }

    // Check if we're on a job page specifically
    const isJobPage = tab.url.includes('/jobs/') ||
      tab.url.includes('/ab/proposals/job/') ||
      tab.url.includes('/freelance-jobs/apply/') ||
      tab.url.includes('/freelance-jobs/') ||
      tab.url.includes('/job/');

    if (!isJobPage) {
      throw new Error(`Please navigate to a specific Upwork job posting (not search results).

Supported URL patterns:
✅ https://www.upwork.com/jobs/~...
✅ https://www.upwork.com/freelance-jobs/apply/...
✅ https://www.upwork.com/ab/proposals/job/~...
✅ https://www.upwork.com/job/...

Current URL: ${tab.url}

Make sure you're on a job details page, not search results.`);
    }

    // Get API URL from config
    const apiUrl = window.CONFIG.API_URL;

    // Check if content script is loaded
    try {
      await chrome.tabs.sendMessage(tab.id, { action: 'ping' });
    } catch (error) {
      // Content script not loaded, try to inject it
      console.log('Content script not loaded, attempting to inject...');
      try {
        await chrome.scripting.executeScript({
          target: { tabId: tab.id },
          files: ['scripts/content.js']
        });
        // Wait a moment for the script to initialize
        await new Promise(resolve => setTimeout(resolve, 1000));
      } catch (injectError) {
        throw new Error(`Failed to load content script. Please refresh the page and try again. Error: ${injectError.message}`);
      }
    }

    // Extract job details from the page
    let response;
    try {
      response = await chrome.tabs.sendMessage(tab.id, { action: 'extractJobDetails' });
    } catch (error) {
      throw new Error(`Content script failed to respond. Please refresh the page and try again. Error: ${error.message}`);
    }

    if (!response) {
      throw new Error('No response from content script. Please refresh the page and try again.');
    }

    if (!response.success) {
      let errorMessage = 'Failed to extract job details from the page';

      if (response.debug) {
        console.log('Debug info:', response.debug);
        errorMessage += `\n\nDebug Info:
- Page Title: ${response.debug.pageTitle}
- Title Found: ${response.debug.titleFound}
- Description Length: ${response.debug.descriptionLength}
- Description Preview: ${response.debug.descriptionPreview}
- Skills Found: ${response.debug.skillsCount}
- Page State: ${response.debug.pageReadyState}`;
      }

      if (response.data && response.data.description && response.data.description.length > 0) {
        errorMessage += `\n\nPartial content was found (${response.data.description.length} characters), but it may not be sufficient for a good proposal.`;
      }

      throw new Error(errorMessage);
    }

    const jobDetails = response.data;

    // Additional validation
    if (!jobDetails.description || jobDetails.description.length < 20) {
      throw new Error(`Could not find sufficient job description on this page. 

Make sure you are on a job details page (not search results).
Found: ${jobDetails.description ? jobDetails.description.length : 0} characters.

Expected URL patterns:
✅ https://www.upwork.com/jobs/~...
✅ https://www.upwork.com/freelance-jobs/apply/...
✅ https://www.upwork.com/ab/proposals/job/~...
✅ https://www.upwork.com/job/...

Current URL: ${tab.url}

Try:
1. Refresh the page and wait for it to fully load
2. Scroll down to ensure all content is loaded
3. Check if you're logged into Upwork`);
    }

    // Check for duplicate job before generating
    const jobId = generateJobId(jobDetails, tab.url);
    const existingJob = await isJobAlreadyGenerated(jobId);

    if (existingJob) {
      // Show duplicate warning and wait for user decision
      showDuplicateJobWarning(
        existingJob,
        async () => {
          // User chose to proceed anyway
          await proceedWithGeneration(jobDetails, apiUrl, jobId);
        },
        () => {
          // User cancelled
          setLoading(false);
          showError('Proposal generation cancelled. This job already has a generated proposal.');
        }
      );
      return; // Exit here, callbacks will handle the rest
    }

    // No duplicate found, proceed with generation
    await proceedWithGeneration(jobDetails, apiUrl, jobId);

  } catch (error) {
    showError(error.message);
  } finally {
    setLoading(false);
  }
}

// Proceed with proposal generation (extracted for reuse)
async function proceedWithGeneration(jobDetails, apiUrl, jobId) {
  try {
    // Save current job details for regeneration
    await chrome.storage.local.set({ lastJobDetails: jobDetails });

    // Generate proposal
    await generateProposal(jobDetails, apiUrl);

    // Mark job as generated after successful generation
    await markJobAsGenerated(jobId, jobDetails);

  } catch (error) {
    throw error;
  }
}

// Generate proposal using backend API with AI review
async function generateProposal(jobDetails, apiUrl) {
  try {
    // Check if template is selected (optional for AI review endpoint)
    const selectedTemplateId = templateSelect.value;

    // Prepare proposal data
    const proposalData = {
      job_title: jobDetails.title || 'Untitled Job',
      job_description: jobDetails.description || '',
      skills: jobDetails.skills ? jobDetails.skills.join(', ') : '',
      budget: jobDetails.budget || ''
    };

    // Add template_id if selected
    if (selectedTemplateId) {
      proposalData.template_id = selectedTemplateId;
    }

    // Use the new AI review endpoint for enhanced generation
    let response = await fetch(`${apiUrl}/api/v1/proposals/generate-with-review`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': `Bearer ${authToken}`
      },
      body: JSON.stringify(proposalData)
    });

    if (response.status === 401) {
      // Token expired, logout
      await handleLogout();
      throw new Error('Session expired. Please login again.');
    }

    let result;
    let proposalText;
    let generationMethod = 'AI Enhanced';
    let reviewData = null;

    if (response.ok) {
      result = await response.json();
      if (result.success && result.data) {
        proposalText = result.data.proposal;
        generationMethod = result.data.generated_by || 'AI Enhanced';
        reviewData = result.data.review;
      }
    }

    // Fallback to original methods if AI review fails
    if (!proposalText || proposalText.length < 50) {
      console.log('AI review generation failed, trying fallback methods...');
      
      if (selectedTemplateId) {
        // Try template-based generation
        response = await fetch(`${apiUrl}${window.CONFIG.ENDPOINTS.GENERATE_PROPOSAL}`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': `Bearer ${authToken}`
          },
          body: JSON.stringify({
            template_id: selectedTemplateId,
            job_title: proposalData.job_title,
            job_description: proposalData.job_description,
            skills: proposalData.skills,
            budget: proposalData.budget
          })
        });

        if (response.ok) {
          result = await response.json();
          if (result.success && result.data) {
            proposalText = result.data.proposal;
            generationMethod = 'Template: ' + result.data.template_name;
          }
        }
      } else {
        // Try AI generation without review
        response = await fetch(`${apiUrl}/api/v1/proposals/generate-openai`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': `Bearer ${authToken}`
          },
          body: JSON.stringify(proposalData)
        });

        if (response.ok) {
          result = await response.json();
          if (result.success && result.data) {
            proposalText = result.data.proposal;
            generationMethod = 'AI (OpenRouter)';
          }
        }
      }
    }

    if (!proposalText) {
      const errorData = await response.json().catch(() => ({}));
      throw new Error(errorData.message || 'Failed to generate proposal with all available methods');
    }

    // Copy to clipboard
    try {
      await navigator.clipboard.writeText(proposalText);
      let successMessage = `Proposal generated using ${generationMethod} and copied to clipboard!`;
      
      if (reviewData) {
        successMessage += ` (AI Score: ${reviewData.score}/10)`;
        if (reviewData.was_revised) {
          successMessage += ` - Improved by AI review`;
        }
      }
      
      showSuccess(successMessage);
    } catch (clipboardError) {
      let successMessage = `Proposal generated using ${generationMethod} and stored in database!`;
      if (reviewData) {
        successMessage += ` (AI Score: ${reviewData.score}/10)`;
      }
      successMessage += ` (Clipboard copy failed)`;
      showSuccess(successMessage);
    }

    // Display the proposal with review information
    displayProposal(proposalText, reviewData);

  } catch (error) {
    throw error;
  }
}

// Display proposal with optional review information
function displayProposal(proposal, reviewData = null) {
  proposalContent.textContent = proposal;
  
  // Add review information if available
  if (reviewData) {
    const reviewInfo = document.createElement('div');
    reviewInfo.className = 'review-info';
    reviewInfo.style.cssText = `
      background: #f8f9fa;
      border: 1px solid #e9ecef;
      border-radius: 6px;
      padding: 12px;
      margin-top: 12px;
      font-size: 12px;
    `;
    
    let reviewHTML = `<strong>AI Review Score: ${reviewData.score}/10</strong>`;
    
    if (reviewData.was_revised) {
      reviewHTML += `<br><span style="color: #28a745;">✅ Improved by AI review</span>`;
    }
    
    if (reviewData.strengths && reviewData.strengths.length > 0) {
      reviewHTML += `<br><strong>Strengths:</strong> ${reviewData.strengths.slice(0, 2).join(', ')}`;
    }
    
    if (reviewData.improvements && reviewData.improvements.length > 0) {
      reviewHTML += `<br><strong>Suggestions:</strong> ${reviewData.improvements.slice(0, 2).join(', ')}`;
    }
    
    reviewInfo.innerHTML = reviewHTML;
    
    // Remove existing review info if any
    const existingReview = proposalContent.parentNode.querySelector('.review-info');
    if (existingReview) {
      existingReview.remove();
    }
    
    proposalContent.parentNode.appendChild(reviewInfo);
  }
  
  proposalSection.style.display = 'block';

  // Save proposal and review data for later
  chrome.storage.local.set({ 
    lastProposal: proposal,
    lastReviewData: reviewData 
  });
}

// Handle copy to clipboard
async function handleCopy() {
  try {
    const text = proposalContent.textContent;
    await navigator.clipboard.writeText(text);
    showSuccess('Copied to clipboard!');
  } catch (error) {
    showError('Failed to copy: ' + error.message);
  }
}

// Handle regenerate
async function handleRegenerate() {
  try {
    const result = await chrome.storage.local.get(['lastJobDetails']);

    if (!result.lastJobDetails) {
      throw new Error('No job details found. Please extract again.');
    }

    if (!authToken) {
      throw new Error('Please login first to regenerate proposals.');
    }

    const apiUrl = window.CONFIG.API_URL;

    hideError();
    hideSuccess();
    setLoading(true);

    await generateProposal(result.lastJobDetails, apiUrl);

  } catch (error) {
    showError(error.message);
  } finally {
    setLoading(false);
  }
}

// UI helper functions
function setLoading(isLoading) {
  extractBtn.disabled = isLoading;
  if (isLoading) {
    extractText.style.display = 'none';
    loadingSpinner.style.display = 'inline';
  } else {
    extractText.style.display = 'inline';
    loadingSpinner.style.display = 'none';
  }
}

function showError(message) {
  errorMessage.textContent = message;
  errorMessage.style.display = 'block';
}

function hideError() {
  errorMessage.style.display = 'none';
}

function showSuccess(message) {
  successMessage.textContent = '✅ ' + message;
  successMessage.style.display = 'block';
  setTimeout(() => {
    successMessage.style.display = 'none';
  }, 3000);
}

function hideSuccess() {
  successMessage.style.display = 'none';
}

function hideProposal() {
  proposalSection.style.display = 'none';
}

// Login-specific error handling
function showLoginError(message) {
  console.log('Showing login error:', message);
  if (loginErrorMessage) {
    loginErrorMessage.textContent = message;
    loginErrorMessage.style.display = 'block';
    console.log('Login error message displayed');
  } else {
    console.error('loginErrorMessage element not found!');
  }
}

function hideLoginError() {
  console.log('Hiding login error');
  if (loginErrorMessage) {
    loginErrorMessage.style.display = 'none';
  }
}

function showSessionWarning(daysLeft) {
  const warningMessage = `⚠️ Session expires in ${daysLeft} day${daysLeft > 1 ? 's' : ''}. You'll need to login again.`;

  // Create or update session warning element
  let warningElement = document.getElementById('sessionWarning');
  if (!warningElement) {
    warningElement = document.createElement('div');
    warningElement.id = 'sessionWarning';
    warningElement.style.cssText = `
      background: #fff3cd;
      color: #856404;
      border: 1px solid #ffeaa7;
      padding: 8px 12px;
      border-radius: 6px;
      font-size: 12px;
      margin: 10px 0;
      text-align: center;
    `;

    // Insert after user welcome section
    const userSection = document.querySelector('.user-section');
    if (userSection) {
      userSection.parentNode.insertBefore(warningElement, userSection.nextSibling);
    }
  }

  warningElement.textContent = warningMessage;
  warningElement.style.display = 'block';
}


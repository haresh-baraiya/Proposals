// Enhanced content script to extract job requirements from modern Upwork pages

// Function to extract job details from the page
function extractJobDetails() {
  console.log("🔍 Extracting job details from:", window.location.href);
  console.log("🔍 Page title:", document.title);
  console.log("🔍 Page ready state:", document.readyState);

  const jobDetails = {
    title: "",
    description: "",
    skills: [],
    budget: "",
    duration: "",
    url: window.location.href,
  };

  try {
    // Wait a bit for dynamic content to load
    if (document.readyState !== 'complete') {
      console.log("⏳ Page not fully loaded, waiting...");
    }

    // Extract job title - comprehensive approach
    jobDetails.title = extractJobTitle();

    // Ensure we always have a title (required by API)
    if (!jobDetails.title || jobDetails.title.length < 3) {
      // Try to extract from page title as fallback
      const pageTitle = document.title;
      if (pageTitle && !pageTitle.toLowerCase().includes('upwork') && pageTitle.length > 10) {
        jobDetails.title = pageTitle.replace(/\s*\|\s*Upwork.*$/i, '').trim();
        console.log("📝 Using page title as fallback:", jobDetails.title);
      } else {
        jobDetails.title = "Job Posting - " + new Date().toLocaleDateString();
        console.log("⚠️ Using generic fallback title:", jobDetails.title);
      }
    } else {
      console.log("📝 Found title:", jobDetails.title);
    }

    // Extract job description - multiple methods
    jobDetails.description = extractJobDescription();
    console.log("📄 Found description (length):", jobDetails.description.length);

    // If description is too short, try alternative methods
    if (jobDetails.description.length < 50) {
      console.log("⚠️ Description too short, trying alternative extraction...");
      jobDetails.description = extractDescriptionAlternative();
      console.log("📄 Alternative description (length):", jobDetails.description.length);
    }

    // Extract skills
    jobDetails.skills = extractSkills();
    console.log("🔧 Found skills:", jobDetails.skills.length, "items");

    // Extract budget
    jobDetails.budget = extractBudget();
    console.log("💰 Found budget:", jobDetails.budget);

    // Extract other details
    jobDetails.duration = extractDuration();
  } catch (error) {
    console.error("❌ Error extracting job details:", error);
  }

  // Validate minimum requirements
  const isValid = validateExtraction(jobDetails);
  console.log("✅ Extraction validation:", isValid ? "PASSED" : "FAILED");

  // Log final extracted data
  console.log("✅ Final extracted job details:", {
    title: jobDetails.title,
    descriptionLength: jobDetails.description.length,
    skillsCount: jobDetails.skills.length,
    budget: jobDetails.budget,
    url: jobDetails.url,
    isValid: isValid
  });

  return jobDetails;
}

// Validate extraction results
function validateExtraction(jobDetails) {
  const issues = [];

  if (!jobDetails.title || jobDetails.title.length < 5) {
    issues.push("Title too short or missing");
  }

  if (!jobDetails.description || jobDetails.description.length < 20) {
    issues.push("Description too short or missing");
  }

  if (issues.length > 0) {
    console.warn("⚠️ Validation issues:", issues);
    return false;
  }

  return true;
}

function extractJobTitle() {
  console.log("🔍 Extracting job title...");

  const titleSelectors = [
    // 2024 Upwork selectors (most recent)
    '[data-test="job-title"] h1',
    '[data-test="job-title"] h2',
    '[data-test="job-title"] h3',
    '[data-test="job-title"] h4',
    '[data-test="job-title"]',

    // Apply page specific selectors
    '.job-apply-title',
    '.apply-job-title',
    '[class*="apply"] h1',
    '[class*="apply"] h2',
    '[class*="apply"] h3',
    '[class*="apply"] h4',

    // Air3 design system selectors
    "h4.d-flex span.flex-1",
    "h4 span.flex-1",
    "section.air3-card-section h4 span",
    ".air3-card-section h4 span",
    "h4.d-flex.align-items-center span.flex-1",
    '.air3-card-section [class*="title"]',

    // Job posting specific selectors
    '[data-qa="job-title"]',
    '[data-testid="job-title"]',
    '.job-tile-title',
    '.job-posting-title',

    // Standard Upwork selectors
    'h1[data-test="job-title"]',
    'h2[data-test="job-title"]',
    'h3[data-test="job-title"]',
    'h4[data-test="job-title"]',
    'h1[class*="job-title"]',
    'h2[class*="job-title"]',
    'h3[class*="job-title"]',
    'h4[class*="job-title"]',
    'h1[class*="JobTitle"]',
    'h2[class*="JobTitle"]',
    'h3[class*="JobTitle"]',
    'h4[class*="JobTitle"]',
    ".job-title h1",
    ".job-title h2",
    ".job-title h3",
    ".job-title h4",

    // Cypress test selectors
    'h1[data-cy="job-title"]',
    'h2[data-cy="job-title"]',
    'h3[data-cy="job-title"]',
    'h4[data-cy="job-title"]',
    '[data-cy="job-title"]',

    // Generic title selectors
    'h1[class*="title"]',
    'h2[class*="title"]',
    'h3[class*="title"]',
    'h4[class*="title"]',
    '[class*="JobTitle"] h1',
    '[class*="JobTitle"] h2',
    '[class*="JobTitle"] h3',
    '[class*="JobTitle"] h4',

    // Generic selectors (will be filtered)
    "h1",
    "h2",
    "h3",
    "h4",
  ];

  for (const selector of titleSelectors) {
    const element = document.querySelector(selector);
    if (element && element.textContent.trim().length > 5) {
      const title = element.textContent.trim();
      console.log(
        `🔍 Checking title from "${selector}":`,
        title.substring(0, 100)
      );

      // Skip generic/unwanted titles
      const lowerTitle = title.toLowerCase();
      if (
        !lowerTitle.includes("upwork") &&
        !lowerTitle.includes("freelancer") &&
        !lowerTitle.includes("sign in") &&
        !lowerTitle.includes("log in") &&
        !lowerTitle.includes("menu") &&
        !lowerTitle.includes("navigation") &&
        title.length < 200 &&
        title.length > 10
      ) {
        console.log("✅ Found valid title:", title);
        return title;
      }
    }
  }

  // Fallback: Look for any text that looks like a job title
  console.log("🔍 Trying fallback title extraction...");
  const allElements = document.querySelectorAll("*");

  for (const element of allElements) {
    const text = element.textContent.trim();
    if (text.length > 10 && text.length < 150) {
      const lowerText = text.toLowerCase();
      // Look for job-related keywords
      if (
        (lowerText.includes("developer") ||
          lowerText.includes("designer") ||
          lowerText.includes("engineer") ||
          lowerText.includes("specialist") ||
          lowerText.includes("manager") ||
          lowerText.includes("consultant")) &&
        !lowerText.includes("upwork") &&
        !lowerText.includes("freelancer")
      ) {
        console.log("✅ Found title via fallback:", text);
        return text;
      }
    }
  }

  console.log("❌ No title found");
  return "";
}

function extractJobDescription() {
  console.log("🔍 Attempting to extract job description...");

  // Method 1: Try specific selectors (updated for 2024)
  const descriptionSelectors = [
    // 2024 Upwork selectors
    '[data-test="Description"]',
    '[data-test="Description"] div',
    '[data-test="Description"] p',
    '[data-test="job-description"]',
    '[data-test="JobDescription"]',
    '[data-qa="job-description"]',
    '[data-testid="job-description"]',

    // Apply page specific selectors
    '.job-apply-description',
    '.apply-job-description',
    '[class*="apply"] [class*="description"]',
    '.job-apply-content',
    '.apply-content',

    // Air3 design system
    '.air3-card-section [class*="description"]',
    'section.air3-card-section div',

    // Cypress selectors
    '[data-cy="job-description"]',
    '[data-cy="Description"]',

    // Class-based selectors
    ".job-description",
    ".job-posting-description",
    ".job-details-description",
    '[class*="description"]',
    '[class*="Description"]',
    '[class*="JobDescription"]',
    'section[class*="description"]',
    'div[class*="job-summary"]',
    'section[class*="job-summary"]',

    // Job details containers
    '[data-test="job-details"]',
    '[data-test="JobDetails"]',
    '.job-details',
    '.job-posting-details',

    // Content containers
    '.job-content',
    '.posting-content',
    'main [class*="content"]',
    'article [class*="content"]',
  ];

  for (const selector of descriptionSelectors) {
    const element = document.querySelector(selector);
    if (element && element.textContent.trim().length > 100) {
      console.log("✅ Found description via selector:", selector);
      return cleanText(element.textContent.trim());
    }
  }

  // Method 2: Look for text containing job-related keywords
  console.log("🔍 Trying keyword-based extraction...");
  const jobKeywords = [
    "responsibilities",
    "requirements",
    "deliverables",
    "experience",
    "skills",
    "project",
    "developer",
    "design",
    "implement",
    "looking for",
    "key responsibilities",
    "job summary",
    "about the role",
  ];

  const allElements = document.querySelectorAll("div, section, p, article");
  let bestMatch = "";
  let bestScore = 0;

  for (const element of allElements) {
    // Skip elements that are likely UI components
    if (isUIElement(element)) {
      continue;
    }

    const text = element.textContent.trim();
    if (text.length > 200 && text.length < 10000) {
      const lowerText = text.toLowerCase();
      const score = jobKeywords.filter((keyword) =>
        lowerText.includes(keyword)
      ).length;

      if (score > bestScore) {
        bestScore = score;
        bestMatch = text;
      }
    }
  }

  if (bestMatch && bestScore >= 2) {
    console.log(
      "✅ Found description via keyword matching (score:",
      bestScore,
      ")"
    );
    return cleanText(bestMatch);
  }

  // Method 3: Get the largest meaningful text block
  console.log("🔍 Trying largest text block extraction...");
  let longestText = "";

  for (const element of allElements) {
    const text = element.textContent.trim();
    const classes = element.className.toLowerCase();

    // Skip navigation, header, footer elements
    if (
      classes.includes("nav") ||
      classes.includes("header") ||
      classes.includes("footer") ||
      classes.includes("sidebar") ||
      classes.includes("menu")
    ) {
      continue;
    }

    if (
      text.length > longestText.length &&
      text.length > 300 &&
      text.length < 8000
    ) {
      // Check if it contains job-related content
      const lowerText = text.toLowerCase();
      if (
        lowerText.includes("project") ||
        lowerText.includes("developer") ||
        lowerText.includes("experience") ||
        lowerText.includes("skills")
      ) {
        longestText = text;
      }
    }
  }

  if (longestText) {
    console.log("✅ Found description via longest text method");
    return cleanText(longestText);
  }

  // Method 4: Try to extract from main content areas
  console.log("🔍 Trying main content area extraction...");
  const mainSelectors = [
    "main",
    '[role="main"]',
    ".main-content",
    "#main",
    ".content",
    "article",
  ];

  for (const selector of mainSelectors) {
    const mainElement = document.querySelector(selector);
    if (mainElement) {
      const text = mainElement.textContent.trim();
      if (text.length > 500) {
        console.log("✅ Found description from main content area");
        return cleanText(text);
      }
    }
  }

  // Method 5: Last resort - get all visible text
  console.log("🔍 Last resort: extracting all visible text...");
  const bodyText = document.body.textContent.trim();
  if (bodyText.length > 500) {
    console.log("⚠️ Using body text as fallback");
    return cleanText(bodyText.substring(0, 3000)); // Limit to reasonable size
  }

  console.log("❌ Could not extract job description");
  return "";
}

// Alternative description extraction for difficult pages
function extractDescriptionAlternative() {
  console.log("🔍 Attempting alternative description extraction...");

  // Method 1: Find the largest text block that looks like a job description
  const allDivs = document.querySelectorAll('div, section, article, p');
  let candidates = [];

  for (const element of allDivs) {
    // Skip UI elements
    if (isUIElement(element)) continue;

    const text = element.textContent.trim();
    const lowerText = text.toLowerCase();

    // Look for job description indicators
    const jobIndicators = [
      'looking for', 'seeking', 'need', 'require', 'project', 'developer',
      'designer', 'experience', 'skills', 'responsibilities', 'deliverables',
      'timeline', 'budget', 'freelancer', 'contractor', 'hire'
    ];

    const indicatorCount = jobIndicators.filter(indicator =>
      lowerText.includes(indicator)
    ).length;

    if (text.length > 100 && text.length < 8000 && indicatorCount >= 2) {
      candidates.push({
        element: element,
        text: text,
        score: indicatorCount,
        length: text.length
      });
    }
  }

  // Sort by score and length
  candidates.sort((a, b) => {
    if (a.score !== b.score) return b.score - a.score;
    return b.length - a.length;
  });

  if (candidates.length > 0) {
    console.log(`✅ Found ${candidates.length} description candidates, using best match`);
    console.log(`Best candidate: ${candidates[0].score} indicators, ${candidates[0].length} chars`);
    return cleanText(candidates[0].text);
  }

  // Method 3: Extract from page body with better filtering
  console.log("🔍 Trying body text extraction with filtering...");
  const bodyText = document.body.textContent;

  // Split into paragraphs and filter
  const paragraphs = bodyText.split(/\n\s*\n/);
  let jobContent = [];

  for (const paragraph of paragraphs) {
    const cleanPara = paragraph.trim();
    const lowerPara = cleanPara.toLowerCase();

    // Skip UI elements and navigation
    if (cleanPara.length < 50 ||
      lowerPara.includes('upwork') ||
      lowerPara.includes('freelancer') ||
      lowerPara.includes('sign in') ||
      lowerPara.includes('connect') ||
      lowerPara.includes('proposal') ||
      lowerPara.includes('navigation') ||
      lowerPara.includes('menu')) {
      continue;
    }

    // Look for job-related content
    const jobKeywords = ['project', 'developer', 'design', 'experience', 'skills', 'looking for'];
    const hasJobKeywords = jobKeywords.some(keyword => lowerPara.includes(keyword));

    if (hasJobKeywords) {
      jobContent.push(cleanPara);
    }
  }

  if (jobContent.length > 0) {
    const result = jobContent.join('\n\n');
    console.log("✅ Extracted from filtered body text");
    return cleanText(result);
  }

  console.log("❌ Alternative extraction failed");
  return "";
}

function extractSkills() {
  const skills = [];
  const skillSelectors = [
    '[data-test="token"]',
    '[data-test="skill"]',
    '[data-cy="skill"]',
    'a[href*="/ab/profiles/search?q="]',
    ".skill-tag",
    '[class*="skill"]',
    '[class*="Skill"]',
    'span[class*="tag"]',
    ".tag",
    '[data-test="SkillsMatchTags"] span',
    '[class*="SkillTag"]',
  ];

  skillSelectors.forEach((selector) => {
    const elements = document.querySelectorAll(selector);
    elements.forEach((element) => {
      const skillText = element.textContent.trim();
      if (
        skillText &&
        skillText.length > 1 &&
        skillText.length < 50 &&
        !skills.includes(skillText) &&
        !skillText.toLowerCase().includes("upwork") &&
        !skillText.includes("$")
      ) {
        skills.push(skillText);
      }
    });
  });

  return skills;
}

function extractBudget() {
  const budgetSelectors = [
    '[data-test="budget"]',
    '[data-test="Budget"]',
    '[class*="budget"]',
    '[class*="Budget"]',
    '[class*="price"]',
    '[class*="Price"]',
  ];

  for (const selector of budgetSelectors) {
    const element = document.querySelector(selector);
    if (element && element.textContent.includes("$")) {
      return cleanBudgetText(element.textContent.trim());
    }
  }

  // Look for any element containing dollar signs
  const allElements = document.querySelectorAll("*");
  for (const element of allElements) {
    const text = element.textContent.trim();
    if (
      text.includes("$") &&
      text.length < 100 &&
      (text.includes("hour") ||
        text.includes("project") ||
        text.includes("budget"))
    ) {
      return cleanBudgetText(text);
    }
  }

  return "";
}

function cleanBudgetText(rawText) {
  if (!rawText || !rawText.includes("$")) {
    return "";
  }

  // IMPORTANT: Preserve original USD format - no currency conversion
  // Extract only USD dollar amounts exactly as they appear on Upwork

  // Remove extra text and keep only budget-related information
  let cleanText = rawText;

  // Remove location, time, and hiring stats
  cleanText = cleanText.replace(/United States[^$]*/, '');
  cleanText = cleanText.replace(/\d{1,2}:\d{2}\s*(AM|PM)[^$]*/, '');
  cleanText = cleanText.replace(/\d+\s*hires?[^$]*/, '');
  cleanText = cleanText.replace(/\d+\s*hours?[^$]*/, '');
  cleanText = cleanText.replace(/\d+\s*active[^$]*/, '');
  cleanText = cleanText.replace(/total spent[^$]*/, '');

  // Extract USD dollar amounts using regex - preserve exact Upwork format
  const dollarAmounts = cleanText.match(/\$[\d,]+(?:\.\d{2})?(?:K|k)?/g);

  // Ensure we only work with USD amounts ($ symbol)
  if (!dollarAmounts || dollarAmounts.length === 0) {
    return "";
  }

  // Look for hourly rate patterns - preserve USD format
  if (rawText.toLowerCase().includes('hour') || rawText.includes('/hr')) {
    const hourlyMatch = rawText.match(/\$[\d,]+(?:\.\d{2})?(?:K|k)?\s*(?:\/hr|per hour|hourly)/i);
    if (hourlyMatch) {
      return hourlyMatch[0].replace(/\s*(?:\/hr|per hour|hourly)/i, '/hr');
    }
  }

  // Look for fixed price patterns - preserve USD format
  if (rawText.toLowerCase().includes('fixed') || rawText.toLowerCase().includes('project')) {
    const fixedMatch = rawText.match(/\$[\d,]+(?:\.\d{2})?(?:K|k)?(?:\s*-\s*\$[\d,]+(?:\.\d{2})?(?:K|k)?)?/);
    if (fixedMatch) {
      return fixedMatch[0];
    }
  }

  // If we have multiple amounts, try to determine if it's a range
  if (dollarAmounts.length === 1) {
    return dollarAmounts[0];
  } else if (dollarAmounts.length === 2) {
    // Check if they appear to be a range (close together in text)
    const firstIndex = cleanText.indexOf(dollarAmounts[0]);
    const secondIndex = cleanText.indexOf(dollarAmounts[1]);
    const distance = secondIndex - (firstIndex + dollarAmounts[0].length);

    if (distance < 10) { // If amounts are close together, likely a range
      return `${dollarAmounts[0]} - ${dollarAmounts[1]}`;
    }
    return dollarAmounts[0]; // Return first amount if not a range
  } else {
    // Multiple amounts found, return the most relevant one
    // Filter out very small amounts that might be irrelevant
    const meaningfulAmounts = dollarAmounts.filter(amount => {
      const numValue = parseFloat(amount.replace(/[$,K]/g, ''));
      return numValue >= 10; // Filter out amounts less than $10
    });

    if (meaningfulAmounts.length > 0) {
      return meaningfulAmounts[0];
    }
    return dollarAmounts[0];
  }
}

function extractDuration() {
  const durationSelectors = [
    '[data-test="duration"]',
    '[data-test="Duration"]',
    '[class*="duration"]',
    '[class*="Duration"]',
  ];

  for (const selector of durationSelectors) {
    const element = document.querySelector(selector);
    if (element) {
      return element.textContent.trim();
    }
  }

  // Look for duration-related text
  const allElements = document.querySelectorAll("*");
  for (const element of allElements) {
    const text = element.textContent.trim();
    if (
      text.length < 100 &&
      (text.includes("month") ||
        text.includes("week") ||
        text.includes("hrs/week"))
    ) {
      return text;
    }
  }

  return "";
}



function isUIElement(element) {
  // Check if element is likely a UI component rather than job content
  const classes = element.className.toLowerCase();
  const id = element.id.toLowerCase();
  const text = element.textContent.trim().toLowerCase();

  // Skip navigation, header, footer, sidebar elements
  const uiPatterns = [
    'nav', 'header', 'footer', 'sidebar', 'menu', 'toolbar', 'breadcrumb',
    'tooltip', 'modal', 'popup', 'dropdown', 'button', 'btn', 'link',
    'connect', 'proposal', 'client-info', 'verification', 'badge',
    'rating', 'review', 'stats', 'history', 'profile'
  ];

  // Check class names and IDs
  for (const pattern of uiPatterns) {
    if (classes.includes(pattern) || id.includes(pattern)) {
      return true;
    }
  }

  // Skip elements with UI-related text
  const uiTextPatterns = [
    'connects to apply', 'submit proposal', 'save job', 'flag as inappropriate',
    'payment verified', 'identity verified', 'hire rate', 'total spent',
    'member since', 'close', 'tooltip', 'learn more', 'show more'
  ];

  for (const pattern of uiTextPatterns) {
    if (text.includes(pattern)) {
      return true;
    }
  }

  return false;
}

function cleanText(text) {
  console.log('🧹 Cleaning extracted text...');

  // Remove Upwork UI clutter and irrelevant content
  const upworkUIPatterns = [
    // Navigation and UI elements
    /As part of our continued efforts to remain compliant with tax laws globally.*/gi,
    /Close the alert.*/gi,
    /Upgrade to a Plus plan for more Connects.*/gi,
    /You'll need Connects to bid.*/gi,
    /Buy Connects to apply.*/gi,
    /Client's recent history \(\d+\).*/gi,
    /Close the tooltip.*/gi,
    /Last viewed by client.*/gi,
    /Payment verified.*/gi,
    /Hire rate.*/gi,
    /Open to offers.*/gi,
    /Total spent.*/gi,
    /Reviews.*/gi,
    /Member since.*/gi,
    /Avg hourly rate paid.*/gi,
    /Hours worked.*/gi,
    /Total jobs posted.*/gi,

    // Repeated sections and duplicates
    /Specialized profiles can help you better highlight your expertise.*/gi,
    /Create a specialized profile.*/gi,
    /Submit a Proposal.*/gi,
    /Save Job.*/gi,
    /Flag as inappropriate.*/gi,
    /Report this job.*/gi,

    // Connect-related UI
    /\d+ Connects? to apply/gi,
    /Available Connects/gi,
    /Get more Connects/gi,

    // Client verification badges
    /Identity Verified/gi,
    /Payment method verified/gi,
    /Phone verified/gi,
    /Email verified/gi,

    // Tooltips and help text
    /Tooltip/gi,
    /Help/gi,
    /Learn more/gi,
    /Show more/gi,
    /Show less/gi,

    // Navigation breadcrumbs
    /Home\s*›\s*Find Work\s*›/gi,
    /Browse jobs/gi,
    /My Jobs/gi,
    /Messages/gi,

    // Repeated job posting info
    /Posted \d+ \w+ ago/gi,
    /Worldwide/gi,
    /Proposals: \d+/gi,
    /Interviewing: \d+/gi,
    /Invites sent: \d+/gi,
    /Unanswered invites: \d+/gi,
  ];

  let cleanedText = text;

  // Remove UI patterns
  upworkUIPatterns.forEach(pattern => {
    cleanedText = cleanedText.replace(pattern, '');
  });

  // Remove excessive whitespace and normalize
  cleanedText = cleanedText
    .replace(/\s+/g, ' ') // Replace multiple spaces with single space
    .replace(/\n\s*\n\s*\n/g, '\n\n') // Replace multiple newlines with double newline
    .replace(/^\s+|\s+$/g, '') // Trim start and end
    .trim();

  // Remove duplicate sentences (common in Upwork pages)
  const sentences = cleanedText.split(/[.!?]+/);
  const uniqueSentences = [];
  const seenSentences = new Set();

  sentences.forEach(sentence => {
    const normalizedSentence = sentence.trim().toLowerCase();
    if (normalizedSentence.length > 10 && !seenSentences.has(normalizedSentence)) {
      seenSentences.add(normalizedSentence);
      uniqueSentences.push(sentence.trim());
    }
  });

  const finalText = uniqueSentences.join('. ').trim();
  console.log('✅ Text cleaned. Original length:', text.length, 'Cleaned length:', finalText.length);

  return finalText;
}

// Listen for messages from popup
chrome.runtime.onMessage.addListener((request, _sender, sendResponse) => {
  // Handle ping to check if content script is loaded
  if (request.action === "ping") {
    sendResponse({ success: true, loaded: true });
    return true;
  }

  if (request.action === "extractJobDetails") {
    console.log("📨 Received extraction request");

    // Handle async extraction
    handleExtractionRequest()
      .then(result => {
        console.log("📤 Sending response:", result);
        sendResponse(result);
      })
      .catch(error => {
        console.error("❌ Extraction error:", error);
        sendResponse({
          success: false,
          error: error.message,
          debug: { error: error.toString() }
        });
      });

    return true; // Keep message channel open for async response
  }
  return false;
});

// Async function to handle extraction request
async function handleExtractionRequest() {
  try {
    // Wait for content to be ready
    console.log("⏳ Waiting for page content to be ready...");
    await waitForJobContent();

    // Perform initial extraction
    const jobDetails = extractJobDetails();
    const isValid = validateExtraction(jobDetails);

    if (isValid) {
      console.log("✅ Extraction successful");
      return { success: true, data: jobDetails };
    }

    console.log("⚠️ Initial extraction insufficient, trying alternative methods...");

    // Try scrolling to load more content
    window.scrollTo(0, document.body.scrollHeight / 2);
    await new Promise(resolve => setTimeout(resolve, 1000));

    // Retry extraction
    const retryDetails = extractJobDetails();
    const retryValid = validateExtraction(retryDetails);

    if (retryValid) {
      console.log("✅ Retry extraction successful");
      return { success: true, data: retryDetails };
    } else {
      console.log("❌ All extraction attempts failed");

      // Provide detailed error information
      const errorInfo = {
        url: window.location.href,
        pageTitle: document.title,
        titleFound: retryDetails.title,
        descriptionLength: retryDetails.description.length,
        descriptionPreview: retryDetails.description.substring(0, 100),
        skillsCount: retryDetails.skills.length,
        pageReadyState: document.readyState,
        bodyTextLength: document.body.textContent.trim().length,
        hasH1: !!document.querySelector('h1'),
        hasH2: !!document.querySelector('h2'),
        hasH3: !!document.querySelector('h3'),
        hasH4: !!document.querySelector('h4'),
        timestamp: new Date().toISOString()
      };

      console.log("🔍 Detailed error info:", errorInfo);

      return {
        success: false,
        data: retryDetails,
        error: "Failed to extract sufficient job details from the page",
        debug: errorInfo
      };
    }
  } catch (error) {
    console.error("❌ Extraction error:", error);
    throw error;
  }
}

// Wait for page to be ready and content to load
function waitForPageReady() {
  return new Promise((resolve) => {
    if (document.readyState === 'complete') {
      // Wait a bit more for dynamic content
      setTimeout(resolve, 1000);
    } else {
      window.addEventListener('load', () => {
        setTimeout(resolve, 1000);
      });
    }
  });
}

// Enhanced page ready detection
function waitForJobContent() {
  return new Promise((resolve) => {
    let attempts = 0;
    const maxAttempts = 10;

    const checkContent = () => {
      attempts++;

      // Look for any job-related content
      const hasTitle = document.querySelector('h1, h2, h3, h4')?.textContent?.trim().length > 5;
      const hasContent = document.body.textContent.trim().length > 1000;

      if (hasTitle && hasContent) {
        console.log(`✅ Job content detected after ${attempts} attempts`);
        resolve(true);
      } else if (attempts >= maxAttempts) {
        console.log(`⚠️ Timeout waiting for job content after ${attempts} attempts`);
        resolve(false);
      } else {
        console.log(`⏳ Waiting for job content... attempt ${attempts}/${maxAttempts}`);
        setTimeout(checkContent, 500);
      }
    };

    checkContent();
  });
}

// Auto-extract when page loads (for debugging)
window.addEventListener("load", async () => {
  console.log("🚀 Upwork Proposal Generator: Enhanced content script loaded");
  console.log("📍 Current URL:", window.location.href);

  // Wait for content to be ready
  await waitForPageReady();
  await waitForJobContent();

  // Auto-extract after content is ready
  console.log("🔄 Auto-extracting job details for debugging...");
  const details = extractJobDetails();
  console.log("🎯 Auto-extraction result:", details);
});

// Monitor for dynamic content changes
let contentChangeTimeout;
const observer = new MutationObserver((mutations) => {
  // Debounce content changes
  clearTimeout(contentChangeTimeout);
  contentChangeTimeout = setTimeout(() => {
    if (mutations.length > 3) {
      console.log("🔄 Significant page content changed, job details may be available now");
    }
  }, 1000);
});

// Start observing after page loads
window.addEventListener("load", () => {
  observer.observe(document.body, {
    childList: true,
    subtree: true,
  });
});

console.log("✅ Enhanced Upwork content script initialized");

// Add a global flag to indicate content script is loaded
window.upworkProposalGeneratorLoaded = true;

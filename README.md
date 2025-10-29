# Upwork Proposal Generator

An AI-powered Chrome extension that automatically generates professional proposals for Upwork job postings using templates and OpenAI integration.

## 🚀 Features

- **Smart Job Extraction**: Automatically extracts job details from Upwork pages
- **Template-Based Generation**: Use predefined templates with variable replacement
- **AI-Enhanced Proposals**: Generate proposals using OpenRouter.ai with DeepSeek model
- **AI Review & Improvement**: Automatically reviews and improves proposals for quality
- **Clipboard Integration**: Automatically copies generated proposals to clipboard
- **Duplicate Detection**: Prevents generating multiple proposals for the same job
- **User Authentication**: Secure login system with session management
- **Proposal History**: Stores all generated proposals in database

## 📁 Project Structure

```
├── proposal-api/              # Laravel API Backend
│   ├── app/
│   │   ├── Http/Controllers/Api/
│   │   │   ├── AuthController.php
│   │   │   └── ProposalController.php
│   │   ├── Models/
│   │   │   ├── User.php
│   │   │   ├── Template.php
│   │   │   └── Proposal.php
│   │   └── Services/
│   │       └── OpenAIService.php
│   ├── config/
│   │   └── openai.php
│   ├── database/
│   │   └── migrations/
│   └── routes/
│       └── api.php
├── upwork-proposal-generator/ # Chrome Extension
│   ├── manifest.json
│   ├── popup/
│   │   ├── popup.html
│   │   ├── popup.js
│   │   └── popup.css
│   ├── scripts/
│   │   ├── content.js
│   │   └── background.js
│   ├── config.js
│   └── icons/
└── test.html                 # Feature Testing Page
```

## 🛠️ Installation & Setup

### Prerequisites

- PHP 8.1+
- Composer
- MySQL/MariaDB
- Node.js (for Chrome extension development)
- Chrome Browser

### 1. Backend Setup (Laravel API)

```bash
# Navigate to API directory
cd proposal-api

# Install dependencies
composer install

# Copy environment file
cp .env.example .env

# Generate application key
php artisan key:generate

# Configure database in .env file
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=proposal_api
DB_USERNAME=your_username
DB_PASSWORD=your_password

# Configure OpenAI API
OPENAI_API_KEY=your_openrouter_api_key
OPENAI_MODEL=deepseek/deepseek-chat-v3.1
OPENAI_MAX_TOKENS=800
OPENAI_TEMPERATURE=0.7

# Run migrations
php artisan migrate

# Seed database (optional)
php artisan db:seed

# Start development server
php artisan serve --host=127.0.0.1 --port=8000
```

### 2. Chrome Extension Setup

1. Open Chrome and navigate to `chrome://extensions/`
2. Enable "Developer mode" in the top right
3. Click "Load unpacked" and select the `upwork-proposal-generator` folder
4. The extension will appear in your Chrome toolbar

### 3. Configuration

#### API Configuration
Update `upwork-proposal-generator/config.js`:
```javascript
const CONFIG = {
  API_URL: 'http://localhost:8000',  // Your Laravel API URL
  ENDPOINTS: {
    GENERATE_PROPOSAL: '/api/v1/proposals/generate',
    GET_TEMPLATES: '/api/v1/templates',
    // ... other endpoints
  }
};
```

#### OpenRouter.ai Setup
1. Sign up at [OpenRouter.ai](https://openrouter.ai/)
2. Get your API key
3. Add it to your `.env` file as `OPENAI_API_KEY`

## 🎯 Usage

### 1. Login to Extension
- Click the extension icon in Chrome
- Enter your credentials (default: admin@admin.com / password)
- Select a template from the dropdown

### 2. Generate Proposals
1. Navigate to any Upwork job posting
2. Click "Generate Proposal" in the extension popup
3. The system will:
   - Extract job details automatically
   - Generate proposal using selected template or AI
   - Review and improve the proposal with AI
   - Copy final proposal to clipboard
   - Store proposal in database

### 3. Supported Upwork URLs
- `https://www.upwork.com/jobs/~...`
- `https://www.upwork.com/freelance-jobs/apply/...`
- `https://www.upwork.com/ab/proposals/job/~...`
- `https://www.upwork.com/job/...`

## 🔧 API Endpoints

### Authentication
- `POST /api/v1/login` - User login
- `POST /api/v1/logout` - User logout
- `GET /api/v1/me` - Get current user

### Proposals
- `POST /api/v1/proposals/generate` - Generate using template
- `POST /api/v1/proposals/generate-openai` - Generate using AI only
- `POST /api/v1/proposals/generate-with-review` - Generate with AI review (recommended)
- `GET /api/v1/proposals` - Get proposal history
- `POST /api/v1/proposals` - Store proposal

### Templates
- `GET /api/v1/templates` - Get available templates

### Testing
- `GET /api/v1/openai/test` - Test OpenAI connection

## 🧪 Testing

### API Testing
```bash
# Test OpenAI connection
curl -X GET http://localhost:8000/api/v1/openai/test

# Login and get token
curl -X POST http://localhost:8000/api/v1/login \
  -H "Content-Type: application/json" \
  -d '{"email": "admin@admin.com", "password": "password"}'

# Generate proposal with AI review
curl -X POST http://localhost:8000/api/v1/proposals/generate-with-review \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{
    "job_title": "React Developer",
    "job_description": "Build a modern web application",
    "skills": "React, JavaScript, Node.js",
    "budget": "$2000-$5000",
    "template_id": 1
  }'
```

### Extension Testing
1. Open `test.html` in Chrome
2. Use the test interface to verify all features
3. Check browser console for any errors

## 🔍 Features in Detail

### AI Review System
The system automatically reviews generated proposals and provides:
- **Quality Score**: 1-10 rating
- **Strengths**: What works well in the proposal
- **Improvements**: Specific suggestions for enhancement
- **Auto-Improvement**: If score < 8, generates improved version

### Template Variables
Templates support the following variables:
- `{{job_title}}` - Job title from posting
- `{{job_description}}` - Job description
- `{{skills}}` - Required skills
- `{{budget}}` - Job budget

### Duplicate Detection
The extension tracks generated jobs by:
- Extracting job ID from URL
- Creating hash from job title + description
- Warning users before generating duplicate proposals

## 🚨 Troubleshooting

### Common Issues

1. **"Failed to generate proposal with OpenAI"**
   - Check OpenAI API key in `.env`
   - Verify OpenRouter.ai account has credits
   - Test connection: `GET /api/v1/openai/test`

2. **"Please navigate to an Upwork job posting"**
   - Ensure you're on a job details page, not search results
   - Supported URL patterns listed above
   - Refresh page and try again

3. **"Session expired. Please login again."**
   - Login tokens expire after 30 days
   - Click logout and login again

4. **Extension not loading**
   - Check Chrome developer mode is enabled
   - Verify manifest.json is valid
   - Check browser console for errors

### Database Issues
```bash
# Reset database
php artisan migrate:fresh --seed

# Check database connection
php artisan tinker
>>> DB::connection()->getPdo();
```

### API Issues
```bash
# Clear caches
php artisan cache:clear
php artisan route:clear
php artisan config:clear

# Check logs
tail -f storage/logs/laravel.log
```

## 🔐 Security

- All API endpoints require authentication (except login)
- Sanctum tokens for secure API access
- Input validation on all endpoints
- CORS configured for Chrome extension
- SQL injection protection via Eloquent ORM

## 📊 Database Schema

### Users Table
- `id`, `name`, `email`, `password`, `created_at`, `updated_at`

### Templates Table
- `id`, `name`, `description`, `content`, `is_active`, `created_at`, `updated_at`

### Proposals Table
- `id`, `template_id`, `job_title`, `job_description`, `job_skills`, `job_budget`
- `generated_proposal`, `generated_at`, `created_at`, `updated_at`

## 🤝 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open Pull Request

## 📝 License

This project is licensed under the MIT License.

## 🆘 Support

For support and questions:
1. Check the troubleshooting section above
2. Review API logs: `proposal-api/storage/logs/laravel.log`
3. Check browser console for extension errors
4. Test API endpoints using the provided curl commands

## 🔄 Updates

### Version 1.0.0
- Initial release with template-based generation
- Chrome extension with Upwork integration
- User authentication system

### Version 1.1.0
- Added OpenAI integration via OpenRouter.ai
- AI review and improvement system
- Enhanced error handling and fallbacks
- Duplicate job detection
- Improved UI with review information

---

**Made with ❤️ for freelancers who want to win more projects on Upwork**
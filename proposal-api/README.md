# 🚀 Upwork Proposal Generator

A powerful Chrome extension with Laravel backend that automatically generates professional proposals for Upwork job postings using customizable templates.

## 📋 Table of Contents

- [Features](#features)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Chrome Extension Setup](#chrome-extension-setup)
- [Usage](#usage)
- [API Documentation](#api-documentation)
- [Template System](#template-system)
- [Session Management](#session-management)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)

## ✨ Features

- 🎯 **Automatic Job Extraction**: Extracts job details from Upwork pages
- 📝 **Template-Based Generation**: Uses customizable templates with variables
- 🔐 **Secure Authentication**: Laravel Sanctum with 30-day sessions
- ⚙️ **Customizable Settings**: Tone, length, and experience preferences
- 📋 **One-Click Copy**: Copy generated proposals to clipboard
- 🔄 **Regenerate Option**: Generate multiple variations
- 📊 **Proposal History**: All proposals stored in database
- 🎨 **Admin Panel**: Manage templates via Filament interface

## 📁 Project Structure

```
upwork-proposal-generator/
├── proposal-api/                 # Laravel Backend
│   ├── app/
│   │   ├── Http/Controllers/Api/ # API Controllers
│   │   ├── Models/              # Eloquent Models
│   │   └── Filament/Resources/  # Admin Panel
│   ├── config/                  # Configuration files
│   ├── database/               # Migrations & seeders
│   └── routes/api.php          # API routes
├── upwork-proposal-generator/   # Chrome Extension
│   ├── popup/                  # Extension UI
│   ├── scripts/               # Content & background scripts
│   ├── icons/                 # Extension icons
│   └── manifest.json          # Extension configuration
├── README.md                   # This file
├── test-connection.html        # API testing tool
└── view-stored-proposals.html  # Proposal viewer
```

## 🔧 Prerequisites

- **PHP 8.1+**
- **Composer**
- **MySQL**
- **Node.js** (optional, for development)
- **Chrome Browser**

## 🚀 Installation

### Step 1: Clone Repository

```bash
git clone https://github.com/yourusername/upwork-proposal-generator.git
cd upwork-proposal-generator
```

```bash
git clone https://github.com/yourusername/proposal-api.git
cd upwork-proposal-generator
```

### Step 2: Laravel Backend Setup

```bash
# Navigate to Laravel directory
cd proposal-api

# Install PHP dependencies
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

# Run database migrations
php artisan migrate

# Create admin user for Filament
php artisan make:filament-user

# Start Laravel server
php artisan serve
```

### Step 3: Verify Backend Installation

1. Open `http://localhost:8000/admin`
2. Login with your admin credentials
3. Create your first template in the Templates section

## 🔌 Chrome Extension Setup

### Method 1: Load Unpacked Extension (Development)

1. **Open Chrome Extensions**
   ```
   chrome://extensions/
   ```

2. **Enable Developer Mode**
   - Toggle "Developer mode" in the top-right corner

3. **Load Extension**
   - Click "Load unpacked"
   - Select the `upwork-proposal-generator` folder
   - Extension icon should appear in toolbar

4. **Pin Extension** (Optional)
   - Click puzzle piece icon in Chrome toolbar
   - Pin "Upwork Proposal Generator"


## 📖 Usage

### 1. Create Templates

1. **Access Admin Panel**: `http://localhost:8000/admin`
2. **Go to Templates** → Create
3. **Fill Template Details**:
   - Name: "Professional Web Development"
   - Tone: professional
   - Length: medium
   - Content: Use variables like `{{job_title}}`, `{{job_description}}`

**Example Template:**
```
Dear {{client_name}},

I am excited to submit my proposal for your {{job_title}} project.

I have the expertise needed for this role. Your project requirements:

{{job_description}}

Required skills: {{skills}}
Budget: {{budget}}

I would love to discuss this opportunity further.

Best regards,
[Your Name]
```

### 2. Use Chrome Extension

1. **Navigate to Upwork Job**
   - Go to any Upwork job posting
   - URL should be: `https://www.upwork.com/jobs/~...`

2. **Open Extension**
   - Click extension icon in Chrome toolbar
   - Login with your admin credentials

3. **Configure Settings**
   - **Tone**: Professional, Friendly, Enthusiastic, Concise
   - **Length**: Short, Medium, Long
   - **Experience**: Your background description

4. **Generate Proposal**
   - Click "Generate Proposal"
   - Wait for generation
   - Click "📋 Copy to Clipboard"
   - Paste into Upwork proposal form

## 🔗 API Documentation

### Base URL
```
http://localhost:8000/api/v1
```

### Authentication
All protected endpoints require Bearer token authentication:
```
Authorization: Bearer {token}
```

### Endpoints

#### Authentication

**Login**
```http
POST /login
Content-Type: application/json

{
  "email": "admin@example.com",
  "password": "password"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "token": "1|abc123...",
    "user": {
      "id": 1,
      "name": "Admin User",
      "email": "admin@example.com"
    }
  }
}
```

**Logout**
```http
POST /logout
Authorization: Bearer {token}
```

**Get Current User**
```http
GET /me
Authorization: Bearer {token}
```

#### Templates

**Get Templates**
```http
GET /templates
Authorization: Bearer {token}
```

**Response:**
```json
{
  "success": true,
  "data": [
    {
      "id": 1,
      "name": "Professional Web Development",
      "tone": "professional",
      "length": "medium",
      "description": "Professional template for web projects"
    }
  ]
}
```

#### Proposals

**Generate Proposal**
```http
POST /proposals/generate
Authorization: Bearer {token}
Content-Type: application/json

{
  "job_title": "Full Stack Developer",
  "job_description": "We need a developer...",
  "skills": "React, Node.js, JavaScript",
  "budget": "$2000-$5000",
  "tone": "professional",
  "length": "medium",
  "experience": "5+ years in web development"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "proposal": "Generated proposal text...",
    "template_name": "Professional Web Development",
    "proposal_id": 123
  }
}
```

**Get Proposals**
```http
GET /proposals
Authorization: Bearer {token}
```

**Get Single Proposal**
```http
GET /proposals/{id}
Authorization: Bearer {token}
```

### Error Responses

```json
{
  "success": false,
  "message": "Error description"
}
```

**Common HTTP Status Codes:**
- `200` - Success
- `401` - Unauthorized (invalid/expired token)
- `404` - Not found
- `422` - Validation error
- `500` - Server error

## 🎨 Template System

### Template Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `{{job_title}}` | Job title from Upwork | "Full Stack Developer" |
| `{{job_description}}` | Complete job description | "We need a developer..." |
| `{{skills}}` | Required skills | "React, Node.js, JavaScript" |
| `{{budget}}` | Budget information | "$2000-$5000" |
| `{{client_name}}` | Client name (if available) | "John Smith" |
| `{{company_name}}` | Company name (if available) | "Tech Corp" |

### Template Matching

Templates are automatically selected based on:
1. **Tone** (professional, friendly, enthusiastic, concise)
2. **Length** (short, medium, long)

If no exact match is found, the system uses the first active template as fallback.

### Template Management

**Via Filament Admin Panel:**
1. Go to `http://localhost:8000/admin`
2. Navigate to "Templates"
3. Create, edit, or deactivate templates
4. Set tone, length, and content with variables

## 🔐 Session Management

### Session Duration
- **Default**: 30 days
- **Warning**: 3 days before expiration
- **Auto-logout**: When session expires


## 🛠️ Troubleshooting

### Common Issues

**"Please navigate to an Upwork job posting"**
- Ensure you're on a job details page: `https://www.upwork.com/jobs/~...`
- Not on search results or other Upwork pages

**"Could not find job description"**
- Scroll down to load all page content
- Wait for page to fully load
- Try a different job posting

**"No active template found"**
- Create templates in Filament admin panel
- Ensure at least one template is marked as "Active"

**"Authentication required"**
- Login to the Chrome extension
- Check if session has expired (30 days)
- Verify Laravel server is running

**API Connection Issues**
- Ensure Laravel server is running: `php artisan serve`
- Check API URL in extension matches server URL
- Verify CORS configuration allows Chrome extension


## 🔧 Development

### Backend Development

```bash
# Install dependencies
composer install

# Run migrations
php artisan migrate

# Start development server
php artisan serve

# Create new migration
php artisan make:migration create_table_name

# Create new model
php artisan make:model ModelName
```

### Extension Development

```bash
# Reload extension after changes
# Go to chrome://extensions/
# Click reload button on your extension
```

### Database Management

```bash
# Reset database
php artisan migrate:fresh

# Seed with sample data
php artisan db:seed

# Create Filament user
php artisan make:filament-user
```

## 📊 Monitoring

### View Proposals
- **Admin Panel**: `http://localhost:8000/admin` → Proposals
- **Database**: Check `proposals` table

### Logs
- **Laravel Logs**: `proposal-api/storage/logs/laravel.log`
- **Chrome Console**: F12 → Console (for extension debugging)


## 🎯 Quick Start Checklist

- [ ] Clone repository
- [ ] Install Laravel dependencies (`composer install`)
- [ ] Configure database in `.env`
- [ ] Run migrations (`php artisan migrate`)
- [ ] Create admin user (`php artisan make:filament-user`)
- [ ] Start Laravel server (`php artisan serve`)
- [ ] Create first template in admin panel
- [ ] Load Chrome extension (`chrome://extensions/`)
- [ ] Test on Upwork job posting
- [ ] Generate your first proposal! 🎉

**Happy freelancing!** 🚀

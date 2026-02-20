# Automation System - Complete Setup

Complete automation system for Facebook posting with dashboard management.

## Architecture

```
Autopost/
├── automation-core/          # Core automation engine
├── automation-dashboard-backend/  # REST API backend
└── automation-dashboard-frontend/ # React dashboard
```

All services share the same MongoDB database.

## Quick Start

### 1. Setup MongoDB

Make sure MongoDB is running:
```bash
mongod
```

### 2. Setup Automation Core

```bash
cd automation-core
npm install
cp .env.example .env
# Edit .env with your MongoDB URI and OpenAI API key
npm run init-db
```

### 3. Setup Backend API

```bash
cd automation-dashboard-backend
npm install
cp .env.example .env
# Edit .env with your MongoDB URI
npm start
```

Backend runs on `http://localhost:3001`

### 4. Setup Frontend

```bash
cd automation-dashboard-frontend
npm install
npm run dev
```

Frontend runs on `http://localhost:3000`

## Workflow

1. **Access Dashboard**: Open `http://localhost:3000`
2. **Add Pages**: Go to Pages tab, add your Facebook pages
3. **Manage Prompts**: Go to Prompts tab, create/edit prompts
4. **Assign Prompts**: Edit a page and assign a prompt to it
5. **Trigger Automation**: Click "Trigger Automation" on Dashboard
6. **View Logs**: Check Logs tab for execution details

## Environment Variables

### Automation Core
- `MONGODB_URI` - MongoDB connection string
- `MONGODB_DB_NAME` - Database name (default: automation_db)
- `OPENAI_API_KEY` - OpenAI API key

### Backend
- `PORT` - Server port (default: 3001)
- `MONGODB_URI` - MongoDB connection string
- `MONGODB_DB_NAME` - Database name
- `FRONTEND_URL` - Frontend URL for CORS

## Database Collections

- **pages**: Facebook pages configuration
- **prompts**: Prompt templates
- **logs**: System logs and execution history

## Features

✅ Multi-page support (100+ pages)  
✅ Dynamic prompt management  
✅ Real-time dashboard  
✅ Manual automation trigger  
✅ Comprehensive logging  
✅ Celebrity comparison template  
✅ Scalable architecture  

## Next Steps

- Add cron scheduling for automatic posting
- Add Google Drive integration for image storage
- Add rate limiting for Facebook API
- Add duplicate post detection


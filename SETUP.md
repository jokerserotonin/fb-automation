# Complete Setup Guide

## Step 1: MongoDB Setup

### Install MongoDB (if not already installed)

**macOS:**
```bash
brew install mongodb-community
brew services start mongodb-community
```

**Linux:**
```bash
sudo apt-get install mongodb
sudo systemctl start mongodb
```

**Windows:**
Download from https://www.mongodb.com/try/download/community

### Verify MongoDB is Running

```bash
mongosh
# or
mongo
```

If you see the MongoDB shell, you're good to go!

## Step 2: Initialize Database

**Go to automation-core directory:**
```bash
cd automation-core
```

**Install dependencies:**
```bash
npm install
```

**Create .env file:**
```bash
cp .env.example .env
```

**Edit .env with your values:**
```bash
MONGODB_URI=mongodb://localhost:27017
MONGODB_DB_NAME=automation_db
OPENAI_API_KEY=your_openai_api_key_here

# Optional: For initial page setup
FACEBOOK_PAGE_ID=your_page_id_here
FACEBOOK_ACCESS_TOKEN=your_access_token_here
```

**Initialize database:**
```bash
npm run init-db
```

This will:
- Create database collections
- Create indexes
- Add a sample prompt
- Add a sample page (if env vars are set)

## Step 3: Start Backend API

**Go to automation-dashboard-backend:**
```bash
cd ../automation-dashboard-backend
```

**Install dependencies:**
```bash
npm install
```

**Create .env file:**
```bash
PORT=3001
MONGODB_URI=mongodb://localhost:27017
MONGODB_DB_NAME=automation_db
FRONTEND_URL=http://localhost:3000
```

**Start backend:**
```bash
npm start
```

Backend should be running on `http://localhost:3001`

## Step 4: Start Frontend

**Go to automation-dashboard-frontend:**
```bash
cd ../automation-dashboard-frontend
```

**Install dependencies:**
```bash
npm install
```

**Start frontend:**
```bash
npm run dev
```

Frontend should be running on `http://localhost:3000`

## Step 5: Start Automation Scheduler (Optional)

**Go to automation-core:**
```bash
cd ../automation-core
```

**Start scheduler:**
```bash
npm run scheduler
```

This will run continuously and post according to your schedules.

## Quick Start Checklist

- [ ] MongoDB installed and running
- [ ] automation-core: `npm install` and `npm run init-db`
- [ ] automation-dashboard-backend: `npm install` and `npm start`
- [ ] automation-dashboard-frontend: `npm install` and `npm run dev`
- [ ] automation-core: `npm run scheduler` (optional, for automatic posting)

## Troubleshooting

### MongoDB Connection Error

**Check MongoDB is running:**
```bash
mongosh
# Should connect successfully
```

**Check connection string:**
- Default: `mongodb://localhost:27017`
- If using different port: `mongodb://localhost:YOUR_PORT`

### Backend API Error

**Check backend is running:**
```bash
curl http://localhost:3001/api/health
# Should return: {"success":true,"message":"API is running"}
```

**Check MongoDB connection in backend:**
- Verify `MONGODB_URI` in backend `.env` matches automation-core

### Frontend API Error

**Check API URL:**
- Default: `http://localhost:3001/api`
- Edit `src/api.js` if backend is on different port

**Check CORS:**
- Backend `FRONTEND_URL` should match frontend URL (default: `http://localhost:3000`)

### No Data Showing

**Initialize database first:**
```bash
cd automation-core
npm run init-db
```

**Check database has data:**
```bash
mongosh
use automation_db
db.pages.find()
db.prompts.find()
```

## Directory Structure

```
Autopost/
├── automation-core/              # Core automation engine
│   ├── npm install
│   ├── npm run init-db          # Initialize database
│   ├── npm start                # Manual trigger
│   └── npm run scheduler        # Continuous scheduler
│
├── automation-dashboard-backend/ # REST API
│   ├── npm install
│   └── npm start                # Runs on port 3001
│
└── automation-dashboard-frontend/ # React dashboard
    ├── npm install
    └── npm run dev              # Runs on port 3000
```

## Next Steps

1. Open `http://localhost:3000` in browser
2. Go to Pages tab and add your Facebook pages
3. Go to Prompts tab and manage prompts
4. Assign prompts to pages
5. Set posting schedules
6. Start scheduler: `cd automation-core && npm run scheduler`


# How The System Works - Complete Guide

## Overview

You have **3 separate services** that work together:

1. **Backend API** - REST API server (runs on port 3001)
2. **Frontend Dashboard** - React web app (runs on port 3000)
3. **Automation Core** - Posting automation (can run manually or as scheduler)

## Service Setup

### 1. Backend API (Terminal 1)

```bash
cd automation-dashboard-backend
npm install
npm start
```

**What it does:**
- Serves REST API endpoints
- Connects to MongoDB
- Handles CRUD operations for pages, prompts, logs
- **Must be running** for frontend to work

**Status:** ✅ Must run in terminal

### 2. Frontend Dashboard (Terminal 2)

```bash
cd automation-dashboard-frontend
npm install
npm run dev
```

**What it does:**
- React web interface
- Connects to backend API
- Lets you manage pages, prompts, view logs
- **Must be running** to access dashboard

**Status:** ✅ Must run in terminal

**Access:** Open `http://localhost:3000` in browser

### 3. Automation Core (Two Options)

#### Option A: Manual Trigger (From Dashboard)

**You DON'T need to run anything!**

1. Open dashboard at `http://localhost:3000`
2. Click "🚀 Trigger Automation" button
3. Backend API spawns automation process
4. Automation runs once and exits

**Status:** ✅ No terminal needed - triggered from dashboard

#### Option B: Automatic Scheduler (Terminal 3 - Optional)

```bash
cd automation-core
npm run scheduler
```

**What it does:**
- Runs continuously
- Checks database every minute
- Automatically posts to pages based on schedules
- **Only needed** if you want automatic posting

**Status:** ⚠️ Optional - only if you want automatic posting

## Complete Flow

### Scenario 1: Manual Posting (Recommended for Testing)

```
1. Start Backend (Terminal 1)
   └─> npm start

2. Start Frontend (Terminal 2)
   └─> npm run dev

3. Open Browser
   └─> http://localhost:3000

4. Click "Trigger Automation" button
   └─> Backend spawns automation
   └─> Automation posts to all active pages
   └─> Automation exits

✅ No scheduler needed!
```

### Scenario 2: Automatic Posting

```
1. Start Backend (Terminal 1)
   └─> npm start

2. Start Frontend (Terminal 2)
   └─> npm run dev

3. Start Scheduler (Terminal 3)
   └─> npm run scheduler
   └─> Runs continuously
   └─> Posts automatically based on schedules

✅ Scheduler handles all automatic posting!
```

## Environment Variables

### Frontend (.env)

**Location:** `automation-dashboard-frontend/.env`

```bash
# Backend API URL (default: http://localhost:3001/api)
VITE_API_URL=http://localhost:3001/api
```

**Note:** Frontend now supports `.env` file! Create it if you need to change the backend URL.

### Backend (.env)

**Location:** `automation-dashboard-backend/.env`

```bash
PORT=3001
MONGODB_URI=mongodb+srv://...
MONGODB_DB_NAME=automation_db
FRONTEND_URL=http://localhost:3000
```

### Automation Core (.env)

**Location:** `automation-core/.env`

```bash
MONGODB_URI=mongodb+srv://...
MONGODB_DB_NAME=automation_db
OPENAI_API_KEY=your_key_here
```

## Quick Start Checklist

### First Time Setup

- [ ] Initialize database: `cd automation-core && npm run init-db`
- [ ] Create `.env` files in all three directories
- [ ] Install dependencies in all three directories

### Daily Use

- [ ] Terminal 1: Backend (`cd automation-dashboard-backend && npm start`)
- [ ] Terminal 2: Frontend (`cd automation-dashboard-frontend && npm run dev`)
- [ ] Browser: Open `http://localhost:3000`
- [ ] Optional Terminal 3: Scheduler (`cd automation-core && npm run scheduler`)

## Common Questions

### Q: Do I need to run automation in terminal?

**A:** No! You can trigger it from the dashboard. The "Trigger Automation" button spawns the automation process automatically.

### Q: When do I need the scheduler?

**A:** Only if you want automatic posting based on schedules. For manual posting, just use the dashboard button.

### Q: Can I run everything from the dashboard?

**A:** Almost! You can:
- ✅ Manage pages
- ✅ Manage prompts  
- ✅ View logs
- ✅ Trigger automation manually
- ❌ Can't start the scheduler (needs to run in terminal)

### Q: What happens if I close the terminals?

**A:**
- Backend terminal closed → Frontend won't work
- Frontend terminal closed → Can't access dashboard
- Scheduler terminal closed → Automatic posting stops (manual trigger still works)

## MongoDB Connection Fix

If you're getting SSL errors with MongoDB Atlas:

1. **Use `mongodb+srv://` format:**
   ```bash
   MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/dbname?retryWrites=true&w=majority
   ```

2. **Check Atlas Network Access:**
   - Go to Atlas → Network Access
   - Add your IP address or `0.0.0.0/0` for testing

3. **Check Database User:**
   - Go to Atlas → Database Access
   - Ensure user has read/write permissions

4. **Try updating Node.js:**
   ```bash
   node --version  # Should be 18+ for better SSL support
   ```


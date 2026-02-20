# System Flow & Initialization Guide

## Understanding the System

### You're Using MongoDB Atlas (Cloud)
- **No local MongoDB needed** - MongoDB Atlas is a cloud service
- **No need to start MongoDB** - It's always running in the cloud
- **Connection string** - Your `MONGODB_URI` points to Atlas

### Database Initialization Flow

#### **One-Time Setup (Only Once)**

```bash
cd automation-core
npm run init-db
```

**What it does:**
1. ✅ Creates database collections (`pages`, `prompts`, `logs`)
2. ✅ Creates indexes for performance
3. ✅ Adds a sample prompt (Celebrity Comparison Template)
4. ✅ Adds a sample page (if you have Facebook credentials in `.env`)

**When to run:**
- **Only once** when setting up the project
- **Never again** unless you want to reset the database
- It checks if data exists and skips if already initialized

#### **Daily Operations (No Initialization Needed)**

Once initialized, you just run:

1. **Backend API** (always running):
   ```bash
   cd automation-dashboard-backend
   npm start
   ```
   - Serves the REST API
   - Connects to database automatically
   - No initialization needed

2. **Frontend** (always running):
   ```bash
   cd automation-dashboard-frontend
   npm run dev
   ```
   - React dashboard
   - Connects to backend API
   - No initialization needed

3. **Automation Scheduler** (optional, for automatic posting):
   ```bash
   cd automation-core
   npm run scheduler
   ```
   - Runs continuously
   - Checks database every minute
   - Posts automatically based on schedules
   - No initialization needed

## Complete Flow Diagram

```
┌─────────────────────────────────────────────────────────┐
│  ONE-TIME SETUP (Only Once)                              │
│                                                           │
│  1. npm run init-db                                      │
│     └─> Creates collections & indexes                    │
│     └─> Adds sample data                                 │
│                                                           │
└─────────────────────────────────────────────────────────┘
                    │
                    ▼
┌─────────────────────────────────────────────────────────┐
│  DAILY OPERATIONS (Always Running)                       │
│                                                           │
│  ┌─────────────────┐    ┌─────────────────┐             │
│  │  Backend API    │    │   Frontend      │             │
│  │  (Port 3001)    │◄───│   (Port 3000)   │             │
│  │                 │    │                 │             │
│  │  - CRUD Pages   │    │  - Dashboard    │             │
│  │  - CRUD Prompts │    │  - Manage Pages │             │
│  │  - View Logs    │    │  - Manage Prompts│            │
│  │  - Trigger Auto│    │  - View Logs    │             │
│  └────────┬────────┘    └─────────────────┘             │
│           │                                                │
│           │ Reads/Writes                                  │
│           ▼                                                │
│  ┌─────────────────┐                                      │
│  │  MongoDB Atlas  │                                      │
│  │  (Cloud Database)│                                      │
│  │                 │                                      │
│  │  - pages        │                                      │
│  │  - prompts      │                                      │
│  │  - logs         │                                      │
│  └────────┬────────┘                                      │
│           │                                                │
│           │ Reads                                          │
│           ▼                                                │
│  ┌─────────────────┐                                      │
│  │  Automation      │                                      │
│  │  Scheduler       │                                      │
│  │  (Optional)      │                                      │
│  │                 │                                      │
│  │  - Checks DB     │                                      │
│  │  - Generates     │                                      │
│  │  - Posts to FB   │                                      │
│  └─────────────────┘                                      │
│                                                           │
└─────────────────────────────────────────────────────────┘
```

## Step-by-Step Setup

### Step 1: One-Time Database Initialization

```bash
cd automation-core
npm install
npm run init-db
```

**Expected Output:**
```
🔌 Connecting to database...
✅ Connected to MongoDB database: automation_db
📊 Creating indexes...
✅ Indexes created
📝 Creating celebrity comparison prompt template...
✅ Sample prompt created with ID: ...
✨ Database initialization complete!
```

**If you see errors:**
- Check your `MONGODB_URI` in `.env` file
- Make sure it's a valid Atlas connection string
- Format: `mongodb+srv://username:password@cluster.mongodb.net/`

### Step 2: Start Backend (Keep Running)

```bash
cd automation-dashboard-backend
npm install
npm start
```

**Expected Output:**
```
🚀 Dashboard API server running on http://localhost:3001
```

### Step 3: Start Frontend (Keep Running)

```bash
cd automation-dashboard-frontend
npm install
npm run dev
```

**Expected Output:**
```
  VITE v5.x.x  ready in xxx ms

  ➜  Local:   http://localhost:3000/
```

### Step 4: Start Scheduler (Optional, Keep Running)

```bash
cd automation-core
npm run scheduler
```

**Expected Output:**
```
🕐 Starting cron scheduler...
✅ Scheduler started successfully
📅 Checking for posts every minute
```

## Common Questions

### Q: Do I need to run `init-db` every time?
**A: No!** Only once when setting up. It checks if data exists and skips if already initialized.

### Q: Do I need to start MongoDB locally?
**A: No!** You're using MongoDB Atlas (cloud). It's always running.

### Q: What if `init-db` fails?
**A: Check:**
1. Your `MONGODB_URI` is correct
2. Your Atlas cluster is running
3. Your IP is whitelisted in Atlas
4. Your username/password are correct

### Q: Can I run `init-db` multiple times?
**A: Yes, it's safe!** It checks if data exists and won't duplicate.

### Q: What happens if I don't run the scheduler?
**A: You can still:**
- Use the dashboard to manage pages/prompts
- Trigger automation manually from dashboard
- Just won't have automatic scheduled posting

## MongoDB Atlas Connection String Format

Your `.env` should have:

```bash
# For Atlas (mongodb+srv://)
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/dbname?retryWrites=true&w=majority

# OR for standard connection
MONGODB_URI=mongodb://username:password@cluster.mongodb.net:27017/dbname?ssl=true
```

**Important:**
- Replace `username` and `password` with your Atlas credentials
- Replace `cluster` with your cluster name
- Make sure your IP is whitelisted in Atlas Network Access

## Troubleshooting Atlas Connection

### SSL Error (like you're seeing):
1. **Check connection string format:**
   - Should use `mongodb+srv://` for Atlas
   - Or include `?ssl=true` for standard connection

2. **Check Atlas Network Access:**
   - Go to Atlas → Network Access
   - Add your IP or `0.0.0.0/0` for testing (not recommended for production)

3. **Check Database User:**
   - Go to Atlas → Database Access
   - Make sure user has read/write permissions

4. **Try connection string with explicit SSL:**
   ```
   mongodb+srv://user:pass@cluster.mongodb.net/dbname?retryWrites=true&w=majority&ssl=true
   ```


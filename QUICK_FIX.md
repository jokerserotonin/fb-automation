# Quick Fix Guide

## Issue 1: Frontend connecting to wrong port

**Problem:** Frontend trying to connect to port 3001, but backend is on 5002

**Fixed:** Updated frontend to use port 5002 by default

**If you need to change it:**
1. Create `.env` file in `automation-dashboard-frontend/`:
   ```bash
   VITE_API_URL=http://localhost:5002/api
   ```
2. Restart frontend dev server

## Issue 2: Database connection failing

**Problem:** Backend showing "Database connection failed"

**Check these:**

1. **Backend .env file exists:**
   ```bash
   cd automation-dashboard-backend
   cat .env
   ```

2. **MONGODB_URI is set correctly:**
   ```bash
   MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/dbname?retryWrites=true&w=majority
   ```

3. **Test database connection:**
   ```bash
   cd automation-core
   npm run test-connection
   ```

4. **Check backend logs:**
   - Look for detailed error messages
   - Should show what's wrong with connection

## Common Database Connection Issues

### SSL/TLS Error
- **Fix:** Use `mongodb+srv://` format for Atlas
- **Check:** Atlas Network Access (IP whitelist)

### Authentication Error
- **Fix:** Check username/password in connection string
- **Check:** Database user exists in Atlas

### Connection Timeout
- **Fix:** Check internet connection
- **Fix:** Verify Atlas cluster is running
- **Fix:** Check firewall settings

## Quick Test

1. **Test backend health (no DB needed):**
   ```bash
   curl http://localhost:5002/api/health
   ```
   Should return: `{"success":true,"message":"API is running"}`

2. **Test database connection:**
   ```bash
   cd automation-core
   npm run test-connection
   ```

3. **If connection works, initialize DB:**
   ```bash
   npm run init-db
   ```

## Port Configuration

**Default ports:**
- Frontend: `3000`
- Backend: `5002` (changed from 3001)
- MongoDB: `27017` (or Atlas cloud)

**To change backend port:**
1. Edit `automation-dashboard-backend/.env`:
   ```bash
   PORT=5002
   ```
2. Update frontend `.env`:
   ```bash
   VITE_API_URL=http://localhost:5002/api
   ```
3. Restart both services


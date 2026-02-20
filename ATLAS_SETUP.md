# MongoDB Atlas Network Access Setup

## The Issue

MongoDB Atlas blocks all connections by default for security. You need to whitelist your IP address to allow connections from your computer.

## Step-by-Step Guide

### Step 1: Find Your IP Address

**Option A: Quick way (for testing)**
- Visit: https://whatismyipaddress.com/
- Copy your public IP address

**Option B: From terminal (macOS/Linux)**
```bash
curl ifconfig.me
```

**Option C: For development (allow all IPs - NOT for production)**
- Use: `0.0.0.0/0` (allows from anywhere)

### Step 2: Whitelist IP in Atlas

1. **Go to MongoDB Atlas:**
   - Login at https://cloud.mongodb.com/

2. **Navigate to Network Access:**
   - Click on your project
   - In the left sidebar, click **"Network Access"** (under Security)

3. **Add IP Address:**
   - Click **"Add IP Address"** button (green button)
   - You have two options:

   **Option A: Add Current IP (Recommended for development)**
   - Click **"Add Current IP Address"** button
   - This automatically adds your current IP
   - Click **"Confirm"**

   **Option B: Add IP Manually**
   - Enter your IP address (e.g., `123.45.67.89`)
   - Or enter `0.0.0.0/0` to allow from anywhere (⚠️ Only for testing!)
   - Add a comment (optional): "My Development Machine"
   - Click **"Confirm"**

4. **Wait for Changes:**
   - Changes take 1-2 minutes to propagate
   - You'll see a green checkmark when it's active

### Step 3: Verify Database User

While you're in Atlas, also check your database user:

1. **Go to Database Access:**
   - Click **"Database Access"** in left sidebar (under Security)

2. **Check Your User:**
   - Make sure you have a database user created
   - Username should match what's in your connection string
   - User should have **"Read and write to any database"** permissions

3. **If No User Exists:**
   - Click **"Add New Database User"**
   - Choose **"Password"** authentication
   - Enter username and password
   - Set privileges to **"Read and write to any database"**
   - Click **"Add User"**

### Step 4: Get Connection String

1. **Go to Database:**
   - Click **"Database"** in left sidebar
   - Click **"Connect"** button on your cluster

2. **Choose Connection Method:**
   - Select **"Connect your application"**

3. **Copy Connection String:**
   - Driver: **Node.js**
   - Version: **5.5 or later**
   - Copy the connection string
   - It looks like: `mongodb+srv://<username>:<password>@cluster.mongodb.net/`

4. **Update Your .env:**
   - Replace `<username>` with your actual username
   - Replace `<password>` with your actual password
   - Add database name at the end: `mongodb+srv://user:pass@cluster.mongodb.net/automation_db?retryWrites=true&w=majority`

## Quick Checklist

- [ ] IP address whitelisted in Network Access
- [ ] Database user exists in Database Access
- [ ] Connection string uses `mongodb+srv://` format
- [ ] Connection string has correct username/password
- [ ] Connection string includes database name
- [ ] Waited 1-2 minutes after adding IP

## Common Issues

### "IP Not Whitelisted"
- **Fix:** Add your IP in Network Access
- **Note:** If your IP changes (different WiFi, VPN), you need to add the new IP

### "Authentication Failed"
- **Fix:** Check username/password in connection string
- **Fix:** Verify user exists in Database Access

### "Connection Timeout"
- **Fix:** Check Network Access IP whitelist
- **Fix:** Wait 1-2 minutes after adding IP
- **Fix:** Check internet connection

## For Production

**⚠️ Security Warning:**

- **Never use `0.0.0.0/0`** in production (allows from anywhere)
- Always whitelist specific IP addresses
- Use MongoDB Atlas IP Access List for server IPs
- Consider using VPC Peering for AWS/GCP/Azure

## Testing After Setup

1. **Test connection:**
   ```bash
   cd automation-core
   npm run test-connection
   ```

2. **If successful, initialize database:**
   ```bash
   npm run init-db
   ```

3. **Start backend:**
   ```bash
   cd automation-dashboard-backend
   npm start
   ```

4. **Test in browser:**
   - Visit: `http://localhost:5002/api/health`
   - Should show: `{"success":true,"message":"API is running"}`
   - Visit: `http://localhost:5002/api/prompts`
   - Should NOT show database error

## Still Having Issues?

If you've done all the above and still get SSL errors:

1. **Check connection string format:**
   ```bash
   cd automation-dashboard-backend
   npm run check-env
   ```

2. **Verify it starts with `mongodb+srv://`:**
   - ❌ Wrong: `mongodb://...`
   - ✅ Correct: `mongodb+srv://...`

3. **Check Node.js version:**
   ```bash
   node --version
   ```
   - Should be 18+ for best SSL support

4. **Try updating MongoDB driver:**
   ```bash
   cd automation-dashboard-backend
   npm update mongodb
   ```


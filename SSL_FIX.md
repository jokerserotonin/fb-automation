# MongoDB Atlas SSL Error Fix

## The Problem

You're getting this SSL error:
```
SSL routines:ssl3_read_bytes:tlsv1 alert internal error
```

This is a common issue with MongoDB Atlas connections.

## Quick Fixes

### Fix 1: Check Connection String Format

**MUST use `mongodb+srv://` format for Atlas:**

```bash
# ✅ CORRECT (for Atlas)
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/dbname?retryWrites=true&w=majority

# ❌ WRONG (causes SSL errors)
MONGODB_URI=mongodb://username:password@cluster.mongodb.net:27017/dbname
```

### Fix 2: Check Your .env File

Run this to check your backend .env:
```bash
cd automation-dashboard-backend
npm run check-env
```

This will show:
- If .env file exists
- If MONGODB_URI is set correctly
- Connection string format

### Fix 3: Test Connection

Test your connection string:
```bash
cd automation-core
npm run test-connection
```

### Fix 4: Check Atlas Settings

1. **Network Access:**
   - Go to Atlas → Network Access
   - Add your IP address (or `0.0.0.0/0` for testing)
   - Wait 1-2 minutes for changes to propagate

2. **Database User:**
   - Go to Atlas → Database Access
   - Verify user exists
   - Check user has read/write permissions

3. **Connection String:**
   - Go to Atlas → Database → Connect
   - Choose "Connect your application"
   - Copy the connection string
   - Replace `<password>` with your actual password

### Fix 5: Node.js Version

Check your Node.js version:
```bash
node --version
```

**Recommended:** Node.js 18+ for better SSL/TLS support

If using older version, update:
```bash
# Using nvm
nvm install 18
nvm use 18
```

## Step-by-Step Debugging

1. **Check backend .env:**
   ```bash
   cd automation-dashboard-backend
   npm run check-env
   ```

2. **Verify connection string format:**
   - Should start with `mongodb+srv://`
   - Should include your username and password
   - Should end with database name

3. **Test connection:**
   ```bash
   cd automation-core
   npm run test-connection
   ```

4. **Check Atlas Network Access:**
   - Your IP must be whitelisted
   - Or use `0.0.0.0/0` for testing (not recommended for production)

5. **Restart backend:**
   ```bash
   cd automation-dashboard-backend
   # Stop current server (Ctrl+C)
   npm start
   ```

## Common Issues

### Issue: "Invalid connection string"
**Fix:** Use `mongodb+srv://` format, not `mongodb://`

### Issue: "Authentication failed"
**Fix:** Check username/password in connection string

### Issue: "IP not whitelisted"
**Fix:** Add your IP in Atlas Network Access

### Issue: "SSL handshake failed"
**Fix:** 
- Use `mongodb+srv://` format
- Update Node.js to version 18+
- Check Atlas cluster is running

## Still Not Working?

Share the output of:
```bash
cd automation-dashboard-backend
npm run check-env

cd ../automation-core
npm run test-connection
```

This will help identify the exact issue.


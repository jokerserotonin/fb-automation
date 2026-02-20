# MongoDB Atlas Permissions Fix

## The Error

```
(Unauthorized) not authorized on admin to execute command { find: "pages" }
```

This means:
1. The connection is trying to use the "admin" database
2. Your user doesn't have permissions on that database
3. OR the database name in connection string is wrong

## Quick Fix

### Option 1: Fix Connection String (Recommended)

Your connection string should include the database name at the end:

**✅ CORRECT Format:**
```bash
MONGODB_URI=mongodb+srv://NavdeepKK:password@cluster.mongodb.net/automation_db?retryWrites=true&w=majority
```

**❌ WRONG Format (uses admin database):**
```bash
MONGODB_URI=mongodb+srv://NavdeepKK:password@cluster.mongodb.net/?retryWrites=true&w=majority
# Missing database name - defaults to "admin"
```

### Option 2: Check Database User Permissions

1. **Go to Atlas → Database Access**
2. **Click on your user (NavdeepKK)**
3. **Check "Database User Privileges":**
   - Should be: **"Read and write to any database"**
   - OR: **"Read and write"** on specific database `automation_db`

4. **If permissions are wrong:**
   - Click **"Edit"** on the user
   - Change privileges to **"Read and write to any database"**
   - Click **"Update User"**

### Option 3: Create Database User with Correct Permissions

If your user doesn't have the right permissions:

1. **Go to Atlas → Database Access**
2. **Click "Add New Database User"**
3. **Authentication:**
   - Choose **"Password"**
   - Username: `NavdeepKK` (or create new)
   - Password: (set a strong password)

4. **Database User Privileges:**
   - Select: **"Read and write to any database"**
   - OR: **"Specific privileges"** → Add database `automation_db` with "readWrite" role

5. **Click "Add User"**

## Step-by-Step Fix

### Step 1: Check Your Connection String

In `automation-dashboard-backend/.env`:

```bash
# Should look like this:
MONGODB_URI=mongodb+srv://NavdeepKK:YOUR_PASSWORD@cluster.mongodb.net/automation_db?retryWrites=true&w=majority
#                                                                        ^^^^^^^^^^^^
#                                                                        Database name here!
```

**Important:** The database name (`automation_db`) must be in the connection string!

### Step 2: Verify Database Exists

The database will be created automatically when you first write to it, but make sure:
- The name matches: `automation_db`
- Or change `MONGODB_DB_NAME` in `.env` to match your database

### Step 3: Check User Permissions

1. Go to https://cloud.mongodb.com/
2. Click your project
3. Go to **"Database Access"** (left sidebar)
4. Find user **"NavdeepKK"**
5. Check privileges:
   - ✅ Should be: **"Read and write to any database"**
   - ❌ If it's something else, click "Edit" and change it

### Step 4: Restart Backend

```bash
cd automation-dashboard-backend
# Stop server (Ctrl+C)
npm start
```

## Connection String Format Guide

### Correct Format:
```
mongodb+srv://USERNAME:PASSWORD@CLUSTER.mongodb.net/DATABASE_NAME?retryWrites=true&w=majority
```

### Example:
```
mongodb+srv://NavdeepKK:mypassword123@cluster0.abc123.mongodb.net/automation_db?retryWrites=true&w=majority
```

**Parts:**
- `mongodb+srv://` - Protocol (required for Atlas)
- `NavdeepKK` - Username
- `mypassword123` - Password
- `cluster0.abc123.mongodb.net` - Cluster address
- `automation_db` - **Database name (IMPORTANT!)**
- `?retryWrites=true&w=majority` - Options

## Common Mistakes

### Mistake 1: Missing Database Name
```bash
# ❌ WRONG - defaults to "admin"
MONGODB_URI=mongodb+srv://user:pass@cluster.net/?retryWrites=true&w=majority

# ✅ CORRECT - specifies database
MONGODB_URI=mongodb+srv://user:pass@cluster.net/automation_db?retryWrites=true&w=majority
```

### Mistake 2: Wrong Database Name
```bash
# ❌ WRONG - uses "admin" database
MONGODB_URI=mongodb+srv://user:pass@cluster.net/admin?retryWrites=true&w=majority

# ✅ CORRECT - uses "automation_db"
MONGODB_URI=mongodb+srv://user:pass@cluster.net/automation_db?retryWrites=true&w=majority
```

### Mistake 3: User Doesn't Have Permissions
- User exists but only has permissions on specific database
- Fix: Change to "Read and write to any database" in Atlas

## Quick Test

After fixing, test the connection:

```bash
cd automation-core
npm run test-connection
```

If successful, you should see:
```
✅ Successfully connected to MongoDB!
✅ Database ping successful
✨ Connection test passed!
```

## Still Having Issues?

1. **Check connection string format:**
   ```bash
   cd automation-dashboard-backend
   npm run check-env
   ```

2. **Verify database name:**
   - Should be in connection string: `/automation_db`
   - Or set `MONGODB_DB_NAME=automation_db` in `.env`

3. **Check user permissions in Atlas:**
   - Go to Database Access
   - Verify user has "Read and write to any database"

4. **Try creating a new database user:**
   - Create fresh user with correct permissions
   - Update connection string with new credentials


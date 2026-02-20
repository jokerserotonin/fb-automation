# Facebook Access Token Setup Guide

## Error
```
OAuthException: Any of the pages_read_engagement, pages_manage_metadata,
pages_read_user_content, pages_manage_ads, pages_show_list or
pages_messaging permission(s) must be granted before impersonating a user's page.
```

## Solution: Get a Page Access Token with Correct Permissions

### Step 1: Go to Facebook Graph API Explorer

1. Visit: https://developers.facebook.com/tools/explorer/
2. Make sure you're logged into Facebook

### Step 2: Select Your App

1. In the top right, click "Meta App" dropdown
2. Select your Facebook App (or create one if you don't have one)

### Step 3: Get User Access Token

1. Click "Generate Access Token" button
2. Select these permissions:
   - ✅ `pages_show_list` (Required - to see your pages)
   - ✅ `pages_read_engagement` (Required - to read page data)
   - ✅ `pages_manage_metadata` (Required - to manage page posts)
   - ✅ `pages_read_user_content` (Optional but recommended)
   - ✅ `pages_manage_posts` (Required - to post on pages)
   - ✅ `pages_read_engagement` (Required)

3. Click "Generate Access Token"
4. **Copy this token** (you'll need it in Step 4)

### Step 4: Exchange for Page Access Token

The token from Step 3 is a **User Access Token**. You need to exchange it for a **Page Access Token**.

**Option A: Using Graph API Explorer**

1. In Graph API Explorer, change the endpoint to:
   ```
   /me/accounts
   ```
2. Click "Submit" 
3. You'll see a list of your pages with their access tokens
4. Find your page and copy the `access_token` field
5. This is your **Page Access Token** - use this in your `.env` file

**Option B: Using API Call**

Make a GET request to:
```
https://graph.facebook.com/v18.0/me/accounts?access_token=YOUR_USER_TOKEN
```

Replace `YOUR_USER_TOKEN` with the token from Step 3.

You'll get a response like:
```json
{
  "data": [
    {
      "access_token": "PAGE_ACCESS_TOKEN_HERE",
      "category": "...",
      "name": "Your Page Name",
      "id": "YOUR_PAGE_ID"
    }
  ]
}
```

Copy the `access_token` for your page.

### Step 5: Update Your Access Token

1. Go to your dashboard
2. Edit the page that's failing
3. Update the "Access Token" field with the new Page Access Token
4. Save

### Step 6: Verify Token Permissions

You can verify your token has the right permissions by calling:
```
https://graph.facebook.com/v18.0/me/permissions?access_token=YOUR_PAGE_TOKEN
```

You should see permissions like:
- `pages_show_list`
- `pages_read_engagement`
- `pages_manage_metadata`
- `pages_manage_posts`

## Important Notes

1. **Page Access Tokens are Long-Lived**: They don't expire (unless you revoke them)
2. **User Access Tokens Expire**: That's why you need to exchange for a Page token
3. **App Review**: For production, you may need to submit your app for review to get these permissions approved

## Quick Fix (If You Have Access to Page Settings)

1. Go to your Facebook Page
2. Settings → Page Access → Add yourself as Admin
3. Then use Graph API Explorer to get the Page Access Token

## Alternative: Use Facebook Business Suite

If you manage the page through Facebook Business Suite, you can generate tokens there with the correct permissions automatically.


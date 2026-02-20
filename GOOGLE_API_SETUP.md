# Google Custom Search API Setup Guide

## Issue
You're seeing this error:
```
Google Custom Search API error: Custom Search API has not been used in project 250729890728 before or it is disabled.
```

## Solution: Enable the API

### Step 1: Enable Custom Search API
1. Go to: https://console.developers.google.com/apis/api/customsearch.googleapis.com/overview?project=250729890728
2. Click **"Enable"** button
3. Wait 1-2 minutes for the API to be activated

### Step 2: Verify API Key Permissions
1. Go to: https://console.cloud.google.com/apis/credentials?project=250729890728
2. Find your API key (the one you're using in `.env`)
3. Make sure it has **"Custom Search API"** enabled in the restrictions

### Step 3: Check API Quotas
- Free tier: 100 searches per day
- If you exceed this, you'll need to upgrade or wait until the next day

### Step 4: Verify Environment Variables
Make sure your `automation-core/.env` has:
```bash
GOOGLE_CUSTOM_SEARCH_API_KEY=your_api_key_here
GOOGLE_CUSTOM_SEARCH_ENGINE_ID=514a7883cc06d4409
```

### Step 5: Test
After enabling, restart your automation and try again. The system will:
1. Try to download images from provided URLs (with proper headers)
2. If that fails, use Google Custom Search to find real images
3. If Google Search fails, fall back to DALL-E (AI-generated images)

## Alternative: Use Different Image Sources

If you continue having issues with Google Custom Search, you can:
- Use Unsplash API (free, requires API key)
- Use Pexels API (free, requires API key)
- Rely on DALL-E fallback (works but generates AI images)

Let me know if you want to set up an alternative image source!


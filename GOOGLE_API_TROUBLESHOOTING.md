# Google Custom Search API Troubleshooting

## Error: "Requests to this API customsearch method google.customsearch.v1.CustomSearchService.List are blocked"

This error means the Custom Search API is not fully enabled or there's a permission issue.

### Solution Steps:

1. **Enable the API (if not done already)**
   - Go to: https://console.developers.google.com/apis/api/customsearch.googleapis.com/overview?project=250729890728
   - Click **"Enable"**
   - Wait 5-10 minutes for propagation

2. **Check API Key Restrictions**
   - Go to: https://console.cloud.google.com/apis/credentials?project=250729890728
   - Find your API key
   - Click on it to edit
   - Under "API restrictions":
     - Select "Restrict key"
     - Make sure "Custom Search API" is checked/enabled
   - OR select "Don't restrict key" (less secure, but works for testing)

3. **Verify Billing**
   - Custom Search API has a free tier (100 queries/day)
   - Make sure billing is enabled (even if you stay within free tier)
   - Go to: https://console.cloud.google.com/billing

4. **Check Quota**
   - Go to: https://console.cloud.google.com/apis/api/customsearch.googleapis.com/quotas?project=250729890728
   - Verify you haven't exceeded the daily limit

5. **Wait and Retry**
   - After enabling, wait 5-10 minutes
   - The API can take time to propagate across Google's systems

### Alternative: Use Search Queries Only

If the API continues to have issues, the system will:
1. Try ChatGPT-provided URLs (if valid)
2. Fall back to DALL-E (AI-generated images)

The system is designed to work even without Google Custom Search, though real images are preferred.

### Testing the API

You can test if the API is working by running:
```bash
curl "https://www.googleapis.com/customsearch/v1?key=YOUR_API_KEY&cx=514a7883cc06d4409&q=test&searchType=image"
```

If you get a JSON response with results, the API is working!


# Google Drive Integration Setup Guide

Follow these steps to enable the system to fetch images from your Google Drive folders.

## Prerequisite: Google Cloud Project
You need a Google Cloud Project to access the Drive API.

1.  Go to the [Google Cloud Console](https://console.cloud.google.com/).
2.  Create a **New Project** (or select an existing one).
3.  Name it something like "Autopost Automation".

## Step 1: Enable Google Drive API
1.  In your project dashboard, go to **APIs & Services** > **Library**.
2.  Search for **"Google Drive API"**.
3.  Click **Enable**.

## Step 2: Create a Service Account
We will use a "Service Account" so the system can access files without you needing to log in every time.

1.  Go to **APIs & Services** > **Credentials**.
2.  Click **Create Credentials** > **Service Account**.
3.  **Name**: `autopost-drive-bot` (or similar).
4.  Click **Create and Continue**.
5.  **Grant this service account access to project**:
    *   Select Role: **Basic** > **Viewer** (or specific Drive API roles if you prefer).
6.  Click **Done**.

## Step 3: Download the JSON Key
1.  Click on the newly created Service Account (email looks like `autopost-drive-bot@your-project.iam.gserviceaccount.com`).
2.  Go to the **Keys** tab.
3.  Click **Add Key** > **Create new key**.
4.  Select **JSON** and click **Create**.
5.  A file will automatically download to your computer.
6.  **Rename** this file to `service-account.json`.
7.  **Move** this file to the root folder of the project (`/Users/navdeepkk/Desktop/Autopost/`).

## Step 4: Configure Environment
1.  Open your `.env` file (in `automation-core` and root).
2.  Add/Update this line (pointing to your JSON key):
    ```env
    GOOGLE_SERVICE_ACCOUNT_JSON=./service-account.json
    ```

## Step 5: Share Folders with the Bot
This is the most important step! The bot cannot see your private folders unless you share them.

1.  Go to your **Google Drive** website.
2.  Right-click the folder you want to use (e.g., "Celebrity Images").
3.  Click **Share**.
4.  In the "Add people" box, paste the **Service Account Email** you created in Step 2 (e.g., `autopost-drive-bot@your-project.iam.gserviceaccount.com`).
5.  Set permission to **Viewer**.
6.  Click **Send**.

## Step 6: Verify in Dashboard
1.  Restart your backend server (`npm start` or the dashboard command).
2.  Go to the **Autopost Dashboard** > **Pages**.
3.  Click **Edit** on a Page (or Add New).
4.  You should now see a **Google Drive Folder** dropdown.
5.  If it lists your shared folder, it's working! 🎉

## Usage
1.  In **Prompts**, create a new prompt (or edit one).
2.  Set **Image Source** to **"Google Drive"**.
3.  The system will now look in that Page's assigned folder for images matching the celebrity names.

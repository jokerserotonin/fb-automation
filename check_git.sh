#!/bin/bash
echo "=== CORE REPO ===" > /Users/navdeepkk/Desktop/Autopost/git_sync_report.txt
cd /Users/navdeepkk/Desktop/Autopost/automation-core
git status >> /Users/navdeepkk/Desktop/Autopost/git_sync_report.txt 2>&1
git log -n 1 --oneline >> /Users/navdeepkk/Desktop/Autopost/git_sync_report.txt 2>&1
git remote -v >> /Users/navdeepkk/Desktop/Autopost/git_sync_report.txt 2>&1

echo -e "\n=== BACKEND REPO ===" >> /Users/navdeepkk/Desktop/Autopost/git_sync_report.txt
cd /Users/navdeepkk/Desktop/Autopost/automation-dashboard-backend
git status >> /Users/navdeepkk/Desktop/Autopost/git_sync_report.txt 2>&1
git log -n 1 --oneline >> /Users/navdeepkk/Desktop/Autopost/git_sync_report.txt 2>&1
git remote -v >> /Users/navdeepkk/Desktop/Autopost/git_sync_report.txt 2>&1

echo -e "\n=== FRONTEND REPO ===" >> /Users/navdeepkk/Desktop/Autopost/git_sync_report.txt
cd /Users/navdeepkk/Desktop/Autopost/automation-dashboard-frontend
git status >> /Users/navdeepkk/Desktop/Autopost/git_sync_report.txt 2>&1
git log -n 1 --oneline >> /Users/navdeepkk/Desktop/Autopost/git_sync_report.txt 2>&1
git remote -v >> /Users/navdeepkk/Desktop/Autopost/git_sync_report.txt 2>&1

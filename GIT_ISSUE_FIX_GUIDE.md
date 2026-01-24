# Git Authentication Issue Resolution Guide

## Problem Description
When attempting to push code to a GitHub repository, you may encounter a 403 permission error:
```
remote: Permission to <username>/<repository>.git denied to <different_username>.
fatal: unable to access 'https://github.com/<username>/<repository>.git/': The requested URL returned error: 403
```

This occurs when your Git client is authenticated with a different GitHub account than the one you're trying to push to.

## Root Cause
The issue happens because:
1. You have multiple GitHub accounts configured
2. Git is using cached credentials for a different account than intended
3. You're using HTTPS instead of SSH for authentication
4. Your Git global configuration doesn't match the repository owner

## Solution Steps

### 1. Check Current Remote URL
```bash
git remote -v
```

### 2. Verify SSH Key Authentication
Check if you're properly authenticated with your SSH key:
```bash
ssh -T git@github.com
```
Expected response: `Hi <your_github_username>! You've successfully authenticated, but GitHub does not provide shell access.`

### 3. Change Remote URL from HTTPS to SSH
If you're using HTTPS, switch to SSH:
```bash
git remote set-url origin git@github.com:<your_github_username>/<repository_name>.git
```

### 4. Verify the Change
Confirm the remote URL has been updated:
```bash
git remote -v
```
Should show: `git@github.com:<your_github_username>/<repository_name>.git`

### 5. Push the Code
Now you can push your code successfully:
```bash
git push origin main
```

## Prevention Tips
- Use SSH authentication instead of HTTPS for easier management of multiple GitHub accounts
- Ensure your Git global configuration matches your GitHub account:
  ```bash
  git config --global user.name "<your_github_username>"
  git config --global user.email "<your_github_email>"
  ```
- If you must use HTTPS, configure credential helper to cache the correct credentials

## Complete Command History
Here are all the commands that were executed during the resolution process:

```bash
# Clean Flutter project
cd /Users/babusaheb/Documents/CompanyProject/obc_App
flutter clean

# Get dependencies
flutter pub get

# Initialize Git repository
git init

git add .
git commit -m "Initial project setup"

git branch

git config --global user.name "Babusaheb12"
git config --global user.email "babusahebji4027@gmail.com"

# First attempt to push (failed)
git push origin main

# Check SSH keys
ls ~/.ssh

# Generate SSH key (if needed)
ssh-keygen -t ed25519 -C "babusahebji4027@gmail.com"

# Check current remote URL
git remote -v

# Configure credential helper
git config --global credential.helper store

# Second failed push attempt
git push origin main

# Test SSH authentication
ssh -T git@github.com

# Change remote URL from HTTPS to SSH
git remote set-url origin git@github.com:Babusaheb12/obc_App.git

# Verify the remote URL change
git remote -v

# Final successful push
git push origin main
```

## Quick Fix Command Sequence
```bash
# Check authentication
ssh -T git@github.com

# Set remote to SSH if needed
git remote set-url origin git@github.com:<your_github_username>/<repository_name>.git

# Push to remote
git push origin main
```

## Flutter Local Notifications Android Build Error Fix

If you encounter the error `Dependency ':flutter_local_notifications' requires core library desugaring to be enabled`, follow these steps:

1. Edit `/android/app/build.gradle.kts`
2. Add the following inside the `android` block under `compileOptions`:
   ```kotlin
   compileOptions {
       sourceCompatibility = JavaVersion.VERSION_11
       targetCompatibility = JavaVersion.VERSION_11
       
       // Enable core library desugaring for flutter_local_notifications
       isCoreLibraryDesugaringEnabled = true
   }
   ```
3. Add the following to the `dependencies` block:
   ```kotlin
   dependencies {
       // Core library desugaring for flutter_local_notifications
       coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
   }
   ```
4. Run `flutter clean && flutter pub get && flutter run`
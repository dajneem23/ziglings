# GitHub Workflow Setup Guide

This workflow automatically tracks your Ziglings progress and sends Telegram notifications when exercises remain incomplete.

## Features

- ✅ Tracks completed exercises vs total exercises
- 📊 Calculates progress percentage
- 📱 Sends Telegram notifications for:
  - Daily reminders (9 AM UTC)
  - Progress updates on push
  - Completion celebration
- 🎯 Shows remaining exercises count
- 🔄 Can be manually triggered

## Setup Instructions

### 1. Create a Telegram Bot

1. Open Telegram and search for `@BotFather`
2. Send `/newbot` command
3. Follow the instructions to create your bot
4. Save the **Bot Token** (looks like `123456789:ABCdefGHIjklMNOpqrsTUVwxyz`)

### 2. Get Your Chat ID

Option A: Using @userinfobot
1. Search for `@userinfobot` in Telegram
2. Start the bot
3. Your Chat ID will be displayed

Option B: Using your bot
1. Send any message to your bot
2. Visit: `https://api.telegram.org/bot<YOUR_BOT_TOKEN>/getUpdates`
3. Look for `"chat":{"id":123456789}` - that's your Chat ID

### 3. Add GitHub Secrets

1. Go to your repository on GitHub
2. Navigate to **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Add two secrets:

   **TELEGRAM_BOT_TOKEN**
   - Value: Your bot token from BotFather
   
   **TELEGRAM_CHAT_ID**
   - Value: Your chat ID (can be negative for groups)

### 4. Workflow Triggers

The workflow runs automatically on:
- ⏰ **Schedule**: Daily at 9 AM UTC (customize in `.github/workflows/check-progress.yml`)
- 🔀 **Push**: When you push to `main` or `process` branches
- 🔍 **Pull Request**: On any PR
- 🎮 **Manual**: Go to Actions tab → Check Progress and Alert Telegram → Run workflow

## Customization

### Change Schedule Time

Edit `.github/workflows/check-progress.yml`:

```yaml
schedule:
  - cron: '0 9 * * *'  # Change time here (UTC)
```

Examples:
- `'0 8 * * *'` - 8 AM UTC daily
- `'0 12 * * 1-5'` - 12 PM UTC weekdays only
- `'0 */6 * * *'` - Every 6 hours

### Change Target Branches

Edit the `push` section:

```yaml
push:
  branches:
    - main
    - process
    - your-branch  # Add more branches
```

### Customize Messages

Edit the status message in the workflow file under the "Check progress" step.

## Testing

### Test Manually
1. Go to your repository on GitHub
2. Click **Actions** tab
3. Select **Check Progress and Alert Telegram**
4. Click **Run workflow**
5. Select branch and click **Run workflow**

### Expected Notifications

**Daily Reminder (if incomplete):**
```
📊 Ziglings Progress Report

✅ Completed: 4/106 exercises
📈 Progress: 3%
⏳ Remaining: 102 exercises

🎯 Keep going! You've got this! 💪

📁 Repository: dajneem23/ziglings
🌿 Branch: process
⏰ Daily reminder
```

**Completion:**
```
🎉 Congratulations! 🎉

You've completed all Ziglings exercises!

📁 Repository: dajneem23/ziglings
🌿 Branch: process
```

## Troubleshooting

### Not Receiving Notifications

1. **Check secrets are set correctly**
   - Settings → Secrets → Actions
   - Verify TELEGRAM_BOT_TOKEN and TELEGRAM_CHAT_ID exist

2. **Check bot permissions**
   - Make sure you've started the bot (send `/start`)
   - For groups: Add bot as member with send messages permission

3. **Check workflow logs**
   - Actions tab → Click on workflow run
   - Check for error messages

4. **Verify Chat ID format**
   - Personal chat: positive number
   - Group chat: negative number (starts with `-`)

### Workflow Not Running

1. **Enable Actions**
   - Settings → Actions → General
   - Allow all actions

2. **Check branch protection**
   - Ensure workflow can run on target branches

3. **Verify .progress.txt exists**
   - File should be in repository root
   - Contains a number representing current exercise

## Example Usage

```bash
# Update your progress
echo "10" > .progress.txt
git add .progress.txt
git commit -m "Completed exercise 10"
git push

# Workflow will automatically:
# 1. Detect progress update
# 2. Calculate remaining exercises
# 3. Send Telegram notification
```

## Privacy Note

- Bot token and chat ID are stored as encrypted GitHub secrets
- Only you and GitHub Actions can access these secrets
- Notifications are sent only to your specified chat

## Support

If you encounter issues:
1. Check workflow logs in Actions tab
2. Verify all secrets are correctly set
3. Test with manual workflow trigger
4. Ensure Telegram bot is active and accessible

# GitHub Workflow & Telegram Alert Setup Complete! 🎉

## About Ziglings

This repository is based on **Ziglings** - a series of tiny broken Zig programs that teach you the Zig programming language by fixing them.

**Official Source:** [https://codeberg.org/ziglings/exercises](https://codeberg.org/ziglings/exercises)

Ziglings was originally created by [Dave Gauer](https://ratfactor.com/) and is inspired by [rustlings](https://github.com/rust-lang/rustlings). The official repository has migrated from GitHub to Codeberg.

**Learn more about Ziglings:**

- 🏠 Official Repository: <https://codeberg.org/ziglings/exercises>
- ⚡ Zig Language: <https://ziglang.org/>
- 📚 Zig Documentation: <https://ziglang.org/documentation/master/>
- 🎥 Zig in Depth (video series): [YouTube Playlist](https://www.youtube.com/watch?v=MMtvGA1YhW4&list=PLtB7CL7EG7pCw7Xy1SQC53Gl8pI7aDg9t&pp=iAQB)

---

## What's Been Added

### 1. GitHub Workflow (`.github/workflows/check-progress.yml`)

Automatically monitors your Ziglings progress and sends Telegram notifications.

**Features:**

- 📊 Tracks completed vs. total exercises (only if exercises changed)
- 📈 Calculates progress percentage
- 📊 Visual progress bar in notifications
- 📝 Shows next exercise to work on
- ⏰ Daily reminders at 9 AM UTC
- 🔔 Smart notifications on push events:
  - 📚 Progress updates when exercises folder changes
  - 🔬 Algorithm notifications when algorithms folder changes
  - 🔧 Commit info for other changes
- 📝 Sends commit messages with links to Telegram
- 🎉 Celebration message on completion
- 🎮 Manual trigger option
- 🤖 Auto-updates this README with current progress on every push

### 2. Progress Check Script (`check-progress.sh`)

Local script to view and update your progress.

**Usage:**

```bash
# View current progress
./check-progress.sh

# Update progress to exercise 10
./check-progress.sh 10
```

### 3. Documentation

- `.github/WORKFLOW_SETUP.md` - Complete setup guide
- `.github/QUICK_REFERENCE.md` - Quick command reference

## Next Steps

### To Enable Telegram Notifications

1. **Create a Telegram Bot** (2 minutes)
   - Open Telegram, search for `@BotFather`
   - Send `/newbot` and follow instructions
   - Save your bot token

2. **Get Your Chat ID** (1 minute)
   - Search for `@userinfobot` in Telegram
   - Start the bot to see your chat ID

3. **Add GitHub Secrets** (2 minutes)
   - Go to: Repository → Settings → Secrets and variables → Actions
   - Add `TELEGRAM_BOT_TOKEN` (your bot token)
   - Add `TELEGRAM_CHAT_ID` (your chat ID)

4. **Push to trigger!** 🚀

   ```bash
   git add .
   git commit -m "Add progress tracking workflow"
   git push
   ```

## How It Works

```
┌─────────────────┐
│  You complete   │
│   an exercise   │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Update progress │
│  ./check-progress.sh 5
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Git commit/push │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ GitHub Actions  │
│   triggers      │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│   Calculates    │
│    progress     │
└────────┬────────┘
         │
         ├─────────────────┐
         ▼                 ▼
┌─────────────────┐ ┌─────────────────┐
│ Sends Telegram  │ │ Auto-updates    │
│  notification   │ │ README.md with  │
│                 │ │ current status  │
└─────────────────┘ └─────────────────┘
```

**Note:** The workflow uses `[skip ci]` in its commit message to prevent infinite loops when updating the README.

## Example Notification

When you push changes with incomplete exercises:

```
📊 Ziglings Progress Report

✅ Completed: 4/111 exercises
📈 Progress: `████░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░` 3%

⏳ Remaining: 107 exercises
📝 Next: `005_arrays2.zig`

🎯 Keep going! You've got this! 💪

📁 Repository: dajneem23/ziglings
🌿 Branch: process
🔔 Progress updated
```

When you complete all exercises:

```
🎉 Congratulations! 🎉

You've completed all Ziglings exercises!

✅ Completed: 111/111 exercises
`████████████████████████████████████████` 100%

📁 Repository: dajneem23/ziglings
🌿 Branch: process

🏆 Amazing work! You're now a Zig expert! 💪
```

**Commit Message Notification (when exercises change):**

```
📝 Commit Pushed

💬 Message: `Complete exercise 10 - if statements`
👤 Author: Your Name
🌿 Branch: process

📚 Exercises changed

📁 Repository: dajneem23/ziglings
🔗 View Commit
📍 SHA: `a1b2c3d`
```

**Commit Message Notification (when algorithms change):**

```
📝 Commit Pushed

💬 Message: `Add binary search algorithm to algorithms collection`
👤 Author: Your Name
🌿 Branch: process

🔬 Algorithms updated

📁 Repository: dajneem23/ziglings
🔗 View Commit
📍 SHA: `b2c3d4e`
```

**Commit Message Notification (other changes):**

```
📝 Commit Pushed

💬 Message: `Update README with new section`
👤 Author: Your Name
🌿 Branch: process

🔧 Other changes

📁 Repository: dajneem23/ziglings
🔗 View Commit
📍 SHA: `c3d4e5f`
```

## Testing Without Setup

You can test locally without Telegram:

```bash
# Check your current progress
./check-progress.sh

# Output:
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 📊 Ziglings Progress Report
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 
# ✅ Completed: 4/111 exercises
# 📈 Progress:  3%
# ⏳ Remaining: 107 exercises
# 
# [█░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░] 3%
# 
# 🎯 Keep going! You've got this! 💪
# 📝 Next exercise: 005_arrays2.zig
```

## Customization

### Change Daily Reminder Time

Edit `.github/workflows/check-progress.yml`:

```yaml
schedule:
  - cron: '0 9 * * *'  # Change to your preferred time (UTC)
```

### Change Target Branches

Edit the workflow file:

```yaml
push:
  branches:
    - main
    - process
    - your-branch  # Add more branches
```

## Files Created

```
.github/
├── workflows/
│   └── check-progress.yml      # Main GitHub workflow
├── WORKFLOW_SETUP.md            # Detailed setup guide
└── QUICK_REFERENCE.md           # Command reference

check-progress.sh                # Local progress checker
```

## Current Status

✅ Workflow created and ready to use  
✅ Local progress checker working  
✅ Documentation complete  
✅ Telegram notifications enabled  

**Your current progress:** 106/111 exercises (95%)  
**Next exercise:** 107_files2.zig  
**Last updated:** 2026-04-08 02:43 UTC
## Support

- Full setup guide: `.github/WORKFLOW_SETUP.md`
- Quick commands: `.github/QUICK_REFERENCE.md`
- Test workflow: Actions tab → Run workflow manually

Happy coding! 🚀

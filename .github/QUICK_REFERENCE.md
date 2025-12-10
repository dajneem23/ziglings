# Quick Reference: Progress Tracking & Telegram Alerts

## 📋 Quick Commands

### Check Current Progress
```bash
./check-progress.sh
```

### Update Progress (after completing exercise)
```bash
./check-progress.sh <exercise_number>
# Example: ./check-progress.sh 10
```

### Commit and Push Progress
```bash
git add .progress.txt
git commit -m "Completed exercise <number>"
git push
```

## 🔔 Automatic Telegram Notifications

The GitHub workflow will automatically send Telegram notifications when:

1. **Daily Reminder** (9 AM UTC) - If exercises remain
2. **Progress Update** - When you push changes
3. **Completion** - When all exercises are done

## 🚀 Quick Setup (First Time)

1. **Create Telegram Bot**
   ```
   1. Message @BotFather on Telegram
   2. Send: /newbot
   3. Follow instructions
   4. Save the bot token
   ```

2. **Get Chat ID**
   ```
   1. Message @userinfobot
   2. Copy your chat ID
   ```

3. **Add GitHub Secrets**
   ```
   Repository → Settings → Secrets → Actions → New secret
   
   Name: TELEGRAM_BOT_TOKEN
   Value: <your_bot_token>
   
   Name: TELEGRAM_CHAT_ID
   Value: <your_chat_id>
   ```

4. **Done!** Push to trigger notifications

## 📊 Progress File

The `.progress.txt` file contains a single number representing the current exercise.

```bash
# View current progress
cat .progress.txt

# Manually update (not recommended, use script instead)
echo "15" > .progress.txt
```

## 🔧 Workflow Files

- `.github/workflows/check-progress.yml` - Main workflow
- `.github/WORKFLOW_SETUP.md` - Detailed setup guide
- `check-progress.sh` - Local progress checker

## 🎯 Typical Workflow

```bash
# 1. Work on an exercise
vim exercises/005_arrays2.zig

# 2. Test it
zig build

# 3. Update progress
./check-progress.sh 5

# 4. Commit and push (triggers notification)
git add .
git commit -m "Completed exercise 5: arrays2"
git push
```

## 🐛 Troubleshooting

**No Telegram notifications?**
- Check GitHub Actions tab for errors
- Verify secrets are set (Settings → Secrets → Actions)
- Ensure bot has been started (send `/start` to your bot)

**Workflow not running?**
- Check Actions are enabled (Settings → Actions → General)
- Verify branch name matches workflow triggers
- Try manual trigger (Actions → Check Progress → Run workflow)

**Progress not updating?**
- Ensure `.progress.txt` is committed
- Check file contains valid number
- Verify workflow has push trigger for your branch

## 📚 More Info

See `.github/WORKFLOW_SETUP.md` for complete documentation.

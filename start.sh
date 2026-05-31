#!/bin/bash

echo "🚀 DRX POWER SYSTEM STARTING..."

# Install libraries
echo "📦 Installing Python libraries..."
pip3 install flask pyTelegramBotAPI requests psutil --quiet

# Compile C binary
echo "⚙️ Compiling drx.c binary..."
gcc drx.c -o drx -lpthread -O3
chmod +x drx

# Clean old sessions
echo "🧹 Cleaning old sessions..."
pkill -f api.py 2>/dev/null
pkill -f drx.py 2>/dev/null

# Start Telegram Bot in background
echo "🤖 Starting Telegram Bot..."
nohup python3 drx.py > bot_logs.txt 2>&1 &

sleep 2

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ SYSTEM IS NOW LIVE!"
echo "📡 API Status: Running"
echo "🤖 Bot Status: Running"
echo "📝 Logs saved in: api_logs.txt and bot_logs.txt"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Start Flask API in FOREGROUND (keeps Render alive)
echo "🌐 Starting Flask API on port 8080..."
python3 api.py

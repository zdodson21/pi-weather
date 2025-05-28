# !/bin/bash

# Start the dev server in the background
npm run dev &

# Wait for server to be ready
sleep 3

# Launch Chromium in fullscreen
chromium --headless --screenshot=piweather.png --window-size="1280,720" --disable-gpu --no-sandbox http://localhost:5173

# Cleanup
echo "Cleaning up processes..."
pkill -f "vite"
exit 0
# !/bin/bash

# Start the dev server in the background
npm run dev &

# Wait for server to be ready
sleep 3

# Launch Chromium in fullscreen
chromium --start-fullscreen http://localhost:5173

# Cleanup
echo "Cleaning up processes..."
pkill -f "vite"
exit 0
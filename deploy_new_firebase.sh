#!/bin/bash

# Cursor assistant: Deploy Digital Mental Health App to a NEW Firebase project
# (This script will BACKUP firebase config, create/use a new Firebase project,
#  set the project in .firebaserc, create a hosting config, build the Flutter web,
#  and deploy hosting. It will PAUSE for Firebase login and for any choices.)

set -e

echo "=== Step 0: Verify working directory ==="
pwd
ls -la | sed -n '1,200p'

echo
echo "=== Step 1: Backup existing firebase config (if any) ==="
if [ -f .firebaserc ]; then cp .firebaserc .firebaserc.bak && echo "Backed up .firebaserc -> .firebaserc.bak"; else echo "No .firebaserc found"; fi
if [ -f firebase.json ]; then cp firebase.json firebase.json.bak && echo "Backed up firebase.json -> firebase.json.bak"; else echo "No firebase.json found"; fi

echo
echo "=== Current .firebaserc (if present) ==="
if [ -f .firebaserc ]; then cat .firebaserc; else echo "(none)"; fi
echo "----------------------------------------"

echo
echo "=== Step 2: Ensure Firebase CLI installed ==="
if ! command -v firebase >/dev/null 2>&1; then
  echo "firebase CLI not found. Attempting to install firebase-tools globally via npm..."
  if command -v npm >/dev/null 2>&1; then
    npm install -g firebase-tools || { echo "npm install failed. Please install firebase-tools manually and re-run."; exit 1; }
  else
    echo "npm not found. Please install Node.js (which includes npm) and re-run."; exit 1;
  fi
else
  echo "firebase CLI found: $(firebase --version)"
fi

echo
echo "=== Step 3: Ensure you are logged in to Firebase CLI ==="
# Try a simple check; if it errors, run login
if ! firebase login:list >/dev/null 2>&1; then
  echo "You are not logged in to Firebase CLI. A browser window will open - please complete login."
  firebase login || { echo "firebase login command failed. Please run 'firebase login' manually, then re-run this script."; exit 1; }
else
  echo "You already appear logged in to Firebase CLI."
fi
read -p "Press Enter here after you've completed the browser login (or if you were already logged in) to continue..."

echo
echo "=== Step 4: Show current Firebase projects (first 50) ==="
firebase projects:list --limit=50 || echo "(If listing failed, continue; you can still enter project id manually)"

echo
echo "=== Step 5: Choose action ==="
echo "Choose one of the following actions:"
echo "  1) Create a NEW Firebase project named 'digital-mental-health-app' (recommended)."
echo "  2) Use an EXISTING Firebase project (you will type its project id)."
echo "  3) Enter a CUSTOM project id to create or use."
read -p "Enter 1, 2 or 3: " CHOICE

PROJECT_ID=""

if [ "$CHOICE" = "1" ]; then
  BASE_ID="digital-mental-health-app"
  PROJECT_ID="$BASE_ID"
  echo "Attempting to create Firebase project with id: $PROJECT_ID"
  attempt=0
  while true; do
    # try to create; if fails, append a short random suffix and retry up to 5 times
    if firebase projects:create "$PROJECT_ID" --display-name "Digital Mental Health App"; then
      echo "Created project: $PROJECT_ID"
      break
    else
      attempt=$((attempt+1))
      SUFFIX=$(printf "%04x" $((RANDOM%65536)))
      PROJECT_ID="${BASE_ID}-${SUFFIX}"
      echo "Create failed, retrying with: $PROJECT_ID (attempt $attempt)"
    fi
    if [ "$attempt" -ge 5 ]; then
      echo "Automatic creation failed after multiple attempts."
      read -p "Enter a custom project id to create (or an existing id to use): " PROJECT_ID
      firebase projects:create "$PROJECT_ID" --display-name "Digital Mental Health App" || { echo "Failed to create project $PROJECT_ID. Exiting."; exit 1; }
      break
    fi
  done

elif [ "$CHOICE" = "2" ]; then
  read -p "Enter the EXISTING project id exactly as listed above: " PROJECT_ID
  echo "Using existing project id: $PROJECT_ID"

elif [ "$CHOICE" = "3" ]; then
  read -p "Enter the CUSTOM project id you want to create or use: " PROJECT_ID
  # try to create; if already exists, continue to use it
  if ! firebase projects:create "$PROJECT_ID" --display-name "Digital Mental Health App" 2>/dev/null; then
    echo "Project create attempt failed (it may already exist). We'll try to use it if it exists."
  else
    echo "Created project: $PROJECT_ID"
  fi

else
  echo "Invalid choice. Exiting."
  exit 1
fi

if [ -z "$PROJECT_ID" ]; then
  echo "No project id set. Exiting."
  exit 1
fi

echo
echo "=== Step 6: Set this project as the local default in .firebaserc ==="
echo "Backing up .firebaserc again..."
if [ -f .firebaserc ]; then cp .firebaserc .firebaserc.preselect.bak; fi

cat > .firebaserc <<EOF
{
  "projects": {
    "default": "$PROJECT_ID"
  }
}
EOF

echo ".firebaserc written with default project: $PROJECT_ID"
echo "Contents:"
cat .firebaserc

echo
echo "=== Step 7: Ensure firebase.json has hosting config for Flutter web ==="
# If firebase.json exists and already has hosting, keep it (but we backed up). Otherwise create one.
if [ -f firebase.json ]; then
  echo "Existing firebase.json found. Showing it now:"
  cat firebase.json
  echo
  echo "If this existing firebase.json already contains hosting, we'll keep it. Otherwise we'll merge a hosting config."
  # quick check for hosting key
  if grep -q "\"hosting\"" firebase.json; then
    echo "hosting already present in firebase.json - leaving file as is (backup saved earlier)."
  else
    echo "Adding hosting config to firebase.json (merge)."
    # create a new one with hosting as default (we will overwrite; you have backups)
    cat > firebase.json <<EOF
{
  "hosting": {
    "public": "build/web",
    "ignore": [
      "firebase.json",
      "**/.*",
      "**/node_modules/**"
    ],
    "rewrites": [
      {
        "source": "**",
        "destination": "/index.html"
      }
    ]
  }
}
EOF
    echo "firebase.json created with hosting config."
  fi
else
  cat > firebase.json <<EOF
{
  "hosting": {
    "public": "build/web",
    "ignore": [
      "firebase.json",
      "**/.*",
      "**/node_modules/**"
    ],
    "rewrites": [
      {
        "source": "**",
        "destination": "/index.html"
      }
    ]
  }
}
EOF
  echo "firebase.json created with hosting config."
fi

echo
echo "=== Step 8: Build Flutter web (release) ==="
echo "Running: flutter build web --release"
flutter build web --release || { echo "flutter build web failed. Fix build errors and re-run."; exit 1; }

echo
echo "=== Step 9: Deploy to Firebase Hosting ==="
echo "Deploying only hosting for project: $PROJECT_ID"
firebase deploy --only hosting || { echo "firebase deploy failed. Please inspect the error above."; exit 1; }

echo
echo "=== Step 10: Deployment complete - Hosting URLs ==="
echo "Likely hosting URLs:"
echo "  https://$PROJECT_ID.web.app"
echo "  https://$PROJECT_ID.firebaseapp.com"
echo
echo "Please open the Firebase Console to confirm: https://console.firebase.google.com/project/$PROJECT_ID/overview"
echo
echo "All done. If you want me to set up automatic deploy on git push (GitHub Actions) next, tell me and I'll add the workflow file."

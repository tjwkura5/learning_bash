#!/bin/bash

# Update the system
sudo apt update -y && sudo apt upgrade -y

#Install inotify-tools 
sudo apt-get install inotify-tools -y

# The directory you want to monitor
DIR_TO_WATCH="/path/to/your/directory"

# GitHub repository URL (replace with your actual repo URL)
GITHUB_REPO_URL="https://github.com/your-username/your-repo.git"


# Check if git is installed
if command -v git >/dev/null 2>&1; then
    if [[ -d "$DIR_TO_WATCH" ]]; then
        # Use inotifywait to monitor the directory for new file creation
        inotifywait -m -e create --format '%f' "$DIR_TO_WATCH" |
        while read NEW_FILE
        do
            echo "New files detected: $NEW_FILE"

            if [ -d "$DIR_TO_WATCH/.git" ]; then
                
                echo "Pushing changes to the existing GitHub repository"

                git add "$DIR_TO_WATCH/$NEW_FILE"
                git commit -m"adding a new file: $NEW_FILE"
                git push

                echo "Changes have been successfully pushed to GitHub"
            else
                echo "The directory is not a Git repository."
                
                while true; do
                    echo "Would you like to create a new repository on GitHub? (yes/no):"
                    read answer

                    answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')

                    # Check if input is 'yes' or 'no'
                    if [[ "$answer" == "yes" || "$answer" == "no" ]]; then
                        break
                    else
                        echo "Invalid input. Please enter 'yes' or 'no'."
                    fi
                done

                if [[ "$answer" == "yes" ]]; then
                    echo "Initializing a new Git repository..."
                    cd "$DIR_TO_WATCH" 

                    # Initialize git repository
                    git init

                    # Add the GitHub repository as the origin remote
                    git remote add origin "$GITHUB_REPO_URL"

                    echo "Git repository initialized and remote added."

                    # Add all changes to git
                    git add .

                    git commit -m"initial commit"

                    # Push the changes to the remote GitHub repository
                    git push -u origin master
                else
                    echo "Changes can't be pushed as there is no Github repository"
                fi
            fi
        done
    else
        echo "Directory does not exists: $DIR_TO_WATCH"
    fi
else
    echo "Git is not installed. Please install Git before running this script."
    exit 1  # Exit the script with a non-zero exit code
fi

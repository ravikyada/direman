#!/bin/bash

# Define the file to store the value
HISTORY_FILE="$HOME/.DIMAN_PATH"

# Check if the user provided the second argument
if [ -z "$2" ]; then
    # Use the stored value from the file if it exists
    if [ -f "$HISTORY_FILE" ]; then
        DIMAN_PATH=$(cat "$HISTORY_FILE")
        echo "Using the stored value: $DIMAN_PATH"
    else
        echo "No stored value found."
    fi
else
    # Save the second argument for future use
    DIMAN_PATH="$2"
    echo "$DIMAN_PATH" > "$HISTORY_FILE"
    echo "Storing the value: $DIMAN_PATH"
fi

# Directory where the files to be organized are located
echo "Final is "$DIMAN_PATH"."
cd "$DIMAN_PATH"

# Set up default directories and log file
LOG_FILE="$HOME/.diman.log"
DEFAULT_DIRS=("Documents" "Images" "Music" "Videos" "Games" "Applications" "Archives" "Torrents")

# ... (rest of the script remains unchanged)

# Recursive function to organize files
organizeFiles() {
    local target_dir="$1"
    shift
    local extensions=("$@")
    
    local found=false
    for ext in "${extensions[@]}"; do
        for file in *"$ext"; do
            if [ -f "$file" ]; then
                found=true
                break
            fi
        done
        
        if [ "$found" = true ]; then
            break
        fi
    done
    
    if [ "$found" = true ]; then
        mkdir -p "$DIMAN_PATH/$target_dir"
        
        shopt -s nullglob
        for ext in "${extensions[@]}"; do
            for file in *"$ext"; do
                if [ -f "$file" ]; then
                    mv --backup=t "$file" "$DIMAN_PATH/$target_dir/"
                fi
            done
        done
        shopt -u nullglob
        
        echo "$(date): Moved "$file" $DIMAN_PATH/$target_dir" >> "$LOG_FILE"
    fi
}

# Move files based on extensions
organizeFiles "Documents" .pdf .doc .rtf .txt .xlsx .ctb .csv docx
organizeFiles "Images" .gif .jpg .jpeg .png .raw .svg .tiff .bmp .webp .avif
organizeFiles "Music" .aiff .flac .mp3 .m4b .ogg .wav .m4a .mpga
organizeFiles "Videos" .3gp .avi .m4v .mkv .mp4 .divx .flv .mov .mpg .webm
organizeFiles "Games" .nes .smc .sfc .n64 .z64 .gba .nds .3ds .swf .gblorb .z3 .z5 .z8
organizeFiles "Applications" .appimage .x86_64 .deb .rpm .flatpakref .exe .app .apk
organizeFiles "Archives" .7z .rar .tar.gz .zip .gz .tgz
organizeFiles "Music" .aiff .flac .mp3 .m4b .ogg .wav .m4a .mpga
organizeFiles "Torrents" .torrent
organizeFiles "Log Files" .log
organizeFiles "YAMLS" .yaml .yml
organizeFiles "SSH-Keys" .pem .ppk
organizeFiles "HTML-Files" .html
organizeFiles "SQL-Files" .sql
organizeFiles "Jmx-Files" .jmx
organizeFiles "J-Files" .js

# ... (similar blocks for other categories)

echo "File organization complete. Log saved to: $LOG_FILE"

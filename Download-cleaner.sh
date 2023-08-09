#!/bin/bash

if [ "$1" = "-dir" ]; then
    # Check if the directory argument is provided
    if [ -n "$2" ]; then
        SOURCE_DIR="$2"
    else
        echo "Error: Directory argument is missing."
        exit 1
    fi
else
    SOURCE_DIR="~/Downloads"
fi
ORG_DIR="~/Downloads"
# Directory where the files to be organized are located

# Directories to move files into based on extensions
DOCUMENTS_DIR="$SOURCE_DIR/Documents"
IMAGES_DIR="$SOURCE_DIR/Pictures"
MUSIC_DIR="$SOURCE_DIR/Music"
VIDEOS_DIR="$SOURCE_DIR/Videos"
GAMES_DIR="$SOURCE_DIR/Games"
APPLICATIONS_DIR="$SOURCE_DIR/Applications"
ARCHIVES_DIR="$SOURCE_DIR/Archives"
TORRENTS_DIR="$SOURCE_DIR/Torrents"
UNSORTED_DIR="$SOURCE_DIR/Unsorted"

# Log file
LOG_FILE="/var/log/diman.log"

# Create directories if they don't exist
mkdir -p "$DOCUMENTS_DIR"
mkdir -p "$IMAGES_DIR"
mkdir -p "$MUSIC_DIR"
mkdir -p "$VIDEOS_DIR"
mkdir -p "$GAMES_DIR"
mkdir -p "$APPLICATIONS_DIR"
mkdir -p "$ARCHIVES_DIR"
mkdir -p "$TORRENTS_DIR"
mkdir -p "$UNSORTED_DIR"

# Change to source directory
cd "$SOURCE_DIR"

# Move files to their respective folders based on extensions
moveFiles() {
    local target_dir="$1"
    shift
    for file in "$@"; do
        if mv --backup=t "$file" "$target_dir"; then
            echo "$(date): Moved $file to $target_dir" > "$LOG_FILE" # Log if successful
        fi
    done
}

# Move documents
moveFiles "$DOCUMENTS_DIR" ./*.pdf ./*.doc ./*.rtf ./*.txt ./*.xlsx ./*.ctb

# Move images
moveFiles "$IMAGES_DIR" ./*.gif ./*.jpg ./*.jpeg ./*.png ./*.raw ./*.svg ./*.tiff ./*.bmp ./*.webp ./*.avif

# Move music
moveFiles "$MUSIC_DIR" ./*.aiff ./*.flac ./*.mp3 ./*.m4b ./*.ogg ./*.wav ./*.m4a ./*.mpga

# Move videos
moveFiles "$VIDEOS_DIR" ./*.3gp ./*.avi ./*.m4v ./*.mkv ./*.mp4 ./*.divx ./*.flv ./*.mov ./*.mpg ./*.webm

# Move games
moveFiles "$GAMES_DIR" ./*.nes ./*.smc ./*.sfc ./*.n64 ./*.z64 ./*.gba ./*.nds ./*.3ds ./*.swf ./*.gblorb ./*.z3 ./*.z5 ./*.z8

# Move applications
moveFiles "$APPLICATIONS_DIR" ./*.appimage ./*.x86_64 ./*.deb ./*.rpm ./*.flatpakref ./*.exe ./*.app ./*.apk

# Move archives
moveFiles "$ARCHIVES_DIR" ./*.7z ./*.rar ./*.tar.gz ./*.zip

# Move torrents
moveFiles "$TORRENTS_DIR" ./*.torrent

# Move remaining files to Unsorted directory
#moveFiles "$UNSORTED_DIR" ./*

echo "File organization complete. Log saved to: $LOG_FILE"

#!/bin/bash

# This script takes (for example) februari24.mp3 (audio), februari24.png (visual) and februari24.csv (chapter markers)
# and generates:
# - A chaptered, IDV3 tagged MP3 file: februari24_chapters.mp3
# - A HTML snippet containing links to Soundcloud chapters: februari24.html
# - A cleartext snippet containing timecodes that can be interpreted by Spotify or Youtube: februari24.spotify.txt

# LOGGING
# -----------------------------------
getDATE () { date '+%F %T'; }
SCRIPTNAME=""; NCB='\033[0m'; BLUEBG='\033[44m\033[1m'; GREENBG='\033[42m\033[1m'; REDBG='\033[41m\033[1m'; YELLOWBG='\033[43m\033[1m'
logNice() { if [ "$1" == "ok" ]; then echo -e "${GREENBG}->${NCB} $(getDATE) ($SCRIPTNAME): $2"
			elif [ "$1" == "warn" ]; then echo -e "${YELLOWBG}->${NCB} $(getDATE) ($SCRIPTNAME): $2"
			elif [ "$1" == "fail" ]; then echo -e "${REDBG}x>${NCB} $(getDATE) ($SCRIPTNAME): $2" >&2
			elif [ "$1" = "start" ] || [ "$1" = "stop" ]; then echo -e "${BLUEBG}-> $(getDATE) ($SCRIPTNAME): $2${NCB}"
			else echo -e "${BLUEBG}->${NCB} $(getDATE) ($SCRIPTNAME): $2"; fi }
export SCRIPTNAME="process_podcast"


# TOOLS CONFIG
# ------------------------------------
# Audition chapter tagger by DrSkunk - https://github.com/DrSkunk/audition-chapter-tagger
TAGGER="node audition-chapter-tagger/index.js"
# CSV to HTML and Spotify scripts
CSV_TO_HTML="python3 csv_to_html_timestamps.py"
CSV_TO_SPOTIFY="python3 csv_to_spotify_timestamps.py"


# CONSTANTS CONFIG
# ------------------------------------
# MONTHLY PODCASTS
MONTHS=( april )
# MONTHS=( januari februari maart april mei juli juni augustus september oktober november december )
YEAR_SHORT=24
YEAR_FULL=2024

#--SCRIPT START-------------------

logNice "start" "Starting processing of podcasts"

for month in "${MONTHS[@]}"; do
    logNice "info" "Processing month $month$YEAR_SHORT"

    # Check if everything is there
    if [ ! -f "$month$YEAR_SHORT.csv" ]; then logNice "error" "$month has no CSV file, skipping"; continue; fi
    if [ ! -f "$month$YEAR_SHORT.mp3" ]; then logNice "error" "$month has no MP3 file, skipping"; continue; fi
    if [ ! -f "$month$YEAR_SHORT.png" ]; then logNice "error" "$month has no PNG file, skipping"; continue; fi

    # Generate HTML
    logNice "info" "Generating HTML for $month$YEAR_SHORT"
    $CSV_TO_HTML "$month$YEAR_SHORT.csv" "https://soundcloud.com/lieven-scheire/nerdland-maandoverzicht-$month-$YEAR_FULL" > "$month$YEAR_SHORT.html"

    # Generate Spotify
    logNice "info" "Generating Spotify text for $month$YEAR_SHORT"
    $CSV_TO_SPOTIFY "$month$YEAR_SHORT.csv" > "$month$YEAR_SHORT.spotify.txt"

    # Generate chaptered MP3
    logNice "info" "Writing chapters for $month$YEAR_SHORT"
    $TAGGER --mp3 "$month$YEAR_SHORT.mp3" --cover "$month$YEAR_SHORT.png" --markers "$month$YEAR_SHORT.csv" --title "Nerdland Maandoverzicht: ${month^} $YEAR_FULL" --artist "Nerdland" --overwrite
done

logNice "stop" "End of script"

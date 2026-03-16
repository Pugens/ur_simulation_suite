#!/bin/bash
PROGRAMS=$(docker exec ursim-container find /ursim/programs -name "*.urp" 2>/dev/null | sed 's|^/ursim/programs/||')

if [ -z "$PROGRAMS" ]; then
    echo "No .urp files found in the container. Is it running?" >&2
    exit 1
fi

if [ -z "$1" ]; then
    echo "Available programs:"
    i=1
    while IFS= read -r p; do
        echo "  [$i] $p"
        i=$((i + 1))
    done <<< "$PROGRAMS"
    read -rp "Select a program (1-$((i - 1))): " choice
    PROGRAM=$(echo "$PROGRAMS" | sed -n "${choice}p")
    if [ -z "$PROGRAM" ]; then
        echo "Invalid selection." >&2
        exit 1
    fi
else
    PROGRAM="$1"
    if ! echo "$PROGRAMS" | grep -qx "$PROGRAM"; then
        echo "Program '$PROGRAM' not found. Available programs:" >&2
        echo "$PROGRAMS" | sed 's/^/  /' >&2
        exit 1
    fi
fi

echo "Loading: $PROGRAM"
{ echo "load $PROGRAM"; sleep 0.5; echo "play"; sleep 0.5; echo "quit"; } | nc localhost 29999
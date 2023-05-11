#!/bin/sh

# For more information visit: https://github.com/downthecrop/TwitchVOD

while true; do
	Date=$(date +%Y%m%d-%H%M%S)
	streamlink "$STREAM_OPTIONS" "$STREAM_LINK" "$STREAM_QUALITY" -o "/home/download/$STREAM_NAME-$Date.mkv"
	sleep 300s
done

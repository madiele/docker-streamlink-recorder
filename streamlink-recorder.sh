#!/bin/sh

# For more information visit: https://github.com/downthecrop/TwitchVOD

while true; do
	Date=$(date +%Y%m%d-%H%M%S)
	streamlink --twitch-disable-ads "$STREAM_OPTIONS" "$STREAM_LINK" "$STREAM_QUALITY" -o "/home/download/$STREAM_NAME-$Date.mp4"
	sleep 300s
done

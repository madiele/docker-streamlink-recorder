#!/bin/sh

# For more information visit: https://github.com/downthecrop/TwitchVOD

while true; do
  Date=$(date +%Y%m%d-%H%M%S)
  start=$(date +%s)
  filename=/home/download/$STREAM_NAME-$Date.mp4
  streamlink --twitch-disable-ads "$STREAM_OPTIONS" "$STREAM_LINK" "$STREAM_QUALITY" -o "$filename"
  end=$(date +%s)
  elapsed=$((end - start))
  duration=$(printf '%02d:%02d:%02d\n' $((elapsed/3600)) $((elapsed%3600/60)) $((elapsed%60)))
  mv "$filename" "$STREAM_NAME-$Date-_%_${duration}_%_.mp4"
  sleep 300s
done

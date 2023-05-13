#!/bin/sh

# For more information visit: https://github.com/downthecrop/TwitchVOD

while true; do
  Date=$(date +%Y-%m-%d_%H:%M:%S)
  filename=/home/download/$STREAM_NAME-$Date
  streamlink --twitch-disable-ads "$STREAM_OPTIONS" "$STREAM_LINK" "$STREAM_QUALITY" -o "${filename}.mkv" > /dev/null
  if [ -e "${filename}.mkv" ]; then
    ffmpeg -fflags +discardcorrupt -i "${filename}.mkv" -c:v copy -c:a copy -f mp4 -movflags faststart -y "${filename}.mp4" \
      && \
    rm "${filename}.mkv"
    elapsed=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "${filename}.mp4" | cut -d. -f1)
    duration=$(printf '%02d:%02d:%02d' $((elapsed/3600)) $((elapsed%3600/60)) $((elapsed%60)))
    mv "${filename}.mp4" "${filename}___${duration}___.mp4"
  fi
  sleep 300s
done

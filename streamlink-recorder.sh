#!/bin/sh

# For more information visit: https://github.com/downthecrop/TwitchVOD

while true; do
  Date=$(date +%Y%m%d-%H%M%S)
  start=$(date +%s)
  filename=/home/download/$STREAM_NAME-$Date.mkv
  streamlink --twitch-disable-ads "$STREAM_OPTIONS" "$STREAM_LINK" "$STREAM_QUALITY" -o "$filename" > /dev/null
  end=$(date +%s)
  elapsed=$((end - start))
  duration=$(printf '%02d:%02d:%02d\n' $((elapsed/3600)) $((elapsed%3600/60)) $((elapsed%60)))
  if [ -e "$filename" ]; then
      ffmpeg -fflags +discardcorrupt -i "$filename" -c:v copy -c:a copy -f mp4 -movflags faststart -y "$STREAM_NAME-$Date-___${duration}___.mp4" \
      && \
    rm "$filename"
  fi
  sleep 300s
done

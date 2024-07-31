#!/bin/bash

mkdir ./temp
mkdir ./temp/input
mkdir ./temp/output

codec=$(ffprobe -v error -select_streams a:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 ./video.mp4)
codec=${codec:0:3}
if [ "$codec" = "vor" ]; then
  codec="ogg"
fi
ffmpeg -i ./video.mp4 -vn -acodec copy ./temp/audio.$codec
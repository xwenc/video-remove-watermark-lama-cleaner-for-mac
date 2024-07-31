#!/bin/bash

get_video_resolution=$(ffprobe -v error -select_streams v:0 -show_entries "stream=width,height" -of "csv=s=x:p=0" ./video.mp4)
get_mask_resolution=$(ffprobe -v error -select_streams v:0 -show_entries "stream=width,height" -of "csv=s=x:p=0" ./mask.png)

video_resolution=$(echo $get_video_resolution | tr -d '\r')
mask_resolution=$(echo $get_mask_resolution | tr -d '\r')

if [ "$video_resolution" == "$mask_resolution" ]; then
  ./scripts/01_audio_extract.sh
  ./scripts/02_frame_extract.sh
  ./scripts/03_frame_clean.sh
  ./scripts/04_frame_merge.sh
  ./scripts/05_audio_merge.sh

  read -p "File saved as video_final.mp4, in output folder. cleanup temporary files? If not, you should manually delete temp folder before next task. (Y/N) " YN
  if [[ "$YN" =~ ^[Yy]$ ]]; then
    ./scripts/06_cleanup.sh
  fi
else
  echo "video and mask resolution must be exact same"
fi

read -p "Press any key to continue..."
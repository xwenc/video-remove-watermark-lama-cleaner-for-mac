codec=$(ffprobe -v error -select_streams a:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 ./video.mp4)
codec=${codec:0:3}
if [ "$codec" = "vor" ]; then
  codec="ogg"
fi
ffmpeg -i ./temp/video_cleaned.mp4 -i ./temp/audio.$codec -c:v copy -map 0:v -map 1:a -y ./output/video_final.mp4
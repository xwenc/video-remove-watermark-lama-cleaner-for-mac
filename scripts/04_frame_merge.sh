Rawfps=$(ffprobe -v error -select_streams v -of default=noprint_wrappers=1:nokey=1 -show_entries stream=avg_frame_rate ./video.mp4)
IFS='/' read -ra Splitfps <<< "$Rawfps"
Truefps=$(echo "scale=2; (${Splitfps[0]} / ${Splitfps[1]}) * 100 / 100" | bc)
ffmpeg -framerate $Truefps -i ./temp/output/%d.jpg -c:v libx264 -crf 7 -pix_fmt yuv420p -y ./temp/video_cleaned.mp4
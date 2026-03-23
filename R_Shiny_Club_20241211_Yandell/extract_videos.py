import re
import subprocess
import os
import sys

# 1. Parsing the markdown
with open('tutorial_transcript.md', 'r') as f:
    text = f.read()

# Match something like:
# - [Title [HH:MM:SS]](#...) or - [Title [MM:SS]](#...)
pattern = re.compile(r'-\s+\[(.*?)\[(?:(\d{1,2}):)?(\d{1,2}):(\d{2})\]\]\(#.*?\)')

clips = []
for match in pattern.finditer(text):
    title_raw = match.group(1).strip()
    h = match.group(2)
    m = match.group(3)
    s = match.group(4)
    h = int(h) if h else 0
    m = int(m)
    s = int(s)
    total_seconds = h * 3600 + m * 60 + s
    
    # Clean title
    clean_title = re.sub(r'[^a-zA-Z0-9_\-]', '_', title_raw)
    clean_title = re.sub(r'_+', '_', clean_title).strip('_')
    
    clips.append({
        'title': clean_title,
        'start_sec': total_seconds,
        'time_str': f"{h:02d}:{m:02d}:{s:02d}"
    })

# Add the end time (1h 17m 59s)
end_time_sec = 1 * 3600 + 17 * 60 + 59  

for i in range(len(clips)):
    start = clips[i]['start_sec']
    end = clips[i+1]['start_sec'] if i + 1 < len(clips) else end_time_sec
    duration = end - start
    clips[i]['duration'] = duration
    
print(f"Parsed {len(clips)} clips from transcript.")
for idx, c in enumerate(clips):
    print(f"Clip {idx+1}: {c['title']} starts at {c['time_str']} ({c['start_sec']}s), duration {c['duration']}s")

output_dir = "R_Shiny_Club_20241211_Yandell"
os.makedirs(output_dir, exist_ok=True)

# 2. Download the video using yt-dlp
# Note from user: The video is stored as mp4 at https://drive.google.com/file/d/1BGSIhihpBc-2TfRza5RGeXBCB55EC6-l
video_url = "https://drive.google.com/file/d/1BGSIhihpBc-2TfRza5RGeXBCB55EC6-l"
video_file = "presentation_full.mp4"

if not os.path.exists(video_file):
    print(f"Downloading video from {video_url} via yt-dlp...")
    res = subprocess.run(["yt-dlp", video_url, "-o", video_file])
    if res.returncode != 0:
        print("yt-dlp failed to download the video.")
        sys.exit(1)
else:
    print(f"{video_file} already exists, skipping download.")

# 3. Extract the clips
for i, clip in enumerate(clips):
    idx = i + 1
    out_file = os.path.join(output_dir, f"{idx:02d}_{clip['title']}.mp4")
    if os.path.exists(out_file):
        print(f"Skipping {out_file}, already exists.")
        continue
    
    print(f"Extracting clip {idx}/{len(clips)}: {clip['title']}")
    # Using ffmpeg exactly as required for video format copy
    cmd = [
        "ffmpeg", "-y", "-i", video_file,
        "-ss", str(clip['start_sec']),
        "-t", str(clip['duration']),
        "-c", "copy",
        out_file
    ]
    subprocess.run(cmd, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    
print("All videos extracted successfully.")

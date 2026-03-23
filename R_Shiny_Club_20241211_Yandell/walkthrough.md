# Walkthrough: Extracting Videos from Presentation

## Original Prompt
>
> Use tutorial_transcript.md to guide extraction of short videos from the cited presentation. Place the extracted videos in a suitably named folder.
> The video is stored as mp4 at <https://drive.google.com/file/d/1BGSIhihpBc-2TfRza5RGeXBCB55EC6-l>

## Overview

This walkthrough documents the steps taken to download the full presentation video and slice it into smaller segments based on the timestamps provided in `tutorial_transcript.md`.

## Steps Completed

1. **Analyzed the Transcript**:
   - Parsed `tutorial_transcript.md` to extract the video segment titles and their start times from the Table of Contents.
   - Identified 16 distinct sections (e.g., *Introduction: Old Faithful Geyser Example*, *Basic Shiny App Structure*, etc.).

2. **Installed Dependencies**:
   - Installed `yt-dlp` via Homebrew to handle downloading the video from Google Drive.
   - Installed `ffmpeg` via Homebrew to accurately slice the MP4 video without re-encoding.

3. **Created Extraction Script**:
   - Wrote a Python script (`extract_videos.py`) that matches markdown links in the transcript to calculate the exact duration of each segment.
   - Setup the script to automatically invoke `yt-dlp` to download the master presentation file.

4. **Extracted and Saved Videos**:
   - Sliced the main presentation video into 16 smaller `.mp4` video files using `ffmpeg`.
   - Saved all extracted clips into the `R_Shiny_Club_20241211_Yandell/` directory, naming them sequentially for easy viewing (e.g., `01_Introduction_Old_Faithful_Geyser_Example.mp4`).

## Validation

- Verified the successful creation of all 16 extracted `.mp4` files in the `R_Shiny_Club_20241211_Yandell/` directory.
- Confirmed that the tools `ffmpeg` and `yt-dlp` installed properly and handled the media without any encoding issues.

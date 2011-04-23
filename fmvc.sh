#!/bin/sh

#Creado por Joe Cabezas <joe.cabezas@gmail.com>

DIR="$1"
OUTPUT_DIR="out"
RAW_DIR="raw"

#ffmpeg variables
VIDEO_CONFIG="-vcodec libx264 -vpre lossless_slow -crf 22"
AUDIO_CONFIG="-acodec libfaac -ab 128k -ac 1"

cd "$DIR"
mkdir $OUTPUT_DIR
mkdir $RAW_DIR
for file in *.avi
do
	#One-pass CRF (Constant Rate Factor) using the slow preset.
	#One-pass CRF is good for general encoding and is what I use most often. Adjust -crf to change the quality.
	#Lower numbers mean higher quality and a larger output file size. A sane range is 18 to 28.
	ffmpeg -i "$file" $VIDEO_CONFIG $AUDIO_CONFIG -threads 8 "$OUTPUT_DIR/_$file.mp4"
	
	#mover archivo raw (de fraps) a una carpeta de archivos ya procesados
	mv "$file" "$RAW_DIR"
done;

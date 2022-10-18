#!/bin/bash
#########################################################
# File Name: ffmpeg.sh
# Author : nudimannui4e
# Email: nudimannui4e@protonmail.com
# Created Time: Вт 18 окт 2022 22:27:52
# desc: Script for concatinate all video_file to one file
#########################################################

FILE_LIST='list.txt'
DATE=$(date +'%d-%m-%Y')
OUTPUT_FILE=$DATE.MOV

# find all media on SD-CARD
# create list for ffmpeg format
find /media/*/ADVOCAM/MOVIE -type f -printf "file '%p'\n" | sort > $FILE_LIST

if [[ -f $FILE_LIST ]]; then
	echo "Created a $FILE_LIST"
	echo "Start concating video? [Yy|Nn]"
	read -r ans
		case $ans in
			y|Y) ffmpeg -safe 0 -f concat -i $FILE_LIST -c copy $OUTPUT_FILE
				;;
			n|N) echo "You list for ffmpeg place to $FILE_LIST"
				;;
		esac
else
	echo "Failed to create $FILE_LIST..."
	echo "check mount of SD-card."
fi
# concatinate all *.MOV to $OUTPUT_FILE.MOV
if [[ -f $OUTPUT_FILE ]]; then
	echo "Clear cache..."
	rm $FILE_LIST
	echo "Play $OUTPUT_FILE? [Yy|Nn]"
	read -r answer
		case $answer in
			y|Y) mpv $OUTPUT_FILE
				;;
			n|N) ls -lh $OUTPUT_FILE
				;;
		esac
    echo "Move $OUTPUT_FILE to ~/Movie"
	rsync -av $OUTPUT_FILE ~/Movie/
		if [[ -f ~/Movie/$OUTPUT_FILE ]]; then
			rm $OUTPUT_FILE
		fi
fi

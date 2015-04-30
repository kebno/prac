#!/bin/bash
# Time Lapse Status Information
#    - Get number of files
#    - Get size of image directory
#    - Get percent of storage space used
#    - Get latest image and its timestamp
#    - Copy resized version of latest image (with timestamp) to page 


IMAGE_DIR='../images'
PREVIEW_IMAGE='latest_image.jpg'

# List all image files, one per line
# Count the number of lines
Nimage=`ls -1 $IMAGE_DIR/*.jpg | wc -l`

# Show disk usage of a directory, in Megabytes
# match the number of megabytes in output
size_image_dir=`du -h -BM $IMAGE_DIR | grep -o '^[0-9]*'`

# report file system disk space usage
# assume main disk is first result of df, get the percent usage
percent_storage=`df -h | grep -o -m 1 '[0-9]\{1,2\}%'`

# Listing of jpg files sorted by modification time (latest first)
# Only keep first line
# Call 'basename' on the result
latest_image=`ls -1t $IMAGE_DIR/*.jpg | head -n 1`

# Listing of jpg files by modification time (latest first), time in ISO format
# Only keep first two lines
# Skip first line, then output 6th and 7th fields (date, time)
# Remove the decimal portion of the time
latest_image_timestamp=`ls -t --full-time $IMAGE_DIR/*.jpg | head -n 2 | awk 'NR>1 {print $6,$7}' | cut -c -19`

# Create smaller version for dashboard page
convert $latest_image -resize 640x480 -background black -fill white \
         label:"$latest_image_timestamp" -gravity west -append latest-image.jpg

# Output as JSON string #
printf '{"Nimage":"%s","size_image_dir":"%s","percent_storage":"%s"}\n' "$Nimage" "$size_image_dir" "$percent_storage"

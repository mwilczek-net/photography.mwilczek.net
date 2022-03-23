#!/bin/bash

. ./generate_new_gallery_consts.sh

newGalleryPostFileName=""
newGalleryPostFullPath=""
galleryImagesDir=""

getGalleryFileName() {
  local fileName=""

  echo "Type filename"
  read fileName

  newGalleryPostFileName=$fileName
  newGalleryPostFullPath="${GALLERY_POST_DIR}${fileName}${GALLERY_POST_EXTENSION}"
  galleryImagesDir="${GALLERY_IMAGES_DIR}${fileName}"

  echo "Gallery Post File Name:  ${newGalleryPostFileName}"
  echo "Gallery Post Full Path:  ${newGalleryPostFullPath}"
  echo "Gallery Images DIR:      ${galleryImagesDir}"
  echo
}

createGalleryFileIfNotExists() {
  if [ -f "${newGalleryPostFullPath}" ];
  then
    echo "File Exists!!"
    echo "Breaking execution"
    exit 1
  else
    echo "Creating file: ${newGalleryPostFullPath}"
    touch "${newGalleryPostFullPath}"
  fi
}

listImagesForGallery() {
  echo "Scanning for images"

  find "${galleryImagesDir}" -print0 -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' | xargs -0 -I '{}' './generate_new_gallery_listing_images.sh' '{}'
}

generateGalleryContent() {
  local generationDate=$(date +%F)

  echo "Generating file content"
  cat > "${newGalleryPostFullPath}" << EOF
---
layout: post
title: !!! GALLERY TITLE - On gallery list and on gallery !!!
summary: "!!! GALLERY SUMMARY - On gallery list under photo !!!"
date: ${generationDate}
coverPhoto: "${newGalleryPostFileName}/SELECT_COVER_PHOTO.null !!! !!!"
photos:
EOF

  listImagesForGallery >> "${newGalleryPostFullPath}"

  cat >> "${newGalleryPostFullPath}" << EOF
---

!!! GALLERY DESCRIPTION - After entering gallery !!!
!!! Set propper text                             !!!

EOF

  echo
  echo "FILE GENERATED"
  echo "AND FILLED"
  echo
}

getGalleryFileName
createGalleryFileIfNotExists
generateGalleryContent

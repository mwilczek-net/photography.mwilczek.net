#!/bin/bash

. ./generate_new_gallery_consts.sh

imageFullPath=${1}
imageInGalleryPath="${1/${GALLERY_IMAGES_DIR}/}"

echo "  \"${imageInGalleryPath}\":"
echo "    title: \"\""
echo "    description: \"\""

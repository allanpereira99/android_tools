#!/bin/bash
git clone "git@github.com:allanpereira99/release-keys.git" -b "master" "/home/$(whoami)/.android-certs"
source "build/envsetup.sh"
breakfast "platina user"
mka "target-files-package otatools"
croot
sign_target_files_apks -o -d ~/.android-certs \
    $OUT/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip \
    signed-target_files.zip

ota_from_target_files -k ~/.android-certs/releasekey \
    --block --backup=true \
    signed-target_files.zip \
    signed-ota_update.zip

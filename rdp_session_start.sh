#!/bin/bash

dir="/home/alek1t/Downloads/"

mapfile -t rdp_files < <(find "$dir" -maxdepth 1 -type f -name "*.rdp" -printf "%T@ %p\n" | sort -nr | cut -d' ' -f2-)

if [ ${#rdp_files[@]} -eq 0 ]; then
  echo "Нет .rdp файлов в директории $DIR"
  exit 1
fi

latest_session="${rdp_files[0]}"

#mv -f "${latest_session}" "${dir}latest_session.rdp"

for file in "${rdp_files[@]:1}"; do
  rm -f "$file"
done

xfreerdp "${latest_session}" /drive:shared,/home/$USER/ >/tmp/rdp_session_log.txt 2>&1 &

#!/bin/sh
set -e

clear 
mkdir -p ~/Helpers

echo
echo
echo -e "\033[1m> Info!!! $1 \033[0m"
echo
echo

cat << EOF > ~/Helpers/info.jlink
st
exit
EOF

JLinkExe -CommandFile ~/Helpers/info.jlink

rm -rf ~/Helpers/

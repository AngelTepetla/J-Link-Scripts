#!/bin/sh
set -e

clear 
mkdir -p ~/Helpers

if [[ $1 == 'on' ]]; then
   echo
   echo -e "\033[1m> Power!!! $1 \033[0m"
   echo
elif [[ $1 == 'off' ]]; then
   echo
   echo -e "\033[1m> Power!!! $1 \033[0m"
   echo
else
   echo
   echo
   echo -e "\033[1m> Unsupported Option!!!\033[0m"
   echo
   echo -e "\033[1m> Choose only between: on, off \033[0m"
   echo
   exit 1
fi

cat << EOF > ~/Helpers/power.jlink
power $1
exit
EOF

JLinkExe -CommandFile ~/Helpers/power.jlink

cat << EOF > ~/Helpers/info.jlink
st
exit
EOF

JLinkExe -CommandFile ~/Helpers/info.jlink

echo -e "\033[1m> Power!!! $1 \033[0m"
echo

rm -rf ~/Helpers/

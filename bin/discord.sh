#!/compat/linux/bin/sh

mkdir -p ~/software
cd ~/software

if [ ! -d Discord ]; then
    curl -L 'https://discord.com/api/download?platform=linux&format=tar.gz' | tar xzf -
fi

cd Discord

#PA_SOCK_PATH=$(sockstat | awk -v me=$(whoami) -F'[ \t]+' '$1 == me && $2 == "pulseaudio" && $6 ~ /native/ { print $6; exit 0 }')
#export PULSE_SERVER=unix:${PA_SOCK_PATH}

#/usr/bin/env LD_LIBRARY_PATH=/usr/local/steam-utils/lib64/fakeudev:/compat/linux/lib64/nss ./Discord --no-sandbox --no-zygote --in-process-gpu --v=0 "$@"
/usr/bin/env LD_LIBRARY_PATH=/usr/local/steam-utils/lib64/fakeudev:/compat/linux/lib64/nss ./Discord --no-sandbox --no-zygote --in-process-gpu --v=0 "$@"

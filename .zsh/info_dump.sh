function -info-dump() {
  local IP ISP BATT DISCHARGE_RATE UNTIL_EMPTY
  local ISP_MESSAGE CHARGE_DISCHARGE_MESSAGE EMPTY_MESSAGE

  IP="$(timeout 1s curl -s 'http://da.gd/ip?strip')"
  ISP="$(timeout 1s curl -s 'http://da.gd/isp?strip')"
  if [ -n "$IP" ]; then
    if [ -n "$ISP" ]; then
      ISP_MESSAGE=" (${ISP})"
    fi
    echo -e "External IP: \\e[32;1m${IP}\\e[m${ISP_MESSAGE}"
  fi

  if timeout 1s upower -e | grep -q battery 2>/dev/null; then
    BATT=$(timeout 1s upower -i $(upower -e | grep battery) | grep ':' | grep -E '^ ' | awk 'BEGIN { FS = " "; ORS = "\\0" } { print $(1) " " $(2) " " $(3) " " $(4) " " $(5) }')
    DISCHARGE_RATE="$(echo -e $BATT | grep -z state | cut -d " " -f 2) at $(echo -e $BATT | grep -z energy-rate | cut -d " " -f 2,3)"
    UNTIL_EMPTY="$(echo -e $BATT | grep -z 'time to' | cut -d " " -f 4,5) $(echo -e $BATT | grep -z 'time to' | cut -d " " -f 2,3 | head -c -2)"

    if [[ "${DISCHARGE_RATE}" =~ "^fully-charged " ]]; then
      CHARGE_DISCHARGE_MESSAGE="fully charged"
    else
      CHARGE_DISCHARGE_MESSAGE="${DISCHARGE_RATE}"
      if [ -n "${UNTIL_EMPTY}" ]; then
        EMPTY_MESSAGE=" (${UNTIL_EMPTY})"
      fi
    fi

    echo "Battery ${CHARGE_DISCHARGE_MESSAGE}${EMPTY_MESSAGE}."
  fi
}

-info-dump

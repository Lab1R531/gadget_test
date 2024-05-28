#!/bin/bash
echo -n

sudo apt-get clean

#sudo service open5gs-amfd restart
#sudo service open5gs-upfd restart
#sudo service open5gs-nrfd restart

for var in $(compgen -e | grep -E "^NTN_|^T_|^PDCP_T"); do
    unset $var
done


echo "performance" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

echo "Running gNB 5G NTN"

export NTN_N_TA_COMMON=0

export NTN_N_TA_UE_SPECIFIC=0
export NTN_EXT_RTT_SLOTS=0
export NTN_EXT_RTT_MS=0
export NTN_RA_RESPONSE_WINDOW_TIMER_INCREMENT=560
export NTN_RA_RESPONSE_WINDOW_SLOT_START_INCREMENT=0
export NTN_RA_RESPONSE_WINDOW_SLOT_LENGTH_INCREMENT=0
export NTN_RA_CONTENTION_RESOLUTION_TIMER_INCREMENT=560
export NTN_T_REASSEMBLY_TIMER_INCREMENT=0
export NTN_DISCARD_TIMER_INCREMENT=0
export NTN_T_REORDERING_TIMER_INCREMENT=0

#set environment vars (default values)
export PDCP_T_REORDERING_5QI7=100
export PDCP_T_REORDERING_5QI9=220
export T_REASSEMBLY_5QI7=90
export T_REASSEMBLY_5QI9=90
export T_REASSEMBLY_RLC_CONF=35
export T_REASSEMBLY_SRB1_CONF=35
export NTN_KOFFSET=0

sudo -E ../5G/build/apps/gnb/gnb -c ../config/GNB_NTN.yaml


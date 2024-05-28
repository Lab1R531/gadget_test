#!/bin/bash
echo -n

sudo apt-get clean

for var in $(compgen -e | grep -E "^NTN_|^T_|^PDCP_T");do
    unset $var
done

echo "performance" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

echo "Running UE 5G NTN.."

Tc=$(bc <<< "scale=4; 10^9/(480000*4096)")
Ts=$(bc <<< "scale=4; 64*$Tc")
Tm=$(bc <<< "scale=4; 8*$Tc")

Tot_Delay_ns=0
TA=$(bc <<< "scale=0; $Tot_Delay_ns/$Ts")

echo "Tot_Delay_ns: $Tot_Delay_ns"
echo "TA: $TA"

export NTN_N_TA_COMMON="$TA"

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

#export NTN_KOFFSET=0
#export PDCP_T_REORDERING_5QI7=100
#export PDCP_T_REORDERING_5QI9=220
#export T_REASSEMBLY_5QI7=90
#export T_REASSEMBLY_5QI9=90
#export T_REASSEMBLY_RLC_CONF=35
#export T_REASSEMBLY_SRB1_CONF=35

sudo -E ../4G/build/srsue/src/srsue ../config/UE_NTN.conf
       

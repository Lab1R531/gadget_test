#!/bin/bash
echo -n
sudo apt-get clean

### PERFORMANCE ###
#set_performance_governor
echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor > /dev/null
#set_kms_polling
echo N | sudo tee /sys/module/drm_kms_helper/parameters/poll > /dev/null
#set_network_buffers
sudo sysctl -w net.core.wmem_max=33554432
sudo sysctl -w net.core.rmem_max=33554432
sudo sysctl -w net.core.wmem_default=33554432
sudo sysctl -w net.core.rmem_default=33554432


### UNSET NTN VARIABLES ###
for var in $(compgen -e | grep -E "^NTN_|^T_|^PDCP_T"); do
    unset $var
done


####################################################################################
####################################################################################
####################################################################################


echo "Running gNB 5G NTN"
   
#export NTN_N_TA_COMMON=0

#export NTN_N_TA_UE_SPECIFIC=0
#export NTN_EXT_RTT_SLOTS=0
#export NTN_EXT_RTT_MS=0
#export NTN_RA_RESPONSE_WINDOW_TIMER_INCREMENT=560
#export NTN_RA_RESPONSE_WINDOW_SLOT_START_INCREMENT=0
#export NTN_RA_RESPONSE_WINDOW_SLOT_LENGTH_INCREMENT=0
#export NTN_RA_CONTENTION_RESOLUTION_TIMER_INCREMENT=560
#export NTN_T_REASSEMBLY_TIMER_INCREMENT=0
#export NTN_DISCARD_TIMER_INCREMENT=0
#export NTN_T_REORDERING_TIMER_INCREMENT=0

#set environment vars (default values)
#export PDCP_T_REORDERING_5QI7=100
#export PDCP_T_REORDERING_5QI9=220
#export T_REASSEMBLY_5QI7=90
#export T_REASSEMBLY_5QI9=90
#export T_REASSEMBLY_RLC_CONF=35
#export T_REASSEMBLY_SRB1_CONF=35
#export NTN_KOFFSET=0


#export NTN_KOFFSET="$rtt_ms"
#export NTN_EXT_RTT_MS="$rtt_ms"

#export T_REASSEMBLY_RLC_CONF=2200
#export T_REASSEMBLY_SRB1_CONF=2200
#export T_REASSEMBLY_5QI7=2200
#export T_REASSEMBLY_5QI9=2200
#export PDCP_T_REORDERING_5QI7=3000
#export PDCP_T_REORDERING_5QI9=3000

#export NTN_KOFFSET=2000
#export NTN_RA_RESPONSE_WINDOW_SLOT_LENGTH_INCREMENT=520

#export NTN_RA_RESPONSE_WINDOW_TIMER_INCREMENT=200
#export NTN_RA_RESPONSE_WINDOW_SLOT_START_INCREMENT=200
#export NTN_RA_RESPONSE_WINDOW_SLOT_LENGTH_INCREMENT=200


####################################################################################
####################################################################################
####################################################################################


if [ "$#" -eq 0 ]; then
    rtt_ms=0
else
    # Estrai il valore dall'argomento
    rtt_ms=$(echo $1 | sed 's/^--//')
    #export NTN_T_REORDERING_TIMER_INCREMENT=2200
    #export NTN_T_REASSEMBLY_TIMER_INCREMENT=2200
    #export NTN_DISCARD_TIMER_INCREMENT=2200
fi

title_length=30
text="rtt_ms=$rtt_ms"
padding=$(( (title_length - ${#text}) / 2 ))
printf "\n\n          "
printf "*%.0s" $(seq 1 $title_length)
printf "**\n          *"
printf " %.0s" $(seq 1 $padding)
printf "$text"
printf " %.0s" $(seq 1 $padding)
printf "*\n          "
printf "*%.0s" $(seq 1 $title_length)
printf "**\n\n"


# Inizializza la variabile x con il valore estratto o di default
x=$rtt_ms
y=$(echo "$rtt_ms / 2" | bc)

#export NTN_KOFFSET="$x"
#export NTN_RA_RESPONSE_WINDOW_SLOT_START_INCREMENT="$y"
#export NTN_RA_RESPONSE_WINDOW_SLOT_LENGTH_INCREMENT="$y"

sudo -E ../build/apps/gnb/gnb -c gnb_zmq_config.yaml


#!/bin/bash
echo -n

sudo apt-get clean

for var in $(compgen -e | grep -E "^NTN_|^T_|^PDCP_T");do
    unset $var
done

echo "performance" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

echo "Running UE 5G NTN.."

#Tc=$(bc <<< "scale=4; 10^9/(480000*4096)")
#Ts=$(bc <<< "scale=4; 64*$Tc")
#Tm=$(bc <<< "scale=4; 8*$Tc")

## UTILIZZATI ##
#export NTN_N_TA_COMMON=0
#export NTN_N_TA_UE_SPECIFIC=0
#export NTN_EXT_RTT_SLOTS=0
#export NTN_EXT_RTT_MS=0
#export NTN_RA_RESPONSE_WINDOW_TIMER_INCREMENT=560
#export NTN_RA_RESPONSE_WINDOW_SLOT_START_INCREMENT=0
#export NTN_RA_RESPONSE_WINDOW_SLOT_LENGTH_INCREMENT=0
#export NTN_RA_CONTENTION_RESOLUTION_TIMER_INCREMENT=560
#export NTN_T_REORDERING_TIMER_INCREMENT=0
#export NTN_KOFFSET=520

## NON USATI ##
#export NTN_T_REASSEMBLY_TIMER_INCREMENT=0
#export NTN_DISCARD_TIMER_INCREMENT=0
#export PDCP_T_REORDERING_5QI7=100
#export PDCP_T_REORDERING_5QI9=220
#export T_REASSEMBLY_5QI7=90
#export T_REASSEMBLY_5QI9=90
#export T_REASSEMBLY_RLC_CONF=35
#export T_REASSEMBLY_SRB1_CONF=35

#############################################################################################
###########################################        ##########################################
###########################################  TEST  ##########################################
###########################################        ##########################################
#############################################################################################

#export NTN_N_TA_UE_SPECIFIC=0
#export NTN_EXT_RTT_SLOTS=0
#export NTN_EXT_RTT_MS="$rtt_ms_int"

#export NTN_RA_RESPONSE_WINDOW_TIMER_INCREMENT=2000
#export NTN_RA_RESPONSE_WINDOW_SLOT_START_INCREMENT=0
#export NTN_RA_RESPONSE_WINDOW_SLOT_LENGTH_INCREMENT=0
#export NTN_RA_CONTENTION_RESOLUTION_TIMER_INCREMENT="$rtt_ms_int"
#export NTN_T_REORDERING_TIMER_INCREMENT=3000
#export NTN_KOFFSET="$rtt_ms_int"

#export NTN_EXT_RTT_MS=0
#export NTN_RA_CONTENTION_RESOLUTION_TIMER_INCREMENT=0
#export NTN_KOFFSET=0

# [LO] this extend the timer (rar_timeout_timer) which start after the SEND OF THE PRACH (MSG1) directed to the GNB
# [LO] I suppose the UE could not detect RAR message (MSG2) from GNB if it (rar_timeout_timer) expires 


if [ "$#" -eq 0 ]; then
    rtt_ms=0
else
    # Estrai il valore dall'argomento
    rtt_ms=$(echo $1 | sed 's/^--//')
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
z=$(echo "$rtt_ms * 30720" | bc)
w=$(echo "$rtt_ms * 30720 / 2" | bc)
export NTN_RTT_MS="$x"


# MSG 2 RX Window
export NTN_RA_RESPONSE_WINDOW_TIMER_INCREMENT="$x"
export NTN_RA_RESPONSE_WINDOW_SLOT_START_INCREMENT="$y"
export NTN_RA_RESPONSE_WINDOW_SLOT_LENGTH_INCREMENT="$y"

# MSG 4 RX Window
export NTN_RA_CONTENTION_RESOLUTION_TIMER_INCREMENT="$x"

# TA COMMON SET
#export NTN_N_TA_COMMON="$z"


#export NTN_T_REORDERING_TIMER_INCREMENT=2200



sudo -E ../build/srsue/src/srsue ue_1_config.conf
#sudo -E /home/gadget1/Downloads/gadget_test/4G/build/srsue/src/srsue ue_config.conf
       

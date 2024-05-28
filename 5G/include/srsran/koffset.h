#pragma once
#include <stdint.h>

/* DCD temporarily stored in lib/srslog/srslog.cpp */
#define DEFAULT_NTN_KOFFSET 0
extern uint16_t NTN_KOFFSET;

// massage CSI-RS around Koffset for TDD slots
#define FIX_CSI_RS_KOFFSET(x) (((x)+NTN_KOFFSET)%10 < 5 ? (x) : (x) + 5)

/* override default values for t-PollRetransmit */
#define ADJUST_T_POLL_RETX_FOR_KOFFSET(x) ( \
        (NTN_KOFFSET <= 40) ? 45 : \
        (NTN_KOFFSET <= 95) ? 100 :  \
        (NTN_KOFFSET <= 195) ? 200 :  \
        (NTN_KOFFSET <= 295) ? 300 :  \
        (NTN_KOFFSET <= 395) ? 400 :  \
        (NTN_KOFFSET <= 495) ? 500 :  \
        (NTN_KOFFSET <= 795) ? 800 :  \
        (NTN_KOFFSET <= 995) ? 1000 : 2000 )

#define ADJUST_T_POLL_RETX_ENUM_FOR_KOFFSET(x) ( \
        (NTN_KOFFSET <= 40) ? t_poll_retx_opts::ms45 : \
        (NTN_KOFFSET <= 95) ? t_poll_retx_opts::ms100 :  \
        (NTN_KOFFSET <= 195) ? t_poll_retx_opts::ms200 :  \
        (NTN_KOFFSET <= 295) ? t_poll_retx_opts::ms300 :  \
        (NTN_KOFFSET <= 395) ? t_poll_retx_opts::ms400 :  \
        (NTN_KOFFSET <= 495) ? t_poll_retx_opts::ms500 :  \
        (NTN_KOFFSET <= 795) ? t_poll_retx_opts::ms800 :  \
        (NTN_KOFFSET <= 995) ? t_poll_retx_opts::ms1000 : t_poll_retx_opts::ms2000 )

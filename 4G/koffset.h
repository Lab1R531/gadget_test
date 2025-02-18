#pragma once
#include <stdint.h>

/* DCD temporarily stored in lib/src/phy/phch/csi.c (libsrsran_phy.a) */
#define DEFAULT_NTN_KOFFSET 0
extern uint16_t NTN_KOFFSET;
extern unsigned int ntn_rtt_ms;        // [GAD]. RTT inserito via command line

/* TODO an optimized version would account for the maximum values of
   k0, k1, k2 and msg3 as in get_allocator_ring_size_gt_min() from the
   5G version. For now, let's stick to the size that fits any Koffset. */
#define KOFFSET_SZ  2048
#define GAD_RTT ntn_rtt_ms
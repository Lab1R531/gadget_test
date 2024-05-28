/**
 * Copyright 2013-2023 Software Radio Systems Limited
 *
 * This file is part of srsRAN.
 *
 * srsRAN is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of
 * the License, or (at your option) any later version.
 *
 * srsRAN is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * A copy of the GNU Affero General Public License can be found in
 * the LICENSE file in the top-level directory of this distribution
 * and at http://www.gnu.org/licenses/.
 *
 */

#include "srsran/version.h"

//#define SRSRAN_LTE_TS (1.0f / (480000.0f * 4096.0f))
#define SRSRAN_LTE_TS (1.0f / (15000.0f * 2048.0f))                                         // SW-MOD_A-50
#define RTT_MS_TO_SLOTS(rtt_ts) ((unsigned int)((((float)rtt_ts) / 1e3f) / SRSRAN_LTE_TS))  // SW-MOD_A-50

unsigned int ntn_n_ta_common = 0;                               // SW-MOD_A-30
unsigned int ntn_n_ta_ue_specific = 0;                          // SW-MOD_A-30
unsigned int ntn_extended_rtt_ms    = 0;                        // SW-MOD_A-50  
unsigned int ntn_extended_rtt_slots = 0;                        // SW-MOD_A-50
unsigned int ntn_ra_response_window_timer_increment = 0;        // SW-MOD_A-50
unsigned int ntn_ra_response_window_slot_start_increment = 0;   // SW-MOD_A-50
unsigned int ntn_ra_response_window_slot_length_increment = 0;  // SW-MOD_A-50
unsigned int ntn_ra_contention_resolution_timer_increment = 0;  // SW-MOD_A-50
unsigned int ntn_t_reassembly_timer_increment = 0;              // SW-MOD_A-50
unsigned int ntn_discard_timer_increment = 0;                   // SW-MOD_A-50
unsigned int ntn_t_reordering_timer_increment = 0;              // SW-MOD_A-50

char* srsran_get_version()
{
  return SRSRAN_VERSION_STRING;
}

int srsran_get_version_major()
{
  return SRSRAN_VERSION_MAJOR;
}
int srsran_get_version_minor()
{
  return SRSRAN_VERSION_MINOR;
}
int srsran_get_version_patch()
{
  return SRSRAN_VERSION_PATCH;
}

int srsran_check_version(int major, int minor, int patch)
{
  return (SRSRAN_VERSION >= SRSRAN_VERSION_ENCODE(major, minor, patch));
}

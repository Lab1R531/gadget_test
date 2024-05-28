/*
 *
 * Copyright 2021-2023 Software Radio Systems Limited
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

#pragma once

#include "cu_cp_configuration.h"
#include "srsran/ngap/ngap_configuration_helpers.h"

namespace srsran {
namespace config_helpers {

/// Generates default cell configuration used by gNB DU. The default configuration should be valid.
inline srs_cu_cp::cu_cp_configuration make_default_cu_cp_config()
{
  srs_cu_cp::cu_cp_configuration cfg{};
  cfg.ngap_config = make_default_ngap_config();
  return cfg;
}

/// Generates default QoS configuration used by gNB CU-CP. The default configuration should be valid.
/// Dependencies between timers should be considered:
///   * t-Reordering: How long the PDCP will wait for an out-of-order PDU. When using RLC UM,
///                   this value should be larger than the RLC's t-Reassembly. When using AM,
///                   this value should be larger than a few RLC retransmissions, see the RLC
///                   timers for details.

// SW-MOD_A-40
// Reads t_reordering value for 5QI7 from environment variable
const pdcp_t_reordering DEFAULT_PDCP_T_REORDERING_5QI7= pdcp_t_reordering::ms100; // srs default
static pdcp_t_reordering read_pdcp_5qi7_t_reordering_env_var(){
  pdcp_t_reordering result = DEFAULT_PDCP_T_REORDERING_5QI7;
  const char* str = std::getenv("PDCP_T_REORDERING_5QI7");
  if (str != nullptr){
    uint16_t int_result = (uint16_t)strtol(str, NULL, 10);
    bool valid = pdcp_t_reordering_from_int(result, int_result); //side-effect on result
    if (valid){
      printf("[GAD] read PDCP_T_REORDERING_5QI7 = %d from env var PDCP_T_REORDERING_5QI7\n", pdcp_t_reordering_to_int(result));
      printf("[GAD] warning: value is valid but may be inconsistent with other (e.g., RLC's t-reassembly)\n");
    }
    return result;
  }
  printf("[GAD] Using default PDCP_T_REORDERING_5QI7 value %d\n", pdcp_t_reordering_to_int(result));
  return result;
}

// Reads t_reordering value for 5QI9 from environment variable
const pdcp_t_reordering DEFAULT_PDCP_T_REORDERING_5QI9= pdcp_t_reordering::ms220; // srs default
static pdcp_t_reordering read_pdcp_5qi9_t_reordering_env_var(){
  pdcp_t_reordering result = DEFAULT_PDCP_T_REORDERING_5QI9;
  const char* str = std::getenv("PDCP_T_REORDERING_5QI9");
  if (str != nullptr){
    uint16_t int_result = (uint16_t)strtol(str, NULL, 10);
    bool valid = pdcp_t_reordering_from_int(result, int_result); //side-effect on result
    if (valid){
      printf("[GAD] read PDCP_T_REORDERING_5QI9 = %d from env var PDCP_T_REORDERING_5QI9\n", pdcp_t_reordering_to_int(result));
      printf("[GAD] warning: value is valid but may be inconsistent with other (e.g., RLC's t-reassembly)\n");
    }
    return result;
  }
  printf("[GAD] Using default PDCP_T_REORDERING_5QI9 value %d\n", pdcp_t_reordering_to_int(result));
  return result;
}
// End of SW-MOD_A-40



inline std::map<five_qi_t, srs_cu_cp::cu_cp_qos_config> make_default_cu_cp_qos_config_list()
{
  std::map<five_qi_t, srs_cu_cp::cu_cp_qos_config> qos_list = {};
  {
    // 5QI=7
    srs_cu_cp::cu_cp_qos_config cfg{};
    pdcp_config                 pdcp_cfg{};

    pdcp_cfg.rb_type                       = pdcp_rb_type::drb;
    pdcp_cfg.rlc_mode                      = pdcp_rlc_mode::um;
    pdcp_cfg.ciphering_required            = true;
    pdcp_cfg.integrity_protection_required = false;

    // > Tx
    pdcp_cfg.tx.sn_size                = pdcp_sn_size::size12bits;
    pdcp_cfg.tx.discard_timer          = pdcp_discard_timer::infinity;
    pdcp_cfg.tx.status_report_required = false;

    // > Rx
    pdcp_cfg.rx.sn_size               = pdcp_sn_size::size12bits;
    pdcp_cfg.rx.out_of_order_delivery = false;
    //SW-MOD_A-40
    // pdcp_cfg.rx.t_reordering          = pdcp_t_reordering::ms100; // srs default
    pdcp_cfg.rx.t_reordering          = read_pdcp_5qi7_t_reordering_env_var();
    //End of SW-MOD_A-40


    cfg.pdcp                     = pdcp_cfg;
    qos_list[uint_to_five_qi(7)] = cfg;
  }
  {
    // 5QI=9
    srs_cu_cp::cu_cp_qos_config cfg{};
    pdcp_config                 pdcp_cfg{};

    pdcp_cfg.rb_type                       = pdcp_rb_type::drb;
    pdcp_cfg.rlc_mode                      = pdcp_rlc_mode::am;
    pdcp_cfg.ciphering_required            = true;
    pdcp_cfg.integrity_protection_required = false;

    // > Tx
    pdcp_cfg.tx.sn_size                = pdcp_sn_size::size12bits;
    pdcp_cfg.tx.discard_timer          = pdcp_discard_timer::infinity;
    pdcp_cfg.tx.status_report_required = false;

    // > Rx
    pdcp_cfg.rx.sn_size               = pdcp_sn_size::size12bits;
    pdcp_cfg.rx.out_of_order_delivery = false;
    //SW-MOD_A-40
    // pdcp_cfg.rx.t_reordering          = pdcp_t_reordering::ms220; // srs default
    pdcp_cfg.rx.t_reordering          = read_pdcp_5qi9_t_reordering_env_var();
    // End of SW-MOD_A-40
    cfg.pdcp                     = pdcp_cfg;
    qos_list[uint_to_five_qi(9)] = cfg;
  }
  return qos_list;
}

/// Returns true if the given CU-CP configuration is valid, otherwise false.
inline bool is_valid_configuration(const srs_cu_cp::cu_cp_configuration& config)
{
  // Notifiers aren't checked here.
  if (!is_valid_configuration(config.ngap_config)) {
    fmt::print("Invalid NGAP configuration.\n");
    return false;
  }

  return true;
}

} // namespace config_helpers
} // namespace srsran

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

namespace srsran {

/// \brief Retrieves the resource grid allocator ring size greater than given minimum value.
/// \remark 1. The implementation of circular ring based resource allocator only works correctly if we set a
/// ring size which satisfies the condition NOF_SLOTS_PER_SYSTEM_FRAME % RING_ALLOCATOR_SIZE = 0.
/// The condition is placed to avoid misalignment between (last_slot_ind + slot_delay) slot point and
/// slot point contained in ((last_slot_ind + slot_delay) % RING_ALLOCATOR_SIZE) slot, which occurs when slot point is
/// close to NOF_SLOTS_PER_SYSTEM_FRAME value.
/// Misalignment example: Assume NOF_SLOTS_PER_SYSTEM_FRAME = 10240 and RING_ALLOCATOR_SIZE = 37
/// At Slot point (10238) % 37 = Element at index 26 of slots array/vector is accessed, similarly
/// Slot point (10239) % 37 = 27
/// Now, Slot point wraps around NOF_SLOTS_PER_SYSTEM_FRAME and is set to 0, this causes Slot point (0) % 37 = 0.
/// Resulting in element at index 0 of slots array/vector being accessed rather than index 28.
/// \remark 2. The reason for choosing values 20, 40 and 80 for RING_ALLOCATOR_SIZE is because it holds the condition
/// NOF_SLOTS_PER_SYSTEM_FRAME % RING_ALLOCATOR_SIZE = 0. for all numerologies.
constexpr inline unsigned get_allocator_ring_size_gt_min(unsigned minimum_value)
{
  if (minimum_value < 20) {
    return 20;
  }
  if (minimum_value < 40) {
    return 40;
  }
  /* DCD account for Koffset - default of return 80 is no longer okay */
  /* Based on include/srsran/ran/slot_point.h we can desume that nof_slots_per_system_frame()
   * will return nof_slots_per_frame() * NOF_SFNS, with the latter being 1024U. The former
   * returns of_slots_per_subframe() * NOF_SUBFRAMES_PER_FRAME, with the latter being 10U.
   * I am assuming that 1024 is a safe value and, pending validation, that 2048 is too. */
  if (minimum_value < 256) {
    return 256;
  }

  if (minimum_value < 512) {
    return 512;
  }

  if (minimum_value < 1024) {
    return 1024;
  }

  srsran_assert(minimum_value < 2048, "Requesting too many slots for ring allocator {}", minimum_value);
  return 2048;
}

} // namespace srsran

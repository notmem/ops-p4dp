/* Copyright 2013-present Barefoot Networks, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/*
 * Antonin Bas (antonin@barefootnetworks.com)
 *
 */

#include <cassert>

#include "bm_sim/conditionals.h"
#include "bm_sim/event_logger.h"

const ControlFlowNode *Conditional::operator()(Packet *pkt) const
{
  PHV *phv = pkt->get_phv();
  bool result = eval(*phv);
  ELOGGER->condition_eval(*pkt, *this, result);
  return result ? true_next : false_next;
}

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

#ifndef _BM_PACKET_HANDLER_H_
#define _BM_PACKET_HANDLER_H_

class PacketDispatcherInterface
{
public:
  typedef std::function<void(int port_num, const char *buffer, int len, void* cookie)> PacketHandler;
  enum class ReturnCode {
   SUCCESS,
   ERROR
  };
    
  virtual ReturnCode set_packet_handler(PacketHandler handler, void* cookie) = 0;
};

class PacketReceiverInterface
{
public:
  virtual void send_packet(int port_num, const char* buffer, int len) = 0;
};

#endif

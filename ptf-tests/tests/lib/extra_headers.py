# Copyright 2020-2021 Open Networking Foundation
# Copyright 2021-present Princeton University
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

from scapy.fields import BitField
from scapy.packet import bind_layers, Packet
from scapy.layers.l2 import Ether


class CpuHeader(Packet):
    name = "CpuHeader"
    fields_desc = [
        BitField("port_num", 0, 9),
        BitField("padding", 0, 7),
    ]


bind_layers(CpuHeader, Ether)

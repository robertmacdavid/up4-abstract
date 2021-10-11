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

PTF_BMV2_IMAGE		:= opennetworking/p4mn:latest@sha256:50c2f414ab2145ee18771af0fcc8f07044dd7b5ab3b68398088b119507cac0f2
P4C_IMAGE 			:= opennetworking/p4c:stable-20210108@sha256:1d36990cdb9b804dd63b41ded32c85f906ec3a38112e93c55443663d496bcf6d
PTF_IMAGE 			:= stratumproject/testvectors:ptf-py3@sha256:bf404361ea5a7a102a30a9d1f36e4b614f586951fc72e1f7e982801270baac70
MN_STRATUM_IMAGE 	:= opennetworking/mn-stratum:latest@sha256:5f53ea1c5784ca89753e7a23ae64d52fe39371f9e0ac218883bc28864c37e373

MKFILE_PATH			:= $(abspath $(lastword $(MAKEFILE_LIST)))
CURRENT_DIR			:= $(patsubst %/,%,$(dir $(MKFILE_PATH)))
main_file			:= p4src/main.p4

default: deps build check

_docker_pull_all:
	docker pull ${P4C_IMAGE}
	docker pull ${PTF_IMAGE}
	docker pull ${PTF_BMV2_IMAGE}

deps: _docker_pull_all
	python3.9 -m pip install -r requirements.txt

build: ${main_file}
	$(info *** Building P4 program...)
	@mkdir -p p4src/build
	docker run --rm -v ${CURRENT_DIR}:/workdir -w /workdir ${P4C_IMAGE} \
		p4c-bm2-ss ${P4C_FLAGS} --arch v1model -o p4src/build/bmv2.json \
		--p4runtime-files p4src/build/p4info.txt,p4src/build/p4info.bin \
		--Wdisable=unsupported \
		${main_file}
	@echo "*** P4 program compiled successfully! Output files are in p4src/build"


check:
	@cd ptf-tests && PTF_IMAGE=$(PTF_IMAGE) PTF_BMV2_IMAGE=$(PTF_BMV2_IMAGE) ./run_tests ${PTF_TEST_PARAMS} $(TEST)

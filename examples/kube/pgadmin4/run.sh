#!/bin/bash
# Copyright 2018 Crunchy Data Solutions, Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.



DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$DIR/cleanup.sh
DATADIR=$PV_PATH/pgadmin4

if [ ! -d "$DATADIR" ]; then
	echo "Setting up pgadmin4 data directory..."
	sudo mkdir $DATADIR
	sudo cp $CCPROOT/conf/pgadmin4/config_local.py $DATADIR
	sudo cp $CCPROOT/conf/pgadmin4/pgadmin4.db $DATADIR
	sudo chmod -R 777 $DATADIR
fi

kubectl create -f $DIR/pgadmin4-service.json
expenv -f $DIR/pgadmin4-pod.json | kubectl create -f -

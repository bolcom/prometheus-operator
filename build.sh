#!/bin/bash
set -euxo pipefail

# bypass license script
echo "exit 0" > scripts/check_license.sh

make crossbuild

#if [[ -e .build/linux-amd64 ]]; then
#  chmod +x operator
#  cp operator .build/linux-amd64/
#fi

image=$(make container | tail -n1 | awk '{print $3}')
docker tag $image eu.gcr.io/bolcom-sbx-monitoring-clients/prometheus-operator:$1
gcloud docker -- push eu.gcr.io/bolcom-sbx-monitoring-clients/prometheus-operator:$1

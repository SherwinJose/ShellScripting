#!/bin/bash

#!/bin/bash

INSTANCE_NAME=$1
if [ -z "${INSTANCE_NAME}" ]; then
  echo -e "Instance Name Argument is needed"
  exit
fi
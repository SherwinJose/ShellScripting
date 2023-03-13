#!/bin/bash

#!/bin/bash

INSTANCE_NAME=$1
if [ -z "${INSTANCE_NAME}" ]; then
  echo -e "Instance Name Argument is needed"
  exit
fi

AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=Centos-7-DevOps-Practice" --query 'Images[*].[ImageId]' --output text)

if [ -z "${AMI_ID}" ]; then
  echo -e "Unable to find Image AMI_ID"
  exit
  else
    echo -e "\e[1;32mAMI ID = ${AMI_ID}\e[0m"
  fi
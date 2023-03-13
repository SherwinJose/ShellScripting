#!/bin/bash

#!/bin/bash

INSTANCE_NAME=$1
if [ -z "${INSTANCE_NAME}" ]; then
  echo -e "Instance Name Argument is needed"
  exit
fi
AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=Centos-7-DevOps-Practice" --query 'Images[*].[ImageId]' --output text)
if [ -z "${AMI_ID}" ]; then
  echo  "Unable to find Image AMI_ID"
  exit
  else
    echo  "AMI ID = ${AMI_ID}"
  fi
aws ec2 describe-instances --filters "Name=tag:Name,Values=${INSTANCE_NAME}" --query 'Reservations[*].Instances[*].PrivateIpAddress' --output text
if [ -z "${PRIVATE_IP}" ]; then
  SG_ID=$(aws ec2 describe-security-groups --filter Name=group-name,Values=Devops_practice --query "SecurityGroups[*].GroupId" --output text)


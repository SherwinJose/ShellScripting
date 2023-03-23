#!/bin/bash

#!/bin/bash
LOG=/tmp/instance-create.log
rm -f $LOG

if [ "$1" == "list" ]; then #if the first arguments is givens as list
  aws ec2 describe-instances  --query "Reservations[*].Instances[*].{PrivateIP:PrivateIpAddress,PublicIP:PublicIpAddress,Name:Tags[?Key=='Name']|[0].Value,Status:State.Name}"  --output table
  exit                                                                                                                             ##The Above AWS command will Gives us the detailed information about the EC2 instances that are running with status and their public and private IPs
fi

INSTANCE_NAME=$1


if [ -z "${INSTANCE_NAME}" ]; then                                                                                                 ##if instance name is passed as a arguments or not validation
  echo -e "Instance Name Argument is needed"
  exit
fi
AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=Centos-7-DevOps-Practice" --query 'Images[*].[ImageId]' --output text) ##aws command for getting the AMI_ID for the customAMI Centos-7-DevOps-Practice
if [ -z "${AMI_ID}" ]; then
  echo  "Unable to find Image AMI_ID"
  exit
  else
    echo  "AMI = ${AMI_ID}"
  fi
PRIVATE_IP=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${INSTANCE_NAME}" --query 'Reservations[*].Instances[*].PrivateIpAddress' --output text)   ##aws command for fetching the private IP of the

if [ -z "${PRIVATE_IP}" ]; then
  # Find Security Group
  SG_ID=$(aws ec2 describe-security-groups --filter Name=group-name,Values=Devops_practice --query "SecurityGroups[*].GroupId" --output text)
if [ -z "${SG_ID}" ]; then
      echo "Security Group Devops_practice does not exist"
      exit
 fi
  aws ec2 run-instances --image-id ${AMI_ID} --instance-type t3.micro --output text --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${INSTANCE_NAME}}]" "ResourceType=spot-instances-request,Tags=[{Key=Name,Value=${INSTANCE_NAME}}]"  --instance-market-options "MarketType=spot,SpotOptions={InstanceInterruptionBehavior=stop,SpotInstanceType=persistent}" --security-group-ids "${SG_ID}"  &>>$LOG
  echo  " Instance Created"
else
  echo "Instance ${INSTANCE_NAME} is already exists, Hence not creating"
fi

IPADDRESS=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${INSTANCE_NAME}" --query 'Reservations[*].Instances[*].PrivateIpAddress' --output text)

echo '{
            "Comment": "CREATE/DELETE/UPSERT a record ",
            "Changes": [{
            "Action": "UPSERT",
                        "ResourceRecordSet": {
                                    "Name": "DNSNAME.roboshop.internal",
                                    "Type": "A",
                                    "TTL": 300,
                                 "ResourceRecords": [{ "Value": "IPADDRESS"}]
}}]
}' | sed -e "s/DNSNAME/${INSTANCE_NAME}/" -e "s/IPADDRESS/${IPADDRESS}/"  >/tmp/record.json

ZONE_ID=$(aws route53 list-hosted-zones --query "HostedZones[*].{name:Name,ID:Id}" --output text | grep roboshop.internal  | awk '{print $1}' | awk -F / '{print $3}')

aws route53 change-resource-record-sets --hosted-zone-id $ZONE_ID --change-batch file:///tmp/record.json --output text &>>$LOG

echo - "DNS Record Created"







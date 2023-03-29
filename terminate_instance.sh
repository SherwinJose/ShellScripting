LOG=/tmp/terminate_instance.log
rm -f $LOG

PRIVATE_IP=$1
  if [ -z "${PRIVATE_IP}" ]; then
    echo -e "\e[1;33mPRIVATE_IP Argument is needed\e[0m"
    exit
  fi

INSTANCE_ID=$(aws ec2 describe-instances --filter Name=private-ip-address,Value=$PRIVATE_IP --'Reservations[*].Instances[*].InstanceID' --output text )

echo "InstanceID =  ${INSTANCE_ID} "





















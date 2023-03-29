LOG=/tmp/terminate_instance.log
rm -f $LOG

PRIVATE_IP=$1
  if [ -z "${INSTANCE_NAME}" ]; then
    echo -e "\e[1;33mInstance Name Argument is needed\e[0m"
    exit
  fi

INSTANCE_ID=$(aws ec2 describe-instances --filter Name=private-ip-address,Value=$PRIVATE_IP --'Reservations[*].Instances[*].InstanceID' --output text )

echo "InstanceID =  ${INSTANCE_ID} "





















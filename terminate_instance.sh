LOG=/tmp/terminate_instance.log
rm -f $LOG

INSTANCE_NAME=$1
  if [ -z "${INSTANCE_NAME}" ]; then
    echo -e "\e[1;INSTANCE_NAME Argument is needed\e[0m"
    exit
  fi

INSTANCE_ID=$(aws ec2 describe-instances --filter "Name=tag:Name,Values=${INSTANCE_NAME}" --query 'Reservations[*].Instances[*].InstanceID' --output text )

echo "InstanceID =  ${INSTANCE_ID} "





















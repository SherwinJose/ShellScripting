LOG=/tmp/terminate_instance.log
rm -f $LOG

INSTANCE_NAME=$1
  if [ -z "${INSTANCE_NAME}" ]; then
    echo -e "\e[1;INSTANCE_NAME Argument is needed\e[0m"
    exit
  fi

  INSTANCE_ID=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${INSTANCE_NAME}" --query 'Reservations[*].Instances[*].InstanceId' --output text)

echo "InstanceID =  ${INSTANCE_ID}"

if [ -z "${INSTANCE_NAME}" ];then
echo "The Instance is not present"
exit
else
aws ec2 terminate-instances --instance-ids "${INSTANCE_ID}" --query 'TerminatingInstances[*].InstanceId[*].Name' --output text
fi



















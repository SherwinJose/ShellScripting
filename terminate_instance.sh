LOG=/tmp/terminate_instance.log
rm -f $LOG

INSTANCE_NAME=$1
  if [ -z "${INSTANCE_NAME}" ]; then
    echo -e "\e[1;INSTANCE_NAME Argument is needed\e[0m"
    exit
  fi

  INSTANCE_ID=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${INSTANCE_NAME}" --query 'Reservations[*].Instances[*].InstanceId' --output text)

echo "InstanceID =  ${INSTANCE_ID}"

if [ ${INSTANCE_ID} -ne 0 ];then
 aws ec2 terminate-instances --instance-ids ${INSTANCE_ID}
else
echo "The Instance is not present"
fi



















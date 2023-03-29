LOG=/tmp/terminate_instance.log
rm -f $LOG

INSTANCE_NAME=$1
  if [ -z "${INSTANCE_NAME}" ]; then
    echo -e "\e[1;33mInstance Name Argument is needed\e[0m"
    exit
  fi


PRIVATE_IP=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${INSTANCE_NAME}" --query 'Reservations[*].Instances[*].PrivateIpAddress' --output text)

if [ -z "${PRIVATE_IP}" ];
then
  echo -e "\e[1;33mThe Given Instance is not active\e[0m"
  else
    #terminate ec2 instance
    INSTANCE_ID=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${INSTANCE_NAME}" --query 'Reservations[*].Instances[*].Instanceid' --output text)
    echo -e the "\e[1;33m ${INSTANCE_ID}  is the instance id for the ${INSTANCE_NAME}"
    #aws ec2 terminate_inatances --intance-ids $


    fi
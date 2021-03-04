## AWS CLI commands

```shell
$ aws ec2 create-key-pair --key-name aws-pma-stockholm --query 'KeyMaterial' --output text > aws-pma-stockholm.pem --profile homeaws
$ chmod 400 aws-pma-stockholm.pem

$ aws ec2 describe-vpcs --filters Name="isDefault,Values=true" --query 'Vpcs[0].VpcId' --profile homeaws
$ aws ec2 describe-subnets --filter "Name=vpc-id,Values=vpc-c18339a8" --query 'Subnets[0].SubnetId' --profile homeaws
$ aws ec2 create-security-group --group-name pma-ec2-ma --description "pma-ec2-ma-sg" --vpc-id vpc-c18339a8 --profile homeaws

$ aws ec2 authorize-security-group-ingress --group-id sg-0b36d4804c10566f9 --protocol tcp --port 22 --cidr 0.0.0.0/0 --profile homeaws && \
aws ec2 authorize-security-group-ingress --group-id sg-0b36d4804c10566f9 --protocol tcp --port 80 --cidr 0.0.0.0/0 --profile homeaws

$ aws ec2 run-instances --image-id ami-09b44b5f46219ee86 \
--count 1 \
--instance-type t3.micro \
--key-name aws-pma-stockholm \
--security-group-ids sg-0b36d4804c10566f9 \
--subnet-id subnet-15fd467c \
--associate-public-ip-address \
--region eu-north-1 \
--credit-specification CpuCredits=standard \
--profile homeaws

$ aws ec2 create-security-group --group-name pma-rds-ma --description "pma-rds-ma-sg" --vpc-id vpc-c18339a8 --profile homeaws
$ aws ec2 authorize-security-group-ingress --group-id sg-06578b97636c1097a --protocol tcp --port 3306 --source-group sg-0b36d4804c10566f9 --profile homeaws
$ aws rds describe-db-subnet-groups --profile homeaws | grep GroupName

$ aws rds create-db-instance --engine mysql \
--db-instance-class db.t3.micro \
--engine-version 8.0.20 \
--db-instance-identifier pma-rds-ma-mysql \
--master-username pma_admin \
--master-user-password sgpwIuPH9GWcuDjumbVd1M9mv1DS24 \
--allocated-storage 10 \
--db-name pma \
--vpc-security-group-ids sg-06578b97636c1097a \
--db-subnet-group default-vpc-c18339a8 \
--auto-minor-version-upgrade \
--profile homeaws

$ aws ec2 describe-addresses --query 'Addresses[?InstanceId==null]' --profile homeaws
$ aws ec2 associate-address --instance-id i-0a3d50b9666116b39 --allocation-id eipalloc-0c123629389c2be1b --profile homeaws

$ aws ec2 describe-instances \
--filter "Name=instance-id,Values=i-0a3d50b9666116b39" \
--query "Reservations[*].Instances[*].PublicIpAddress" \
--output text \
--profile homeaws

$ aws rds describe-db-instances \
--filter "Name=db-instance-id,Values=pma-rds-ma-mysql" \
--query "DBInstances[*].Endpoint.Address" \
--output text \
--profile homeaws
```

## phpMyAdmin

IP: 13.51.76.103

User: pma_admin

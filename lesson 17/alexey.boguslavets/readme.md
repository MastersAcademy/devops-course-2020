aws ec2 create-key-pair --key-name 'alexxck-phpadmin-eu-north-1' --query 'KeyMaterial' --output text > alexxck-phpadmin-eu-north-1.pem

chmod 400 alexxck-phpadmin-eu-north-1.pem

aws ec2 describe-vpcs --filters Name="isDefault,Values=true" --query 'Vpcs[0].VpcId'

aws ec2 describe-subnets --filter "Name=vpc-id,Values=vpc-6f902a06" --query 'Subnets[0].SubnetId'

aws ec2 create-security-group --group-name hw17-ma --description "hw17-sg" --vpc-id vpc-6f902a06

(GroupId: sg-0e9127aa1ca877d44)

aws ec2 authorize-security-group-ingress --group-id sg-0e9127aa1ca877d44 --protocol tcp --port 22 --cidr 0.0.0.0/0

aws ec2 authorize-security-group-ingress --group-id sg-0e9127aa1ca877d44 --protocol tcp --port 80 --cidr 0.0.0.0/0

aws ec2 run-instances --image-id ami-09b44b5f46219ee86 \
--count 1 \
--instance-type t3.micro \
--key-name alexxck-phpadmin-eu-north-1 \
--security-group-ids sg-0e9127aa1ca877d44 \
--subnet-id subnet-a3ba60d8 \
--associate-public-ip-address \
--region eu-north-1 \
--credit-specification CpuCredits=standard

aws ec2 create-security-group --group-name hw17-rds-ma --description "hw17-rds-sg" --vpc-id vpc-6f902a06

aws ec2 authorize-security-group-ingress --group-id sg-096a31d221fc6d462 --protocol tcp --port 3306 --source-group sg-0e9127aa1ca877d44

aws rds describe-db-subnet-groups  | grep GroupName

aws rds create-db-instance --engine mysql \
--db-instance-class db.t3.micro \
--engine-version 8.0.20 \
--db-instance-identifier hw17-rds-mysql \
--master-username root \
--master-user-password sgpwIuPH9GWcuDjumbVd1M9mv1DS24 \
--allocated-storage 10 \
--db-name hw17 \
--vpc-security-group-ids sg-096a31d221fc6d462 \
--db-subnet-group default-vpc-6f902a06 \
--auto-minor-version-upgrade

user: root
http://13.51.72.124/
http://ec2-13-51-72-124.eu-north-1.compute.amazonaws.com/

project design architecture
https://miro.com/app/board/o9J_lQqNMLY=/
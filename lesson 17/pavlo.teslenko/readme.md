commands:
	aws ec2 create-key-pair --key-name 'paullol-cliphpadmin-stockholm' --query 'KeyMaterial' --output text > paullol-cliphpadmin-stockholm.pem
  
	aws ec2 create-security-group --group-name cliphpadmin-sg --description "cliphpadmin-sg" --vpc-id vpc-9a972df3
  
	aws ec2 authorize-security-group-ingress --group-id sg-02faf61fbd1e41204 --protocol tcp --port 80 --cidr 0.0.0.0/0
  
	aws ec2 authorize-security-group-ingress --group-id sg-02faf61fbd1e41204 --protocol tcp --port 22 --cidr 0.0.0.0/0
  
	aws ec2 run-instances --image-id ami-09b44b5f46219ee86 --count 1 --instance-type t3.micro --key-name paullol-cliphpadmin-stockholm --security-group-ids sg-02faf61fbd1e41204 --subnet-id subnet-bebe64c5
  
	aws ec2 create-tags --resources i-06eccbb6d3df73a9a --tags Key=Name,Value=cliphpmyadmin
  
	aws ec2 create-security-group --group-name cliphpadmindb-rds --description "cliphpadmindb-rds" --vpc-id vpc-9a972df3
  
	aws ec2 authorize-security-group-ingress --group-id sg-04e9ed4ab1e3c0e81 --protocol tcp --port 3306 --source-group sg-02faf61fbd1e41204
  
	aws rds create-db-instance --engine mysql --engine-version 8.0.20 --db-instance-identifier cliphpmyadmin-db --allocated-storage 20 --db-instance-class db.t3.micro --vpc-security-group-ids sg-04e9ed4ab1e3c0e81 --db-subnet-group default-vpc-9a972df3 --master-username root --master-user-password sgpwIuPH9GWcuDjumbVd1M9mv1DS24 --auto-minor-version-upgrade

user:root

ip: 13.53.59.204
# dev-vpc subnets list
aws ec2 describe-subnets --filter "Name=vpc-id,Values=vpc-067dd34cd32d9461c" --query Subnets[*].[SubnetId,CidrBlock,AvailableIpAddressCount,Tags[?key==Name].Value] --output text --profile uat-wins
# list all images
aws ec2 describe-images --filters "Name=name,Values=GT_GCCS_StandardBuild_RHEL_8*2022-07*" --query "Images[*].[ImageId,Name]" --profile uat-wins  |sort -k 2
aws ec2 describe-images --filters "Name=name,Values=ubuntu/images/hvm-ssd/ubuntu-*-18.04-amd64-server-202206*"
--query "Images[*].[ImageId,Name]" --output text --profile uat-wins
# describe instance
aws ec2 describe-instances --filters "Name=instance-id,Values=i-00742ff5000ac081c" --profile=uat-wins
eval $(ssh-agent)
ssh-add /dir/key.pem
ssh -A wins@IP
curl http://169.254.169.254/latest/user-data
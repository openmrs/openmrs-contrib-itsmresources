In order to update this stack, you need a power user in AWS console.

## Generate access keys as per [AWS documentation](http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html#Using_CreateAccessKey).

Do not store those credentials in git and it should not leave your computer unless it's encrypted.


## Install and configure aws cli
```
pip install aws-cli
aws configure
```
Set region as `us-west-2`.

## Update stack
Change the file, and run:
```
aws cloudformation update-stack --stack-name backups \
   --capabilities CAPABILITY_NAMED_IAM --template-body file://backup_stack.json
```

The output can be seen in AWS Console, Oregon region. 

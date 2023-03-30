region=$(aws configure get region)

aws cloudformation create-stack --region $region  --stack-name ecs-codebuild-stack --template-body file://./ecs-codebuild.yaml --capabilities CAPABILITY_NAMED_IAM
aws cloudformation wait stack-create-complete --region $region --stack-name ecs-codebuild-stack
aws cloudformation create-stack --region $region --stack-name ecs-codepipeline-stack --template-body file://./ecs-codepipeline.yaml --capabilities CAPABILITY_NAMED_IAM
aws cloudformation wait stack-create-complete --region $region --stack-name ecs-codepipeline-stack

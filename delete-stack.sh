region=$(aws configure get region)

aws cloudformation delete-stack --region $region --stack-name ecs-codepipeline-stack
aws cloudformation wait stack-delete-complete --region $region --stack-name ecs-codepipeline-stack
aws cloudformation delete-stack --region $region --stack-name ecs-codebuild-stack
aws cloudformation wait stack-delete-complete --region $region --stack-name ecs-codebuild-stack

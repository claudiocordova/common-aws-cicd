#!/bin/bash

region=$(aws configure get region)

aws cloudformation create-stack --region $region  --stack-name ecs-codebuild-stack --template-body file://./ecs-codebuild.yaml --capabilities CAPABILITY_NAMED_IAM

result=$?

if [ $result -eq 254 ] || [ $result -eq 255 ]; then
  echo "ecs-codebuild-stack already exists"
  #exit 0
elif [ $result -ne 0 ]; then
  echo "ecs-codebuild-stack failed to create " $result
  exit 1
fi

aws cloudformation wait stack-create-complete --region $region --stack-name ecs-codebuild-stack
aws cloudformation create-stack --region $region --stack-name ecs-codepipeline-stack --template-body file://./ecs-codepipeline.yaml --capabilities CAPABILITY_NAMED_IAM

result=$?

if [ $result -eq 254 ] || [ $result -eq 255 ]; then
  echo "ecs-codepipeline-stack already exists"
  #exit 0
elif [ $result -ne 0 ]; then
  echo "ecs-codepipeline-stack failed to create " $result
  exit 1
fi


aws cloudformation wait stack-create-complete --region $region --stack-name ecs-codepipeline-stack

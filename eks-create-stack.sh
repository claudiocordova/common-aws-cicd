#!/bin/bash

region=$(aws configure get region)

aws cloudformation create-stack --region $region  --stack-name eks-codebuild-stack --template-body file://./eks-codebuild.yaml --capabilities CAPABILITY_NAMED_IAM

result=$?

if [ $result -eq 254 ] || [ $result -eq 255 ]; then
  echo "eks-codebuild-stack already exists"
  #exit 0
elif [ $result -ne 0 ]; then
  echo "eks-codebuild-stack failed to create " $result
  exit 1
fi

aws cloudformation wait stack-create-complete --region $region --stack-name eks-codebuild-stack
aws cloudformation create-stack --region $region --stack-name eks-codepipeline-stack --template-body file://./eks-codepipeline.yaml --capabilities CAPABILITY_NAMED_IAM

result=$?

if [ $result -eq 254 ] || [ $result -eq 255 ]; then
  echo "eks-codepipeline-stack already exists"
  #exit 0
elif [ $result -ne 0 ]; then
  echo "eks-codepipeline-stack failed to create " $result
  exit 1
fi


aws cloudformation wait stack-create-complete --region $region --stack-name eks-codepipeline-stack

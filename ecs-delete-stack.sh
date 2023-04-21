#!/bin/bash

region=$(aws configure get region)

aws cloudformation delete-stack --region $region --stack-name ecs-codepipeline-stack
if [ $? -ne 0 ]; then
  echo "Failed to delete ecs-codepipeline-stack"
  exit 1
fi
aws cloudformation wait stack-delete-complete --region $region --stack-name ecs-codepipeline-stack
aws cloudformation delete-stack --region $region --stack-name ecs-codebuild-stack

if [ $? -ne 0 ]; then
  echo "Failed to delete ecs-codebuild-stack"
  exit 1
fi

aws cloudformation wait stack-delete-complete --region $region --stack-name ecs-codebuild-stack

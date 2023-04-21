#!/bin/bash

region=$(aws configure get region)

aws cloudformation delete-stack --region $region --stack-name eks-codepipeline-stack
if [ $? -ne 0 ]; then
  echo "Failed to delete eks-codepipeline-stack"
  exit 1
fi
aws cloudformation wait stack-delete-complete --region $region --stack-name eks-codepipeline-stack
aws cloudformation delete-stack --region $region --stack-name eks-codebuild-stack

if [ $? -ne 0 ]; then
  echo "Failed to delete eks-codebuild-stack"
  exit 1
fi

aws cloudformation wait stack-delete-complete --region $region --stack-name eks-codebuild-stack

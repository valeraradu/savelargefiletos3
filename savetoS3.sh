#!/usr/bin/env bash
set -o errexit -o xtrace

aws ec2 run-instances --image-id ami-0998bf58313ab53da --instance-type  t2.micro \
--user-data "#!/bin/bash

export AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}
export AWS_ACCESS_KEY_ID=\"${AWS_ACCESS_KEY_ID}\"
export AWS_SECRET_ACCESS_KEY=\"${AWS_SECRET_ACCESS_KEY}\"

yum -y update
yum install curl -y
mkdir -p /tmp/my-file
cd /tmp/my-file
curl -O ${1}
aws s3 sync . ${2}
poweroff"

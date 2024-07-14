#!/bin/sh

#reset output directory
rm -rf ./output
mkdir ./output

#start terraform procedure
terraform init
terraform apply --auto-approve

# Output lambda URLs to file, -raw added to remove quotes
terraform output -raw first_lambda_invoke_url > ./output/first_lambda_url.txt
terraform output -raw second_lambda_invoke_url > ./output/second_lambda_url.txt 
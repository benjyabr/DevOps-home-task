#!/bin/sh

#invoking both lambdas and printing out only the secret of the second lambda
curl -X GET --url "$(cat /mnt/output/first_lambda_url.txt)" > /dev/null
curl -X GET -H "Authorization: 946684800" --url "$(cat /mnt/output/second_lambda_url.txt)" | sed -n -e 's/^.*secret is: //p'
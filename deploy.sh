#! /bin/bash
. ./deploy.ini

echo "cleaning deploy environment ..."
rm -rf ./bin
echo "environment cleaned!"

echo "creating binary to upload ..."
cd src

GOOS=linux go build -o ../bin/main
cd ../
echo "binary created!"

echo "deploying to cloud ..."
cd deploy
terraform init -input=false
terraform apply -input=false -auto-approve -var-file=$TERRAFORM_PARAMETERS_PATH
cd ../
echo "deployed!"

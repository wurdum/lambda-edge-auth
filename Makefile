version?=1.0
project_name=test-container-lambda
account_id=590320146706

all: tf-aws-apply build tag push tf-lambda-apply
rebuild: clean build

test:
	@echo 'Building and running lambda locally'
	docker build -t lambda-edge-auth:latest .
	docker run --rm --name lambda-edge-auth -p 9000:8080 lambda-edge-auth:latest
	@echo 'Done!'

tf-aws-apply:
	@echo 'terraform plan aws and apply'
	terraform -chdir=terraform/aws apply -auto-approve
	@echo 'Done!'

tf-lambda-apply:
	@echo 'terraform plan lambda and apply'
	terraform -chdir=terraform/lambda apply -auto-approve
	@echo 'Done!'

build:
	@echo 'Building code and docker image'
	npm run build
	zip -j dist/package.zip dist/* package.json package-lock.json configuration.json
	@echo 'Done!'

tag:
	@echo 'Tag docker image'
	docker tag $(project_name):latest $(account_id).dkr.ecr.us-east-1.amazonaws.com/$(project_name):latest
	docker tag $(project_name):latest $(account_id).dkr.ecr.us-east-1.amazonaws.com/$(project_name):$(version)
	@echo 'Done!'

push:
	@echo 'Push built image'
	aws ecr get-login-password | docker login --username AWS --password-stdin $(account_id).dkr.ecr.us-east-1.amazonaws.com
	docker push $(account_id).dkr.ecr.us-east-1.amazonaws.com/$(project_name):latest
	docker push $(account_id).dkr.ecr.us-east-1.amazonaws.com/$(project_name):$(version)
	@echo 'Done!'

clean:
	@echo 'Cleaning solution from temp files'
	rm -rf dist temp
	@echo 'Done!'

clean-all:
	@echo 'Cleaning solution from temp files'
	rm -rf dist temp node_modules package-lock.json
	@echo 'Done!'

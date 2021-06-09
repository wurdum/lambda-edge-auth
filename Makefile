version?=1.0
project_name=test-container-lambda
account_id=590320146706

all: clean build tf-lambda-apply tf-aws-apply
rebuild: clean build

tf-lambda-apply:
	@echo 'terraform plan lambda and apply'
	terraform -chdir=terraform/lambda apply -auto-approve
	@echo 'Done!'

tf-aws-apply:
	@echo 'terraform plan aws and apply'
	terraform -chdir=terraform/aws apply -auto-approve
	@echo 'Done!'

build:
	@echo 'Building code and docker image'
	npm run build
	zip -j dist/package.zip dist/* package.json package-lock.json configuration.json
	@echo 'Done!'

clean:
	@echo 'Cleaning solution from temp files'
	rm -rf dist temp
	@echo 'Done!'

clean-all:
	@echo 'Cleaning solution from temp files'
	rm -rf dist temp node_modules package-lock.json
	@echo 'Done!'

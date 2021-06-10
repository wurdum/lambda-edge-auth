version?=1.0
project_name=test-container-lambda
account_id=590320146706

all: clean build tf-artifacts-apply tf-aws-apply
rebuild: clean build

tf-artifacts-apply:
	@echo 'terraform plan artifacts and apply'
	terraform -chdir=terraform/artifacts apply -auto-approve
	@echo 'Done!'

tf-aws-apply:
	@echo 'terraform plan aws and apply'
	terraform -chdir=terraform/aws apply -auto-approve
	@echo 'Done!'

build:
	@echo 'Building code and docker image'
	npm run build
	zip -j dist/package.zip dist/* package.json package-lock.json
	@echo 'Done!'

clean:
	@echo 'Cleaning solution from temp files'
	rm -rf dist temp
	@echo 'Done!'

clean-all:
	@echo 'Cleaning solution from temp files'
	rm -rf dist temp node_modules package-lock.json
	@echo 'Done!'

tf-destroy:
	@echo 'Destroying aws and artifacts'
	terraform -chdir=terraform/aws apply -auto-approve -destroy
	terraform -chdir=terraform/artifacts apply -auto-approve -destroy
	@echo 'Done!'

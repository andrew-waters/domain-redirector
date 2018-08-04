build:
	packer build -var-file=config/tf.json ./packer-build.json

deploy:
	terraform init && terraform apply -var-file=config/tf.json

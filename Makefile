.PHONY: generate-docs
generate-docs:
	go install github.com/terraform-docs/terraform-docs@v0.20.0
	terraform-docs markdown table --output-file README.md --output-mode inject .

.PHONY: format
format:
	terraform fmt -recursive

.PHONY: lint
lint:
	terraform fmt -check -recursive
	docker run --rm -v $(PWD):/data -w /data ghcr.io/terraform-linters/tflint --init
	docker run --rm -v $(PWD):/data -w /data ghcr.io/terraform-linters/tflint

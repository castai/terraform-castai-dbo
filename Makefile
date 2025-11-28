.PHONY: generate-doc
generate-doc:
	go install github.com/terraform-docs/terraform-docs@v0.20.0
	terraform-docs markdown table --output-file README.md --output-mode inject .

.PHONY: format
format:
	terraform fmt -recursive

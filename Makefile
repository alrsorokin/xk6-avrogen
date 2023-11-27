SHELL:=/bin/bash


help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

clean: ## Removes any previously created build artifacts.
	@rm -f ./k6

build: ## Builds a custom 'k6' with the local extension. 
	@go install go.k6.io/xk6/cmd/xk6@latest
	@xk6 build --with $(shell go list -m)=.

format: ## Applies Go formatting to code.
	@go fmt ./...

test: ## Executes any unit tests.
	@./k6 run test/test.js

.PHONY: build clean format help test
.DEFAULT_GOAL := help

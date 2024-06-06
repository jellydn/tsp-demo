.PHONY: install
install:
	@echo "Installing dependencies..."
	@bun install

.PHONY: install-cli
install-cli:
	@echo "Installing CLI dependencies..."
	@npm install -g @typespec/compiler

.PHONY: dev
dev:
	@echo "Starting development server..."
	@tsp compile . --watch

.PHONY: build
build:
	@echo "Building..."
	@tsp compile .

.PHONY: format
format:
	@echo "Formatting..."
	@tsp format "**/*.tsp"

.PHONY: help
help:
	@echo "Available targets:"
	@echo "  install     - Install dependencies"
	@echo "  install-cli - Install CLI dependencies"
	@echo "  dev         - Start development server"
	@echo "  build       - Build the project"
	@echo "  format      - Format the project"
	@echo "  help        - Show this help message"


MAIN=./cmd/api/main.go
BINARY_NAME=conduit
BUILD_DIR = ./tmp
MIGRATION_PATH = ./internal/migrations/sqlite
DB_NAME = conduit.db

# Build the application
all: build

build:
	@echo "Building..."
	@templ generate
	@npx npx tailwindcss -i ./cmd/web/css/input.css -o ./cmd/web/css/output.css
	@go build -o ${BUILD_DIR}/${BINARY_NAME} ${MAIN}

# Run the application
run:
	@go run cmd/api/main.go

# Create DB container
docker-run:
	@if docker compose up 2>/dev/null; then \
		: ; \
	else \
		echo "Falling back to Docker Compose V1"; \
		docker-compose up; \
	fi

# Shutdown DB container
docker-down:
	@if docker compose down 2>/dev/null; then \
		: ; \
	else \
		echo "Falling back to Docker Compose V1"; \
		docker-compose down; \
	fi

# Test the application
test:
	@echo "Testing..."
	@go test ./tests -v

# Clean the binary
clean:
	@echo "Cleaning..."
	@rm -f main

# Live Reload
watch:
	@if command -v air > /dev/null; then \
	    air; \
	    echo "Watching...";\
	else \
	    read -p "Go's 'air' is not installed on your machine. Do you want to install it? [Y/n] " choice; \
	    if [ "$$choice" != "n" ] && [ "$$choice" != "N" ]; then \
	        go install github.com/cosmtrek/air@latest; \
	        air; \
	        echo "Watching...";\
	    else \
	        echo "You chose not to install air. Exiting..."; \
	        exit 1; \
	    fi; \
	fi

.PHONY: all build run test clean

# Migrations

#Check if goose is installed
goose-install:
	@if ! command -v goose > /dev/null; then \
		echo "goose is not installed. Installing..."; \
		go install github.com/pressly/goose/v3/cmd/goose@latest; \
	fi

db-status: goose-install
	@GOOSE_DRIVER=sqlite3 GOOSE_DBSTRING=$(DB_NAME) goose -dir=$(MIGRATION_PATH) status

up: goose-install
	@GOOSE_DRIVER=sqlite3 GOOSE_DBSTRING=$(DB_NAME) goose -dir=$(MIGRATION_PATH) up

down: goose-install
	@GOOSE_DRIVER=sqlite3 GOOSE_DBSTRING=$(DB_NAME) goose -dir=$(MIGRATION_PATH) down

reset: goose-install
	@GOOSE_DRIVER=sqlite3 GOOSE_DBSTRING=$(DB_NAME) goose -dir=$(MIGRATION_PATH) reset

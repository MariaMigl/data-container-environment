.DEFAULT_GOAL := help

# container related variables
ENVIRONMENT := data-science## Environment to run commands


.PHONY: help
help:
	@utils/help.sh Makefile

.PHONY: build
build: build-data-science build-data-engineer ## Build all project containers

.PHONY: build-data-science
build-data-science: clean-data-science-container ## Build the data science container
	@echo "Building data-science container..."
	@cd build/scripts/; ./build data-science


.PHONY: build-data-engineer
build-data-engineer: clean-data-engineer-container ## Build the data engineer container
	@echo "Building data-engineer container..."
	@cd build/scripts/; ./build data-engineer

.PHONY: run
run: run-data run-airflow ## Runs data science, data engineer & airflow containers

.PHONY: run-data
run-data: run-data-science run-data-engineer ## Runs data science & data engineer containers

.PHONY: run-data-science
run-data-science: ## Run the data science container
	@echo "Running data-science container..."
	@docker compose up -d data-science

.PHONY: run-data-engineer
run-data-engineer: ## Run the data engineer container
	@echo "Running data-engineer container..."
	@docker compose up -d data-engineer

.PHONY: clean
clean: clean-data-environment clean-airflow ## Stop and removes all containers

.PHONY: clean-data-environment
clean-data-environment: clean-data-science-container clean-data-science-container ## Stop and removes all data containers
	@echo "Stopping and removing all containers..."
	@docker compose down

.PHONY: stop-data-science-container
stop-data-science-container: ## Stop data science containers
	@echo "Stopping data science containers..."
	@docker compose stop data-science

.PHONY: check-data-science-backup
check-data-science-backup: ## Check data science backup
	@echo "Data science backup:\n\n"
	@docker compose exec -it data-science bash -c 'ls /backup-folder'

.PHONY: restore-data-science-backup
restore-data-science-backup: ## Restore data science backup
	@echo "Restoring data science backup\n"
	@docker compose exec -it data-science bash -c 'cp -r /backup-folder/. /jupyter-folder/'
	@echo "Restored!"

.PHONY: clean-data-science-backup
clean-data-science-backup: ## Clean data science backup
	@echo "Cleaning data science backup\n"
	@docker compose exec -it data-science bash -c 'rm -rf /backup-folder/*'
	@echo "Cleaned!"

.PHONY: force-data-science-backup
force-data-science-backup: ## Force data science backup
	@echo "Backing up data science content\n"
	@docker compose exec -it data-science bash -c 'cp -r /jupyter-folder/. /backup-folder/'
	@echo "Backup done!"

.PHONY: check-data-engineer-backup
check-data-engineer-backup: ## Check data engineer backup
	@echo "Data engineer backup:\n\n"
	@docker compose exec -it data-engineer bash -c 'ls /backup-folder'

.PHONY: restore-data-engineer-backup
restore-data-engineer-backup: ## Restore data engineer backup
	@echo "Restoring data engineer backup\n"
	@docker compose exec -it data-engineer bash -c 'cp -r /backup-folder/. /jupyter-folder/'
	@echo "Restored!"

.PHONY: stop-data-engineer-container
stop-data-engineer-container: ## Stop data engineer containers
	@echo "Stopping data engineer containers..."
	@docker compose stop data-engineer

.PHONY: start-data-science-container
start-data-science-container: ## Start data science containers
	@echo "Starting data science containers..."
	@docker compose start data-science

.PHONY: start-data-engineer-container
start-data-engineer-container: ## Start data engineer containers
	@echo "Starting data engineer containers..."
	@docker compose start data-engineer

.PHONY: clean-data-science-container
clean-data-science-container: ## Stop and remove data science containers
	@echo "Stopping and removing data science containers..."
	@docker compose rm -fs data-science

.PHONY: clean-data-engineer-container
clean-data-engineer-container: ## Stop and remove data engineer containers
	@echo "Stopping and removing data science containers..."
	@docker compose rm -fs data-engineer

.PHONY: add-data-science-dependency
add-data-science-dependency: ## Add a dependency to data science containers `package=<package>`
	@echo "Adding data science dependency"
	@cd build/scripts/; ./add-dep data-science $(package)

.PHONY: add-data-science-dependency
add-data-engineer-dependency: ## Add a dependency to data engineer containers `package=<package>`
	@echo "Adding data engineer dependency"
	@cd build/scripts/; ./add-dep data-engineer $(package)

.PHONY: run-airflow
run-airflow: ## Run all airflow containers
	@echo "Running airflow containers"
	@cd airflow; docker compose up --build -d

.PHONY: clean-airflow
clean-airflow: ## Stop and remove all airflow containers
	@echo "Running airflow containers"
	@cd airflow; docker compose down --rmi local

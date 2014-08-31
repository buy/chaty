usage:
	@echo 'make setup                       : Install all necessary dependencies'
	@echo 'make clean                       : Remove all installed node_modules'
	@echo 'make dev                         : Start the local development server'

# Install all necessary dependencies
setup:
	npm install

# Remove all installed node_modules
clean:
	rm -rf node_modules

# Start local development env
dev:
	@./env.sh coffee server.coffee

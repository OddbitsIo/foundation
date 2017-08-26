API_SRC=api/src
ADMIN_SRC=admin/src
default: build
build: build-api build-admin
build-api:
	@if [ -d $(API_SRC) ]; then \
		git -C $(API_SRC) pull; \
	else \
		git clone https://github.com/OddbitsIo/api.git $(API_SRC); \
	fi
	@cd $(API_SRC); glide install
	@docker-compose build api
	@if [[ "$(docker ps -aq -f name=oddbits_api 2> /dev/null)" != "" ]]; then \
		docker-compose stop api; \
		docker-compose up -d --no-deps api; \
	fi
build-admin:
	@if [ -d $(ADMIN_SRC) ]; then \
		git -C $(ADMIN_SRC) pull; \
	else \
		git clone https://github.com/OddbitsIo/admin.git $(ADMIN_SRC); \
	fi
	@cd $(ADMIN_SRC); npm install; ng build
	@docker-compose build admin
test-api:
	@if [ -d $(API_SRC) ]; then \
		git -C $(API_SRC) pull; \
	else \
		git clone https://github.com/OddbitsIo/api.git $(API_SRC); \
	fi
	@cd $(API_SRC); glide install
	@docker-compose -f docker-compose-test.yml up api
clean:
	@if [ -d $(API_SRC) ]; then \
		git -C $(API_SRC) fetch origin; \
		git -C $(API_SRC) reset --hard origin/master; \
		git -C $(API_SRC) clean -fdx; \
	fi
	@if [ -d $(ADMIN_SRC) ]; then \
		git -C $(ADMIN_SRC) fetch origin; \
		git -C $(ADMIN_SRC) reset --hard origin/master; \
		git -C $(ADMIN_SRC) clean -fdx; \
	fi
	@docker-compose down -v --rmi all
start:
	@if [[ "$(docker ps -aq -f name=oddbits_api 2> /dev/null)" == "" ]]; then \
		docker-compose up -d; \
	else \
		docker-compose start; \
	fi
stop:
	@docker-compose stop
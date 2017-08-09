API_SRC=api-build/src
ADMIN_SRC=admin-build/src
default: build
build-api:
	@if [ -d $(API_SRC) ]; then \
		git -C $(API_SRC) pull; \
	else \
		git clone https://github.com/OddbitsIo/api.git $(API_SRC); \
	fi
	@cd $(API_SRC); glide install
	@docker-compose build api
build-admin:
	@if [ -d $(ADMIN_SRC) ]; then \
		git -C $(ADMIN_SRC) pull; \
	else \
		git clone https://github.com/OddbitsIo/admin.git $(ADMIN_SRC); \
	fi
	@cd $(ADMIN_SRC); npm install; ng build
	@docker-compose build admin
clean:
	@if [ -d $(API_SRC) ]; then \
		git -C $(API_SRC) fetch origin; \
		git -C $(API_SRC) reset --hard origin/master; \
		git -C $(API_SRC) clean -fdx; \
	fi
	@docker-compose down
start:
	@if [[ "$(docker ps -aq -f name=oddbits_api 2> /dev/null)" == "" ]]; then \
		docker-compose up -d; \
	else \
		docker-compose start; \
	fi
stop:
	@docker-compose stop
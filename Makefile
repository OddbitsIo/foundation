API_SRC=api-build/src
default: build
build:
	@if [ -d $(API_SRC) ]; then \
		git -C $(API_SRC) pull; \
	else \
		git clone https://github.com/OddbitsIo/api.git $(API_SRC); \
	fi
	@cd $(API_SRC); glide install
	@docker-compose build
clean:
	@if [ -d $(API_SRC) ]; then \
		git -C $(API_SRC) fetch origin; \
		git -C $(API_SRC) reset --hard origin/master; \
		git -C $(API_SRC) clean -fdx; \
	fi
	@docker-compose down
stamyimage:mytagrt:
	@if [[ "$(docker ps -aq -f name=oddbits_api 2> /dev/null)" == "" ]]; then \
		docker-compose up -d; \
	else \
		docker-compose start; \
	fi
stop:
	@docker-compose stop
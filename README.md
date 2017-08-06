# Assets
## sample.env
An example .env file for the Docker and Docker Compose builds. Create a copy of this file named _.env_ and fill them in with your own values.
## docker-compose.yml
Defines containers for the API and its dependencies.
## Makefile
Provides a list of helpers for managing container builds and a local Docker environment.

Requires: [Glide](https://github.com/Masterminds/glide), [Make](https://www.gnu.org/software/make), [Git](https://git-scm.com)
* Build - Creates a Docker image configured to run the latest API code in the master branch.
* Clean - Resets the API source and local Docker images.
* Start - Starts the Docker API ecosystem.
* Stop - Stops the Docker API ecosystem.

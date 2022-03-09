# Dockers tools repository

You can make Dockerfile for any tools and this Dockerfile will be apply and push to the docker.oft-e.com/tools repository.
Name of the folder is a name of the docker image. Extension of the Dockerfile is a tag of the docker image.
If Extension is absent the tag will be set 'latest'.

Example:
- phpunit/Dockerfile.pcov - the Docker image file docker.oft-e.com/tools/phpunit:pcov
- vjunit/Dockerfile - the Docker image file docker.oft-e.com/tools/vjunit:latest

       
# VJUnit Docker Container.

[Docker](https://www.docker.com) container to install and run [VJUnit](https://github.com/ahelsayd/vjunit).

## Features

* [VJUnit](https://github.com/ahelsayd/vjunit)

## All images has been built by CI/CD 

## Run VJUnit through the VJUnit container:

    $ docker run -v $(pwd):/app --rm docker.oft-e.com/tools/vjunit run

or in shorthand add

    $ sudo sh -c "printf \"#!/bin/sh
    export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
    docker run -v $(pwd):/app --rm docker.oft-e.com/tools/vjunit run
    \" > /usr/local/bin/vjunit"

    $ sudo chmod +x /usr/local/bin/vjunit

and then from host machine just (in folder with junit.xml)

    $ vjunit




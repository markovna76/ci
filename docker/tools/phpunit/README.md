# PHPUnit Docker Container.

[Docker](https://www.docker.com) container to install and run [PHPUnit](https://www.phpunit.de/).

## Features

* [PHPUnit](https://www.phpunit.de/)
  * [`8.5.0`](https://github.com/sebastianbergmann/phpunit/blob/8.5/ChangeLog-8.5.md)

* [PHP](https://php.net) [7.0](https://php.net/ChangeLog-7.php)

## All images has been built by CI/CD 

## Run PHPUnit through the PHPUnit container:
with [PCOV](https://github.com/krakjoe/pcov)

    $ docker run -v $(pwd):/app --rm docker.oft-e.com/tools/phpunit:pcov run

with [xDebug](https://xdebug.org/)

    $ docker run -v $(pwd):/app --rm docker.oft-e.com/tools/phpunit:xdebug run

#### You can make shorthand with PCOV

    $ sudo sh -c "printf \"#!/bin/sh
    export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
    docker run -v $(pwd):/app --rm docker.oft-e.com/tools/phpunit:pcov run \\\$@
    \" > /usr/local/bin/phpunit"

    $ sudo chmod +x /usr/local/bin/phpunit

#### or shorthand with xDebug

    $ sudo sh -c "printf \"#!/bin/sh
    export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
    docker run -v $(pwd):/app --rm docker.oft-e.com/tools/phpunit:xdebug run \\\$@
    \" > /usr/local/bin/phpunit"

    $ sudo chmod +x /usr/local/bin/phpunit

and then from host machine just

    $ phpunit --version




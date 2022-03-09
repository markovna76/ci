#!/bin/sh
# PHP switcher

# Run this docker only
if [ ! -f /.dockerenv ]; then echo "Run this in Docker only"; exit; fi

PHP7="/opt/php7"
PHP8="/opt/php8"

# Change default PHP version
PHP="${PHP8}"

PARAM1=$1
PARAMS=$*

# debug can be 0,1,2
debug=1

echo "${PARAMS}" | grep " \-\-version" >/dev/null 2>/dev/null
[ "$?" = "0" ] && debug=0

[ "${debug}" = "2" ] && echo "==== Head start ===="
[ "${debug}" = "2" ] && echo "CMD=[${0}]"
[ "${debug}" = "2" ] && echo "PARAM1=[${PARAM1}]"
[ "${debug}" = "2" ] && echo "PARAMS=[${PARAMS}]"
[ "${debug}" = "2" ] && echo "=== Head end ======="

# Fix for using "/bin/composer" script
PARAM1=`echo ${PARAM1} | sed "s/\/composer/\/composer_empty/"`

Composer_found() {
    # What is the PATH for PHP script starting
    # We will try to find composer.json which contain a required PHP version
    # Root PATH is default

    if [ ! -f "${1}" -a ! -d "${1}" ]; then
        LOOKDIR="/"
    else
        LOOKDIR=${1}
    fi
    # The "/vendor/*" part of path should be removed if any
    LOOKDIR=`echo ${LOOKDIR} | sed "s/^\(.*\)\/vendor\/.*$/\1/"`

    # Founding composer.json
    COMPOSER_DIR=""
    while [ "${LOOKDIR}" != "/" ];
    do
        if [ -f "${LOOKDIR}/composer.json" ]; then
            COMPOSER_DIR="${LOOKDIR}/composer.json"
            [ "${debug}" -ge "1" ] && echo -en "\tFound \"${COMPOSER_DIR}\" "
            LOOKDIR="/"
        fi
        LOOKDIR=`dirname ${LOOKDIR}`
    done
}

Composer_Parsing() {
    cat ${COMPOSER_DIR} | jq '.require.php'|grep "8." >/dev/null
    if [ "$?" = "0" ]; then
        PHP=${PHP8}
        rm -rf /usr/local/* && ln -s $PHP/* /usr/local/
        [ "${debug}" -ge "1" ] && echo -e " -> Use PHP8"
    else
        PHP=${PHP7}
        rm -rf /usr/local/* && ln -s $PHP/* /usr/local/
        [ "${debug}" -ge "1" ] && echo -e " -> Use PHP7"
    fi
}

# --- Main ---

[ "${debug}" -ge "1" ] && echo -e "\n\t========================================================="

# Review all arguments for search composer.json
ARGS="${PARAMS} `pwd`"
for CHK_PATH in $ARGS; do
  [ "${COMPOSER_DIR}" = "" ] && Composer_found $CHK_PATH
done

if [ "${COMPOSER_DIR}" = "" ]; then
    rm -rf /usr/local/* && ln -s $PHP/* /usr/local/
    [ "${debug}" -ge "1" ] && echo -e "\tcomposer.json does not found."
else
    Composer_Parsing
fi
[ "${debug}" -ge "1" ] && echo -e "\t========================================================="

unlink /bin/php
ln -s /usr/local/bin/php /bin/

if [ "$0" = "/docker-entrypoint.sh" ]; then
[ "${debug}" = "2" ] &&   echo "Debug RUN1: [/usr/local/bin/php /usr/local/bin/phpunit $@]"
   /usr/local/bin/php /usr/local/bin/phpunit $@
else
[ "${debug}" = "2" ] &&   echo "Debug RUN2: [/usr/local/bin/php ${@}]"
    /usr/local/bin/php $@
fi


# PHPUnit Docker Container.
FROM python:3.8

RUN pip3 install vjunit

VOLUME ["/app"]

ENTRYPOINT vjunit -f /app/junit.xml -o /app/junit.html

FROM python:3.9-alpine3.13
LABEL maintainer='pavlos'

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app

WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    adduser \ 
        --disabled-password \ 
        --no-create-home \
        django-user

ENV PATH="/py/bin/:$PATH"

USER django-user


# writing image sha256:7142829048cfc89d2c3d4aff207b8f188980bda0ed90483dc690c43f73d75a5f
FROM python:3.9-alpine

LABEL maintainer="Mikhail Troshechkin <mihavatr@users.noreply.github.com>"
LABEL description="Containerized RobotFramework"

#Build args
ARG user_id=1000
ARG group_id=1000

#Versions
ENV PABOT_VERSION 1.11.0
ENV ROBOT_FRAMEWORK_VERSION 4.0.1
ENV SELENIUM_LIBRARY_VERSION 5.1.3
ENV SSH_LIBRARY_VERSION 3.6.0
ENV PYYAML_VERSION 5.4.1
ENV SNMPLIBRARY_VERSION 0.2.1

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
  && echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
  && echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
  && apk update \
  && apk --no-cache upgrade \
  && apk --no-cache --virtual .build-deps add \
    gcc \
    libffi-dev \
    linux-headers \
    make \
    musl-dev \
    openssl-dev \
    python3-dev \
    cargo \
    which \
    wget \
  
  && pip3 install --no-cache-dir --upgrade pip setuptools wheel \
  && pip3 install --no-cache-dir \
    robotframework==$ROBOT_FRAMEWORK_VERSION \
    robotframework-pabot==$PABOT_VERSION \
    robotframework-seleniumlibrary==$SELENIUM_LIBRARY_VERSION \
    robotframework-sshlibrary==$SSH_LIBRARY_VERSION \
    robotframework-snmplibrary==$SNMPLIBRARY_VERSION \
    PyYAML==$PYYAML_VERSION \
  
  && apk del .build-deps

WORKDIR /testenv

RUN addgroup --gid ${group_id} robot && \
    adduser --ingroup robot --uid ${user_id} --disabled-password --home /testenv robot

USER robot

CMD ["robot"]

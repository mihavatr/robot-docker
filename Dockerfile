FROM python:3.7.6-alpine3.10

MAINTAINER Mikhail Troshechkin <mihavatr@users.noreply.github.com>
LABEL description Containerized RobotFramework.

RUN mkdir /testenv

#Versions
ENV PABOT_VERSION 1.6.1
ENV ROBOT_FRAMEWORK_VERSION 3.2.1
ENV SELENIUM_LIBRARY_VERSION 4.4.0
ENV SSH_LIBRARY_VERSION 3.4.0
ENV PYYAML_VERSION 5.3.1
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
    which \
    wget 
  
RUN pip3 install --no-cache-dir \
    robotframework==$ROBOT_FRAMEWORK_VERSION \
    robotframework-pabot==$PABOT_VERSION \
    robotframework-seleniumlibrary==$SELENIUM_LIBRARY_VERSION \
    robotframework-sshlibrary==$SSH_LIBRARY_VERSION \
    robotframework-snmplibrary==$SNMPLIBRARY_VERSION \
    PyYAML==$PYYAML_VERSION

WORKDIR /testenv

CMD ["robot"]

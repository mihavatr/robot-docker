FROM python:3.9-slim-buster

LABEL maintainer="Mikhail Troshechkin <mihavatr@users.noreply.github.com>"
LABEL description="Containerized RobotFramework"

#Build args
ARG user_id=1000
ARG group_id=1000

#Versions
ENV PABOT_VERSION 1.13
ENV ROBOT_FRAMEWORK_VERSION 4.0.1
ENV SELENIUM_LIBRARY_VERSION 5.1.3
ENV SSH_LIBRARY_VERSION 3.6.0
ENV PYYAML_VERSION 5.4.1
ENV SNMPLIBRARY_VERSION 0.2.1

RUN apt update \
  && apt-get upgrade -y \
  && apt-get install -y \
    gcc \
    libffi-dev \
    make \
    musl-dev \
    librust-openssl-dev \
    python3-dev \
    cargo \
    wget \
  
  && pip3 install --no-cache-dir --upgrade pip setuptools wheel \
  && pip3 install --no-cache-dir \
    robotframework==$ROBOT_FRAMEWORK_VERSION \
    robotframework-pabot==$PABOT_VERSION \
    robotframework-seleniumlibrary==$SELENIUM_LIBRARY_VERSION \
    robotframework-sshlibrary==$SSH_LIBRARY_VERSION \
    robotframework-snmplibrary==$SNMPLIBRARY_VERSION \
    PyYAML==$PYYAML_VERSION \
  
  && apt-get purge -y \ 
    gcc \
    libffi-dev \
    make \
    musl-dev \
    librust-openssl-dev \
    python3-dev \
    cargo \
    wget \
  && apt-get clean && apt-get autoclean && apt-get autoremove -y && rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN groupadd -g ${group_id} robot && \
    useradd -g ${group_id} -u ${user_id} -no-create-home robot

WORKDIR /testenv

USER robot

# Smoketest
RUN pip3 list && robot --version

CMD ["robot"]

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

RUN groupadd -g ${group_id} robot && \
    useradd -g ${group_id} -u ${user_id} -m robot

RUN pip install --no-cache-dir \
    robotframework==$ROBOT_FRAMEWORK_VERSION \
    robotframework-pabot==$PABOT_VERSION \
    robotframework-seleniumlibrary==$SELENIUM_LIBRARY_VERSION \
    robotframework-sshlibrary==$SSH_LIBRARY_VERSION \
    robotframework-snmplibrary==$SNMPLIBRARY_VERSION \
    PyYAML==$PYYAML_VERSION
  
WORKDIR /testenv

USER robot

# Smoketest (dont use "robot --version" cause of non-zero exit code)
RUN which robot

CMD ["robot"]

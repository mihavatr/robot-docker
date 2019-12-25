### Robotframework in Docker
Containerized Robot Framework with SSH and Selenium libraries

Building image: 
```
git clone https://github.com/mihavatr/robot-docker.git
docker build -t robot-docker .
```

For run tests using robot type: `docker run robot-docker [args] [tests]`

You can also use "pabot" instead of robot for parallel tests: `docker run robot-docker pabot [args] [tests]`
Option '--testlevelsplit' also supported

For more information see:
[https://robotframework.org](https://robotframework.org "https://robotframework.org")
[https://pabot.org/](https://pabot.org/ "https://pabot.org/")

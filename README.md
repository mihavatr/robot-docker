### Robotframework in Docker
Containerized Robot Framework with SSH and Selenium libraries

Building image: 
```
git clone https://github.com/mihavatr/robot-docker.git
docker build -t robot-docker .
```

For run tests using robot type: `docker run mihavatr/robot-docker [args] [tests]`

You can also use "pabot" instead of robot for parallel tests: `docker run mihavatr/robot-docker pabot [args] [tests]`
option '--testlevelsplit' also supported

For more information see:

https://robotframework.org
 
https://pabot.org/

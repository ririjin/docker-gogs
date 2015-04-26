docker-gogs
===========

deploy gogs by docker with ssh

#### docker

build:

```bash
docker build -t docker-gogs .
```

run:

```bash
docker run -d --name docker_gogs -v $PWD/conf:/gogs/custom/conf -v $PWD/repo/:/home/git/gogs-repositories -p 3000:3000 -p 222:22 docker-gogs
```

#### docker-compose

```bash
docker-compose up
```
FROM ubuntu:14.04.2

ENV DEBIAN_FRONTEND noninteractive

ENV GOGS_VERSION v0.6.1

# install sshd

RUN sed -i "s/http:\/\/archive\.ubuntu\.com/http:\/\/mirrors\.aliyun\.com/g" /etc/apt/sources.list

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install openssh-server pwgen
RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config

ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh

ENV AUTHORIZED_KEYS **None**

# install gogs

RUN apt-get install -y vim wget zip unzip git git-core

RUN wget https://github.com/gogits/gogs/releases/download/${GOGS_VERSION}/linux_amd64.zip && unzip linux_amd64.zip && rm linux_amd64.zip

RUN mkdir -p /gogs/custom/conf/ && touch /gogs/custom/conf/app.ini

RUN useradd -U -d /home/git -s /bin/bash git && mkdir -p /home/git/gogs-repositories && mkdir /home/git/.ssh && chown -R git:git /home/git && sed -i "s/git\:\!\:/git\:NP\:/g" /etc/shadow

RUN chown -R git:git /gogs

RUN chmod +x /*.sh

CMD ["/run.sh"]

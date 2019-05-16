FROM centos:7

ENV container docker

ARG USERNAME
ARG PASSWD

EXPOSE 1080/tcp

# 更改时区
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 支持中文显示
ENV LANG en_US.UTF-8

RUN /usr/bin/yum install -y deltarpm
RUN /usr/bin/yum install -y wget unzip gcc make pam-devel openldap-devel cyrus-sasl-devel openssl-devel
RUN /usr/bin/yum clean all

RUN /usr/bin/localedef -c -f UTF-8 -i en_US en_US.utf8

WORKDIR /root
RUN wget https://github.com/chrisniael/ss5/archive/master.zip; \
unzip master.zip; \
cd ss5-master

WORKDIR /root/ss5-master
RUN ./configure
RUN make && make install

WORKDIR /root
RUN rm -rf ss5-master && rm -rf master.zip

RUN echo "auth 0.0.0.0/0 - u" >> /etc/opt/ss5/ss5.conf; \
echo "permit u 0.0.0.0/0 - 0.0.0.0/0 - - - - -" >> /etc/opt/ss5/ss5.conf; \
echo "$USERNAME $PASSWD" > /etc/opt/ss5/ss5.passwd

CMD /usr/sbin/ss5

#Dockerfile
FROM ubuntu
#指定centos6系统
MAINTAINER dddddd <XXXXXXXXX>
#我抄的他�?Dockerfile
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
#创建私钥
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
#修复SSH登录，否则登陆后的用户会被秒退�?
RUN mkdir -p /root/.ssh && chown root.root /root && chmod 700 /root/.ssh
#创建root用户的ssh文件�?
EXPOSE 22
#开放端�?
RUN echo 'root:redhat' | chpasswd
#root用户改密码为redhat
RUN yum install -y yum-priorities && rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm && rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6
RUN yum install tar gzip gcc vim wget screen -y
#安装epel和安装一些软�?
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
#系统环境变量
CMD ["/usr/sbin/sshd", "-D"]
#启动sshd
#End

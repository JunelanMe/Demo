FROM centos:7.2.1511
MAINTAINER Junelan <xiuju_lan@foxitsoftware.com>

RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
RUN cd /etc/yum.repos.d && curl http://mirrors.aliyun.com/repo/Centos-7.repo -o Centos-7.repo
RUN rpm -Uvh http://yum.puppetlabs.com/el/7Server/products/x86_64/puppetlabs-release-7-12.noarch.rpm
#RUN rpm -Uvhhttp://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-8.noarch.rpm
RUN yum makecache
RUN yum -y install sudo make puppet
RUN echo 'root:root' | chpasswd

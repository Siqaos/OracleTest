FROM oraclelinux
RUN yum -y install git
RUN yum -y install httpd
WORKDIR /var/www/html/
RUN git clone https://github.com/igameproject/Breakout.git .
RUN echo "ServerName localhost" >> /etc/httpd/conf/httpd.conf

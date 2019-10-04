FROM oraclelinux
RUN yum -y install git httpd openssl haproxy
WORKDIR /var/www/html/
RUN git clone https://github.com/igameproject/Breakout.git .
RUN echo "ServerName localhost" >> /etc/httpd/conf/httpd.conf
ADD ./gen-cer /home/
RUN mkdir /etc/ssl/private/
WORKDIR /home/
RUN chmod +x gen-cer
RUN ./gen-cer fadil.info
RUN mv fadil.info.pem /etc/ssl/private
RUN mv /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.old
RUN mkdir /run/haproxy/
ADD ./haproxy.cfg /etc/haproxy/

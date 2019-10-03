FROM oraclelinux
RUN yum -y install git
RUN yum -y install httpd
WORKDIR /var/www/html/
RUN git clone https://github.com/igameproject/Breakout.git .
RUN echo "ServerName localhost" >> /etc/httpd/conf/httpd.conf
RUN yum -y install openssl
ADD ./gen-cer /home/
RUN mkdir /etc/ssl/private/
WORKDIR /home/
RUN chmod +x gen-cer
RUN ./gen-cer fadil.info
RUN mv fadil.info.pem /etc/ssl/private
CMD ["httpd"]
ENTRYPOINT ["tail", "-f", "/dev/null"]



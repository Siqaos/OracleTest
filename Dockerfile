FROM oraclelinux:8
ARG username 
ARG password
ARG domain
WORKDIR /var/www/html/
RUN \ 
    useradd $username && \
    echo "$username:$password" | chpasswd && \
    yum update && \
    yum -y install git httpd openssl haproxy && \
    yum clean all && \
    echo "ServerName localhost" >> /etc/httpd/conf/httpd.conf && \
    mkdir -p /etc/ssl/private/ && \
    su $username && \
    git clone https://github.com/igameproject/Breakout.git . && \
    git checkout 68d7121 && \
    mkdir -p /run/haproxy/
COPY ./gen-cer /home/$username/
COPY ./haproxy.cfg /etc/haproxy/
COPY ./runservices.sh /home/$username/
RUN \
    cd /home/$username/ && \
    chmod +x gen-cer && \
    chmod +x runservices.sh && \
    ./gen-cer $domain $password && \
    mv key.pem /etc/ssl/private && exit
CMD ["bash","-c","haproxy -f /etc/haproxy/haproxy.cfg && httpd -DFOREGROUND"]


# PGX DevOps technical challenge
This repository include all necessary files to build and run the docker image asked as a technical test for the PGX DevOps job offer.
# Installation
All that is needed is a docker installation on your machine.
Use docker-compose command to build and run in detached mode.
```bash
git clone https://github.com/siqaos/oracletest.git
cd oracletest
docker-compose build
docker-compose up -d
```

Alternatively, you could also use the docker image stored in docker hub as the following :
```bash
docker pull siqaos/oracletest
docker run -d -p 0.0.0.0:443:443 -p 0.0.0.0:8080:80 siqaos/oracletest bash -c "httpd && haproxy -f /etc/haproxy/haproxy.cfg && tail -f /dev/null"
```
## Information
The certificate is self-generated everytime the image is built ( unless it's cached ).
after running the docker container you can access it through http://localhost (or in my case fadil.info)
It will redirect automatically to HTTPS (port 443).

## Benchmark
I was asked in the test to benchmark the docker container through 10 concurrent connection with 10000 requests.
I chose to use ApacheBenchmark included in the apache2-utils.
It's a neat tool that can output reports including response time and percentage served.

| WARNING: Benchmarking may vary depending on your configuration. |
| --- |

I'm using my VPS as a host and a laptop running the ApacheBenchmark program.

![Breakout online at fadil.info using https](https://github.com/Siqaos/OracleTest/blob/master/images/breakout.png)

You can see the self signed certificate here :

![enter image description here](https://github.com/Siqaos/OracleTest/blob/master/images/selfsigned.png)

Here is the output of the benchmark as well as graphs :

* Server Software:Apache/2.4.6 
* Server Hostname:fadil.info 
* Server Port:443 
* Document Path:/ 
* Document Length:760 bytes 
* Concurrency Level:10 
* Time taken for tests:372.200 seconds 
* Complete requests:10000 
* Failed requests:0
* Total transferred:10890000 bytes 
* HTML transferred:7600000 bytes 
* Requests per second:26.87


**Connection times**

||min | avg | max
|--|--|--|--|
|Connect|216|278 |1415
|Processing|80|93|212
|Total|296|371|1627

![Sequence](https://github.com/Siqaos/OracleTest/blob/master/images/sequence.jpg)

![Timeseries](https://github.com/Siqaos/OracleTest/blob/master/images/timeseries.jpg)

![Apache Benchmark output](https://github.com/Siqaos/OracleTest/blob/master/images/ab.png)

## Dockerfile weaknesses

Because of the challenge restriction to build a **single** docker image, the ability to spread the service into micro services (having apache:alpine and a haproxy run separately), as well as size optimizations, is lost.
Here is the current docker image architecture :


## Thank you
I would like to thank Alexandra for giving me this opportunity and her time, it was a pleasure talking with you,
I am confident that my skills will allow me to come in and succeed in this role, and it’s a position I’d be excited to take on because it will help me improve and acquire skills in both development and operations.
Thank you for taking the time to evaluate this work, I'm optimistic that this collaboration will be fruitful.

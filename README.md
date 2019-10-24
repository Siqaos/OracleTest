
# PGX DevOps technical challenge
This repository include all necessary files to build and run the docker image asked as a technical test for the PGX DevOps job offer.
# Installation
All that is needed is a docker installation on your machine.
Use docker-compose command to build and run in detached mode.
```bash
git clone https://github.com/siqaos/oracletest.git
cd oracletest
docker build . -t oracleweb --build-arg username=[username] --build-arg password=[password] --build-arg domain=[domain]
docker run -d -p 80:8000 -p 443:443 oracleweb
```

Alternatively, you could also use the docker image stored in docker hub as the following :
```bash
docker pull siqaos/oracleweb
docker run -d -p 443:443 -p 8000:80 siqaos/oracleweb
```
## Information
The certificate is self-generated everytime the image is built ( unless it's cached ).
after running the docker container you can access it through http://localhost (or in my case fadil.info)
It will redirect automatically to HTTPS (port 443).

![Breakout online at fadil.info using https](https://github.com/Siqaos/OracleTest/blob/master/images/breakout.png)

You can see the self signed certificate here :

![Selfsigned certificate](https://github.com/Siqaos/OracleTest/blob/master/images/selfsigned.png)

## Benchmark
I was asked in the test to benchmark the docker container through 10 concurrent connection with 10000 requests.
In the beginning I taught about creating my own python program, but figured that I should just use something already made than reinventing the wheel.
I chose to use ApacheBenchmark included in the apache2-utils.
It's a neat tool that can output reports including response time and percentage served.

| WARNING: Benchmarking may vary depending on your configuration. |
| --- |

I'm using my VPS as a host and a laptop running the ApacheBenchmark program.

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

For comparaison sake, I tried another program called Weighttp that is the same as ApacheBench but use multithreading to send concurrent requests.
Since Weighttp doesn't support ssl yet, the http response is 3XX (normal since the haproxy service automatically redirects http to https.
Doesn't give much details about the response time but shows that the server process around the same requests per second as ApacheBench.

![Weighttp](https://github.com/Siqaos/OracleTest/blob/master/images/weighttp.png)

From the apache benchmark output we can see that the server struggling around the end to respond to the requests, load balancing is a solution to remediate to this issue, more into that in the next chapter.

## Dockerfile weaknesses

Because of the challenge restriction to build a **single** docker image, the ability to spread the service into micro services (having apache:alpine and a haproxy run separately), as well as size optimizations, is lost.
Here is the current docker image architecture :

![Current image architecture](https://github.com/Siqaos/OracleTest/blob/master/images/currentarch.png)

As an example, here's a more flexible architecture to our docker container, we could use a smaller docker image containing an apache server that we could scale, as well as a shared volume ( or multiple depending on the demand ), and a load balancer that will round robin between the servers.
Scattering the services across multiple image make the administration and scaling easier :

![Current image architecture](https://github.com/Siqaos/OracleTest/blob/master/images/possiblearch.png)

Although this is from a **beginner persective**, I have still a lot to learn and this is just the beginning.

The simplifications used in this Dockerfile are many :
* Self-generated OpenSSL certificate.
* Git cloning directly from a non controlled public Github repository.
* Not using specific version for the oraclelinux image.
* Using a bigger package rather than a specific image for the task ( i.e httpd:<version>-alpine )
These simplifications either poses security threats or simply are unoptimized for a production environnement.
  
## Conclusion

I learned a lot in this Tech challenge, I learned how to operate with Haproxy, Gnuplot, dived more into Docker, I'm happy I have come this far.
I wish to learn more and dive deeper into DevOps, see how testing is done, and work in an experienced and unified team to produce a common result.
  
## Thank you
I would like to thank Alexandra for giving me this opportunity and her time, it was a pleasure talking with you,
I am confident that my skills will allow me to come in and succeed in this role, and it’s a position I’d be excited to take on because it will help me improve and acquire skills in both development and operations.
Thank you for taking the time to evaluate this work, I'm optimistic that this collaboration will be fruitful.

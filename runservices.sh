#!/bin/bash
httpd -DFOREGROUND && haproxy -f /etc/haproxy/haproxy.cfg

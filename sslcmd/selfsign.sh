#!/bin/bash
openssl req -new -newkey rsa -days 365 -nodes -x509 -subj "/C=CN/ST=Beijing/O=Personal/CN=myca" -keyout myca.key -out myca.crt -outform PEM

keytool -v -printcert -file myca.crt

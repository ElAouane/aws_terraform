#!/bin/bash


cd /home/ubuntu/AppFolder/app

export DB_HOST=mongodb://ip-10-0-1-100:27017/posts,ip-10-0-2-100:27017/posts,ip-10-0-3-100:27017/posts?replicaSet=rs0


node seeds/seed.js

node app.js &

sudo filebeat modules enable nginx






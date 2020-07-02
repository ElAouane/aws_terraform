#!/bin/bash

sudo systemctl enable mongod
sudo systemctl start mongod

mongo mongodb://ip-10-0-1-100 --eval 'rs.initiate({_id: "rs0", members: [{_id: 0, host: "ip-10-0-1-100:27017"}]})'
mongo mongodb://ip-10-0-1-100 --eval 'rs.add("ip-10-0-2-100:27017")'
mongo mongodb://ip-10-0-1-100 --eval 'rs.add("ip-10-0-3-100:27017")'
mongo mongodb://ip-10-0-1-100 --eval "db.isMaster().primary"
mongo mongodb://ip-10-0-1-100 --eval "rs.slaveOk()"


sleep 60; sudo systemctl restart metricbeat
sudo systemctl restart filebeat

sleep 180;
 sudo filebeat setup -e \
  -E output.logstash.enabled=false \
  -E output.elasticsearch.hosts=['10.0.105.100:9200'] \
  -E setup.kibana.host=10.0.105.101:5601 && sudo metricbeat setup

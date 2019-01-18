#!/bin/bash

HEADER="Content-Type: application/json"
DATA=$( cat << EOF
{
  "name": "replicator-dc2-to-dc1-topic1",
  "config": {
    "connector.class": "io.confluent.connect.replicator.ReplicatorSourceConnector",
    "topic.whitelist": "topic1",
    "key.converter": "io.confluent.connect.replicator.util.ByteArrayConverter",
    "value.converter": "io.confluent.connect.replicator.util.ByteArrayConverter",
    "src.kafka.bootstrap.servers": "broker-dc2:9092",
    "src.consumer.group.id": "replicator-dc2-to-dc1-topic1",
    "src.kafka.timestamps.producer.interceptor.classes": "io.confluent.monitoring.clients.interceptor.MonitoringProducerInterceptor",
    "src.kafka.timestamps.producer.confluent.monitoring.interceptor.bootstrap.servers": "broker-dc2:9092",
    "dest.kafka.bootstrap.servers": "broker-dc1:9091",
    "dest.kafka.replication.factor": 1,
    "provenance.header.enable": "true",
    "header.converter": "io.confluent.connect.replicator.util.ByteArrayConverter",
    "tasks.max": "1"
  }
}
EOF
)

curl -X POST -H "${HEADER}" --data "${DATA}" http://localhost:8381/connectors

FROM docker.elastic.co/beats/filebeat:6.8.3
LABEL Description="Listern logstash messages on UDP port and send them into elasticsearch" Vendor="512k"

COPY --chown=1000:1000 ./filebeat.yml /usr/share/filebeat/filebeat.yml

RUN set -xe \
  && chmod go-w /usr/share/filebeat/filebeat.yml \
  && filebeat version

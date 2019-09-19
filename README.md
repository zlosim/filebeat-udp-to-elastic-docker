<p align="center">
 <img src="https://hsto.org/webt/o4/zb/gr/o4zbgrru1fh7tlu85jpo727ghsk.png" width="450" alt="filebeat">
</p>

# Docker image with pre-configured Filebeat

[![Build][badge_automated]][link_hub]
[![Build][badge_build]][link_hub]
[![Docker Pulls][badge_pulls]][link_hub]
[![Issues][badge_issues]][link_issues]
[![License][badge_license]][link_license]

> [Filebeat][Filebeat] Filebeat is an open source file harvester, mostly used to fetch logs files and feed them into logstash.

## What is this?

Docker image with pre-configured Filebeat for collecting event on UDP port, decode JSON event message and send it to Elasticsearch.

## Supported tags

Tag name | Details                    | Full image name  | Dockerfile
:------: | :------------------------: | :--------------: | :--------:
`latest` | ![Size][badge_size_latest] | `512k/filebeat-udp-to-elastic:latest` | [link][dockerfile_latest]
`7`      | ![Size][badge_size_7]      | `512k/filebeat-udp-to-elastic:7`      | [link][dockerfile_7]
`6`      | ![Size][badge_size_6]      | `512k/filebeat-udp-to-elastic:6`      | [link][dockerfile_6]

[badge_size_latest]:https://images.microbadger.com/badges/image/512k/filebeat-udp-to-elastic:latest.svg
[badge_size_7]:https://images.microbadger.com/badges/image/512k/filebeat-udp-to-elastic:7.svg
[badge_size_6]:https://images.microbadger.com/badges/image/512k/filebeat-udp-to-elastic:6.svg
[dockerfile_latest]:https://github.com/512k/filebeat-udp-to-elastic-docker/blob/image-latest/Dockerfile
[dockerfile_7]:https://github.com/512k/filebeat-udp-to-elastic-docker/blob/image-7/Dockerfile
[dockerfile_6]:https://github.com/512k/filebeat-udp-to-elastic-docker/blob/image-6/Dockerfile

## Allowed environment variables

### Internal queue variables

Variable name | Default value | Сonfig equivalent | Description
:-----------: | :-----------: | :---------------: | :---------:
`FILEBEAT_MEM_EVENTS` | `4096` | `queue.mem.events` | Number of events the queue can store
`FILEBEAT_MEM_MIN_EVENTS` | `2048` | `queue.mem.flush.min_events` | Minimum number of events required for publishing. If this value is set to `0`, the output can start publishing events without additional waiting times. Otherwise the output has to wait for more events to become available
`FILEBEAT_MEM_TIMEOUT` | `1s` | `queue.mem.flush.timeout` | Maximum wait time for `flush.min_events` to be fulfilled. If set to `0s`, events will be immediately available for consumption

> Events will be immediately available for consumption when `queue.mem.flush.min_events` limit will be reached or when `queue.mem.flush.timeout`

### UDP input variables

Variable name | Default value | Сonfig equivalent | Description
:-----------: | :-----------: | :---------------: | :---------:
`UDP_MAX_MESSAGE_SIZE` | `10KiB` | `filebeat.inputs.max_message_size` | The maximum size of the message received over UDP
`UDP_LISTEN_PORT` | `5160` | `filebeat.inputs.host` | UDP port to listen on for event streams

### Processors variables

Variable name | Default value | Description
:-----------: | :-----------: | :---------:
`PROCESSORS_DECODE_FIELDS` | `message` | The fields containing `JSON` strings to decode. Support multiple fields, in format `field-name-1,field-name-2` _(config equivalent: `processors.decode_json_fields.fields`)_
`PROCESSORS_DECODE_PROCESS_ARRAY` | `false` | A boolean that specifies whether to process arrays _(config equivalent: `processors.decode_json_fields.process_array`)_
`PROCESSORS_DECODE_MAX_DEPTH` | `1` | The maximum parsing depth _(config equivalent: `processors.decode_json_fields.max_depth`)_
`PROCESSORS_DECODE_TARGET` | `-` | The field under which the decoded JSON will be written. By default the decoded JSON object replaces the string field from which it was read. To merge the decoded JSON fields into the root of the event, specify `target` with an empty string (`target: ""`). Note that the `null` value (`target:`) is treated as if the field was not set at all _(config equivalent: `processors.decode_json_fields.target`)_
`PROCESSORS_DECODE_OVERWRITE_KEYS` | `false` | A boolean that specifies whether keys that already exist in the event are overwritten by keys from the decoded JSON object _(config equivalent: `processors.decode_json_fields.overwrite_keys`)_
`PROCESSORS_DROP_FIELDS` | `message` | Specifies which fields to drop from event. Support multiple fields, in format `field-name-1,field-name-2` _(config equivalent: `processors.decode_json_fields.fields`)_

### Output Elasticsearch variables

Variable name | Default value | Description
:-----------: | :-----------: | :---------:
`ELASTIC_HOSTS` | `elasticsearch:9200` | The list of Elasticsearch nodes to connect to. The events are distributed to these nodes in round robin order. If one node becomes unreachable, the event is automatically sent to another node. Each Elasticsearch node can be defined as a `URL` or `IP:PORT`. For example: `http://192.15.3.2`, `https://es.found.io:9230` or `192.24.3.2:9300`. If no port is specified, `9200` is used _(config equivalent: `output.elasticsearch.hosts`)_
`ELASTIC_PROTOCOL` | `http` |  The name of the protocol Elasticsearch is reachable on. The options are: `http` or `https`. However, if you specify a URL for `output.elasticsearch.hosts`, the value of `protocol` is overridden by whatever scheme you specify in the URL _(config equivalent: `output.elasticsearch.protocol`)_
`ELASTIC_USERNAME` | `-` | The basic authentication username for connecting to Elasticsearch _(config equivalent: `output.elasticsearch.username`)_
`ELASTIC_PASSWORD` | `-` | The basic authentication username for connecting to Elasticsearch _(config equivalent: `output.elasticsearch.password`)_
`ELASTIC_INDEX_PREFIX` | `filebeat` | Prefix for index _(config equivalent: `output.elasticsearch.index`)_
`ELASTIC_INDEX_DATEFORMAT` | `yyyy.MM.dd` | Postfix for index. Only date format without `+` _(config equivalent: `output.elasticsearch.index`)_

> Index template looks like `${ELASTIC_INDEX_PREFIX}-%{+${ELASTIC_INDEX_DATEFORMAT}}`

## Запуск

### Docker CLI

```bash
$ docker run \
  -e ELASTIC_HOSTS="elasticsearch:9200" \
  -e UDP_LISTEN_PORT="5160" \
  512k/filebeat-udp-to-elastic:latest
```

### docker-compose

```yaml
services:
  filebeat:
    image: 512k/filebeat-udp-to-elastic:latest
    restart: on-failure
    environment:
      ELASTIC_HOSTS: 'http://elasticsearch:9200'
      UDP_LISTEN_PORT: 5160
      ELASTIC_INDEX_PREFIX: 'filebeat'
      ELASTIC_INDEX_DATEFORMAT: 'yyyy.MM.dd'
    ports:
      - 5160/udp
    depends_on:
      - elasticsearch
    networks:
      - app-network
```

### License

MIT. Use anywhere for your pleasure.

[badge_automated]:https://img.shields.io/docker/cloud/automated/512k/filebeat-udp-to-elastic.svg?style=flat-square&maxAge=30
[badge_pulls]:https://img.shields.io/docker/pulls/512k/filebeat-udp-to-elastic.svg?style=flat-square&maxAge=30
[badge_issues]:https://img.shields.io/github/issues/512k/filebeat-udp-to-elastic-docker.svg?style=flat-square&maxAge=30
[badge_build]:https://img.shields.io/docker/cloud/build/512k/filebeat-udp-to-elastic.svg?style=flat-square&maxAge=30
[badge_license]:https://img.shields.io/github/license/512k/filebeat-udp-to-elastic-docker.svg?style=flat-square&maxAge=30
[link_hub]:https://hub.docker.com/r/512k/filebeat-udp-to-elastic/
[link_license]:https://github.com/512k/filebeat-udp-to-elastic-docker/blob/master/LICENSE
[link_issues]:https://github.com/512k/filebeat-udp-to-elastic-docker/issues
[filebeat]:https://www.elastic.co/products/beats/filebeat

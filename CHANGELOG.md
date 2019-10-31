# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog][keepachangelog] and this project adheres to [Semantic Versioning][semver].

## 19.10.31

### Fixed

- Environment variable `ELASTIC_INDEX_DATEFORMAT` set only default value ([PR1], [PR2], [PR3]) for `6`, `7` and `latest` images

[PR1]:https://github.com/512k/filebeat-udp-to-elastic-docker/pull/1
[PR2]:https://github.com/512k/filebeat-udp-to-elastic-docker/pull/2
[PR3]:https://github.com/512k/filebeat-udp-to-elastic-docker/pull/3

## 19.9.19

### Added

- Dockerfile for `latest` (base image version `7.3.2`)
- Dockerfile for `7` (base image version `7.3.2`)
- Dockerfile for `6` (base image version `6.8.3`)

[keepachangelog]:https://keepachangelog.com/en/1.0.0/
[semver]:https://semver.org/spec/v2.0.0.html

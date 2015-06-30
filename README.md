# CrashPlan for Raspberry Pi 2

This is a Dockerfile to set up [CrashPlan](http://www.code42.com/crashplan/).

# Usage

```shell
$ docker run \
  -p 4242:4242
  -p 4243:4243
  -v /mnt/data:/data
  -v ./config:/config
  nunofgs/rpi-crashplan
```

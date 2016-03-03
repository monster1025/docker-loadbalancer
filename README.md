#### Nginx dynamic load balancer, based on consul services.
Based on https://github.com/monster1025/docker-loadbalancer repo.

You can use registrator to register services. 
This image registers only production tagged services.


#### Examples:
And here is example for consul server run using atlas:

```
docker run --name consul -h=hostname --restart=always -p 8300:8300 -p 8301:8301 -p 8301:8301/udp -p 8302:8302 -p 8302:8302/udp -p 8400:8400 -p 8500:8500 gliderlabs/consul-server -server -advertise 10.10.10.10 -atlas-join -atlas=******/infrastructure -atlas-token='LWdH***************zjk'
```

Example compose file:
```
version: '2'
services:
loadbalancer:
build: ./
container_name: loadbalancer
ports:
- "80:80"
restart: always
network_mode: host
```
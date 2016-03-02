FROM nginx:latest
MAINTAINER Shane Sveller <shane@bellycard.com>

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update -qq && \
    apt-get -y install curl vim unzip runit && \
    rm -rf /var/lib/apt/lists/*

ADD https://releases.hashicorp.com/consul-template/0.12.2/consul-template_0.12.2_linux_amd64.zip /usr/bin/
RUN unzip /usr/bin/consul-template_0.12.2_linux_amd64.zip -d /usr/local/bin
#ENV CT_URL https://releases.hashicorp.com/consul-template/0.13.0/consul-template_0.13.0_linux_amd64.zip
#RUN curl -L $CT_URL | tar -C /usr/local/bin --strip-components 1 -xf -

ADD nginx.service /etc/service/nginx/run
ADD consul-template.service /etc/service/consul-template/run

RUN rm -v /etc/nginx/conf.d/*
ADD nginx.conf /etc/consul-templates/nginx.conf
ADD nginx.html /var/www/index-template.html

CMD ["/usr/bin/runsvdir", "/etc/service"]

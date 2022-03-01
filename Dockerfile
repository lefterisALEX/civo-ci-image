FROM alpine:latest
ARG CIVO_CLI=1.22.0
ARG TERRAFORM=1.1.6


RUN echo -e "http://nl.alpinelinux.org/alpine/v3.5/main\nhttp://nl.alpinelinux.org/alpine/v3.5/community" > /etc/apk/repositories && apk add --update ca-certificates 
RUN apk add --update wget curl zip tar && \
    rm -rf /var/cache/apk/*

RUN wget https://github.com/civo/cli/releases/download/v1.0.22/civo-1.0.22-linux-amd64.tar.gz
RUN tar -xzvf civo-1.0.22-linux-amd64.tar.gz 
RUN mv civo /usr/local/bin/  
RUN chmod +x  /usr/local/bin/civo 
RUN apk add --update -t deps curl 
RUN curl -L "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl 
RUN chmod +x /usr/local/bin/kubectl 
RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM}/terraform_${TERRAFORM}_linux_amd64.zip 
RUN unzip terraform_${TERRAFORM}_linux_amd64.zip && rm -rf terraform_${TERRAFORM}_linux_amd64.zip 
RUN mv terraform  /usr/local/bin/  && chmod +x  /usr/local/bin/terraform

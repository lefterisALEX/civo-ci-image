FROM alpine:latest
ARG CIVO_CLI=1.0.22
ARG TERRAFORM=1.1.6


RUN echo -e "http://nl.alpinelinux.org/alpine/v3.5/main\nhttp://nl.alpinelinux.org/alpine/v3.5/community" > /etc/apk/repositories && apk add --update ca-certificates 
RUN apk add --update wget curl zip tar && \
    rm -rf /var/cache/apk/*

RUN wget https://github.com/civo/cli/releases/download/v${CIVO_CLI}/civo-${CIVO_CLI}-linux-amd64.tar.gz && tar -xzvf civo-${CIVO_CLI}-linux-amd64.tar.gz \
    && mv civo /usr/local/bin/  && rm -rf civo-${CIVO_CLI}-linux-amd64.tar.gz  \
    && chmod +x  /usr/local/bin/civo  \
    && apk add --update -t deps curl \
    && curl -L "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl \
    &&  chmod +x /usr/local/bin/kubectl \
    && wget https://releases.hashicorp.com/terraform/${TERRAFORM}/terraform_${TERRAFORM}_linux_amd64.zip \
    && unzip terraform_${TERRAFORM}_linux_amd64.zip && rm -rf terraform_${TERRAFORM}_linux_amd64.zip \
    && mv terraform  /usr/local/bin/  && chmod +x  /usr/local/bin/terraform

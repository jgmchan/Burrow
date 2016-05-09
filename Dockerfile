FROM golang:alpine

MAINTAINER Alex Nederlof "https://github.com/alexnederlof"

RUN adduser -S burrow

RUN apk add --update bash curl git && rm -rf /var/cache/apk/*

RUN cd /usr/local/bin && curl -O https://raw.githubusercontent.com/pote/gpm/v1.4.0/bin/gpm && chmod +x gpm

ADD . $GOPATH/src/github.com/linkedin/burrow
RUN cd $GOPATH/src/github.com/linkedin/burrow && gpm install && go install

USER burrow

ADD config /etc/burrow

CMD ["/go/bin/burrow", "--config", "/etc/burrow/burrow.cfg"]

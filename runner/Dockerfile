ARG GO_VERSION
FROM golang:${GO_VERSION}-alpine
RUN apk add git
ADD gocover.sh /
RUN chmod +x /gocover.sh
WORKDIR /go/src
ENTRYPOINT ["/gocover.sh"]

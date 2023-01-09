# Base
FROM golang:1.18.0-alpine AS builder

RUN apk add --no-cache git
RUN go install -v github.com/projectdiscovery/proxify/cmd/proxify@latest

FROM alpine:3.17.1
RUN apk -U upgrade --no-cache \
    && apk add --no-cache bind-tools ca-certificates
COPY --from=builder /go/bin/proxify /usr/local/bin/

ENTRYPOINT ["proxify"]

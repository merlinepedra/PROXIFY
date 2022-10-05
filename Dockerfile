# Base
FROM golang:1.19.2-alpine AS builder

RUN apk add --no-cache git
RUN go install -v github.com/projectdiscovery/proxify/cmd/proxify@latest

FROM alpine:3.15.0
RUN apk -U upgrade --no-cache \
    && apk add --no-cache bind-tools ca-certificates
COPY --from=builder /go/bin/proxify /usr/local/bin/

ENTRYPOINT ["proxify"]

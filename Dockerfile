FROM golang:alpine AS build_base
RUN apk add --no-cache git ca-certificates \
&& mkdir -p /go/src/github.com/everything411/ \
&& cd /go/src/github.com/everything411/ \
&& git clone https://github.com/everything411/nekobin.git
WORKDIR /go/src/github.com/everything411/nekobin
RUN go build -o nekobin

FROM alpine
RUN apk add ca-certificates
WORKDIR /app
COPY --from=build_base /go/src/github.com/everything411/nekobin/nekobin ./nekobin
COPY --from=build_base /go/src/github.com/everything411/nekobin/assets ./assets
COPY --from=build_base /go/src/github.com/everything411/nekobin/config-sample.yaml ./config.yaml

EXPOSE 5555

CMD ["./nekobin"]
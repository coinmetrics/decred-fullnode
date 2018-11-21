FROM golang:alpine as builder

RUN apk add --no-cache git

ARG VERSION

RUN set -ex; \
	git clone --depth 1 -b release-v${VERSION} https://github.com/decred/dcrd.git /root/dcrd; \
	cd /root/dcrd; \
	CGO_ENABLED=0 GOOS=linux GO111MODULE=on go install .



FROM alpine

RUN apk add --no-cache ca-certificates
COPY --from=builder /go/bin/* /bin/

ENTRYPOINT ["dcrd"]

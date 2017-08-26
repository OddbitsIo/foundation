FROM golang:1.8 as builder
WORKDIR /go/src/github.com/oddbitsio/api
COPY src/ .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app github.com/oddbitsio/api/rest-server

FROM alpine:latest  
RUN apk --no-cache add ca-certificates
WORKDIR /root
COPY --from=builder /go/src/github.com/oddbitsio/api/app .
CMD ["./app"]
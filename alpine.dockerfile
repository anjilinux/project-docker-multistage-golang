FROM golang as builder

WORKDIR /go/github.com/coding-latte/golang-docker-multistage-build-demo

COPY . .

RUN go get .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

# deployment image
FROM alpine:latest  
RUN apk --no-cache add ca-certificates

LABEL author="Maina Wycliffe"

WORKDIR /root/
COPY --from=builder /go/github.com/coding-latte/golang-docker-multistage-build-demo/app .

CMD [ "./app" ]

EXPOSE 8080
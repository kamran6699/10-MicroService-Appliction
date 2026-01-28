# Production Dockerfile (recreated) - productcatalogservice (Go / gRPC)

FROM golang:1.21-alpine AS builder
RUN apk add --no-cache ca-certificates git build-base
WORKDIR /src

COPY go.mod go.sum ./
RUN go mod download
COPY . .

ARG SKAFFOLD_GO_GCFLAGS
RUN CGO_ENABLED=0 go build -gcflags="${SKAFFOLD_GO_GCFLAGS}" -o /out/productcatalogservice .

FROM gcr.io/distroless/static-debian12:nonroot
WORKDIR /app
COPY --from=builder /out/productcatalogservice /app/server
COPY ./products.json /app/products.json

EXPOSE 3550
USER nonroot:nonroot
ENTRYPOINT ["/app/server"]


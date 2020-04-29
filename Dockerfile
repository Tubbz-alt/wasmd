# Simple usage with a mounted data directory:
# > docker build -t xrn .
# > docker run -it -p 46657:46657 -p 46656:46656 -v ~/.xrnd:/root/.xrnd -v ~/.xrncli:/root/.xrncli xrn xrnd init
# > docker run -it -p 46657:46657 -p 46656:46656 -v ~/.xrnd:/root/.xrnd -v ~/.xrncli:/root/.xrncli xrn xrnd start
FROM golang:alpine AS build-env

# Set up dependencies
ENV PACKAGES curl make git libc-dev bash gcc linux-headers eudev-dev python

# Set working directory for the build
WORKDIR /go/src/github.com/regen-network/wasmd

# Add source files
COPY . .

# Install minimum necessary dependencies, build Cosmos SDK, remove packages
RUN apk add --no-cache $PACKAGES && \
    make tools && \
    make install

# Final image
FROM alpine:edge

# Install ca-certificates
RUN apk add --update ca-certificates
WORKDIR /root

# Copy over binaries from the build-env
COPY --from=build-env /go/bin/xrnd /usr/bin/xrnd
COPY --from=build-env /go/bin/xrncli /usr/bin/xrncli

# Run xrnd by default, omit entrypoint to ease using container with xrncli
CMD ["xrnd"]

FROM rust:1.40.0-alpine AS build-stage

RUN mkdir -p /app
WORKDIR /app

COPY . /app
RUN cargo build --release --target x86_64-unknown-linux-musl

# runtime stage
FROM scratch

COPY --from=build-stage /app/target/release/multi-stage /usr/bin/multi-stage

ENTRYPOINT ["/usr/bin/multi-stage"]

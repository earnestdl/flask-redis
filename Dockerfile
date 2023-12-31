# syntax=docker/dockerfile:1.4
FROM --platform=$BUILDPLATFORM python:3.10-alpine AS builder

WORKDIR /usr/app-root
COPY . .

WORKDIR /usr/app-root/src
RUN --mount=type=cache,target=/root/.cache/pip \
    pip3 install -r requirements.txt

ENTRYPOINT ["python3"]
CMD ["app.py"]

FROM builder as dev-envs

RUN apk update; \
    apk add git bash curl

RUN addgroup -S docker; \
    adduser -S --shell /bin/bash --ingroup docker vscode

COPY --from=gloursdocker/docker / /

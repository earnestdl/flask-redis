# syntax=docker/dockerfile:1.4
FROM --platform=$BUILDPLATFORM python:3.10-alpine AS builder

WORKDIR /code

COPY requirements.txt /code
RUN --mount=type=cache,target=/root/.cache/pip \
    pip3 install -r requirements.txt

COPY . /code

ENTRYPOINT ["python3"]
CMD ["src/app.py"]

FROM builder as dev-envs

RUN apk update; \
    apk add git bash curl

RUN addgroup -S docker; \
    adduser -S --shell /bin/bash --ingroup docker vscode

COPY --from=gloursdocker/docker / /
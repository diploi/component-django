# syntax=docker/dockerfile:1.4

FROM --platform=linux/arm64 python:3.7-alpine AS builder

ARG FOLDER=/app

# Add user 1000 to docker containers - not root
COPY . /app
WORKDIR ${FOLDER}
# COPY requirements.txt ${FOLDER}
RUN pip3 install -r requirements.txt --no-cache-dir
ENTRYPOINT ["python3"] 
CMD ["manage.py", "runserver", "0.0.0.0:8000"]

FROM builder as dev-envs
RUN <<EOF
apk update
apk add git
EOF

RUN <<EOF
addgroup -S docker
adduser -S --shell /bin/bash --ingroup docker vscode
EOF
# install Docker tools (cli, buildx, compose)
EXPOSE 8000
COPY --from=gloursdocker/docker / /
CMD ["manage.py", "runserver", "0.0.0.0:8000"]

FROM ghcr.io/astral-sh/uv:python3.13-alpine AS base

ARG FOLDER=/app

WORKDIR ${FOLDER}

ENV UV_COMPILE_BYTECODE=1
ENV UV_LINK_MODE=copy
ENV UV_TOOL_BIN_DIR=/usr/local/bin


COPY . /app
RUN uv sync --locked --no-dev --group deploy

ENV PATH="$FOLDER/.venv/bin:$PATH"


FROM base AS release

WORKDIR ${FOLDER}

RUN apk add --no-cache shadow

RUN groupadd -g 1000 devgroup && \
    useradd -u 1000 -g 1000 -m devuser

RUN chown -R devuser:devgroup /app

RUN uv run --locked --no-dev python manage.py collectstatic --noinput

USER devuser

ENTRYPOINT []

EXPOSE 8000
ENV PORT=8000
ENV HOST="0.0.0.0"

CMD ["uv","run","gunicorn","djangoapp.wsgi:application","--bind", "0.0.0.0:8000","--workers", "3", "--log-level", "info"]
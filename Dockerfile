# ─── STAGE 1: Build / Install dependencies ───────────────────────────

FROM python:3.13-alpine AS base

ARG FOLDER=/app

WORKDIR ${FOLDER}

COPY . /app

RUN chown -R 1000:1000 /app

RUN pip3 wheel --no-cache-dir --no-deps -r requirements.txt -w /wheels

# ─── STAGE 2: Final image ────────────────────────────────────────────

FROM base AS release

WORKDIR ${FOLDER}

RUN apk add --no-cache shadow

RUN groupadd -g 1000 devgroup && \
    useradd -u 1000 -g 1000 -m devuser

# Copy the wheels and install them (faster, no compilation in this step)
COPY --from=base /wheels /wheels

RUN chown -R 1000:1000 /wheels

RUN pip3 install gunicorn --no-cache /wheels/*

# Copy the Django project code
COPY . /app/

RUN chown -R 1000:1000 /app

# Collect static files
RUN python manage.py collectstatic --noinput

USER devuser

#  Gunicorn listens on port 8000
EXPOSE 8000

#  Use Gunicorn with some sensible defaults:
CMD ["gunicorn", "djangoapp.wsgi:application", \
     "--bind", "0.0.0.0:8000", \
     "--workers", "3", \
     "--log-level", "info"]
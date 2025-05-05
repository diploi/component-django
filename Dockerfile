FROM python:3.13-alpine AS base

ARG FOLDER=/app

WORKDIR ${FOLDER}

COPY . /app

RUN pip3 wheel --no-cache-dir --no-deps -r requirements.txt -w /wheels

FROM base AS release

WORKDIR ${FOLDER}

RUN apk add --no-cache shadow

RUN groupadd -g 1000 devgroup && \
    useradd -u 1000 -g 1000 -m devuser

COPY --from=base /wheels /wheels

RUN chown -R devuser:devgroup /wheels

RUN pip3 install gunicorn --no-cache /wheels/*

RUN chown -R devuser:devgroup /app

RUN python manage.py collectstatic --noinput

USER devuser

EXPOSE 8000

CMD ["gunicorn", "djangoapp.wsgi:application", \
     "--bind", "0.0.0.0:8000", \
     "--workers", "3", \
     "--log-level", "info"]

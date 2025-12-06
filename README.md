<img alt="icon" src=".diploi/icon.svg" width="32">

# Django Component for Diploi

[![launch with diploi badge](https://diploi.com/launch.svg)](https://diploi.com/component/django)
[![component on diploi badge](https://diploi.com/component.svg)](https://diploi.com/component/django)
[![latest tag badge](https://badgen.net/github/tag/diploi/component-django)](https://diploi.com/component/django)

Start a demo, no card required
https://diploi.com/component/django

Getting started guide
https://diploi.com/blog/hosting_django_apps

A generic Django component ready to build your Django app.

This component was kickstarted running
`django-admin startproject djangoapp`
and it has `DEBUG=true` inside **settings.py** by default

**To secure your Django app,** you must **update your SECRET_KEY in settings.py**

By default all Django apps use SQlite, which you must update to use your database of choice inside **settings.py**

Uses the official [astral-sh/uv:3.13-alpine](https://github.com/astral-sh/uv/pkgs/container/uv) Docker image and Django

#### IMPORTANT
- You must generate a new SECRET_KEY for your own application
- Remember to update the database settings inside **settings.py** to match your own database config
- In production you must remember to update your **settings.py**, by changing `DEBUG=false` and if you want to use external CDNs for your static files, you will need to update the `STATIC_ROOT`
- For production and development, you are free to change the app server runner, so for example, if you prefer `uwsgi` you can change it directly on the Dockerfile for production and development
- To install new packages, this component uses `uv`, so you can add new packages using `uv add <name-of-package>`

## Operation

### Getting started

1. In the Dashboard, click **Create Project +**
2. Under **Pick Components**, choose **Django**
3. In **Pick Add-ons**, you can add one or multiple databases to your app
4. Choose **Create Repository**, which will generate a new GitHub repo
5. Now click **Launch Stack**

### Development

Will run
`uv sync`
when component is first initialized, and `uv run --isolated python3 manage.py runserver 0.0.0.0:8000` when deployment is started.

### Production

Will build a production ready image. The first step runs the command:
`uv sync --locked --no-dev --group deploy`
Which installs **gunicorn**, as part of `--group=deploy` in `pyproject.toml`, to install all necessary dependencies for production.

To get all static files, the image runs the command:
`uv run --locked --no-dev python manage.py collectstatic --noinput` to get all static files.

Lastly, the image will start the production server with the command:
`uv run gunicorn djangoapp.wsgi:application --bind 0.0.0.0:8000 --workers 3 --log-level info`

### Common tasks (using uv)

- Create a superuser  
  `uv run python manage.py createsuperuser`

- Run migrations  
  `uv run python manage.py migrate`

- Switch the database to Postgres instead of SQLite  
  1. Install the Postgres driver (already present in `pyproject.toml`, but if missing run `uv add "psycopg2-binary"`).  
  2. In `djangoapp/settings.py`, set `DATABASES["default"]` to read from `DATABASE_URL` (e.g. using `env.dj_db_url` if `environs[django]` is installed). A typical value:  
     `postgres://postgres:postgres@postgres.postgres:5432/app`  
  3. Export `DATABASE_URL` in your environment (or add to `.env`), then run `uv run python manage.py migrate`.

- Adjust CSRF trusted origins  
  In `djangoapp/settings.py`, the list comes from `CSRF_TRUSTED_ORIGINS` env var. Add hosts as a comma-separated list, e.g.:  
  `export CSRF_TRUSTED_ORIGINS="https://example.com,https://admin.example.com"`  
  After updating, restart the app so Django picks up the new origins.

## Links

- [Adding Django to a project](https://docs.diploi.com/building/components/django)
- [Django for production](https://docs.djangoproject.com/en/5.2/howto/deployment/checklist/)
- [Django static files](https://docs.djangoproject.com/en/5.2/howto/static-files/)
- [SECRET_KEY in Django](https://docs.djangoproject.com/en/5.2/ref/settings/#std-setting-SECRET_KEY)
- [Databases in Django](https://docs.djangoproject.com/en/5.2/ref/databases/)
- [Working with multiple databases in Django](https://docs.djangoproject.com/en/5.2/topics/db/multi-db/)

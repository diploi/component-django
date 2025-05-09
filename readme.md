<img alt="icon" src=".diploi/icon.svg" width="32">

# Django Component for Diploi

A generic Django component ready to build your Django app.

This component was kickstarted running
`django-admin startproject djangoapp`
and it has `DEBUG=true` inside **settings.py** by default

Uses the official [python:3.13-alpine](https://hub.docker.com/_/python/) Docker image.

## Operation

### Development

Will run
`pip3 install -r requirements.txt --no-cache-dir`
when component is first initialized, and `python3 manage.py runserver 0.0.0.0:8000` when deployment is started.

### Production

Will build a production ready image. Image runs
`pip3 wheel --no-cache-dir --no-deps -r requirements.txt -w /wheels` & `pip3 install gunicorn --no-cache /wheels/*`
to install all necessary dependencies and
`python manage.py collectstatic --noinput` to get all static files. Once the image runs, production is started using the command
`gunicorn djangoapp.wsgi:application --bind 0.0.0.0:8000 --workers 3 --log-level info`

#### IMPORTANT
- In production you must remember to update your **settings.py**, by changing `DEBUG=false` and if you want to use external CDNs for your static files, you will need to update the `STATIC_ROOT`
- For production and development, you are free to change the app server runner, so for example, if you prefer `uwsgi` you can change it directly on the Dockerfile for production and development

## Links

- [Django for production](https://docs.djangoproject.com/en/4.2/howto/deployment/checklist/)
- [Django static files](https://docs.djangoproject.com/en/4.2/howto/static-files/)

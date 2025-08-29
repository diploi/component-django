<img alt="icon" src=".diploi/icon.svg" width="32">

# Django Component for Diploi

Start a demo, no card required
https://diploi.com/component/django

A generic Django component ready to build your Django app.

This component was kickstarted running
`django-admin startproject djangoapp`
and it has `DEBUG=true` inside **settings.py** by default

To secure your Django app, you must update your SECRET_KEY in **settings.py**

By default all Django apps use SQlite, which you must update to use your database of choice inside **settings.py**

Uses the official [python:3.13-alpine](https://hub.docker.com/_/python/) Docker image and Django 5.2.3

## Operation

### Getting started

1. In the Dashboard, click **Create Project +**
2. Under **Pick Components**, choose **Django**
3. In **Pick Add-ons**, you can add one or multiple databases to your app
4. Choose **Create Repository**, which will generate a new GitHub repo
5. Now click **Launch Stack**

Full guide https://diploi.com/blog/hosting_django_apps

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
- You must generate a new SECRET_KEY for your own application
- Remember to update the database settings inside **settings.py** to match your own database config
- In production you must remember to update your **settings.py**, by changing `DEBUG=false` and if you want to use external CDNs for your static files, you will need to update the `STATIC_ROOT`
- For production and development, you are free to change the app server runner, so for example, if you prefer `uwsgi` you can change it directly on the Dockerfile for production and development

## Links

- [Django for production](https://docs.djangoproject.com/en/5.2/howto/deployment/checklist/)
- [Django static files](https://docs.djangoproject.com/en/5.2/howto/static-files/)
- [SECRET_KEY in Django](https://docs.djangoproject.com/en/5.2/ref/settings/#std-setting-SECRET_KEY)
- [Databases in Django](https://docs.djangoproject.com/en/5.2/ref/databases/)
- [Working with multiple databases in Django](https://docs.djangoproject.com/en/5.2/topics/db/multi-db/)

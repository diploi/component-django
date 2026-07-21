"""
URL configuration for djangoapp project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.http import HttpResponse
from django.urls import path


def home(request):
    return HttpResponse(
        """
        <!DOCTYPE html>
        <html>
        <head>
            <title>Django</title>
            <meta name="viewport" content="width=device-width, initial-scale=1" />
            <style>
            * {
                font-family: sans-serif;
                font-size: 16px;
            }

            html,
            body {
                margin: 0;
                min-height: 100vh;
                background: #202328;
                color: #fff;
            }

            body {
                display: flex;
                flex-direction: column;
                gap: 8px;
                padding: 32px;
                align-items: center;
                justify-content: center;
                box-sizing: border-box;
            }

            h1 {
                font-size: 24px;
            }

            p,
            form,
            hr {
                max-width: min(400px, 100%);
            }

            p {
                text-align: center;
                opacity: 0.8;
                line-height: 1.5;
            }

            button,
            .button {
                padding: 10px 18px;
                align-self: center;
                text-decoration: none;
                background: #6650fa;
                border-radius: 64px;
                border: none;
                color: #fff;
                cursor: pointer;
            }

            a {
                font-size: inherit;
                color: inherit;
            }

            hr {
                display: block;
                margin: 32px 0;
                width: 100%;
                height: 2px;
                background: #31363f;
                border: none;
            }

            a:last-child {
                margin-top: 32px;
            }

            code {
                font-family: monospace;
                font-size: 14px;
                background: #31363f;
                padding: 2px 4px;
                border-radius: 4px;
            }
            </style>
        </head>
        <body>
            <img
                alt="Django logo"
                src="https://github.com/diploi/component-django/raw/main/.diploi/icon.svg"
                width="64"
                height="64"
            />

            <h1>Django</h1>

            <p>
                Your Django application is up and running! You can start editing the code in
                <code>djangoapp</code> to build your application.
                In development stage, Django will automatically reload as you make changes.
                <br><br>
                <b>Install dependencies:</b><br>
                Please use <code>uv add package_name</code> to add Python packages to your environment.
            </p>

            <hr />

            <a href="https://diploi.com/">
                <img
                    alt="Diploi"
                    width="54"
                    height="16"
                    src="https://diploi.com/logo-white.svg"
                />
            </a>
        </body>
        </html>
        """,
        content_type="text/html",
    )


urlpatterns = [
    path('', home, name='home'),
    path('admin/', admin.site.urls),
]

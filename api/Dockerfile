FROM python:3.10

RUN pip install "poetry==1.1.13"

WORKDIR /src

COPY poetry.lock pyproject.toml /src/
RUN poetry config virtualenvs.create false && poetry install --no-interaction --no-ansi
RUN pip install gunicorn
COPY . /src

RUN python manage.py collectstatic --no-input

# RUN docker run --env-file provisioning/.env.production -p 80:8000 telecom-api gunicorn app.wsgi:application --bind 0.0.0.0:8000

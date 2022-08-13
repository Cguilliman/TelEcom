FROM python:3.10

RUN pip install "poetry==1.1.13"

WORKDIR /src

COPY poetry.lock pyproject.toml /src/
RUN poetry config virtualenvs.create false && poetry install --no-interaction --no-ansi
COPY . /src

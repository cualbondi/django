FROM python:2

MAINTAINER Cualbondi

ENV APP_PATH=/usr/src/app

# Add postgresql repository
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        osm2pgsql \
        osmctools \
        libgeos-dev \
        gdal-bin \
        git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR $APP_PATH

ONBUILD COPY requirements.txt $APP_PATH/

ONBUILD RUN pip install -r requirements.txt

ONBUILD COPY . $APP_PATH/

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
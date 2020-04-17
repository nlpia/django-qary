#!/usr/bin/env bash
set -e

echo ''
if [ "$1" == 'prod' ]
then
<<<<<<< HEAD
    MIDATA_HOST_PATH=/midata/public
    mkdir -p $MIDATA_HOST_PATH

    echo "STOPPING ALL CONTAINERS!!!"
    docker-compose down -v --remove-orphans

    echo ''
    echo "Building !PROD! docker image ..."
    docker-compose -f docker-compose.prod.yml up -d
    docker-compose -f docker-compose.prod.yml exec web python manage.py migrate upload --no-input

    echo ''
    echo "Starting PROD containers for the webapp at http://localhost/ ..."
    docker-compose -f docker-compose.prod.yml exec web python manage.py collectstatic upload --no-input --clear
=======
    MIDATA_HOST_PATH="$HOME/midata/public"
    mkdir -p $MIDATA_HOST_PATH

    echo "STOPPING ALL CONTAINERS!!!"
    docker-compose -f docker-compose.prod.yml down -v --remove-orphans

    echo ''
    echo "Bringing up docker-compose.prod.yml docker images ..."
    docker-compose -f docker-compose.prod.yml up -d --build

    echo "Migrating DB in PROD containers with exec web python manage.py migrate (without --no-input)"
    docker-compose  -f docker-compose.prod.yml exec --user app web python manage.py migrate

    echo ''
    echo "Collecting static in PROD containers for the webapp with exec web python manage.py collect static ..."

    docker-compose  -f docker-compose.prod.yml exec --user app web python manage.py collectstatic --no-input  # --clear
>>>>>>> unstable
elif [ "$1" == 'dev' ]
then
    MIDATA_HOST_PATH="$HOME/midata/public"
    mkdir -p $MIDATA_HOST_PATH

    echo "STOPPING ALL CONTAINERS!!!"
<<<<<<< HEAD
    docker-compose down -v --remove-orphans

    echo ''
    echo "Building development docker image with nginx path=$MIDATA_HOST_PATH ..."
    docker-compose -f docker-compose.dev.yml up -d
    docker-compose -f docker-compose.def.yml exec web python manage.py migrate upload --no-input

    echo ''
    echo "Starting development containers for the webapp at http://localhost:8000/ ..."
    docker-compose -e MIDATA_HOST_PATH=$MIDATA_HOST_PATH -f docker-compose.dev.yml exec web python manage.py collectstatic --no-input --clear
elif [ "$1" == 'stop' ]
then
    echo "STOPPING ALL CONTAINERS!!!"
    docker-compose down -v --remove-orphans
=======
    docker-compose -f docker-compose.dev.yml down -v --remove-orphans

    echo ''
    echo "Building development docker image with nginx path=$MIDATA_HOST_PATH ..."
    docker-compose -f docker-compose.dev.yml up -d --build
    echo "Running exec web python manage.py migrate (without --no-input)"
    docker-compose -f docker-compose.dev.yml exec web python manage.py migrate

    echo ''
    echo "Starting development containers for the webapp at http://localhost:8000/ ..."
    docker-compose -f docker-compose.dev.yml exec web python manage.py collectstatic --no-input --clear
elif [ "$1" == 'stop' ]
then
    echo "STOPPING ALL CONTAINERS!!!"
    docker-compose -f docker-compose.prod.yml down -v --remove-orphans
    docker-compose -f docker-compose.dev.yml down -v --remove-orphans
>>>>>>> unstable
fi

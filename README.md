# README

This application is based on Ruby on Rails and we run our development environment with Docker.

## Dependencies

Docker and Docker-compose ([https://docs.docker.com/get-docker/])

## Installation

Simply download the app and run:

```
docker-compose build
```

This will build the Docker image and install all dependencies.

## Initial setup (mostly just needed to run once)

Install all `node-modules`:

```
docker-compose run app yarn install
```

Run database container once:

```
docker-compose up db
```

And after the db container first runs and automatically sets up for the first time, you can then quit it with `CTRL+C`

Create development and test databases:

```
docker-comopose run app rails db:create
```

That's it! Now we should be able to properly run the app.

## Running the application

```
docker-compose up
```

This command will start a container with for the application along with a container for the database.

You can then access the application at [http://localhost:3000]

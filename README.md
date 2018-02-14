# Docker for Front-End

This is a quick guide for setting up a development environment for front-end applications using Docker.

What is Docker? How is it different from Vagrant?

Check out the official [Get Started](https://docs.docker.com/get-started/) guide.

## Why Docker?

Docker can save us from the JavaScript fatigue.

- We have to constantly switch node versions between projects and it gets annoying even with a tool like [n](https://github.com/tj/n).
- Yarn, NPM, we constantly switch around how we manage packages.
- Many times, we just want projects to be up and running on localhost without having to type series of commands that is unique to each project.

## Project Setup

For the demonstration purpose, this document will specifically cover how to containerize an app created with [create-react-app](https://github.com/facebook/create-react-app)

### Pre-requisite

- npm@5.2.0 (for npx)
- Docker for [Mac](https://www.docker.com/docker-mac) / [Windows](https://www.docker.com/docker-windows)

### Create a new React app

Run following command(s):

- `npx create-react-app myapp`

## Docker Setup

Copy following files to your project:

- [Dockerfile](Dockerfile) - Setup image and used for deployment.
- [docker-compose.yml](docker-compose.yml) - Setup local environment.
- [docker-entrypoint.sh](docker-entrypoint.sh) - Run series of shell commands.

Run following command(s):

- `docker-compose up`

Sit back and grab a cup of :coffee: because it’ll take awhile.

- Open [http://localhost:3000/](http://localhost:3000/) ✨

## Install new packages

What’s the point of container if we still `npm intall` packages from host machine with a node version different from what’s inside the container?

You can execute a command to use your container’s npm to install new packages that is also reflected back in your host machine to check-in.

- Get your container ID with `docker ps -a`
- Install your package `docker exec <container_id> npm install <package>`

## Destroy

You can destroy Docker container with:

- `docker-compose down`

Additionally, you can remove container:

- `docker ps -a`
- `docker rm <container_id>`

Finally, you can remove image:

- `docker images`
- `docker rmi <image_id>`

## Deployment

When you deploy a container, the container host will generally read [Dockerfile](Dockerfile). It is important that your Dockerfile is written to setup a complete container that runs production code.

This example assumes you have [Dokku installed on Digital Ocean](https://www.digitalocean.com/products/one-click-apps/dokku/).

Create a new app using Dokku command:

- `dokku apps:create <APP>`

Expose the port defined in Dockefile, which is 3000 in this example.

- `dokku proxy:ports-add <APP> http:80:3000 http:3000:3000`

Git push the latest code up to the remote:

- `git remote add dokku dokku@<DOMAIN>:<APP>`
- `git push`

Your app should now be available under the app domain.

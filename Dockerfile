# https://docs.docker.com/engine/reference/builder/
# > Docker can build images automatically by reading the instructions from a Dockerfile. A Dockerfile is a text document that contains all the commands a user could call on the command line to assemble an image. Using docker build users can create an automated build that executes several command-line instructions in succession.

# https://docs.docker.com/engine/reference/builder/#from
# > The FROM instruction initializes a new build stage and sets the Base Image for subsequent instructions. As such, a valid Dockerfile must start with a FROM instruction. The image can be any valid image – it is especially easy to start by pulling an image from the Public Repositories.
# https://hub.docker.com/_/node/
FROM node:latest

# https://docs.docker.com/engine/reference/builder/#workdir
# > The WORKDIR instruction sets the working directory for any RUN, CMD, ENTRYPOINT, COPY and ADD instructions that follow it in the Dockerfile. If the WORKDIR doesn’t exist, it will be created even if it’s not used in any subsequent Dockerfile instruction.
WORKDIR /app

# https://docs.docker.com/engine/reference/builder/#add
# > The ADD instruction copies new files, directories or remote file URLs from <src> and adds them to the filesystem of the image at the path <dest>.
ADD . /app

### DEPLOYMENT ###

# https://docs.docker.com/engine/reference/builder/#expose
# > The EXPOSE instruction informs Docker that the container listens on the specified network ports at runtime. You can specify whether the port listens on TCP or UDP, and the default is TCP if the protocol is not specified.
EXPOSE 5000

# https://docs.docker.com/engine/reference/builder/#run
# > The RUN instruction will execute any commands in a new layer on top of the current image and commit the results. The resulting committed image will be used for the next step in the Dockerfile.
RUN npm install
RUN npm run build

# https://docs.docker.com/engine/reference/builder/#cmd
# > The main purpose of a CMD is to provide defaults for an executing container. These defaults can include an executable, or they can omit the executable, in which case you must specify an ENTRYPOINT instruction as well.
CMD ["npx", "serve", "-s", "build"]

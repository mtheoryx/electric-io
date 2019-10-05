#
# Create a base install layer
FROM node:10.14.1-alpine as install

# Create and change into a directory in the container
WORKDIR /usr/app

# Install app dependencies
COPY ./package.json ./package-lock.json ./
RUN npm install --silent

#
# Create the application development layer
FROM node:10.14.1-alpine as develop

# Ports
EXPOSE 3000

# Create and change into a directory in the container
WORKDIR /usr/app

# Copy our dependencies from previous install layer
COPY --from=install /usr/app/. .

# App source
COPY . .

#
# Create the application testing layer
# If the tests fail, this container will not build
FROM node:10.14.1-alpine as testing

# Create and change into a directory in the container
WORKDIR /usr/app

# We already have everything we need in the develop layer
COPY --from=develop /usr/app/. .

# Run our tests
RUN npm run test

#
# @TODO: Create the production install and build layer
FROM node:10.14.1-alpine as production-install

# Create and change into a directory in the container
WORKDIR /usr/app

# Now we install for PRODUCTION only
COPY ./package.json ./package-lock.json ./
RUN npm install --silent --production

# App source
COPY . .

#
# @TODO: Create the production file layer
FROM node:10.14.1-alpine as production

# Create and change into a directory in the container
WORKDIR /usr/app

# Now we build for PRODUCTION only
COPY --from=production-install /usr/app/. .
RUN npm run build:production

EXPOSE 3000

#
# @TODO: Create the production hosting layer
# @TODO: We need to separate the client and server first

#
# @TODO: Create the production file layer
# @TODO: We need to separate the client and server first

# Default Command - This is never used
CMD [""]

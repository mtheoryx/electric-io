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

# Default Command
CMD ["npm", "run", "start"]

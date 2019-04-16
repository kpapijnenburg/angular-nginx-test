#Tutorial used: https://medium.com/@tiangolo/angular-in-docker-with-nginx-supporting-environments-built-with-multi-stage-docker-builds-bb9f1724e984

# Stage 0, "build-stage", based on Node.js, to build and compile the frontend
# This image uses tiangolo for drontend multistage buidling
# Check https://hub.docker.com/r/tiangolo/node-frontend/ for more information.
FROM tiangolo/node-frontend:10 as build-stage

# Set working directory to the app folder. 
WORKDIR /app

# Copy all files that start with package and end with json. 
COPY package*.json /app/

RUN npm install

# Copy source code
COPY ./ /app/

# Create argument for configuration.
ARG configuration=production

# Build application to the ./dist/out folder. this folder will be used by nginx later.
RUN npm run build -- --output-path=./dist/out --configuration $configuration

# Stage 1, based on Nginx, to have only the compiled app, ready for production with Nginx
FROM nginx:1.15

# Copy files from the build stage /out folder to the nginx directory.
COPY --from=build-stage /app/dist/out/ /usr/share/nginx/html

# Copy the default nginx.conf provided by tiangolo/node-frontend
COPY --from=build-stage /nginx.conf /etc/nginx/conf.d/default.conf

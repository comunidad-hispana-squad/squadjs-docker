ARG SQUADJS_VERSION="4.2.0"
ARG NODE_VERSION=18
#ARG YARN_VERSION=1.22 # For doc purposes yarn is already installed.


# Stage 1: Build environment
FROM node:${NODE_VERSION} AS build

WORKDIR /app

# Make ARG available for run command.
ARG SQUADJS_VERSION
ENV SQUADJS_VERSION="${SQUADJS_VERSION}"

RUN echo "SquadJS Version: $SQUADJS_VERSION" && \
    echo "Node Version: $NODE_VERSION"

RUN curl -L -o SquadJS.zip "https://github.com/Team-Silver-Sphere/SquadJS/archive/refs/tags/v${SQUADJS_VERSION}.zip" && \
    unzip SquadJS.zip && \
    mv SquadJS-${SQUADJS_VERSION} SquadJS && \
    ls -lah && \
    rm SquadJS.zip && \
    yarn --cwd="./SquadJS" --ignore-optional install


# Stage 2: Production environment
FROM node:${NODE_VERSION}-slim AS prod

LABEL maintainer="Comunidad Hispana de Squad"
LABEL version=${SQUADJS_TAG}
LABEL description="Production ready docker container for SquadJS"

WORKDIR /app

# Copy necessary files from the build stage
COPY --from=build /app/SquadJS ./

RUN npm install -g pm2

CMD ["pm2-runtime", "start", "index.js"]

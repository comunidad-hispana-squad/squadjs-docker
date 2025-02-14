# SquadJS Docker

This is a docker image for [SquadJS](https://github.com/Team-Silver-Sphere).
Runs with pm2 to mantain the process uptime and uses the `-slim` image to reduce image size.

## Using the image

```yaml
services:
    squadjs:
        image: squadjs-docker
        volumes:
        - ./my-config.json:/app/config.json
```



## Upgrading the image

Change the `ARG` as required. Increase the `version` label.
Create a new release.

### Versions

The image will always target the versions defined in the [Prerequisites](https://github.com/Team-Silver-Sphere/SquadJS?tab=readme-ov-file#prerequisites) section.


## Working locally

```bash
docker build . -t squadjs-docker

docker run --rm -it \
    -v "./test/minimal-config.json:/app/config.json" \
    -v "./test/test.log:/app/test/test.log" \
    localhost/squadjs-docker
```
# SquadJS Docker

This is a docker image for [SquadJS](https://github.com/Team-Silver-Sphere).
Runs with pm2 to mantain the process uptime and uses the `-slim` image to reduce image size.

## Using the image

Check the examples on the `examples` folder.

```yaml
services:
    squadjs:
        image: squadjs-docker
        volumes:
        - ./my-config.json:/app/config.json
        - /squad/logs/:/logs
```

### Config management

You can either mount a volume to hook up the configuration or provide a `config` environmental with the json configuration.

### Logs

When using `ftp` or `sftp` no special configuration is required.
If you want to use the `tail` method you will need to mount the logs folder and point the configuration to the mounted path.

### Sqlite database

SquadJS can run with a SQLite database. If nothing is done by default this database will be wiped every restart.

Use either a volume our a mount point to not loose the data.


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
    -v "./test/test.log:/logs/SquadGame.log" \
    localhost/squadjs-docker
```

Add `-v "./test/database.sqlite:/app/database.sqlite" \` if you want to persist the sqlite db.

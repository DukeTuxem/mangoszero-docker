## Docker generic build system for the mangos server repositories.

The Dockerfile is here to build a docker container with all the dependencies required to compile two important binaries:

- realmd (for authentication on the client side)
- mangosd (the game, or world server)

The container once built then run, will have some folders mapped to this repository, so it will compile the source code, and makes the output (binaries and config) available locally.

This process needs to be done before running docker-compose which will rely on generated binaries, this way it will just execute each of them in a dedicated container.

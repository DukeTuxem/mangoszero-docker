# Deployer project around mangos repository using Docker

Get your own instance of mangos (zero for now) running by issuing two commands!

## Why this project ?

Because installing dependencies and setting up server configuration for a host is always time-consuming.

On top of relieving you a little from those steps, docker offers an abstraction from your OS, so you can be running a server without installing any required part of it.

Finally all your files are at the same place and any pre-existing config can be loaded so back up is made easy.

## Getting started

### Clone

Start cloning the repository using this command, then change dir:
```sh
$> git clone https://github.com/DukeTuxem/mangoszero-docker --recursive --shallow-submodules

$> cd mangos-docker
```

### Build

From here, run "compile-mangos.sh" script contained in build, with root privileges since it will call the docker daemon:

```sh
$> sudo ./build/compile-mangos.sh
```
Once this step done, the binaries along with config files will be placed to the right folders.

### Config

Either create your config from the generated files or paste yours into:

```
./realmd/etc/realmd.conf
./world/etc/mangosd.conf
./world/etc/ahbot.conf

```
Note that the hostname will be the container names, defined in the docker-compose.yml file so it would look like this:
```
# Important: set DataDir like so:

DataDir                      = "../data"
LogsDir                      = "../logs"
LoginDatabaseInfo            = "db;3306;root;password;realmd"
WorldDatabaseInfo            = "db;3306;root;password;mangos0"
CharacterDatabaseInfo        = "db;3306;root;password;character0"
```

### Data

Now refer to the world/data/README.md file to place the data folders (maps) the server will need.

### Create DB

Tip: If you don't have a database, I would suggest you to just run the db service, so it will be created without the realmd and world services asking to connect meanwhile.

To do so:

```sh
$> sudo docker-compose up db
```
Once data has been loaded, and when you see a:
```
[Note] mysqld: ready for connections.
```
hit Ctrl+c once, wait for it to be closed.

### Finally

Use a database editor (I used Dbeaver on Linux but there are plenty) to edit your realmlist table under realmd database and modify the name and address field.

Address field is your external IP, internal if you only intend to connect under your network.

### Run and enjoy !

```sh
$> sudo docker-compose up
```
Ctrl+c to kill process

### Additionnal information

Only tested on Linux.

The server repository is cloned from the mangos-build docker image, but you can find the sources after compilation at:
```
mangos-docker/world/src/server
```

The database data (usually at /var/lib/mysql) will be held inside the mangos-docker/db/data/ folder. Everything is created under root account.

#### Versions used (for reference)

Docker: docker-compose version 1.25.3

Docker-compose: Docker version 19.03.5-ce

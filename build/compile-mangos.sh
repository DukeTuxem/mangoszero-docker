#!/bin/bash

sudo docker build -t mangos-build:zero ./build

sudo docker run -v `pwd`/world:/world -v `pwd`/realmd:/realmd mangos-build:zero

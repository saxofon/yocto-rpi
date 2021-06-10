# A pure Yocto / RaspberryPi4 platform


## Initial setup

Fetch the project project repo as

```
git clone https://github.com/saxofon/yocto-rpi.git
```

## Build

```
make images
```

## Build accelerations

Cache for downloads and sstate is setup in lib.mk/0-env.mk

Download cache is used directly from beginning and all downloads end up here.

Sstate cache is empty and needs to be updated when we so whishes. Like after a good build
after a uplift, after a release build and such. There is a makefile rule for this :

```
make sstate-update
```

## Build via container

In case your host is to modern/old, cannot install additional tools or so (but still have
docker/container support) there is some convenient rules to setup a build container image,
start it and have a shell for it for build purposes.

To create the container image
```
make build-container-image
```
This uses a container setup file as of dockerfiles/yocto-builder. It can easily be adjusted
in case more host tools or so is needed for some specific platform build.

Start the container
```
make build-container-start
```
This starts the container via docker utility in detached mode.

Start the build container shell
```
make build-container-shell
```
When there is need for building, we can get a shell this way.

Direct execute of a command in the build container
```
make build-container-exec CMD=top
```
For automating/scripting things, this would be the "API".

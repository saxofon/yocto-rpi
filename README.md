# A pure Yocto platform


## Initial setup

Fetch the project repo as

```
git clone https://github.com/saxofon/yocto-rpi.git
```

## Configuration
### Layers

#### Adding existing layers to project build
Layers are added in top Makefile, via "LAYERS +=" assignments.

#### Adding new layers
If it is a new project only layer, then add layer to this repository layers directory and to LAYERS.
If it is a new external layer, then apart from adding it to LAYERS there needs to be a lib.mk/layer-index/my-new-layer.mk fragment added. This fragment defines URL and default revision (usually master or $(BASE)).

#### Lock layer revision
Locking of poky and layer revisions is made via "make update-layer-lock" so that we get
reproducable builds with same sw base.
We can view the layers and their locked commits in layer-versions.txt
```
builder@1901a526558c:/src$ cat layer-versions.txt
# meta-filesystems is an embedded layer in meta-openembedded
# meta-initramfs is an embedded layer in meta-openembedded
meta-javascripts_rev := 9a0c97e935a8bc4e17a62baa7f619ff5aa295742
meta-marine-instruments_rev := 9ab86ccb5f3c7b429badcf8d9563b32c50582a01
# meta-networking is an embedded layer in meta-openembedded
# meta-oe is an embedded layer in meta-openembedded
meta-openembedded_rev := 0b0ab6a2d227f22374268d29fcb8e4f9dab5374b
# meta-perl is an embedded layer in meta-openembedded
# meta-project-setup is a local project layer
# meta-python is an embedded layer in meta-openembedded
meta-raspberrypi_rev := b4ec97e4eb8e36efd1f7e2f8ae020a9e55cfc239
poky_rev := f6ad205e1adb16f8bde715302f6a1d23ec7fba62
builder@1901a526558c:/src$
```

## Build
Building is done via a build container and container volumes for downloads, sstate cache and
the build output. Artifacts from the build can be exported to artifacts directory which is a
local directory not in any container volume. The download volume is shared amongst all projects
whereas the sstate cache and build volumes are per project. This accelerates yocto builds so
that instead of taking 1h or more we should see these numbers (made on a fairly simple laptop) :

#### Rebuild without change
```
builder@1901a526558c:/src$ time make images

### Shell environment set up for builds. ###

You can now run 'bitbake <target>'

Common targets are:
    core-image-minimal
    core-image-full-cmdline
    core-image-sato
    core-image-weston
    meta-toolchain
    meta-ide-support

You can also run generated qemu images with a command like 'runqemu qemux86'

Other commonly useful commands are:
 - 'devtool' and 'recipetool' handle common recipe tasks
 - 'bitbake-layers' handles common layer tasks
 - 'oe-pkgdata-util' handles common target package tasks
Loading cache: 100% |#################################################################| Time: 0:00:00
Loaded 3783 entries from dependency cache.
NOTE: Resolving any missing task queue dependencies

Build Configuration:
BB_VERSION           = "1.50.0"
BUILD_SYS            = "x86_64-linux"
NATIVELSBSTRING      = "universal"
TARGET_SYS           = "aarch64-poky-linux"
MACHINE              = "raspberrypi4-64"
DISTRO               = "poky"
DISTRO_VERSION       = "3.3.4"
TUNE_FEATURES        = "aarch64 armv8a crc crypto cortexa72"
TARGET_FPU           = ""
meta
meta-poky
meta-yocto-bsp       = "HEAD:f6ad205e1adb16f8bde715302f6a1d23ec7fba62"
meta-javascripts     = "master:9a0c97e935a8bc4e17a62baa7f619ff5aa295742"
meta-marine-instruments = "master:9ab86ccb5f3c7b429badcf8d9563b32c50582a01"
meta-filesystems
meta-initramfs
meta-networking
meta-oe
meta-perl
meta-python          = "HEAD:0b0ab6a2d227f22374268d29fcb8e4f9dab5374b"
meta-raspberrypi     = "HEAD:b4ec97e4eb8e36efd1f7e2f8ae020a9e55cfc239"
meta-project-setup   = "master:b8324c8b69a0f6128ad0d4b59db8afc293d58e01"

Initialising tasks: 100% |############################################################| Time: 0:00:01
Sstate summary: Wanted 44 Local 44 Network 0 Missed 0 Current 1386 (100% match, 100% complete)
NOTE: Executing Tasks
NOTE: Tasks Summary: Attempted 3657 tasks of which 3657 didn't need to be rerun and all succeeded.

real    0m5.616s
user    0m0.540s
sys     0m0.112s
builder@1901a526558c:/src$
```

#### Rebuild with a packaged added (in this case gpsd, that needed some dependencies as well)
```
builder@1901a526558c:/src$ time make images

### Shell environment set up for builds. ###

You can now run 'bitbake <target>'

Common targets are:
    core-image-minimal
    core-image-full-cmdline
    core-image-sato
    core-image-weston
    meta-toolchain
    meta-ide-support

You can also run generated qemu images with a command like 'runqemu qemux86'

Other commonly useful commands are:
 - 'devtool' and 'recipetool' handle common recipe tasks
 - 'bitbake-layers' handles common layer tasks
 - 'oe-pkgdata-util' handles common target package tasks
Loading cache: 100% |#################################################################| Time: 0:00:00
Loaded 3783 entries from dependency cache.
Parsing recipes: 100% |###############################################################| Time: 0:00:00
Parsing of 2436 .bb files complete (2435 cached, 1 parsed). 3783 targets, 353 skipped, 0 masked, 0 errors.
NOTE: Resolving any missing task queue dependencies

Build Configuration:
BB_VERSION           = "1.50.0"
BUILD_SYS            = "x86_64-linux"
NATIVELSBSTRING      = "universal"
TARGET_SYS           = "aarch64-poky-linux"
MACHINE              = "raspberrypi4-64"
DISTRO               = "poky"
DISTRO_VERSION       = "3.3.4"
TUNE_FEATURES        = "aarch64 armv8a crc crypto cortexa72"
TARGET_FPU           = ""
meta
meta-poky
meta-yocto-bsp       = "HEAD:f6ad205e1adb16f8bde715302f6a1d23ec7fba62"
meta-javascripts     = "master:9a0c97e935a8bc4e17a62baa7f619ff5aa295742"
meta-marine-instruments = "master:9ab86ccb5f3c7b429badcf8d9563b32c50582a01"
meta-filesystems
meta-initramfs
meta-networking
meta-oe
meta-perl
meta-python          = "HEAD:0b0ab6a2d227f22374268d29fcb8e4f9dab5374b"
meta-raspberrypi     = "HEAD:b4ec97e4eb8e36efd1f7e2f8ae020a9e55cfc239"
meta-project-setup   = "project/yacht-server:4f4a4c122722165fab27980bed4ccd87bced886b"

Initialising tasks: 100% |############################################################| Time: 0:00:01
Sstate summary: Wanted 76 Local 43 Network 0 Missed 33 Current 1354 (56% match, 97% complete)
Removing 2 stale sstate objects for arch raspberrypi4_64: 100% |######################| Time: 0:00:00
NOTE: Executing Tasks
NOTE: Tasks Summary: Attempted 3657 tasks of which 3577 didn't need to be rerun and all succeeded.

real    2m3.945s
user    0m0.816s
sys     0m0.114s
builder@1901a526558c:/src$
```


#### Update sstate cache
When project moves on, new additions can be pushed to sstate cache in order to accelerate
builds also for these new additions :

```
make sstate-update
```

Commonly done during new release build in a pipeline or so.

#### To create the container image
```
make build-container-image
```
This uses a container setup file as of dockerfiles/yocto-builder. It can easily be adjusted
in case more host tools or so is needed for some specific platform build.

#### Start the container
```
make build-container-start
```
This starts the container via docker utility in detached mode.

#### Start the build container shell for interactive usage
```
make build-container-shell
```
When there is need for interactive building, during development or so, we can get a shell this way.

### Direct execute of a command in the build container
```
make build-container-exec CMD=top
```
For automating/scripting things, this would be the "API".

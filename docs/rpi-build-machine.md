# Small build server

We can also do small build servers, like a Raspberry Pi 5 for example :)

## full build
```
per@bj-rpi5-1:~/fs/rpi/yocto-rpi $ make build-container-start
259c307abb7d7c318048b4cd96ab2ad2c6c9251c0a4043515a121b1a11be9dff
per@bj-rpi5-1:~/fs/rpi/yocto-rpi $ make build-container-shell
builder@259c307abb7d:/src$ time make images
Cloning into bare repository 'git.yoctoproject.org.poky.git'...
remote: Enumerating objects: 677822, done.
remote: Counting objects: 100% (46/46), done.
remote: Compressing objects: 100% (41/41), done.
remote: Total 677822 (delta 5), reused 31 (delta 5), pack-reused 677776
Receiving objects: 100% (677822/677822), 213.44 MiB | 33.76 MiB/s, done.
Resolving deltas: 100% (492497/492497), done.
Cloning into '/build/poky'...
done.
branch 'scarthgap' set up to track 'origin/scarthgap'.
Switched to a new branch 'scarthgap'
Cloning into bare repository 'github.com.openembedded.meta-openembedded.git'...
remote: Enumerating objects: 273881, done.
remote: Counting objects: 100% (2848/2848), done.
remote: Compressing objects: 100% (991/991), done.
remote: Total 273881 (delta 2151), reused 1962 (delta 1854), pack-reused 271033 (from 2)
Receiving objects: 100% (273881/273881), 78.28 MiB | 30.29 MiB/s, done.
Resolving deltas: 100% (163997/163997), done.
Cloning into '/build/layers/meta-openembedded'...
done.
branch 'scarthgap' set up to track 'origin/scarthgap'.
Switched to a new branch 'scarthgap'
Cloning into bare repository 'git.yoctoproject.org.meta-raspberrypi'...
remote: Enumerating objects: 11408, done.
remote: Counting objects: 100% (7/7), done.
remote: Compressing objects: 100% (7/7), done.
remote: Total 11408 (delta 1), reused 0 (delta 0), pack-reused 11401
Receiving objects: 100% (11408/11408), 3.50 MiB | 15.19 MiB/s, done.
Resolving deltas: 100% (6617/6617), done.
Cloning into '/build/layers/meta-raspberrypi'...
done.
branch 'scarthgap' set up to track 'origin/scarthgap'.
Switched to a new branch 'scarthgap'
You had no conf/local.conf file. This configuration file has therefore been
created for you from /build/poky/meta-poky/conf/templates/default/local.conf.sample
You may wish to edit it to, for example, select a different MACHINE (target
hardware).

You had no conf/bblayers.conf file. This configuration file has therefore been
created for you from /build/poky/meta-poky/conf/templates/default/bblayers.conf.sample
To add additional metadata layers into your configuration please add entries
to conf/bblayers.conf.

The Yocto Project has extensive documentation about OE including a reference
manual which can be found at:
    https://docs.yoctoproject.org

For more information about OpenEmbedded see the website:
    https://www.openembedded.org/

This is the default build configuration for the Poky reference distribution.

### Shell environment set up for builds. ###

You can now run 'bitbake <target>'

Common targets are:
    core-image-minimal
    core-image-full-cmdline
    core-image-sato
    core-image-weston
    meta-toolchain
    meta-ide-support

You can also run generated qemu images with a command like 'runqemu qemux86-64'.

Other commonly useful commands are:
 - 'devtool' and 'recipetool' handle common recipe tasks
 - 'bitbake-layers' handles common layer tasks
 - 'oe-pkgdata-util' handles common target package tasks
NOTE: Starting bitbake server...
This is the default build configuration for the Poky reference distribution.

### Shell environment set up for builds. ###

You can now run 'bitbake <target>'

Common targets are:
    core-image-minimal
    core-image-full-cmdline
    core-image-sato
    core-image-weston
    meta-toolchain
    meta-ide-support

You can also run generated qemu images with a command like 'runqemu qemux86-64'.

Other commonly useful commands are:
 - 'devtool' and 'recipetool' handle common recipe tasks
 - 'bitbake-layers' handles common layer tasks
 - 'oe-pkgdata-util' handles common target package tasks
WARNING: Host distribution "ubuntu-24.04" has not been validated with this version of the build system; you may possibly experience unexpected failures. It is recommended that you use a tested distribution.
Loading cache: 100% |                                                                                                           | ETA:  --:--:--
Loaded 0 entries from dependency cache.
Parsing recipes: 100% |##########################################################################################################| Time: 0:03:22
Parsing of 2875 .bb files complete (0 cached, 2875 parsed). 4880 targets, 351 skipped, 0 masked, 0 errors.
NOTE: Resolving any missing task queue dependencies

Build Configuration:
BB_VERSION           = "2.8.0"
BUILD_SYS            = "aarch64-linux"
NATIVELSBSTRING      = "ubuntu-24.04"
TARGET_SYS           = "aarch64-poky-linux"
MACHINE              = "raspberrypi4-64"
DISTRO               = "poky"
DISTRO_VERSION       = "5.0.7"
TUNE_FEATURES        = "aarch64 crc cortexa72"
TARGET_FPU           = ""
meta                 
meta-poky            
meta-yocto-bsp       = "scarthgap:7a06e2daa719ca0cac9905988f72bb0cb546c7b5"
meta-filesystems     
meta-initramfs       
meta-networking      
meta-oe              
meta-perl            
meta-python          = "scarthgap:6c9f1f8d4538119803bf793747b65e4d23c33544"
meta-raspberrypi     = "scarthgap:6df7e028a2b7b2d8cab0745dc0ed2eebc3742a17"
meta-project-setup   = "<unknown>:<unknown>"

NOTE: Fetching uninative binary shim http://downloads.yoctoproject.org/releases/uninative/4.6/aarch64-nativesdk-libc-4.6.tar.xz;sha256sum=c2d36338272eba101580f648dd8dff5352cdb4c1809db7dedf8fc4d7e7df716c (will check PREMIRRORS first)
Sstate summary: Wanted 2706 Local 0 Mirrors 0 Missed 2706 Current 0 (0% match, 0% complete)###########################           | ETA:  0:00:00
Initialising tasks: 100% |#######################################################################################################| Time: 0:00:04
NOTE: Executing Tasks
NOTE: Tasks Summary: Attempted 5672 tasks of which 0 didn't need to be rerun and all succeeded.

Summary: There was 1 WARNING message.

real	318m10.324s
user	1m29.588s
sys	0m14.542s
builder@259c307abb7d:/src$
```

So the full build from scratch without populated caches (downloads as well as sstate) took about 5.5h.

Caches (downloads and sstate) are contained in docker volumes, and so is the build sandbox.
These will stick even though we stop the build container and such and we can
reuse them in other builds :

```
per@bj-rpi5-1:~/fs/rpi/yocto-rpi $ list-docker-volumes.sh 
yocto-cache-downloads 7.5G
yocto-cache-sstate 5.3G
yocto-project-base 51.3G
per@bj-rpi5-1:~/fs/rpi/yocto-rpi $ time make images
This is the default build configuration for the Poky reference distribution.

### Shell environment set up for builds. ###

You can now run 'bitbake <target>'

Common targets are:
    core-image-minimal
    core-image-full-cmdline
    core-image-sato
    core-image-weston
    meta-toolchain
    meta-ide-support

You can also run generated qemu images with a command like 'runqemu qemux86-64'.

Other commonly useful commands are:
 - 'devtool' and 'recipetool' handle common recipe tasks
 - 'bitbake-layers' handles common layer tasks
 - 'oe-pkgdata-util' handles common target package tasks
WARNING: Host distribution "ubuntu-24.04" has not been validated with this version of the build system; you may possibly experience unexpected failures. It is recommended that you use a tested distribution.
Loading cache: 100% |############################################################################################################| Time: 0:00:01
Loaded 4880 entries from dependency cache.
NOTE: Resolving any missing task queue dependencies

Build Configuration:
BB_VERSION           = "2.8.0"
BUILD_SYS            = "aarch64-linux"
NATIVELSBSTRING      = "universal"
TARGET_SYS           = "aarch64-poky-linux"
MACHINE              = "raspberrypi4-64"
DISTRO               = "poky"
DISTRO_VERSION       = "5.0.7"
TUNE_FEATURES        = "aarch64 crc cortexa72"
TARGET_FPU           = ""
meta                 
meta-poky            
meta-yocto-bsp       = "scarthgap:7a06e2daa719ca0cac9905988f72bb0cb546c7b5"
meta-filesystems     
meta-initramfs       
meta-networking      
meta-oe              
meta-perl            
meta-python          = "scarthgap:6c9f1f8d4538119803bf793747b65e4d23c33544"
meta-raspberrypi     = "scarthgap:6df7e028a2b7b2d8cab0745dc0ed2eebc3742a17"
meta-project-setup   = "<unknown>:<unknown>"

Sstate summary: Wanted 0 Local 0 Mirrors 0 Missed 0 Current 2706 (0% match, 100% complete)############################           | ETA:  0:00:00
Initialising tasks: 100% |#######################################################################################################| Time: 0:00:05
NOTE: Executing Tasks
NOTE: Tasks Summary: Attempted 5672 tasks of which 5672 didn't need to be rerun and all succeeded.

Summary: There was 1 WARNING message.

real	0m21.244s
user	0m1.582s
sys	0m0.303s
builder@259c307abb7d:/src$
```

So... the next build took only 21 seconds, not to shabby of a simple RPi5, eh? :)
But will differ of course depending on how much changes we do.
Here we add a package into our rootfs and do a build again:

```
per@bj-rpi5-1:~/fs/rpi/yocto-rpi $ git diff
diff --git a/layers/meta-project-setup/recipes-core/images/core-image-full-cmdline.bbappend b/layers/meta-project-setup/recipes-core/images/core-image-full-cmdline.bbappend
index 9678b39..d107679 100644
--- a/layers/meta-project-setup/recipes-core/images/core-image-full-cmdline.bbappend
+++ b/layers/meta-project-setup/recipes-core/images/core-image-full-cmdline.bbappend
@@ -4,4 +4,5 @@ IMAGE_INSTALL += "iw"
 IMAGE_INSTALL += "kernel-modules"
 IMAGE_INSTALL += "linux-firmware-bcm43430"
 IMAGE_INSTALL += "raspi-gpio"
+IMAGE_INSTALL += "tcpdump"
 IMAGE_INSTALL += "wireless-regdb-static"
per@bj-rpi5-1:~/fs/rpi/yocto-rpi $ 
```

And now in the build container we build it :
```
builder@259c307abb7d:/src$ time make images
This is the default build configuration for the Poky reference distribution.

### Shell environment set up for builds. ###

You can now run 'bitbake <target>'

Common targets are:
    core-image-minimal
    core-image-full-cmdline
    core-image-sato
    core-image-weston
    meta-toolchain
    meta-ide-support

You can also run generated qemu images with a command like 'runqemu qemux86-64'.

Other commonly useful commands are:
 - 'devtool' and 'recipetool' handle common recipe tasks
 - 'bitbake-layers' handles common layer tasks
 - 'oe-pkgdata-util' handles common target package tasks
WARNING: Host distribution "ubuntu-24.04" has not been validated with this version of the build system; you may possibly experience unexpected failures. It is recommended that you use a tested distribution.
Loading cache: 100% |############################################################################################################| Time: 0:00:01
Loaded 4880 entries from dependency cache.
Parsing recipes: 100% |##########################################################################################################| Time: 0:00:01
Parsing of 2875 .bb files complete (2874 cached, 1 parsed). 4880 targets, 351 skipped, 0 masked, 0 errors.
NOTE: Resolving any missing task queue dependencies

Build Configuration:
BB_VERSION           = "2.8.0"
BUILD_SYS            = "aarch64-linux"
NATIVELSBSTRING      = "universal"
TARGET_SYS           = "aarch64-poky-linux"
MACHINE              = "raspberrypi4-64"
DISTRO               = "poky"
DISTRO_VERSION       = "5.0.7"
TUNE_FEATURES        = "aarch64 crc cortexa72"
TARGET_FPU           = ""
meta                 
meta-poky            
meta-yocto-bsp       = "scarthgap:7a06e2daa719ca0cac9905988f72bb0cb546c7b5"
meta-filesystems     
meta-initramfs       
meta-networking      
meta-oe              
meta-perl            
meta-python          = "scarthgap:6c9f1f8d4538119803bf793747b65e4d23c33544"
meta-raspberrypi     = "scarthgap:6df7e028a2b7b2d8cab0745dc0ed2eebc3742a17"
meta-project-setup   = "<unknown>:<unknown>"

Sstate summary: Wanted 22 Local 0 Mirrors 0 Missed 22 Current 2703 (0% match, 99% complete)###########################           | ETA:  0:00:00
Removing 3 stale sstate objects for arch raspberrypi4_64: 100% |#################################################################| Time: 0:00:00
NOTE: Executing Tasks
NOTE: Tasks Summary: Attempted 5710 tasks of which 5660 didn't need to be rerun and all succeeded.

Summary: There was 1 WARNING message.

real	4m31.150s
user	0m2.451s
sys	0m0.352s
builder@259c307abb7d:/src$
```

Still quite decent actually for the little fellow. But I will not have a RPi5 as a build
server actually but instead some NUC format factor or similar so lets do same trials here :)


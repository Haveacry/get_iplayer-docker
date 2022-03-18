# get_iplayer on Docker

[![](https://images.microbadger.com/badges/image/speedst3r/get-iplayer.svg)](https://microbadger.com/images/speedst3r/get-iplayer "Get your own image badge on microbadger.com")

[Get_iPlayer](https://github.com/get-iplayer/get_iplayer) A utility for downloading TV and radio programmes from BBC iPlayer, that is currently in active development.

## Usage
    docker create \
    --name get_iplayer \
    -p 8181:8181 \
    -v /etc/localtime:/etc/localtime:ro \
    -v </path/to/config>:/root/.get_iplayer \
    -v </path/to/downloads>:/root/output \
    ghcr.io/speedst3r/get-iplayer

* Backup your current config and recordings.
* Mount `/root/.get_iplayer` to your config directory.  This should include your `options` file and `pvr` directory.  If starting from scratch, you can manually edit the `options` file created here.
* Mount `/root/output` to your recordings location.

**WARNING - get_iplayer stores cookies in your browser for some default settings.  Because of this, at least try to see if you can find those cookies and remove them BEFORE loading the newly installed container.  For example, if you have set the recordings path in the webgui, this overrides the location in the `options` file for downloads.**

## Start
Upon first start, it will download the latest get_iplayer scripts from the official github repo <https://github.com/get-iplayer/get_iplayer>.
* When starting this for the first time, it will create some nice newbie default options (enable whitespace in filenames, download subtitles, etc.).
* When starting this using existing configuration files, it will forcibly change the output location to the container's output volume location, thus hopefully, it should "just work".

## Updating
 There is a cron job that runs daily that checks the latest release of get_iplayer, and downloads it.  It then checks to see if the pvr is running, before killing the perl process, which automatically gets restarted using the new version of the get_iplayer script.  This is different from other docker containers in that the version of get_iplayer in this container is not statically included in the container, leading to a stale container.

To do a manual update, you just need to re-create this container and it will have the latest version from the get_iplayer repo.  I use Portainer <https://hub.docker.com/r/portainer/portainer/> to manage my containers, and I just need to hit the `Recreate` button.

**Watchtower <https://github.com/v2tec/watchtower> will not update this container to the latest version of get_iplayer by its self.  Until Docker introduces monitoring of alternative github repos for automated container builds (which trigger watchtower), this auto-update method is the best you can get.**

## Issues
* Report issues with this dockerfile <https://github.com/speedst3r/get_iplayer/issues>
* Report issues with the get_iplayer script <https://squarepenguin.co.uk/forums/>

## About me
Just a small-time tinkerer of almost anything computer-related (servers, raspi, networks, programming, android, etc.).  I am active on various places on the net, like StackExchange, github, and some mailing lists, etc., so ping me a message about anything - if I don't know, I'll know where to go to find out!

## Todo
1. Check different base os's for Dockerfile
2. Remove as much gumf as possible

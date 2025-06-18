# get_iplayer on Docker

[![](https://images.microbadger.com/badges/image/haveacry/get-iplayer.svg)](https://microbadger.com/images/haveacry/get-iplayer "Get your own image badge on microbadger.com")

[Get_iPlayer](https://github.com/get-iplayer/get_iplayer) A utility for downloading TV and radio programmes from BBC iPlayer, that is currently in active development.

## Usage
    docker create \
    --name get_iplayer \
    -p 8181:8181 \
    -v /etc/localtime:/etc/localtime:ro \
    -v </path/to/config>:/root/.get_iplayer \
    -v </path/to/downloads>:/root/output \
    ghcr.io/haveacry/get-iplayer

* Backup your current config and recordings.
* Mount `/root/.get_iplayer` to your config directory.  This should include your `options` file and `pvr` directory.  If starting from scratch, you can manually edit the `options` file created here.
* Mount `/root/output` to your recordings location.

**WARNING - get_iplayer stores cookies in your browser for some default settings.  Because of this, at least try to see if you can find those cookies and remove them BEFORE loading the newly installed container.  For example, if you have set the recordings path in the webgui, this overrides the location in the `options` file for downloads.**

## Start
* When starting this for the first time, it will create some nice newbie default options (enable whitespace in filenames, download subtitles, etc.).
* When starting this using existing configuration files, it will forcibly change the output location to the container's output volume location, thus hopefully, it should "just work".

## Updating
This container is rebuilt automatically when a new release of get_iplayer upstream is published. Utilities that monitor for new versions of the container or new tags should pick up the new version.

## Issues
* Report issues with this dockerfile <https://github.com/haveacry/get_iplayer/issues>
* Report issues with the get_iplayer script <https://squarepenguin.co.uk/forums/>

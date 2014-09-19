# box
lightweight online judge for CS problems
## Requirements
You need everything you would need to manually judge problem solutions, but there are a few special requirements.
### C/C++
You need `libseccomp`. We patch the C runtime to support secure computing mode.
### Turing
The compiler and VM both require `libseccomp`.
## Compatibility
### IE 6
Good luck. YMMV
### Reverse proxies
The editor contents are backed up across multiple cookies, depending how much code there is to save. If a reverse proxy sets a cookie, it could truncate saved code.
## Setup
0. ```bash
git clone --recursive $repo && cd src # also make sure you have the submodules```
0. ```bash
make -C ace # optionally configure ACE before building```
0. Mount `/bin`, `/lib`, `/usr`, and `/tmp` for the container in `rootfs/`. Example of how to use bind mounts: `src/old/bind.sh`
0. ```bash
make```
0. Either:
```bash
cd .. && ./server.py # use wsgiref.simple_server```
or point your server at the WSGI app `server.py`. Example config: `src/wsgi-scriptalias-box.conf.sample`
0. Edit `config`.

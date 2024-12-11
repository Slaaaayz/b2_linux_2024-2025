# TP1 : Premiers pas Docker

# I. Init

## 3. sudo c pa bo

**🌞 Ajouter votre utilisateur au groupe docker**

```bash
slayz@debian:~$ sudo usermod -aG docker slayz

slayz@debian:~$ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

## 4. Un premier conteneur en vif

**🌞 Lancer un conteneur NGINX**

```bash
slayz@debian:~$ docker run -d -p 9999:80 nginx
Unable to find image 'nginx:latest' locally
latest: Pulling from library/nginx
bc0965b23a04: Pull complete 
650ee30bbe5e: Pull complete 
8cc1569e58f5: Pull complete 
362f35df001b: Pull complete 
13e320bf29cd: Pull complete 
7b50399908e1: Pull complete 
57b64962dd94: Pull complete 
Digest: sha256:fb197595ebe76b9c0c14ab68159fd3c08bd067ec62300583543f0ebda353b5be
Status: Downloaded newer image for nginx:latest
c79a172fb023f1d1f5aa11caee7cbca8aa30d0abf826353bbdac5dd3957a1867
```

**🌞 Visitons**

```bash
slayz@debian:~$ docker ps 
CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS         PORTS                                     NAMES
c79a172fb023   nginx     "/docker-entrypoint.…"   2 minutes ago   Up 2 minutes   0.0.0.0:9999->80/tcp, [::]:9999->80/tcp   focused_ritchie

slayz@debian:~$ docker logs c79
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Sourcing /docker-entrypoint.d/15-local-resolvers.envsh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2024/12/11 09:23:51 [notice] 1#1: using the "epoll" event method
2024/12/11 09:23:51 [notice] 1#1: nginx/1.27.3
2024/12/11 09:23:51 [notice] 1#1: built by gcc 12.2.0 (Debian 12.2.0-14) 
2024/12/11 09:23:51 [notice] 1#1: OS: Linux 6.1.0-27-amd64
2024/12/11 09:23:51 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2024/12/11 09:23:51 [notice] 1#1: start worker processes
2024/12/11 09:23:51 [notice] 1#1: start worker process 29
2024/12/11 09:23:51 [notice] 1#1: start worker process 30
2024/12/11 09:23:51 [notice] 1#1: start worker process 31
2024/12/11 09:23:51 [notice] 1#1: start worker process 32
2024/12/11 09:23:51 [notice] 1#1: start worker process 33
2024/12/11 09:23:51 [notice] 1#1: start worker process 34
2024/12/11 09:23:51 [notice] 1#1: start worker process 35
2024/12/11 09:23:51 [notice] 1#1: start worker process 36
2024/12/11 09:23:51 [notice] 1#1: start worker process 37
2024/12/11 09:23:51 [notice] 1#1: start worker process 38
2024/12/11 09:23:51 [notice] 1#1: start worker process 39
2024/12/11 09:23:51 [notice] 1#1: start worker process 40
2024/12/11 09:23:51 [notice] 1#1: start worker process 41
2024/12/11 09:23:51 [notice] 1#1: start worker process 42
2024/12/11 09:23:51 [notice] 1#1: start worker process 43
2024/12/11 09:23:51 [notice] 1#1: start worker process 44
2024/12/11 09:23:51 [notice] 1#1: start worker process 45
2024/12/11 09:23:51 [notice] 1#1: start worker process 46
2024/12/11 09:23:51 [notice] 1#1: start worker process 47
2024/12/11 09:23:51 [notice] 1#1: start worker process 48
172.17.0.1 - - [11/Dec/2024:09:24:32 +0000] "GET / HTTP/1.1" 200 615 "-" "Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101 Firefox/128.0" "-"
2024/12/11 09:24:33 [error] 29#29: *1 open() "/usr/share/nginx/html/favicon.ico" failed (2: No such file or directory), client: 172.17.0.1, server: localhost, request: "GET /favicon.ico HTTP/1.1", host: "localhost:9999", referrer: "http://localhost:9999/"
172.17.0.1 - - [11/Dec/2024:09:24:33 +0000] "GET /favicon.ico HTTP/1.1" 404 153 "http://localhost:9999/" "Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101 Firefox/128.0" "-"

slayz@debian:~$ docker inspect c79
[
    {
        "Id": "c79a172fb023f1d1f5aa11caee7cbca8aa30d0abf826353bbdac5dd3957a1867",
        "Created": "2024-12-11T09:23:51.523967456Z",
        "Path": "/docker-entrypoint.sh",
        "Args": [
            "nginx",
            "-g",
            "daemon off;"
        ],
        "State": {
            "Status": "running",
            "Running": true,
            "Paused": false,
            "Restarting": false,
            "OOMKilled": false,
            "Dead": false,
            "Pid": 288616,
            "ExitCode": 0,
            "Error": "",
            "StartedAt": "2024-12-11T09:23:51.590542398Z",
            "FinishedAt": "0001-01-01T00:00:00Z"
        },
        "Image": "sha256:66f8bdd3810c96dc5c28aec39583af731b34a2cd99471530f53c8794ed5b423e",
        "ResolvConfPath": "/var/lib/docker/containers/c79a172fb023f1d1f5aa11caee7cbca8aa30d0abf826353bbdac5dd3957a1867/resolv.conf",
        "HostnamePath": "/var/lib/docker/containers/c79a172fb023f1d1f5aa11caee7cbca8aa30d0abf826353bbdac5dd3957a1867/hostname",
        "HostsPath": "/var/lib/docker/containers/c79a172fb023f1d1f5aa11caee7cbca8aa30d0abf826353bbdac5dd3957a1867/hosts",
        "LogPath": "/var/lib/docker/containers/c79a172fb023f1d1f5aa11caee7cbca8aa30d0abf826353bbdac5dd3957a1867/c79a172fb023f1d1f5aa11caee7cbca8aa30d0abf826353bbdac5dd3957a1867-json.log",
        "Name": "/focused_ritchie",
        "RestartCount": 0,
        "Driver": "overlay2",
        "Platform": "linux",
        "MountLabel": "",
        "ProcessLabel": "",
        "AppArmorProfile": "docker-default",
        "ExecIDs": null,
        "HostConfig": {
            "Binds": null,
            "ContainerIDFile": "",
            "LogConfig": {
                "Type": "json-file",
                "Config": {}
            },
            "NetworkMode": "bridge",
            "PortBindings": {
                "80/tcp": [
                    {
                        "HostIp": "",
                        "HostPort": "9999"
                    }
                ]
            },
            "RestartPolicy": {
                "Name": "no",
                "MaximumRetryCount": 0
            },
            "AutoRemove": false,
            "VolumeDriver": "",
            "VolumesFrom": null,
            "ConsoleSize": [
                24,
                65
            ],
            "CapAdd": null,
            "CapDrop": null,
            "CgroupnsMode": "private",
            "Dns": [],
            "DnsOptions": [],
            "DnsSearch": [],
            "ExtraHosts": null,
            "GroupAdd": null,
            "IpcMode": "private",
            "Cgroup": "",
            "Links": null,
            "OomScoreAdj": 0,
            "PidMode": "",
            "Privileged": false,
            "PublishAllPorts": false,
            "ReadonlyRootfs": false,
            "SecurityOpt": null,
            "UTSMode": "",
            "UsernsMode": "",
            "ShmSize": 67108864,
            "Runtime": "runc",
            "Isolation": "",
            "CpuShares": 0,
            "Memory": 0,
            "NanoCpus": 0,
            "CgroupParent": "",
            "BlkioWeight": 0,
            "BlkioWeightDevice": [],
            "BlkioDeviceReadBps": [],
            "BlkioDeviceWriteBps": [],
            "BlkioDeviceReadIOps": [],
            "BlkioDeviceWriteIOps": [],
            "CpuPeriod": 0,
            "CpuQuota": 0,
            "CpuRealtimePeriod": 0,
            "CpuRealtimeRuntime": 0,
            "CpusetCpus": "",
            "CpusetMems": "",
            "Devices": [],
            "DeviceCgroupRules": null,
            "DeviceRequests": null,
            "MemoryReservation": 0,
            "MemorySwap": 0,
            "MemorySwappiness": null,
            "OomKillDisable": null,
            "PidsLimit": null,
            "Ulimits": [],
            "CpuCount": 0,
            "CpuPercent": 0,
            "IOMaximumIOps": 0,
            "IOMaximumBandwidth": 0,
            "MaskedPaths": [
                "/proc/asound",
                "/proc/acpi",
                "/proc/kcore",
                "/proc/keys",
                "/proc/latency_stats",
                "/proc/timer_list",
                "/proc/timer_stats",
                "/proc/sched_debug",
                "/proc/scsi",
                "/sys/firmware",
                "/sys/devices/virtual/powercap"
            ],
            "ReadonlyPaths": [
                "/proc/bus",
                "/proc/fs",
                "/proc/irq",
                "/proc/sys",
                "/proc/sysrq-trigger"
            ]
        },
        "GraphDriver": {
            "Data": {
                "LowerDir": "/var/lib/docker/overlay2/adb142b5096db535289dbbb6b1a74996746dd02c3b1d2a8b3d496653d86fd2ea-init/diff:/var/lib/docker/overlay2/d8f7d21928f1fb9202ff39f9a3d1e344be259411602ad49ad4ecbbf55fc72821/diff:/var/lib/docker/overlay2/660876f9781b75a44bffbef21c05cd548457a253af2ec6fc9f3ef76173c316ae/diff:/var/lib/docker/overlay2/8f72db29389bda81432fe5bd216619643ce2692fbd097eeb94ba4c7256b37af0/diff:/var/lib/docker/overlay2/6da408f0b1967c9833ac52d737753aefe01e4cf1c1c4b1890285d8f4055cc7c5/diff:/var/lib/docker/overlay2/92b9437e3ac17f7a2ad80d1262fe81affc4c90ec9da77d945593d138c80bb5a3/diff:/var/lib/docker/overlay2/44f1ca42c2a29dda499bfb70e02fa83d159a142d91090ccf1944abd28f3f26dd/diff:/var/lib/docker/overlay2/8928e5ae19a6a22eef740081c9a62d40a8a6d46c4aec1d14fa0796ae1458dc58/diff",
                "MergedDir": "/var/lib/docker/overlay2/adb142b5096db535289dbbb6b1a74996746dd02c3b1d2a8b3d496653d86fd2ea/merged",
                "UpperDir": "/var/lib/docker/overlay2/adb142b5096db535289dbbb6b1a74996746dd02c3b1d2a8b3d496653d86fd2ea/diff",
                "WorkDir": "/var/lib/docker/overlay2/adb142b5096db535289dbbb6b1a74996746dd02c3b1d2a8b3d496653d86fd2ea/work"
            },
            "Name": "overlay2"
        },
        "Mounts": [],
        "Config": {
            "Hostname": "c79a172fb023",
            "Domainname": "",
            "User": "",
            "AttachStdin": false,
            "AttachStdout": false,
            "AttachStderr": false,
            "ExposedPorts": {
                "80/tcp": {}
            },
            "Tty": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Env": [
                "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
                "NGINX_VERSION=1.27.3",
                "NJS_VERSION=0.8.7",
                "NJS_RELEASE=1~bookworm",
                "PKG_RELEASE=1~bookworm",
                "DYNPKG_RELEASE=1~bookworm"
            ],
            "Cmd": [
                "nginx",
                "-g",
                "daemon off;"
            ],
            "Image": "nginx",
            "Volumes": null,
            "WorkingDir": "",
            "Entrypoint": [
                "/docker-entrypoint.sh"
            ],
            "OnBuild": null,
            "Labels": {
                "maintainer": "NGINX Docker Maintainers <docker-maint@nginx.com>"
            },
            "StopSignal": "SIGQUIT"
        },
        "NetworkSettings": {
            "Bridge": "",
            "SandboxID": "11a3624bde929c801be65ee6651f2d36c5f56fd1ec29307efac9fd1271e5b69f",
            "SandboxKey": "/var/run/docker/netns/11a3624bde92",
            "Ports": {
                "80/tcp": [
                    {
                        "HostIp": "0.0.0.0",
                        "HostPort": "9999"
                    },
                    {
                        "HostIp": "::",
                        "HostPort": "9999"
                    }
                ]
            },
            "HairpinMode": false,
            "LinkLocalIPv6Address": "",
            "LinkLocalIPv6PrefixLen": 0,
            "SecondaryIPAddresses": null,
            "SecondaryIPv6Addresses": null,
            "EndpointID": "7b9780def20e3bb87b28e9eb453b4ccb5ab381cc781a60ef564920fc2efec579",
            "Gateway": "172.17.0.1",
            "GlobalIPv6Address": "",
            "GlobalIPv6PrefixLen": 0,
            "IPAddress": "172.17.0.2",
            "IPPrefixLen": 16,
            "IPv6Gateway": "",
            "MacAddress": "02:42:ac:11:00:02",
            "Networks": {
                "bridge": {
                    "IPAMConfig": null,
                    "Links": null,
                    "Aliases": null,
                    "MacAddress": "02:42:ac:11:00:02",
                    "DriverOpts": null,
                    "NetworkID": "1734ca31adbc76fd1582694b13f6176e00ff584a6f4b8a73225b4cad525d1f7d",
                    "EndpointID": "7b9780def20e3bb87b28e9eb453b4ccb5ab381cc781a60ef564920fc2efec579",
                    "Gateway": "172.17.0.1",
                    "IPAddress": "172.17.0.2",
                    "IPPrefixLen": 16,
                    "IPv6Gateway": "",
                    "GlobalIPv6Address": "",
                    "GlobalIPv6PrefixLen": 0,
                    "DNSNames": null
                }
            }
        }
    }
]

slayz@debian:~$ sudo ss -lnpt
[sudo] Mot de passe de slayz : 
State             Recv-Q            Send-Q                       Local Address:Port                         Peer Address:Port            Process                                              
LISTEN            0                 128                              127.0.0.1:631                               0.0.0.0:*                users:(("cupsd",pid=1055,fd=7))                     
LISTEN            0                 4096                               0.0.0.0:9999                              0.0.0.0:*                users:(("docker-proxy",pid=288526,fd=4))            
LISTEN            0                 2048                               0.0.0.0:389                               0.0.0.0:*                users:(("slapd",pid=1669,fd=8))                     
LISTEN            0                 128                                  [::1]:631                                  [::]:*                users:(("cupsd",pid=1055,fd=6))                     
LISTEN            0                 4096                                  [::]:9999                                 [::]:*                users:(("docker-proxy",pid=288552,fd=4))            
LISTEN            0                 32                                       *:21                                      *:*                users:(("vsftpd",pid=1066,fd=3))                    
LISTEN            0                 2048                                  [::]:389                                  [::]:*                users:(("slapd",pid=1669,fd=9))  
```

**🌞 On va ajouter un site Web au conteneur NGINX**

```bash
slayz@debian:~/nginx$ docker run -d -p 9999:8080 -v /home/slayz/nginx/index.html:/var/www/html/index.html -v /home/slayz/nginx/site_nul.conf:/etc/nginx/conf.d/site_nul.conf nginx
194466ae901630c2c4c4d0b5305964ca615d0122f703e5c7c58dbc7e8ad9734a
slayz@debian:~/nginx$ docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS         PORTS                                                 NAMES
194466ae9016   nginx     "/docker-entrypoint.…"   4 seconds ago   Up 3 seconds   80/tcp, 0.0.0.0:9999->8080/tcp, [::]:9999->8080/tcp   eager_jones

slayz@debian:~/nginx$ curl localhost:9999
<h1> Meow </h1>
```

## 5. Un deuxième conteneur en vif

**🌞 Lance un conteneur Python, avec un shell**

```bash
slayz@debian:~/nginx$ docker run -it python bash
Unable to find image 'python:latest' locally
latest: Pulling from library/python
fdf894e782a2: Pull complete 
5bd71677db44: Pull complete 
551df7f94f9c: Pull complete 
ce82e98d553d: Pull complete 
5f0e19c475d6: Pull complete 
abab87fa45d0: Pull complete 
2ac2596c631f: Pull complete 
Digest: sha256:220d07595f288567bbf07883576f6591dad77d824dce74f0c73850e129fa1f46
Status: Downloaded newer image for python:latest
root@33b5b8e9e40e:/# 
```

**🌞 Installe des libs Python**

```bash
root@33b5b8e9e40e:/# pip install aiohttp
Collecting aiohttp
  Downloading aiohttp-3.11.10-cp313-cp313-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (7.7 kB)
Collecting aiohappyeyeballs>=2.3.0 (from aiohttp)
  Downloading aiohappyeyeballs-2.4.4-py3-none-any.whl.metadata (6.1 kB)
Collecting aiosignal>=1.1.2 (from aiohttp)
  Downloading aiosignal-1.3.1-py3-none-any.whl.metadata (4.0 kB)
Collecting attrs>=17.3.0 (from aiohttp)
  Downloading attrs-24.2.0-py3-none-any.whl.metadata (11 kB)
Collecting frozenlist>=1.1.1 (from aiohttp)
  Downloading frozenlist-1.5.0-cp313-cp313-manylinux_2_5_x86_64.manylinux1_x86_64.manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (13 kB)
Collecting multidict<7.0,>=4.5 (from aiohttp)
  Downloading multidict-6.1.0-cp313-cp313-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (5.0 kB)
Collecting propcache>=0.2.0 (from aiohttp)
  Downloading propcache-0.2.1-cp313-cp313-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (9.2 kB)
Collecting yarl<2.0,>=1.17.0 (from aiohttp)
  Downloading yarl-1.18.3-cp313-cp313-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (69 kB)
Collecting idna>=2.0 (from yarl<2.0,>=1.17.0->aiohttp)
  Downloading idna-3.10-py3-none-any.whl.metadata (10 kB)
Downloading aiohttp-3.11.10-cp313-cp313-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (1.7 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 1.7/1.7 MB 29.2 MB/s eta 0:00:00
Downloading aiohappyeyeballs-2.4.4-py3-none-any.whl (14 kB)
Downloading aiosignal-1.3.1-py3-none-any.whl (7.6 kB)
Downloading attrs-24.2.0-py3-none-any.whl (63 kB)
Downloading frozenlist-1.5.0-cp313-cp313-manylinux_2_5_x86_64.manylinux1_x86_64.manylinux_2_17_x86_64.manylinux2014_x86_64.whl (267 kB)
Downloading multidict-6.1.0-cp313-cp313-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (131 kB)
Downloading propcache-0.2.1-cp313-cp313-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (227 kB)
Downloading yarl-1.18.3-cp313-cp313-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (339 kB)
Downloading idna-3.10-py3-none-any.whl (70 kB)
Installing collected packages: propcache, multidict, idna, frozenlist, attrs, aiohappyeyeballs, yarl, aiosignal, aiohttp
Successfully installed aiohappyeyeballs-2.4.4 aiohttp-3.11.10 aiosignal-1.3.1 attrs-24.2.0 frozenlist-1.5.0 idna-3.10 multidict-6.1.0 propcache-0.2.1 yarl-1.18.3
WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager, possibly rendering your system unusable.It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv. Use the --root-user-action option if you know what you are doing and want to suppress this warning.
root@33b5b8e9e40e:/# pip install aioconsole
Collecting aioconsole
  Downloading aioconsole-0.8.1-py3-none-any.whl.metadata (46 kB)
Downloading aioconsole-0.8.1-py3-none-any.whl (43 kB)
Installing collected packages: aioconsole
Successfully installed aioconsole-0.8.1
WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager, possibly rendering your system unusable.It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv. Use the --root-user-action option if you know what you are doing and want to suppress this warning.
root@33b5b8e9e40e:/# python
Python 3.13.1 (main, Dec  4 2024, 20:40:27) [GCC 12.2.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import aiohttp
>>> 

root@33b5b8e9e40e:/# pip install aiohttp
Collecting aiohttp
  Downloading aiohttp-3.11.10-cp313-cp313-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (7.7 kB)
Collecting aiohappyeyeballs>=2.3.0 (from aiohttp)
  Downloading aiohappyeyeballs-2.4.4-py3-none-any.whl.metadata (6.1 kB)
Collecting aiosignal>=1.1.2 (from aiohttp)
  Downloading aiosignal-1.3.1-py3-none-any.whl.metadata (4.0 kB)
Collecting attrs>=17.3.0 (from aiohttp)
  Downloading attrs-24.2.0-py3-none-any.whl.metadata (11 kB)
Collecting frozenlist>=1.1.1 (from aiohttp)
  Downloading frozenlist-1.5.0-cp313-cp313-manylinux_2_5_x86_64.manylinux1_x86_64.manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (13 kB)
Collecting multidict<7.0,>=4.5 (from aiohttp)
  Downloading multidict-6.1.0-cp313-cp313-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (5.0 kB)
Collecting propcache>=0.2.0 (from aiohttp)
  Downloading propcache-0.2.1-cp313-cp313-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (9.2 kB)
Collecting yarl<2.0,>=1.17.0 (from aiohttp)
  Downloading yarl-1.18.3-cp313-cp313-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (69 kB)
Collecting idna>=2.0 (from yarl<2.0,>=1.17.0->aiohttp)
  Downloading idna-3.10-py3-none-any.whl.metadata (10 kB)
Downloading aiohttp-3.11.10-cp313-cp313-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (1.7 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 1.7/1.7 MB 29.2 MB/s eta 0:00:00
Downloading aiohappyeyeballs-2.4.4-py3-none-any.whl (14 kB)
Downloading aiosignal-1.3.1-py3-none-any.whl (7.6 kB)
Downloading attrs-24.2.0-py3-none-any.whl (63 kB)
Downloading frozenlist-1.5.0-cp313-cp313-manylinux_2_5_x86_64.manylinux1_x86_64.manylinux_2_17_x86_64.manylinux2014_x86_64.whl (267 kB)
Downloading multidict-6.1.0-cp313-cp313-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (131 kB)
Downloading propcache-0.2.1-cp313-cp313-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (227 kB)
Downloading yarl-1.18.3-cp313-cp313-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (339 kB)
Downloading idna-3.10-py3-none-any.whl (70 kB)
Installing collected packages: propcache, multidict, idna, frozenlist, attrs, aiohappyeyeballs, yarl, aiosignal, aiohttp
Successfully installed aiohappyeyeballs-2.4.4 aiohttp-3.11.10 aiosignal-1.3.1 attrs-24.2.0 frozenlist-1.5.0 idna-3.10 multidict-6.1.0 propcache-0.2.1 yarl-1.18.3
WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager, possibly rendering your system unusable.It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv. Use the --root-user-action option if you know what you are doing and want to suppress this warning.
root@33b5b8e9e40e:/# pip install aioconsole
Collecting aioconsole
  Downloading aioconsole-0.8.1-py3-none-any.whl.metadata (46 kB)
Downloading aioconsole-0.8.1-py3-none-any.whl (43 kB)
Installing collected packages: aioconsole
Successfully installed aioconsole-0.8.1
WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager, possibly rendering your system unusable.It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv. Use the --root-user-action option if you know what you are doing and want to suppress this warning.
root@33b5b8e9e40e:/# python
Python 3.13.1 (main, Dec  4 2024, 20:40:27) [GCC 12.2.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import aiohttp
>>> 
```

# II. Images

## 1. Images publiques

**🌞 Récupérez des images**

```bash
slayz@debian:~/nginx$ docker pull python && docker pull mysql && docker pull wordpress:latest && docker pull linuxserver/wikijs:latest
```

**🌞 Lancez un conteneur à partir de l'image Python**

```bash
slayz@debian:~$ docker run -it --name toto python:latest bash
root@92be9235f938:/# python3
Python 3.13.1 (main, Dec  4 2024, 20:40:27) [GCC 12.2.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> 
```

## 2. Construire une image

**🌞 Ecrire un Dockerfile pour une image qui héberge une application Python***

```Dockerfile
FROM debian
RUN apt update
RUN apt install -y python3 python3-pip
RUN pip install emoji
COPY app.py /app.py
ENTRYPOINT ["python3", "app.py"]
```

**🌞 Build l'image**

```bash
slayz@debian:~/tp_docker$ docker build . -t python_app:version_de_ouf
[+] Building 3.6s (11/11) FINISHED                                                                                                                                             docker:default
 => [internal] load build definition from Dockerfile                                                                                                                                     0.0s
 => => transferring dockerfile: 246B                                                                                                                                                     0.0s
 => [internal] load metadata for docker.io/library/debian:latest                                                                                                                         0.4s
 => [internal] load .dockerignore                                                                                                                                                        0.0s
 => => transferring context: 2B                                                                                                                                                          0.0s
 => [1/6] FROM docker.io/library/debian:latest@sha256:17122fe3d66916e55c0cbd5bbf54bb3f87b3582f4d86a755a0fd3498d360f91b                                                                   0.0s
 => [internal] load build context                                                                                                                                                        0.0s
 => => transferring context: 27B                                                                                                                                                         0.0s
 => CACHED [2/6] RUN apt update                                                                                                                                                          0.0s
 => CACHED [3/6] RUN apt install -y python3 python3-pip                                                                                                                                  0.0s
 => [4/6] RUN python3 -m pip config set global.break-system-packages true                                                                                                                0.4s
 => [5/6] RUN pip install emoji                                                                                                                                                          0.8s
 => [6/6] COPY app.py /app.py                                                                                                                                                            0.0s
 => exporting to image                                                                                                                                                                   2.0s
 => => exporting layers                                                                                                                                                                  2.0s
 => => writing image sha256:5a965fec568d3ad294276d1eb7c0a39a5a4c1dd0edecfda29f4c4ad0aabc77c9                                                                                             0.0s
 => => naming to docker.io/library/python_app:version_de_ouf  

 slayz@debian:~/tp_docker$ docker images
REPOSITORY           TAG              IMAGE ID       CREATED          SIZE
python_app           version_de_ouf   5a965fec568d   58 seconds ago   635MB
linuxserver/wikijs   latest           863e49d2e56c   4 days ago       465MB
python               latest           3ca4060004b1   7 days ago       1.02GB
nginx                latest           66f8bdd3810c   2 weeks ago      192MB
wordpress            latest           c89b40a25cd1   2 weeks ago      700MB
mysql                latest           56a8c14e1404   8 weeks ago      603MB


```

**🌞 Lancer l'image**

```bash
slayz@debian:~/tp_docker$ docker run python_app:version_de_ouf
Cet exemple d'application est vraiment naze 👎
```

# III. Docker compose

**🌞 Créez un fichier docker-compose.yml**

```yml
slayz@debian:~/compose_test$ cat docker-compose.yml 

version: "3"

services:
  conteneur_nul:
    image: debian
    entrypoint: sleep 9999
  conteneur_flopesque:
    image: debian
    entrypoint: sleep 9999
```

**🌞 Lancez les deux conteneurs avec docker compose**

```bash
slayz@debian:~/compose_test$ docker compose up -d
WARN[0000] /home/slayz/compose_test/docker-compose.yml: the attribute `version` is obsolete, it will be ignored, please remove it to avoid potential confusion 
[+] Running 3/3
 ✔ conteneur_nul Pulled                                                                                                                                                                  2.9s 
 ✔ conteneur_flopesque Pulled                                                                                                                                                            2.6s 
   ✔ fdf894e782a2 Already exists                                                                                                                                                         0.0s 
[+] Running 3/3
 ✔ Network compose_test_default                  Created                                                                                                                                 0.1s 
 ✔ Container compose_test-conteneur_flopesque-1  Started                                                                                                                                 0.4s 
 ✔ Container compose_test-conteneur_nul-1        Started    
```

**🌞 Vérifier que les deux conteneurs tournent**

```bash
slayz@debian:~/compose_test$ docker ps 
CONTAINER ID   IMAGE     COMMAND        CREATED          STATUS          PORTS     NAMES
cd555ed1c366   debian    "sleep 9999"   40 seconds ago   Up 40 seconds             compose_test-conteneur_nul-1
b5c9f03f6897   debian    "sleep 9999"   40 seconds ago   Up 40 seconds             compose_test-conteneur_flopesque-1

slayz@debian:~/compose_test$ docker compose ps
WARN[0000] /home/slayz/compose_test/docker-compose.yml: the attribute `version` is obsolete, it will be ignored, please remove it to avoid potential confusion 
NAME                                 IMAGE     COMMAND        SERVICE               CREATED              STATUS              PORTS
compose_test-conteneur_flopesque-1   debian    "sleep 9999"   conteneur_flopesque   About a minute ago   Up About a minute   
compose_test-conteneur_nul-1         debian    "sleep 9999"   conteneur_nul         About a minute ago   Up About a minute  
```

**🌞 Pop un shell dans le conteneur conteneur_nul**

```bash
slayz@debian:~/compose_test$ docker exec -it cd555ed1c366 bash
root@cd555ed1c366:/# apt update  
Get:1 http://deb.debian.org/debian bookworm InRelease [151 kB]
Get:2 http://deb.debian.org/debian bookworm-updates InRelease [55.4 kB]
Get:3 http://deb.debian.org/debian-security bookworm-security InRelease [48.0 kB]
Get:4 http://deb.debian.org/debian bookworm/main amd64 Packages [8789 kB]
Get:5 http://deb.debian.org/debian bookworm-updates/main amd64 Packages [8856 B]
Get:6 http://deb.debian.org/debian-security bookworm-security/main amd64 Packages [216 kB]
Fetched 9268 kB in 1s (7709 kB/s)                       
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
All packages are up to date.

root@cd555ed1c366:/# apt-get install iputils-ping
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
  libcap2-bin libpam-cap
The following NEW packages will be installed:
  iputils-ping libcap2-bin libpam-cap
0 upgraded, 3 newly installed, 0 to remove and 0 not upgraded.
Need to get 96.3 kB of archives.
After this operation, 312 kB of additional disk space will be used.
Do you want to continue? [Y/n] y
Get:1 http://deb.debian.org/debian bookworm/main amd64 libcap2-bin amd64 1:2.66-4 [34.7 kB]
Get:2 http://deb.debian.org/debian bookworm/main amd64 iputils-ping amd64 3:20221126-1+deb12u1 [47.2 kB]
Get:3 http://deb.debian.org/debian bookworm/main amd64 libpam-cap amd64 1:2.66-4 [14.5 kB]
Fetched 96.3 kB in 0s (1174 kB/s)    
debconf: delaying package configuration, since apt-utils is not installed
Selecting previously unselected package libcap2-bin.
(Reading database ... 6089 files and directories currently installed.)
Preparing to unpack .../libcap2-bin_1%3a2.66-4_amd64.deb ...
Unpacking libcap2-bin (1:2.66-4) ...
Selecting previously unselected package iputils-ping.
Preparing to unpack .../iputils-ping_3%3a20221126-1+deb12u1_amd64.deb ...
Unpacking iputils-ping (3:20221126-1+deb12u1) ...
Selecting previously unselected package libpam-cap:amd64.
Preparing to unpack .../libpam-cap_1%3a2.66-4_amd64.deb ...
Unpacking libpam-cap:amd64 (1:2.66-4) ...
Setting up libcap2-bin (1:2.66-4) ...
Setting up libpam-cap:amd64 (1:2.66-4) ...
debconf: unable to initialize frontend: Dialog
debconf: (No usable dialog-like program is installed, so the dialog based frontend cannot be used. at /usr/share/perl5/Debconf/FrontEnd/Dialog.pm line 78.)
debconf: falling back to frontend: Readline
debconf: unable to initialize frontend: Readline
debconf: (Can't locate Term/ReadLine.pm in @INC (you may need to install the Term::ReadLine module) (@INC contains: /etc/perl /usr/local/lib/x86_64-linux-gnu/perl/5.36.0 /usr/local/share/perl/5.36.0 /usr/lib/x86_64-linux-gnu/perl5/5.36 /usr/share/perl5 /usr/lib/x86_64-linux-gnu/perl-base /usr/lib/x86_64-linux-gnu/perl/5.36 /usr/share/perl/5.36 /usr/local/lib/site_perl) at /usr/share/perl5/Debconf/FrontEnd/Readline.pm line 7.)
debconf: falling back to frontend: Teletype
Setting up iputils-ping (3:20221126-1+deb12u1) ...

root@cd555ed1c366:/# ping conteneur_flopesque
PING conteneur_flopesque (172.18.0.2) 56(84) bytes of data.
64 bytes from compose_test-conteneur_flopesque-1.compose_test_default (172.18.0.2): icmp_seq=1 ttl=64 time=0.093 ms
64 bytes from compose_test-conteneur_flopesque-1.compose_test_default (172.18.0.2): icmp_seq=2 ttl=64 time=0.071 ms
^C
--- conteneur_flopesque ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1001ms
rtt min/avg/max/mdev = 0.071/0.082/0.093/0.011 ms
```

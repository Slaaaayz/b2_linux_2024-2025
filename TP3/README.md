# TP3 Sécu : Linux Hardening

## 1. Guides CIS

**🌞 Suivre un guide CIS**

```bash
[root@localhost ~]# rpm -q  autofs
package autofs is not installed

[root@localhost ~]# rpm -q avahi
package avahi is not installed

[root@localhost ~]# rpm -q dhcp-server
package dhcp-server is not installed

[root@localhost ~]# rpm -q bind
package bind is not installed

[root@localhost ~]# rpm -q dnsmasq
package dnsmasq is not installed

[root@localhost ~]# rpm -q samba
package samba is not installed

[root@localhost ~]# rpm -q vsftpd
package vsftpd is not installed

[root@localhost ~]# rpm -q dovecot cyrus-imapd
package dovecot is not installed
package cyrus-imapd is not installed

[root@localhost ~]# rpm -q nfs-utils
package nfs-utils is not installed

[root@localhost ~]# rpm -q ypserv
package ypserv is not installed

[root@localhost ~]# rpm -q cups
package cups is not installed

[root@localhost ~]# rpm -q rpcbind
package rpcbind is not installed

[root@localhost ~]# rpm -q rsync-daemon
package rsync-daemon is not installed

[root@localhost ~]# rpm -q net-snmp
package net-snmp is not installed

[root@localhost ~]# rpm -q tftp-server
package tftp-server is not installed

[root@localhost ~]# rpm -q squid
package squid is not installed

[root@localhost ~]# rpm -q httpd nginx
package httpd is not installed
package nginx is not installed

[root@localhost ~]# rpm -q xinetd
package xinetd is not installed

[root@localhost ~]# rpm -q xorg-x11-server-common
package xorg-x11-server-common is not installed

[root@localhost ~]# bash script.sh 
script.sh: line 9: postconf: command not found

- Audit Result:
 ** PASS **

 - Port "25" is not listening on a non-loopback network interface
 - Port "465" is not listening on a non-loopback network interface
 - Port "587" is not listening on a non-loopback network interface

[root@localhost ~]# ss -plntu
Netid           State            Recv-Q           Send-Q                     Local Address:Port                       Peer Address:Port           Process                                     
udp             UNCONN           0                0                              127.0.0.1:323                             0.0.0.0:*               users:(("chronyd",pid=705,fd=5))           
udp             UNCONN           0                0                                  [::1]:323                                [::]:*               users:(("chronyd",pid=705,fd=6))           
tcp             LISTEN           0                128                              0.0.0.0:22                              0.0.0.0:*               users:(("sshd",pid=738,fd=3))              
tcp             LISTEN           0                128                                 [::]:22                                 [::]:*               users:(("sshd",pid=738,fd=4)) 

[root@localhost ~]# bash script.sh 

- IPv6 is enabled

[root@localhost ~]# bash script.sh 

- Audit Result:
 ** PASS **

 - System has no wireless NICs installed


[root@localhost ~]# rpm -q bluez
package bluez is not installed

[root@localhost ~]# bash script.sh 

- Audit Result:
 ** PASS **
 - kernel module: "dccp" doesn't exist in "/usr/lib/modules/5.14.0-427.13.1.el9_4.x86_64/kernel/net"
 - kernel module: "dccp" doesn't exist in "/usr/lib/modules/5.14.0-427.40.1.el9_4.x86_64/kernel/net"


[root@localhost ~]# bash script.sh 


 -- INFO --
 - module: "tipc" exists in:
 - "/usr/lib/modules/5.14.0-427.13.1.el9_4.x86_64/kernel/net"
 - "/usr/lib/modules/5.14.0-427.40.1.el9_4.x86_64/kernel/net"

- Audit Result:
 ** FAIL **
 - Reason(s) for audit failure:
 - kernel module: "tipc" is loadable
 - kernel module: "tipc" is not deny listed
- Correctly set:
 - kernel module: "tipc" is not loaded
[root@localhost ~]# bash script.sh 
script.sh: line 30: /usr/lib/modules/5.14.0-427.13.1.el9_4.x86_64/kernel/net/tipc: Is a directory
script.sh: line 30: /usr/lib/modules/5.14.0-427.40.1.el9_4.x86_64/kernel/net/tipc: Is a directory


 -- INFO --
 - module: "tipc" exists in:
 - "/usr/lib/modules/5.14.0-427.13.1.el9_4.x86_64/kernel/net"
 - "/usr/lib/modules/5.14.0-427.40.1.el9_4.x86_64/kernel/net"
 - setting kernel module: "tipc" to "/bin/false"
 - denylisting kernel module: "tipc"

 - remediation of kernel module: "tipc" complete

[root@localhost ~]# bash script.sh 

- Audit Result:
 ** PASS **
 - kernel module: "rds" doesn't exist in "/usr/lib/modules/5.14.0-427.13.1.el9_4.x86_64/kernel/net"
 - kernel module: "rds" doesn't exist in "/usr/lib/modules/5.14.0-427.40.1.el9_4.x86_64/kernel/net"

[root@localhost ~]# bash script.sh 

- Audit Result:
 ** PASS **
 - kernel module: "sctp" doesn't exist in "/usr/lib/modules/5.14.0-427.13.1.el9_4.x86_64/kernel/net"
 - kernel module: "sctp" doesn't exist in "/usr/lib/modules/5.14.0-427.40.1.el9_4.x86_64/kernel/net"

[root@localhost ~]# bash script.sh 

- Audit Result:
 ** FAIL **
 - Reason(s) for audit failure:

 - "net.ipv4.ip_forward" is not set in an included file
 ** Note: "net.ipv4.ip_forward" may be set in a file that's ignored by the load procedure **
 - "net.ipv6.conf.all.forwarding" is not set in an included file
 ** Note: "net.ipv6.conf.all.forwarding" may be set in a file that's ignored by the load procedure **


- Correctly set:

 - "net.ipv4.ip_forward" is correctly set to "0" in the running configuration
 - "net.ipv6.conf.all.forwarding" is correctly set to "0" in the running configuration

[root@localhost ~]# bash test.sh 
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0
net.ipv4.route.flush = 1
[root@localhost ~]# bash script.sh 

- Audit Result:
 ** FAIL **
 - Reason(s) for audit failure:

 - "net.ipv4.conf.all.send_redirects" is not set in an included file
 ** Note: "net.ipv4.conf.all.send_redirects" may be set in a file that's ignored by the load procedure **

 - "net.ipv4.conf.default.send_redirects" is not set in an included file
 ** Note: "net.ipv4.conf.default.send_redirects" may be set in a file that's ignored by the load procedure **



- Correctly set:

 - "net.ipv4.conf.all.send_redirects" is correctly set to "0" in the running configuration
 - "net.ipv4.conf.default.send_redirects" is correctly set to "0" in the running configuration

[root@localhost ~]# bash script.sh 

- Audit Result:
 ** FAIL **
 - Reason(s) for audit failure:

 - "net.ipv4.icmp_ignore_bogus_error_responses" is not set in an included file
 ** Note: "net.ipv4.icmp_ignore_bogus_error_responses" may be set in a file that's ignored by the load procedure **



- Correctly set:

 - "net.ipv4.icmp_ignore_bogus_error_responses" is correctly set to "1" in the running configuration

[root@localhost ~]# bash script.sh 

- Audit Result:
 ** FAIL **
 - Reason(s) for audit failure:

 - "net.ipv4.icmp_echo_ignore_broadcasts" is not set in an included file
 ** Note: "net.ipv4.icmp_echo_ignore_broadcasts" may be set in a file that's ignored by the load procedure **



- Correctly set:

 - "net.ipv4.icmp_echo_ignore_broadcasts" is correctly set to "1" in the running configuration

[root@localhost ~]# bash test.sh 
net.ipv6.conf.all.accept_redirects = 0
net.ipv6.conf.default.accept_redirects = 0
net.ipv6.route.flush = 1
[root@localhost ~]# bash script.sh 

- Audit Result:
 ** FAIL **
 - Reason(s) for audit failure:

 - "net.ipv4.conf.all.accept_redirects" is incorrectly set to "1" in the running configuration and should have a value of: "0"
 - "net.ipv4.conf.all.accept_redirects" is not set in an included file
 ** Note: "net.ipv4.conf.all.accept_redirects" may be set in a file that's ignored by the load procedure **

 - "net.ipv4.conf.default.accept_redirects" is incorrectly set to "1" in the running configuration and should have a value of: "0"
 - "net.ipv4.conf.default.accept_redirects" is not set in an included file
 ** Note: "net.ipv4.conf.default.accept_redirects" may be set in a file that's ignored by the load procedure **

 - "net.ipv6.conf.all.accept_redirects" is not set in an included file
 ** Note: "net.ipv6.conf.all.accept_redirects" may be set in a file that's ignored by the load procedure **

 - "net.ipv6.conf.default.accept_redirects" is not set in an included file
 ** Note: "net.ipv6.conf.default.accept_redirects" may be set in a file that's ignored by the load procedure **



- Correctly set:

 - "net.ipv6.conf.all.accept_redirects" is correctly set to "0" in the running configuration
 - "net.ipv6.conf.default.accept_redirects" is correctly set to "0" in the running configuration

[root@localhost ~]# bash test.sh 
net.ipv4.conf.all.secure_redirects = 0
net.ipv4.conf.default.secure_redirects = 0
net.ipv4.route.flush = 1
[root@localhost ~]# bash script.sh 

- Audit Result:
 ** FAIL **
 - Reason(s) for audit failure:

 - "net.ipv4.conf.all.secure_redirects" is not set in an included file
 ** Note: "net.ipv4.conf.all.secure_redirects" may be set in a file that's ignored by the load procedure **

 - "net.ipv4.conf.default.secure_redirects" is not set in an included file
 ** Note: "net.ipv4.conf.default.secure_redirects" may be set in a file that's ignored by the load procedure **



- Correctly set:

 - "net.ipv4.conf.all.secure_redirects" is correctly set to "0" in the running configuration
 - "net.ipv4.conf.default.secure_redirects" is correctly set to "0" in the running configuration

root@localhost ~]# bash script.sh 

- Audit Result:
 ** FAIL **
 - Reason(s) for audit failure:

 - "net.ipv4.conf.all.rp_filter" is incorrectly set to "0" in the running configuration and should have a value of: "1"
 - "net.ipv4.conf.all.rp_filter" is not set in an included file
 ** Note: "net.ipv4.conf.all.rp_filter" may be set in a file that's ignored by the load procedure **



- Correctly set:

 - "net.ipv4.conf.default.rp_filter" is correctly set to "1" in the running configuration
 - "net.ipv4.conf.default.rp_filter" is correctly set to "1" in "/usr/lib/sysctl.d/50-redhat.conf"

[root@localhost ~]# bash script.sh 

- Audit Result:
 ** FAIL **
 - Reason(s) for audit failure:

 - "net.ipv4.conf.all.log_martians" is not set in an included file
 ** Note: "net.ipv4.conf.all.log_martians" may be set in a file that's ignored by load procedure **

 - "net.ipv4.conf.default.log_martians" is not set in an included file
 ** Note: "net.ipv4.conf.default.log_martians" may be set in a file that's ignored by load procedure **



- Correctly set:

 - "net.ipv4.conf.all.log_martians" is correctly set to "1" in the running configuration
 - "net.ipv4.conf.default.log_martians" is correctly set to "1" in the running configuration

[root@localhost ~]# bash script.sh 

- Audit Result:
 ** FAIL **
 - Reason(s) for audit failure:

 - "net.ipv4.tcp_syncookies" is not set in an included file
 ** Note: "net.ipv4.tcp_syncookies" May be set in a file that's ignored by load procedure **



- Correctly set:

 - "net.ipv4.tcp_syncookies" is correctly set to "1" in the running configuration


```

```bash
[slayz@localhost ~]$ bash script.sh 

- Audit Result:
 *** PASS ***
- * Correctly set * :

 - File: "/etc/ssh/sshd_config":
 - Correct: mode (0600), owner (root), and group owner (root) configured
```

```bash
[slayz@localhost ~]$ bash script.sh 

- Audit Result:
 ** PASS **
 - * Correctly configured * :
 - No openSSH private keys found
```

```bash
[slayz@localhost ~]$ bash script.sh 

- Audit Result:
 ** PASS **
 - * Correctly configured * :
 - File: "/etc/ssh/ssh_host_ed25519_key.pub"
 - Correct: mode: "0644", owner: "root", and group owner: "root" configured
 - File: "/etc/ssh/ssh_host_ecdsa_key.pub"
 - Correct: mode: "0644", owner: "root", and group owner: "root" configured
 - File: "/etc/ssh/ssh_host_rsa_key.pub"
 - Correct: mode: "0644", owner: "root", and group owner: "root" configured
```

```bash
[slayz@localhost ~]$ sudo sshd -T | grep -Pi -- '^ciphers\h+\"?([^#\n\r]+,)?((3des|blowfish|cast128|aes(128|192|256))-
cbc|arcfour(128|256)?|rijndael-cbc@lysator\.liu\.se|chacha20-poly1305@openssh\.com)\b'
grep: the -P option only supports a single pattern
```

```bash
[slayz@localhost ~]$ sudo !!
sudo sshd -T | grep -Pi -- 'kexalgorithms\h+([^#\n\r]+,)?(diffie-hellman-group1-sha1|diffie-hellman-group14-
sha1|diffie-hellman-group-exchange-sha1)\b'
grep: the -P option only supports a single pattern
```

```bash
[slayz@localhost ~]$ sudo sshd -T | grep -Pi -- 'macs\h+([^#\n\r]+,)?(hmac-md5|hmac-md5-96|hmac-ripemd160|hmac-sha1-96|umac-
64@openssh\.com|hmac-md5-etm@openssh\.com|hmac-md5-96-etm@openssh\.com|hmac-ripemd160-etm@openssh\.com|hmac-
sha1-96-etm@openssh\.com|umac-64-etm@openssh\.com|umac-128-etm@openssh\.com)\b'
grep: the -P option only supports a single pattern
```

```bash
[slayz@localhost ~]$ sudo sshd -T | grep -Pi -- '^\h*(allow|deny)(users|groups)\h+\H+'
```

```bash
[slayz@localhost ~]$ sudo sshd -T | grep -Pi -- '^banner\h+\/\H+'
```

```bash
[slayz@localhost ~]$ sudo sshd -T | grep -Pi -- '(clientaliveinterval|clientalivecountmax)'
clientaliveinterval 0
clientalivecountmax 3
```

```bash
[slayz@localhost ~]$ sudo sshd -T | grep -i disableforwarding
disableforwarding no

Edit the /etc/ssh/sshd_config file to set the DisableForwarding parameter to yes
above any Include entry as follows:

DisableForwarding yes

[slayz@localhost ~]$ sudo sshd -T | grep -i disableforwarding
disableforwarding yes
```

```bash
[slayz@localhost ~]$ sudo sshd -T | grep gssapiauthentication
gssapiauthentication yes
```

```bash
[slayz@localhost ~]$ sudo sshd -T | grep hostbasedauthentication
hostbasedauthentication no
```

```bash
[slayz@localhost ~]$ sudo sshd -T | grep ignorerhosts
ignorerhosts yes
```

```bash
[slayz@localhost ~]$ sudo sshd -T | grep logingracetime
logingracetime 60
```

```bash
[slayz@localhost ~]$ sudo sshd -T | grep loglevel
loglevel INFO
```

```bash
[slayz@localhost ~]$ sudo sshd -T | grep maxauthtries
maxauthtries 4
```

```bash
[slayz@localhost ~]$ sudo sshd -T | awk '$1 ~ /^\s*maxstartups/{split($2, a, ":");{if(a[1] > 10 || a[2] > 30 || a[3] > 60) print $0}}'
maxstartups 10:30:100
```

```bash
[slayz@localhost ~]$ sudo sshd -T | grep -i maxsessions
maxsessions 10
```

```bash
[slayz@localhost ~]$ sudo sshd -T | grep permitemptypasswords
permitemptypasswords no
```

```bash
[slayz@localhost ~]$ sudo sshd -T | grep permitrootlogin
permitrootlogin no
```

```bash
[slayz@localhost ~]$ sudo sshd -T | grep permituserenvironment
permituserenvironment no
```

```bash
[slayz@localhost ~]$ sudo sshd -T | grep -i usepam
usepam yes
```

```bash
[slayz@localhost ~]$ stat -Lc 'Access: (%#a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/passwd
Access: (0644/-rw-r--r--) Uid: ( 0/ root) Gid: ( 0/ root)
```

```bash
[slayz@localhost ~]$ stat -Lc 'Access: (%#a/%A) Uid: ( %u/ %U) Gid: { %g/ %G)' /etc/passwd-
Access: (0644/-rw-r--r--) Uid: ( 0/ root) Gid: { 0/ root)
```

```bash
[slayz@localhost ~]$ stat -Lc 'Access: (%#a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/group
Access: (0644/-rw-r--r--) Uid: ( 0/ root) Gid: ( 0/ root)
```

```bash
[slayz@localhost ~]$ stat -Lc 'Access: (%#a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/group-
Access: (0644/-rw-r--r--) Uid: ( 0/ root) Gid: ( 0/ root)
```

```bash
[slayz@localhost ~]$ stat -Lc 'Access: (%#a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/shadow
Access: (0/----------) Uid: ( 0/ root) Gid: ( 0/ root)
```

```bash
[slayz@localhost ~]$ stat -Lc 'Access: (%#a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/shadow-
Access: (0/----------) Uid: ( 0/ root) Gid: ( 0/ root)
```

```bash
[slayz@localhost ~]$ stat -Lc 'Access: (%#a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/gshadow
Access: (0/----------) Uid: ( 0/ root) Gid: ( 0/ root)
```

```bash
[slayz@localhost ~]$ stat -Lc 'Access: (%#a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/gshadow-
Access: (0/----------) Uid: ( 0/ root) Gid: ( 0/ root)
```

```bash
[slayz@localhost ~]$ stat -Lc 'Access: (%#a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/shells
Access: (0644/-rw-r--r--) Uid: ( 0/ root) Gid: ( 0/ root)
```

```bash
[slayz@localhost ~]$ sudo [ -e "/etc/security/opasswd.old" ] && stat -Lc
```

```bash
[slayz@localhost ~]$ rpm -q libselinux
libselinux-3.6-1.el9.x86_64
```

```bash
[slayz@localhost ~]$ sudo grubby --info=ALL | grep -Po '(selinux|enforcing)=0\b'
```

```bash
[slayz@localhost ~]$ grep -E '^\s*SELINUXTYPE=(targeted|mls)\b' /etc/selinux/config
SELINUXTYPE=targeted
```

```bash
[slayz@localhost ~]$ getenforce
Permissive
```

```bash
[slayz@localhost ~]$ sudo !!
sudo bash script.sh 

- Audit Result:
 ** PASS **
 - All audit configuration files are mode: "640" or more restrictive
```

```bash
[slayz@localhost ~]$ sudo find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) ! -user root
```

```bash
[slayz@localhost ~]$ sudo find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) ! -group root
```

```bash
[slayz@localhost ~]$ bash script.sh 

- Audit Result:
 ** PASS **
 - * Correctly configured * :
 - Audit tool "/sbin/auditctl" is correctly configured to mode: "0755"
 - Audit tool "/sbin/aureport" is correctly configured to mode: "0755"
 - Audit tool "/sbin/ausearch" is correctly configured to mode: "0755"
 - Audit tool "/sbin/autrace" is correctly configured to mode: "0750"
 - Audit tool "/sbin/auditd" is correctly configured to mode: "0755"
 - Audit tool "/sbin/augenrules" is correctly configured to mode: "0755"
```

```bash
[slayz@localhost ~]$ stat -Lc "%n %U" /sbin/auditctl /sbin/aureport /sbin/ausearch /sbin/autrace /sbin/auditd /sbin/augenrules | awk '$2 != "root" {print}'
```

```bash
[slayz@localhost ~]$ stat -Lc "%n %G" /sbin/auditctl /sbin/aureport /sbin/ausearch /sbin/autrace /sbin/auditd /sbin/augenrules |
awk '$2 != "root" {print}'
```

## 2. Conf SSH

**🌞 Chiffrement fort côté serveur**

[Voici le lien de la doc que j'ai uilisé](https://blog.stephane-robert.info/docs/securiser/durcissement/ssh/)

[Voici la conf](test.conf)

**🌞 Clés de chiffrement fortes pour le client**

[Voici la doc](https://www.hostinger.fr/tutoriels/generer-cle-ssh)


```bash
slayz@debian:~$ ssh-keygen -t ed25519 
Generating public/private ed25519 key pair.
Enter file in which to save the key (/home/slayz/.ssh/id_ed25519): 
/home/slayz/.ssh/id_ed25519 already exists.
Overwrite (y/n)? y
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/slayz/.ssh/id_ed25519
Your public key has been saved in /home/slayz/.ssh/id_ed25519.pub
The key fingerprint is:
SHA256:BesDGxAz+q9/hT7qwKa0B1bCf+f0Qte24af5LZqwOTE slayz@debian
The key's randomart image is:
+--[ED25519 256]--+
|    =.  .        |
|   . +   o       |
| ..   o . .      |
|  o..  = .       |
|   +. . S. .     |
|  o.... =.E +    |
| ...+..* +.= o   |
| . +.o  * o+ooo. |
|  o..o+o oo.==...|
+----[SHA256]-----+
```

**🌞 Connectez-vous en SSH à votre VM avec cette paire de clés**

```bash
slayz@debian:~$ ssh -i ~/.ssh/id_ed25519 -vvvv slayz@10.7.1.56
OpenSSH_9.2p1 Debian-2+deb12u3, OpenSSL 3.0.15 3 Sep 2024
debug1: Reading configuration data /etc/ssh/ssh_config
debug1: /etc/ssh/ssh_config line 19: include /etc/ssh/ssh_config.d/*.conf matched no files
debug1: /etc/ssh/ssh_config line 21: Applying options for *
debug2: resolve_canonicalize: hostname 10.7.1.56 is address
debug3: expanded UserKnownHostsFile '~/.ssh/known_hosts' -> '/home/slayz/.ssh/known_hosts'
debug3: expanded UserKnownHostsFile '~/.ssh/known_hosts2' -> '/home/slayz/.ssh/known_hosts2'
debug3: ssh_connect_direct: entering
debug1: Connecting to 10.7.1.56 [10.7.1.56] port 22.
debug3: set_sock_tos: set socket 3 IP_TOS 0x10
debug1: Connection established.
debug1: identity file /home/slayz/.ssh/id_ed25519 type 3
debug1: identity file /home/slayz/.ssh/id_ed25519-cert type -1
debug1: Local version string SSH-2.0-OpenSSH_9.2p1 Debian-2+deb12u3
debug1: Remote protocol version 2.0, remote software version OpenSSH_8.7
debug1: compat_banner: match: OpenSSH_8.7 pat OpenSSH* compat 0x04000000
debug2: fd 3 setting O_NONBLOCK
debug1: Authenticating to 10.7.1.56:22 as 'slayz'
debug3: record_hostkey: found key type ED25519 in file /home/slayz/.ssh/known_hosts:1
debug3: record_hostkey: found key type RSA in file /home/slayz/.ssh/known_hosts:2
debug3: record_hostkey: found key type ECDSA in file /home/slayz/.ssh/known_hosts:3
debug3: load_hostkeys_file: loaded 3 keys from 10.7.1.56
debug1: load_hostkeys: fopen /home/slayz/.ssh/known_hosts2: No such file or directory
debug1: load_hostkeys: fopen /etc/ssh/ssh_known_hosts: No such file or directory
debug1: load_hostkeys: fopen /etc/ssh/ssh_known_hosts2: No such file or directory
debug3: order_hostkeyalgs: have matching best-preference key type ssh-ed25519-cert-v01@openssh.com, using HostkeyAlgorithms verbatim
debug3: send packet: type 20
debug1: SSH2_MSG_KEXINIT sent
debug3: receive packet: type 20
debug1: SSH2_MSG_KEXINIT received
debug2: local client KEXINIT proposal
debug2: KEX algorithms: sntrup761x25519-sha512@openssh.com,curve25519-sha256,curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group16-sha512,diffie-hellman-group18-sha512,diffie-hellman-group14-sha256,ext-info-c,kex-strict-c-v00@openssh.com
debug2: host key algorithms: ssh-ed25519-cert-v01@openssh.com,ecdsa-sha2-nistp256-cert-v01@openssh.com,ecdsa-sha2-nistp384-cert-v01@openssh.com,ecdsa-sha2-nistp521-cert-v01@openssh.com,sk-ssh-ed25519-cert-v01@openssh.com,sk-ecdsa-sha2-nistp256-cert-v01@openssh.com,rsa-sha2-512-cert-v01@openssh.com,rsa-sha2-256-cert-v01@openssh.com,ssh-ed25519,ecdsa-sha2-nistp256,ecdsa-sha2-nistp384,ecdsa-sha2-nistp521,sk-ssh-ed25519@openssh.com,sk-ecdsa-sha2-nistp256@openssh.com,rsa-sha2-512,rsa-sha2-256
debug2: ciphers ctos: chacha20-poly1305@openssh.com,aes128-ctr,aes192-ctr,aes256-ctr,aes128-gcm@openssh.com,aes256-gcm@openssh.com
debug2: ciphers stoc: chacha20-poly1305@openssh.com,aes128-ctr,aes192-ctr,aes256-ctr,aes128-gcm@openssh.com,aes256-gcm@openssh.com
debug2: MACs ctos: umac-64-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,hmac-sha1-etm@openssh.com,umac-64@openssh.com,umac-128@openssh.com,hmac-sha2-256,hmac-sha2-512,hmac-sha1
debug2: MACs stoc: umac-64-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,hmac-sha1-etm@openssh.com,umac-64@openssh.com,umac-128@openssh.com,hmac-sha2-256,hmac-sha2-512,hmac-sha1
debug2: compression ctos: none,zlib@openssh.com,zlib
debug2: compression stoc: none,zlib@openssh.com,zlib
debug2: languages ctos: 
debug2: languages stoc: 
debug2: first_kex_follows 0 
debug2: reserved 0 
debug2: peer server KEXINIT proposal
debug2: KEX algorithms: curve25519-sha256,curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group14-sha256,diffie-hellman-group16-sha512,diffie-hellman-group18-sha512,kex-strict-s-v00@openssh.com
debug2: host key algorithms: rsa-sha2-512,rsa-sha2-256,ecdsa-sha2-nistp256,ssh-ed25519
debug2: ciphers ctos: aes256-gcm@openssh.com,chacha20-poly1305@openssh.com,aes256-ctr,aes128-gcm@openssh.com,aes128-ctr
debug2: ciphers stoc: aes256-gcm@openssh.com,chacha20-poly1305@openssh.com,aes256-ctr,aes128-gcm@openssh.com,aes128-ctr
debug2: MACs ctos: hmac-sha2-256-etm@openssh.com,hmac-sha1-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512-etm@openssh.com,hmac-sha2-256,hmac-sha1,umac-128@openssh.com,hmac-sha2-512
debug2: MACs stoc: hmac-sha2-256-etm@openssh.com,hmac-sha1-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512-etm@openssh.com,hmac-sha2-256,hmac-sha1,umac-128@openssh.com,hmac-sha2-512
debug2: compression ctos: none,zlib@openssh.com
debug2: compression stoc: none,zlib@openssh.com
debug2: languages ctos: 
debug2: languages stoc: 
debug2: first_kex_follows 0 
debug2: reserved 0 
debug3: kex_choose_conf: will use strict KEX ordering
debug1: kex: algorithm: curve25519-sha256
debug1: kex: host key algorithm: ssh-ed25519
debug1: kex: server->client cipher: chacha20-poly1305@openssh.com MAC: <implicit> compression: none
debug1: kex: client->server cipher: chacha20-poly1305@openssh.com MAC: <implicit> compression: none
debug3: send packet: type 30
debug1: expecting SSH2_MSG_KEX_ECDH_REPLY
debug3: receive packet: type 31
debug1: SSH2_MSG_KEX_ECDH_REPLY received
debug1: Server host key: ssh-ed25519 SHA256:E0DUFUamr4RruHPvAkAKkhWKQli1+Sw+ZEiBf6ePFlg
debug3: record_hostkey: found key type ED25519 in file /home/slayz/.ssh/known_hosts:1
debug3: record_hostkey: found key type RSA in file /home/slayz/.ssh/known_hosts:2
debug3: record_hostkey: found key type ECDSA in file /home/slayz/.ssh/known_hosts:3
debug3: load_hostkeys_file: loaded 3 keys from 10.7.1.56
debug1: load_hostkeys: fopen /home/slayz/.ssh/known_hosts2: No such file or directory
debug1: load_hostkeys: fopen /etc/ssh/ssh_known_hosts: No such file or directory
debug1: load_hostkeys: fopen /etc/ssh/ssh_known_hosts2: No such file or directory
debug1: Host '10.7.1.56' is known and matches the ED25519 host key.
debug1: Found key in /home/slayz/.ssh/known_hosts:1
debug3: send packet: type 21
debug1: ssh_packet_send2_wrapped: resetting send seqnr 3
debug2: ssh_set_newkeys: mode 1
debug1: rekey out after 134217728 blocks
debug1: SSH2_MSG_NEWKEYS sent
debug1: expecting SSH2_MSG_NEWKEYS
debug3: receive packet: type 21
debug1: ssh_packet_read_poll2: resetting read seqnr 3
debug1: SSH2_MSG_NEWKEYS received
debug2: ssh_set_newkeys: mode 0
debug1: rekey in after 134217728 blocks
debug3: ssh_get_authentication_socket_path: path '/tmp/ssh-XXXXXXPdjPV9/agent.8092'
debug1: get_agent_identities: bound agent to hostkey
debug1: get_agent_identities: ssh_fetch_identitylist: agent contains no identities
debug1: Will attempt key: /home/slayz/.ssh/id_ed25519 ED25519 SHA256:BesDGxAz+q9/hT7qwKa0B1bCf+f0Qte24af5LZqwOTE explicit
debug2: pubkey_prepare: done
debug3: send packet: type 5
debug3: receive packet: type 7
debug1: SSH2_MSG_EXT_INFO received
debug1: kex_input_ext_info: server-sig-algs=<ssh-ed25519,sk-ssh-ed25519@openssh.com,ssh-rsa,rsa-sha2-256,rsa-sha2-512,ssh-dss,ecdsa-sha2-nistp256,ecdsa-sha2-nistp384,ecdsa-sha2-nistp521,sk-ecdsa-sha2-nistp256@openssh.com,webauthn-sk-ecdsa-sha2-nistp256@openssh.com>
debug3: receive packet: type 6
debug2: service_accept: ssh-userauth
debug1: SSH2_MSG_SERVICE_ACCEPT received
debug3: send packet: type 50
debug3: receive packet: type 51
debug1: Authentications that can continue: publickey,gssapi-keyex,gssapi-with-mic
debug3: start over, passed a different list publickey,gssapi-keyex,gssapi-with-mic
debug3: preferred gssapi-with-mic,publickey,keyboard-interactive,password
debug3: authmethod_lookup gssapi-with-mic
debug3: remaining preferred: publickey,keyboard-interactive,password
debug3: authmethod_is_enabled gssapi-with-mic
debug1: Next authentication method: gssapi-with-mic
debug1: No credentials were supplied, or the credentials were unavailable or inaccessible
No Kerberos credentials available (default cache: FILE:/tmp/krb5cc_1000)


debug1: No credentials were supplied, or the credentials were unavailable or inaccessible
No Kerberos credentials available (default cache: FILE:/tmp/krb5cc_1000)


debug2: we did not send a packet, disable method
debug3: authmethod_lookup publickey
debug3: remaining preferred: keyboard-interactive,password
debug3: authmethod_is_enabled publickey
debug1: Next authentication method: publickey
debug1: Offering public key: /home/slayz/.ssh/id_ed25519 ED25519 SHA256:BesDGxAz+q9/hT7qwKa0B1bCf+f0Qte24af5LZqwOTE explicit
debug3: send packet: type 50
debug2: we sent a publickey packet, wait for reply
debug3: receive packet: type 60
debug1: Server accepts key: /home/slayz/.ssh/id_ed25519 ED25519 SHA256:BesDGxAz+q9/hT7qwKa0B1bCf+f0Qte24af5LZqwOTE explicit
debug3: sign_and_send_pubkey: using publickey with ED25519 SHA256:BesDGxAz+q9/hT7qwKa0B1bCf+f0Qte24af5LZqwOTE
debug3: sign_and_send_pubkey: signing using ssh-ed25519 SHA256:BesDGxAz+q9/hT7qwKa0B1bCf+f0Qte24af5LZqwOTE
debug3: send packet: type 50
debug3: receive packet: type 52
Authenticated to 10.7.1.56 ([10.7.1.56]:22) using "publickey".
debug1: channel 0: new session [client-session] (inactive timeout: 0)
debug3: ssh_session2_open: channel_new: 0
debug2: channel 0: send open
debug3: send packet: type 90
debug1: Requesting no-more-sessions@openssh.com
debug3: send packet: type 80
debug1: Entering interactive session.
debug1: pledge: filesystem
debug3: client_repledge: enter
debug3: receive packet: type 80
debug1: client_input_global_request: rtype hostkeys-00@openssh.com want_reply 0
debug3: client_input_hostkeys: received RSA key SHA256:GzXlRxrV0kiDameyNeYE2SDTZvDmAOzBn6Z0QBYdNTw
debug3: client_input_hostkeys: received ECDSA key SHA256:PISUX5KdfPSN+b4QcXThiLkq5+hmmEQwj9wv/Cm7gKo
debug3: client_input_hostkeys: received ED25519 key SHA256:E0DUFUamr4RruHPvAkAKkhWKQli1+Sw+ZEiBf6ePFlg
debug1: client_input_hostkeys: searching /home/slayz/.ssh/known_hosts for 10.7.1.56 / (none)
debug3: hostkeys_foreach: reading file "/home/slayz/.ssh/known_hosts"
debug3: hostkeys_find: found ssh-ed25519 key at /home/slayz/.ssh/known_hosts:1
debug3: hostkeys_find: found ssh-rsa key at /home/slayz/.ssh/known_hosts:2
debug3: hostkeys_find: found ecdsa-sha2-nistp256 key at /home/slayz/.ssh/known_hosts:3
debug1: client_input_hostkeys: searching /home/slayz/.ssh/known_hosts2 for 10.7.1.56 / (none)
debug1: client_input_hostkeys: hostkeys file /home/slayz/.ssh/known_hosts2 does not exist
debug3: client_input_hostkeys: 3 server keys: 0 new, 3 retained, 0 incomplete match. 0 to remove
debug1: client_input_hostkeys: no new or deprecated keys from server
debug3: client_repledge: enter
debug3: receive packet: type 4
debug1: Remote: /home/slayz/.ssh/authorized_keys:2: key options: agent-forwarding port-forwarding pty user-rc x11-forwarding
debug3: receive packet: type 4
debug1: Remote: /home/slayz/.ssh/authorized_keys:2: key options: agent-forwarding port-forwarding pty user-rc x11-forwarding
debug3: receive packet: type 91
debug2: channel_input_open_confirmation: channel 0: callback start
debug2: fd 3 setting TCP_NODELAY
debug3: set_sock_tos: set socket 3 IP_TOS 0x10
debug2: client_session2_setup: id 0
debug2: channel 0: request pty-req confirm 1
debug3: send packet: type 98
debug1: Sending environment.
debug3: Ignored env SHELL
debug3: Ignored env SESSION_MANAGER
debug3: Ignored env WINDOWID
debug3: Ignored env QT_ACCESSIBILITY
debug3: Ignored env COLORTERM
debug3: Ignored env XDG_CONFIG_DIRS
debug3: Ignored env NVM_INC
debug3: Ignored env XDG_MENU_PREFIX
debug3: Ignored env GTK_IM_MODULE
debug3: Ignored env SSH_AUTH_SOCK
debug3: Ignored env XMODIFIERS
debug3: Ignored env DESKTOP_SESSION
debug3: Ignored env SSH_AGENT_PID
debug3: Ignored env GTK_MODULES
debug3: Ignored env XDG_SEAT
debug3: Ignored env PWD
debug3: Ignored env LOGNAME
debug3: Ignored env XDG_SESSION_DESKTOP
debug3: Ignored env XDG_SESSION_TYPE
debug3: Ignored env SYSTEMD_EXEC_PID
debug3: Ignored env XAUTHORITY
debug3: Ignored env WINDOWPATH
debug3: Ignored env GDM_LANG
debug3: Ignored env HOME
debug3: Ignored env USERNAME
debug1: channel 0: setting env LANG = "fr_FR.UTF-8"
debug2: channel 0: request env confirm 0
debug3: send packet: type 98
debug3: Ignored env LS_COLORS
debug3: Ignored env XDG_CURRENT_DESKTOP
debug3: Ignored env VTE_VERSION
debug3: Ignored env CLUTTER_IM_MODULE
debug3: Ignored env NVM_DIR
debug3: Ignored env XDG_SESSION_CLASS
debug3: Ignored env TERM
debug3: Ignored env XAUTHLOCALHOSTNAME
debug3: Ignored env USER
debug3: Ignored env DISPLAY
debug3: Ignored env SHLVL
debug3: Ignored env NVM_CD_FLAGS
debug3: Ignored env QT_IM_MODULE
debug3: Ignored env XDG_VTNR
debug3: Ignored env XDG_SESSION_ID
debug3: Ignored env XDG_RUNTIME_DIR
debug3: Ignored env XDG_DATA_DIRS
debug3: Ignored env PATH
debug3: Ignored env GDMSESSION
debug3: Ignored env DBUS_SESSION_BUS_ADDRESS
debug3: Ignored env NVM_BIN
debug3: Ignored env _
debug2: channel 0: request shell confirm 1
debug3: send packet: type 98
debug3: client_repledge: enter
debug1: pledge: fork
debug2: channel_input_open_confirmation: channel 0: callback done
debug2: channel 0: open confirm rwindow 0 rmax 32768
debug3: receive packet: type 99
debug2: channel_input_status_confirm: type 99 id 0
debug2: PTY allocation request accepted on channel 0
debug2: channel 0: rcvd adjust 2097152
debug3: receive packet: type 99
debug2: channel_input_status_confirm: type 99 id 0
debug2: shell request accepted on channel 0
Last login: Mon Jan 13 12:34:14 2025 from 10.7.1.1
```

## 4. DoT

**🌞 Configurer la machine pour qu'elle fasse du DoT**

```bash
[slayz@localhost ~]$ sudo dnf install systemd-resolved

[slayz@localhost ~]$ sudo systemctl start systemd-resolved

[slayz@localhost ~]$ sudo nano /etc/systemd/resolved.conf
[Resolve]
DNS=1.1.1.1
DNSSEC=true
DNSOverTLS=yes
[slayz@localhost ~]$ sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
```

**🌞 Prouvez que les requêtes DNS effectuées par la machine...**

```bash
[slayz@linux ~]$ dig ynov.com

; <<>> DiG 9.16.23-RH <<>> ynov.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 30474
;; flags: qr rd ra; QUERY: 1, ANSWER: 3, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;ynov.com.			IN	A

;; ANSWER SECTION:
ynov.com.		300	IN	A	172.67.74.226
ynov.com.		300	IN	A	104.26.10.233
ynov.com.		300	IN	A	104.26.11.233

;; Query time: 415 msec
;; SERVER: 127.0.0.53#53(127.0.0.53)
;; WHEN: Thu Jan 16 09:20:46 CET 2025
;; MSG SIZE  rcvd: 85


[slayz@linux ~]$ resolvectl query ynov.com
ynov.com: 104.26.11.233                        -- link: enp0s8
          104.26.10.233                        -- link: enp0s8
          172.67.74.226                        -- link: enp0s8
          2606:4700:20::681a:ae9               -- link: enp0s8
          2606:4700:20::ac43:4ae2              -- link: enp0s8
          2606:4700:20::681a:be9               -- link: enp0s8

-- Information acquired via protocol DNS in 1.3ms.
-- Data is authenticated: no; Data was acquired via local or encrypted transport: yes
-- Data from: cache

```

[Trame Wireshark](dns_tls_capture.pcap)

## 5. AIDE

**🌞 Installer et configurer AIDE**

```bash
[slayz@linux ~]$ sudo yum install aide
[slayz@linux ~]$ sudo aide --init
Start timestamp: 2025-01-16 09:40:10 +0100 (AIDE 0.16)
AIDE initialized database at /var/lib/aide/aide.db.new.gz

Number of entries:	40990

---------------------------------------------------
The attributes of the (uncompressed) database(s):
---------------------------------------------------

/var/lib/aide/aide.db.new.gz
  MD5      : yV+nRnXG4V0PcpIrWKJxzw==
  SHA1     : pXqxFFRIZhEpw4Td4EmeU5OJj9w=
  RMD160   : 4KlWFXHJj9RVQjWw6dKpMLlqmUY=
  TIGER    : FBcG9tao3wOVT4yssovJy+KKUmv8l9LT
  SHA256   : hhaNwHA/QNmst+Do6JAY70+zAkpD8ogT
             /gkqiIYB0xQ=
  SHA512   : bYz6XXbjkG6jvgwKg37I5ZKNKwQDMa1b
             whKnjNQuObZSHOGHGOXVUcIuDuBdLrWB
             p6kuUk67aYMV3Lb78J19vg==


End timestamp: 2025-01-16 09:40:20 +0100 (run time: 0m 10s)
[slayz@linux ~]$ sudo mv /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz
[slayz@linux ~]$ sudo aide --check
Start timestamp: 2025-01-16 09:41:54 +0100 (AIDE 0.16)
AIDE found NO differences between database and filesystem. Looks okay!!

Number of entries:	40990

---------------------------------------------------
The attributes of the (uncompressed) database(s):
---------------------------------------------------

/var/lib/aide/aide.db.gz
  MD5      : yV+nRnXG4V0PcpIrWKJxzw==
  SHA1     : pXqxFFRIZhEpw4Td4EmeU5OJj9w=
  RMD160   : 4KlWFXHJj9RVQjWw6dKpMLlqmUY=
  TIGER    : FBcG9tao3wOVT4yssovJy+KKUmv8l9LT
  SHA256   : hhaNwHA/QNmst+Do6JAY70+zAkpD8ogT
             /gkqiIYB0xQ=
  SHA512   : bYz6XXbjkG6jvgwKg37I5ZKNKwQDMa1b
             whKnjNQuObZSHOGHGOXVUcIuDuBdLrWB
             p6kuUk67aYMV3Lb78J19vg==


End timestamp: 2025-01-16 09:42:05 +0100 (run time: 0m 11s)

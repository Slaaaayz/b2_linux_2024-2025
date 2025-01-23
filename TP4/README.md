# TP4 : Hardening Script

## I. Setup initial

**🌞 Setup web.tp5.b2**

```bash
[slayz@localhost ~]$ sudo dnf install nginx
[slayz@localhost ~]$ sudo systemctl enable nginx
Created symlink /etc/systemd/system/multi-user.target.wants/nginx.service → /usr/lib/systemd/system/nginx.service.
[slayz@localhost ~]$ sudo systemctl start nginx
[slayz@localhost ~]$ sudo firewall-cmd --add-port=80/tcp --permanent
success
[slayz@localhost ~]$ sudo firewall-cmd --reload
success
[slayz@localhost ~]$ sudo mkdir -p /var/www/app_nulle/
[slayz@localhost ~]$ sudo cat /var/www/app_nulle/index.html 
<h1>Hi, Im Slayz</h1>
[slayz@localhost ~]$ sudo nano /etc/nginx/conf.d/nginx.conf
[slayz@localhost ~]$ sudo nginx -t
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
[slayz@localhost ~]$ sudo cat /etc/nginx/conf.d/nginx.conf 
server {
    listen 80;

    location / {
        root /var/www/app_nulle/;
        index index.html index.htm;
    }
}
[slayz@localhost ~]$ sudo systemctl restart nginx
```

**🌞 Setup rp.tp5.b2**

```bash
[slayz@localhost ~]$ sudo dnf install nginx
[slayz@localhost ~]$ sudo cat /etc/nginx/conf.d/proxy.conf 
server {
    listen    80;

    location / {
        proxy_pass http://10.7.1.12;
    }
}
[slayz@localhost ~]$ sudo firewall-cmd --add-port=80/tcp --permanent
success
[slayz@localhost ~]$ sudo firewall-cmd --reload
success
[slayz@localhost ~]$ sudo systemctl enable nginc
Failed to enable unit: Unit file nginc.service does not exist.
[slayz@localhost ~]$ sudo systemctl enable nginx
Created symlink /etc/systemd/system/multi-user.target.wants/nginx.service → /usr/lib/systemd/system/nginx.service.
[slayz@localhost ~]$ sudo systemctl start nginc
Failed to start nginc.service: Unit nginc.service not found.
[slayz@localhost ~]$ sudo systemctl start nginx

**🌞 HTTPS rp.tp5.b2**

```bash
[slayz@localhost key]$ openssl req -new -newkey rsa:4080 -days 365 -nodes -x509 -keyout server.key -out server.crt
[slayz@localhost ~]$ sudo cat /etc/nginx/conf.d/proxy.conf 
server {
    listen    443 ssl;

    ssl_certificate     /home/slayz/key/server.crt;
    ssl_certificate_key /home/slayz/key/server.key;
	


    location / {
        proxy_pass http://10.7.1.12;
    }
}
[slayz@localhost ~]$ sudo firewall-cmd --add-port=443/tcp --permanent
success
[slayz@localhost ~]$ sudo firewall-cmd --reload
success
[slayz@localhost ~]$ sudo systemctl restart nginx
```

# II. Hardening script

[Voici le script](hardening.sh)



# TP2 : Utilisation courante de Docker

## I. Packaging de l'app Web

**🌞 docker-compose.yml**

[Voir le docker compose](docker-compose.yml)

## II Dév. Python 

**🌞 Le lien vers ton dépôt**

### 1. Calculatrice

[Clique ici pour la calculatrice](https://github.com/Slaaaayz/calc_docker)


### 2. Chat room

[Clique ici pour le chat room](https://github.com/Slaaaayz/chat_room)

### 3. Ur own

**🌞 Packager une application à vous**

[Clique ici pour voir le docker de mon projet](https://github.com/Slaaaayz/fightclub)

## TP2 admins : Web stack



### I. Good practices
**🌞 Limiter l'accès aux ressources**

```bash
docker run -m 1g --cpus="1" <image_name>
```

**🌞 No root**

```bash
FROM nginx:latest
RUN useradd -m -s /bin/bash nginxuser
USER nginxuser
```

**🌞 Gestion des droits du volume qui contient le code**
    
```bash
sudo chmod -R 755 /app
```

**🌞 Gestion des capabilities sur le conteneur NGINX**
```bash
    cap_drop:
      - ALL        
    cap_add:
      - NET_BIND_SERVICE 
```

**🌞 Mode read-only**

```bash
    read_only: true      
```



## II. Reverse proxy buddy

### A. Simple HTTP setup

[Voir le docker compose](./docker-compose.yml)

```bash
slayz@debian:~/Repo Git/b2_linux_2024-2025$ sudo cat /etc/hosts
127.0.0.1 www.supersite.com
127.0.0.1 pma.supersite.com 
```

### B. HTTPS auto-signé

**🌞 HTTPS auto-signé**

```bash
slayz@debian:~/Repo Git/b2_linux_2024-2025/TP2$ openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -keyout *.supersite.com.key -out *.supersite.com.crt
.....+..+...+...+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*....+...+......+...+..+.+........+.......+...+.....+....+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*..+..........+.....+.+.....+.......+.....+.......+.....+.+.....+.............+......+.....+......+.............+.........+...+........+......................+..+...+....+.....................+.....+....+.........+..+.......+...+.................+......+............+.......+..+.........+.....................+...............+.........+..........+......+...+...+..+.......+.....+.+........+............+.......+.................+....+..+....+.....+......+....+...+......+......+.....+................+........+....+..+...+..................+.......+..+....+...............+.....+...............+....+...+..+............+....+.................+..........+.............................+...+.+......+..................+...+.........+...........+...................+...........+..........+..............+....+............+.....+.......+..+..................+.+..+..........+........+.+...+..+.....................+......................+......+..+....+...+.....+.+.....+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
...+.......+............+...........+.+...+...+..+...+....+...+...+.........+.........+.........+..+.+..+.............+...+..+...+......+...+.+......+...+..+...+..........+.....+..........+..+....+......+......+...............+..+......+.+.....+.+...+...........+.+...+..+.......+........+..................+.+..............+.+.....+..........+...+...+.....+...+....+......+.........+...+...+......+...+..+...+...+...+.........+.......+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*.+...+.........+............+...........+...+....+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*..+......+.+..+.......+........+...+...+.........+...+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:FR
State or Province Name (full name) [Some-State]:France
Locality Name (eg, city) []:Bordeaux
Organization Name (eg, company) [Internet Widgits Pty Ltd]:Slayz
Organizational Unit Name (eg, section) []:Slayz
Common Name (e.g. server FQDN or YOUR name) []:Slayz
Email Address []:slayz@gmail.com
```

### C. HTTPS avec une CA maison

**🌞 Générer une clé et un certificat de CA**

```bash
slayz@debian:~/Repo Git/b2_linux_2024-2025/TP2$ openssl genrsa -des3 -out CA.key 4096
Enter PEM pass phrase:
40A722E9307F0000:error:14000065:UI routines:UI_set_result_ex:result too small:../crypto/ui/ui_lib.c:888:You must type in 4 to 1024 characters
40A722E9307F0000:error:1400006B:UI routines:UI_process:processing error:../crypto/ui/ui_lib.c:548:while reading strings
40A722E9307F0000:error:0480006D:PEM routines:PEM_def_callback:problems getting password:../crypto/pem/pem_lib.c:62:
40A722E9307F0000:error:07880109:common libcrypto routines:do_ui_passphrase:interrupted or cancelled:../crypto/passphrase.c:184:
40A722E9307F0000:error:1C80009F:Provider routines:p8info_to_encp8:unable to get passphrase:../providers/implementations/encode_decode/encode_key2any.c:116:
slayz@debian:~/Repo Git/b2_linux_2024-2025/TP2$ openssl genrsa -des3 -out CA.key 4096
Enter PEM pass phrase:
Verifying - Enter PEM pass phrase:
slayz@debian:~/Repo Git/b2_linux_2024-2025/TP2$ openssl req -x509 -new -nodes -key CA.key -sha256 -days 1024  -out CA.pem
Enter pass phrase for CA.key:
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:FR
State or Province Name (full name) [Some-State]:France
Locality Name (eg, city) []:Bordeaux 
Organization Name (eg, company) [Internet Widgits Pty Ltd]:Slayz
Organizational Unit Name (eg, section) []:Slayz
Common Name (e.g. server FQDN or YOUR name) []:Slayz
Email Address []:Slayz@gmail.com
```

**🌞 Générer une clé et une demande de signature de certificat pour notre serveur web**

```bash
slayz@debian:~/Repo Git/b2_linux_2024-2025/TP2$ openssl req -new -nodes -out www.supersite.com.csr -newkey rsa:4096 -keyout www.supersite.com.key
..+........+...+....+........+.......+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*..+.......+.....+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*...........+.+..............+......+.......+.........+.....+..........+......+..+...+...+......+.........+.......+........+..........+.....................+...+......+..+.........+.+..............+.........+....+.....+.......+...+..+.+............+....................+.............+...+......+...+...........+......+.+...+.....+.........+......+.......+........+......+.+..............+...+.+.................+...+....+..+.+.................+..........+...........+......+....+.........+..+....+.........+..+.........+....+............+......+........+.+......+...............+............+.......................+.........+...+..........+......+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
.+...+....+......+...+..+...+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*..............+...+..........+..+.+.....+.+......+..+......+.+......+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*..+.+..+................+...........+.............+..+...+......+.+.....................+...+..............+.+..+....+.....+......+....+..................+...+............+........+..........+.....+.......+...........+.+.....+...+............+.+.....+.........+......+...+...........................+....+..............+.+......+..............+.........+.+...+.....+...+.............+...........+...+.+..+....+...+...........+.+.........+......+...+...+.........+..................+...+..............+....+.....+....+..+.............+..+....+.....+............+...+......+.+...............+..+...............+......+......+.+.....+.......+..+.+.....+..................+.+.........+...........+....+.....+.....................+.+.........+...+...+.....+...+.......+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:FR
State or Province Name (full name) [Some-State]:France
Locality Name (eg, city) []:France
Organization Name (eg, company) [Internet Widgits Pty Ltd]:Slayz
Organizational Unit Name (eg, section) []:SLayz
Common Name (e.g. server FQDN or YOUR name) []:Slayz
Email Address []:slayz@gmail.com

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:root
An optional company name []:
```

**🌞 Faire signer notre certificat par la clé de la CA**

```bash
slayz@debian:~/Repo Git/b2_linux_2024-2025/TP2$ openssl x509 -req -in www.supersite.com.csr -CA CA.pem -CAkey CA.key -CAcreateserial -out www.supersite.com.crt -days 500 -sha2
Certificate request self-signature ok
subject=C = FR, ST = France, L = France, O = Slayz, OU = SLayz, CN = Slayz, emailAddress = slayz@gmail.com
Enter pass phrase for CA.key:
40F72B04FF7E0000:error:0308010C:digital envelope routines:inner_evp_generic_fetch:unsupported:../crypto/evp/evp_fetch.c:386:Global default library context, Algorithm (sha2 : 0), Properties (<null>)
40F72B04FF7E0000:error:03000086:digital envelope routines:do_sigver_init:initialization error:../crypto/evp/m_sigver.c:253:
```

**🌞 Ajustez la configuration NGINX**

[Voir la conf nginx](./nginx/web.conf)

**🌞 Prouvez avec un curl que vous accédez au site web**

```bash
slayz@debian:~/Repo Git/b2_linux_2024-2025/TP2$ curl -k https://www.supersite.com/
[{"id":"bob","name":1},{"id":"martin","name":2},{"id":"pikachu","name":3},{"id":"shibboleth","name":4}]
```

**🌞 Ajouter le certificat de la CA dans votre navigateur**

![certif](./img/certif.png)


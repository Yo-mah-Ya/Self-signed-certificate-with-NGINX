# SSL communication demo with NGINX

1. Copy default nginx folders in a docker container to local folder

```sh
./docker.sh build
./docker.sh run_first
./docker.sh cp
```

2. Add SSL config into nginx config

```sh
./ssl.sh
```

**This time passphrase is supposed to be passphrase**

so just type `passphrase` for shown below question

```
Enter pass phrase for privkey.pem:
```

**Common Name is also supposed to be `ssl.test`**

so just type `ssl.test` for shown below question

```
Common Name (eg, fully qualified host name) []:ssl.test
```

3. add `ssl.test` domain into your hosts setting.

```sh
sudo vim /etc/hosts
```

add like shown below
```sh
127.0.0.1       ssl.test
```

4. Run docker

```sh
./docker.sh build
./docker.sh run
```

5. access `ssl.test` on web browser or just access with `curl` command

```sh
curl --verbose --insecure --header 'Host: ssl.test' https://ssl.test
```

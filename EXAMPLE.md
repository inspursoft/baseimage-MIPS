# EXAMPLE
Tips: The rootfs generated by both methods need to execute `febootstrap-minimize`, and then delete the locale file to make the image smaller. <br>
More detailed explanation is at the end of this shell: https://github.com/moby/moby/blob/master/contrib/mkimage-yum.sh or you can `man febootstrap-minimize`.
## 1. HOW TO USE `mkimage-kylin-1.0.sh`
This shell helps to make a base rootfs containing *yum* and *bash*. Then you can use `tar -c .|docker import - imagename:tag` to make a base image. Next is the example of generating a Nginx image based on the base image. Here are the operations after entering the  container.<br>
1. Since we have yum, we can directly `yun install wget`
```
yum install -y wget
```
2. Download the installation package
```
wget http://nginx.org/download/nginx-1.10.3.tar.gz
```
3. Install dependence
```
yum install -y gcc* c++ openssl openssl-devel cyrus-sasl-md5
```
4. Unzip the package
```
tar -zxvf nginx-1.10.3.tar.gz
```
5. Install nginx
```
cd nginx-1.10.3
./configure --prefix=/usr/local/nginx
make && make install
```
6. Configure environment variables
```
vi /etc/profile
export PATH="$PATH:/usr/local/nginx/sbin"
source /etc/profile
```
7. Modify the nginx configuration file
```
vi /usr/local/nginx/conf/nginx.conf
listen 8080
```
8. Start nginx and test
```
nginx
curl localhost:8080
```
9. Exit the container, the container will stop
```
exit
```
10. Use the `docker commit` command to submit a image created
```
docker commit -m 'Nginx' -a 'Kylin-Nginx' f750f537df59 fanzhihai/nginx-mips:1.0
```
11. End, `docker push` the image to the repository
```
docker push fanzhihai/nginx-mips:1.0
```
## 2. HOW TO USE `mkimage-kylin-latest.sh`
This shell helps to make a base rootfs ONLY containing *bash*. So far, it's the minimal image from NeoKylin OS image(81.6 MB). Next is the example of generating a Nginx image based on the base image.<br>

1. Since we do not have *yum* in the image, we directly add nginx binary, config, html... in the image.<br>
2. You can find these files in `nginx-image/source` that are same as `/usr/local/nginx` in last method.
3. The Dockerfile is provided in `nginx-image` floder.

# Introduction
This repository is used for my private command collection
Used for several task, e.g. add user, install shell, packages, and etc.

Feel free to use this repository if you need

# How to run
## Pre-requisites
1. Add the `Shell Script` directory into your `PATH`, or simply just go inside it
2. Don't forget to add execute permission to all of the .sh files.

```
chmod +x './Shell Script/*.sh'
```

## Add user
### Without pre-filled encrypted password
```
cd "Shell Script"

./os-user-add.sh -u USERNAME
```

### With pre-filled encrypted password
```
./os-user-add.sh -u USERNAME -p PASSWORD
```
or
```
./os-user-add.sh -u USERNAME -p $(openssl passwd -6 "PASSWORD")
```
> You can get the encrypted password from any other online tools such as [mkpasswd.net](https://www.mkpasswd.net/index.php). \
> However, it will be much safer to generate the password from your own local device.


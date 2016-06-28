# EashSSH
Use ssh, scp without IP address and password 

## Config
Add path of folder `bin` to envionment variables `PATH`

Add hosts into `cfg/hosts`, each host take one line and identify by hostid, eg.

```text
hostid1 111.111.111.111 22 username password 
hostid2 123.123.111.111 22 username password 
```

## Usage
login remote host

```sh
ssh_login hostid
```
run command at remote host

```sh
ssh_cmd hostid command
```

copy file from local to remote host

```sh
ssh_scp hostid tofar localfile remotefile
```

copy file from remote host to local

```sh
ssh_scp hostid toloc remotefile localfile
```
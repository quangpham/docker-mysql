```bash
git clone https://github.com/quangpham/docker-mysql.git
cd docker-mysql
docker build -t="quangpham/mysql" .
```

# Quick Start

Run the mysql image

```bash
docker run -name mysql -d quangpham/mysql:latest
```

By default the root mysql user is not assigned a password and remote logins are permitted from the docker network which normally is the '172.17.%.%' address space. This means that you should be able to login to the mysql server as root from the host machine as well as other containers running on the same host.

To test if the mysql server is configured properly, try connecting to the server.

```bash
mysql -h$(docker inspect --format {{.NetworkSettings.IPAddress}} mysql) -uroot
```

# Configuration

## Data Store

You should mount a volume at `/var/lib/mysql`.

SELinux users are also required to change the security context of the mount point so that it plays nicely with selinux.

```bash
mkdir -p /opt/mysql/data
sudo chcon -Rt svirt_sandbox_file_t /opt/mysql/data
```

The updated run command looks like this.

```
docker run -name mysql -d \
  -v /opt/mysql/data:/var/lib/mysql quangpham/mysql:latest
```

This will make sure that the data stored in the database is not lost when the image is stopped and started again.

## Allowing remote access

By default the installation will allow remote access to the root user from the docker network which normally is the `172.17.%.%` address space. This means that your host machine and other containers running on the host machine can login to the mysql server as root.

```sql
GRANT ALL ON *.<db-name> TO '<db-user>'@'<ip-address>' IDENTIFIED BY 'PASSWORD' WITH GRANT OPTION;
FLUSH PRIVILEGES;
```

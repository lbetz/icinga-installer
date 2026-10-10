# Installation

All commands have to be performed as user `root`.

The installer uses OpenVox >= 8.24 < 9. The `openvox-agent` package supplies the compatible
`puppet` command and the Ruby runtime under `/opt/puppetlabs/puppet/bin/ruby`.
Use this bundled Ruby for Bundler, gem installation, tests and release tools;
do not install a separate system Ruby for the installer. Source builds use
OpenVox Strings instead of Puppet Strings; see the source-build steps in the README.
Do not install a legacy `puppet-agent` package alongside OpenVox. On an existing
system, back up `/etc/puppetlabs` before replacing the runtime. The following
instructions target fresh systems; external installer packages must also allow
`openvox-agent` in their package dependencies.

## RHEL/AlmaLinux/Rocky 8:

**Notice**: The Installer supports SELinux only for Icinga 2 out of the box. So it makes no sense to set SELinux to `enforce` for server systems but you are able to do that for agents or workers.

Icinga Web 2 >= v2.9 recommends PHP 7.3 or higher, so we have to change the default package module for PHP!

```bash
dnf install -y https://packages.private.prefork.de/epel/8/Packages/p/prefork-packages-1.0.0-1.el8.noarch.rpm
dnf install -y https://yum.voxpupuli.org/openvox8-release-el-8.noarch.rpm
dnf install -y openvox-agent

dnf module reset php
dnf module enable php:7.4

dnf install -y icinga-installer
```

**Notice**: For some time now, access to current RPM packages on Icinga has required a paid [subscription](https://icinga.com/subscription). Unfortunately, using older package versions for an Icinga server is not provided for in this project. However, for workers and agents, there should be no issues with the public repos and thus older versions of Icinga 2.

A subscription is required, it is configured as follows:

```bash
cat /etc/icinga-installer/custom-hiera.yaml
---
icinga::repos:
  icinga-stable-release:
    baseurl: 'https://packages.icinga.com/subscription/rhel/$releasever/release/'
    username: <username>
    password: <password>
```

Username `<username>` and password `<password>` must be set according to your subscription.


## RHEL/AlmaLinux/Rocky 9 and CentOS Stream 9:

**Notice**: The Installer supports SELinux only for Icinga 2 out of the box. So it makes no sense to set SELinux to `enforce` for server systems but you are able to do that for agents or workers.

```bash
dnf install -y https://packages.private.prefork.de/epel/9/Packages/p/prefork-packages-1.0.0-1.el9.noarch.rpm
dnf install -y https://yum.voxpupuli.org/openvox8-release-el-9.noarch.rpm
dnf install -y openvox-agent

dnf install -y icinga-installer
```

**Notice**: For some time now, access to current RPM packages on Icinga has required a paid [subscription](https://icinga.com/subscription). Unfortunately, using older package versions for an Icinga server is not provided for in this project. However, for workers and agents, there should be no issues with the public repos and thus older versions of Icinga 2.

A subscription is required, it is configured as follows:

```bash
cat /etc/icinga-installer/custom-hiera.yaml
---
icinga::repos:
  icinga-stable-release:
    baseurl: 'https://packages.icinga.com/subscription/rhel/$releasever/release/'
    username: <username>
    password: <password>
```

Username `<username>` and password `<password>` must be set according to your subscription.


## Debian Bookworm:

```bash
apt update
apt install -y ca-certificates wget apt-transport-https gpg
install -d -m 0755 /etc/apt/keyrings
wget -O /etc/apt/keyrings/prefork-packages.asc https://packages.private.prefork.de/keys/prefork-packages.asc
chmod 0644 /etc/apt/keyrings/prefork-packages.asc
echo "deb [signed-by=/etc/apt/keyrings/prefork-packages.asc] https://packages.private.prefork.de/debian bookworm main" | tee /etc/apt/sources.list.d/prefork-packages.list
wget -O /tmp/openvox8-release.deb https://apt.voxpupuli.org/openvox8-release-debian12.deb
dpkg -i /tmp/openvox8-release.deb
apt update

apt install -y openvox-agent
apt install -y icinga-installer
```

## Ubuntu Jammy Jellyfish:

```bash
apt update
apt install -y ca-certificates wget apt-transport-https gpg
install -d -m 0755 /etc/apt/keyrings
wget -O /etc/apt/keyrings/prefork-packages.asc https://packages.private.prefork.de/keys/prefork-packages.asc
chmod 0644 /etc/apt/keyrings/prefork-packages.asc
echo "deb [signed-by=/etc/apt/keyrings/prefork-packages.asc] https://packages.private.prefork.de/ubuntu jammy main" | tee /etc/apt/sources.list.d/prefork-packages.list
wget -O /tmp/openvox8-release.deb https://apt.voxpupuli.org/openvox8-release-ubuntu22.04.deb
dpkg -i /tmp/openvox8-release.deb
apt update

apt install -y openvox-agent
apt install -y icinga-installer
```

## Ubuntu Noble Numbat

```bash
apt update
apt install -y ca-certificates wget apt-transport-https gpg
install -d -m 0755 /etc/apt/keyrings
wget -O /etc/apt/keyrings/prefork-packages.asc https://packages.private.prefork.de/keys/prefork-packages.asc
chmod 0644 /etc/apt/keyrings/prefork-packages.asc
echo "deb [signed-by=/etc/apt/keyrings/prefork-packages.asc] https://packages.private.prefork.de/ubuntu noble main" | tee /etc/apt/sources.list.d/prefork-packages.list
wget -O /tmp/openvox8-release.deb https://apt.voxpupuli.org/openvox8-release-ubuntu24.04.deb
dpkg -i /tmp/openvox8-release.deb
apt update

apt install -y openvox-agent
apt install -y icinga-installer
```

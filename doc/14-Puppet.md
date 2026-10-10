# OpenVox Agent

By default the OpenVox agent service is disabled by the installer. To keep the
host managed by OpenVox, enter the following in `/etc/icinga-installer/custom-hiera.yaml`.
The service name `puppet` and the existing Hiera key remain unchanged for compatibility.

```yaml
puppet::disable: false
```

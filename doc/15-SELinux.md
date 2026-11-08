# SELinux

SELinux is only enabled by default on RedHat platforms if SELinux is enabled. To completely disable the management of SELinux, the following must be set in custom-hiera.yaml:

```yaml
icinga2::manage_selinux: false
```

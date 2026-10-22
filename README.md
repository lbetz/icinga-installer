# Simple installer for the Icinga software stack

The `icinga-installer` is a tool to install and manage your Icinga instance. It is based on OpenVox 8 and uses `YAML` configuration.

## Requirements:

 * OpenVox >= 8.24 < 9 from the `openvox-agent` package
 * The Ruby bundled with OpenVox (>= 3.2)
 * Rubygem `kafo`

OpenVox retains the `puppet` executable, Ruby `require 'puppet'`, service name,
and `/opt/puppetlabs` paths. Puppet module metadata therefore continues to use
the `puppet` requirement name. Do not install the legacy Puppet runtime alongside
OpenVox. All Ruby tools use `/opt/puppetlabs/puppet/bin/ruby`, not a system Ruby
or a separately installed OpenVox gem. The Gemfile checks the packaged runtime
and exposes its supporting gems to Bundler. OpenFact remains the vendor library
from the agent package. JSON is pinned to the packaged default version because
JSON 3 is incompatible with the OpenVox 8 module-install API.

## Source Build

On a disposable Linux system with `openvox-agent` installed, run as root:

Install Bolt (or OpenBolt) separately and ensure `bolt` is on `PATH`.

```sh
export PATH="/opt/puppetlabs/puppet/bin:/opt/puppetlabs/bin:$PATH"
/opt/puppetlabs/puppet/bin/ruby --version
/opt/puppetlabs/bin/puppet --version
bolt --version
/opt/puppetlabs/puppet/bin/bundle config set --local path.system true
/opt/puppetlabs/puppet/bin/bundle config set --local disable_shared_gems false
/opt/puppetlabs/puppet/bin/bundle install
/opt/puppetlabs/bin/puppet help strings
/opt/puppetlabs/puppet/bin/bundle exec rake build
/opt/puppetlabs/puppet/bin/bundle exec ruby test/verify_aio.rb
```

Do not isolate gems in `vendor/bundle`: Kafo's AIO subprocesses clear Bundler
environment overrides, so OpenVox Strings must be installed in the agent's gem
environment. The executable already has the AIO Ruby shebang; build subprocesses
also use that interpreter explicitly. `build` installs Forge modules with
`bolt module install --no-resolve` in a separate project under `_build`, copies
them to `_build/modules`, and adds the local `install` module. It generates
parser caches for all scenarios. Bolt runs outside the installer's Bundler
environment and uses its own runtime. The build does not
install the Icinga services on the system.

On a completely fresh container, an installer `--noop` run can compile the
catalog but still report missing MySQL providers or CA files: no-op does not
install packages or create certificates needed by subsequent resources. A clean
build and dependency check are not a complete installation test. Use a disposable
systemd VM for the real installation and a subsequent no-op/idempotency check.

The bundle uses Kafo 7.8 and OpenVox Strings 7.2. For the optional ncurses backend,
the locally modified Kafo and kafo_wizards checkouts are still required; the
released gems do not contain that extension.

## Puppet Module Versions

The Puppetfile pins the newest jointly compatible Forge releases checked on
2026-10-10. Four modules intentionally remain below their newest major version:

| Module | Pin | Compatibility constraint |
|---|---|---|
| puppetlabs/apt | 10.0.1 | puppet/icinga 7.2 requires apt < 11 |
| puppetlabs/stdlib | 9.7.0 | icinga, redis, php, archive and extlib require stdlib < 10 |
| puppet/systemd | 9.4.0 | puppet/redis 13.1 requires systemd < 10 |
| puppetlabs/concat | 9.1.0 | puppet/zypprepo 5.0 requires concat < 10; icinga requires zypprepo < 6 |

The local `install` module is copied from `modules/install` by the build task
and is not listed in the Puppetfile. Do not independently upgrade
every pin to the newest Forge release without checking all dependency ranges.

## Installation

Please refer to the [doc](https://github.com/NETWAYS/icinga-installer/tree/main/doc) directory for an installation guide and further information on how to configure the installer.

## Usage

The default Admin-Account for Icinga Web 2 is 'icingaadmin', the random initial password is displayed at the end of the installation process.

```bash
icinga-installer [-i] -S server-db-mysql|server-db-pgsql|server-ido-mysql|server-ido-pgsql|worker|agent
```

From the second run on, the -S option may be omitted, since the host is now set to this scenario.

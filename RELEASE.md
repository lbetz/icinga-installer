# Release Workflow
Before submitting a new release, make sure all relevant pull requests and local branches have been merged to the `main`
branch. All tests must pass before a release is tagged.


## 1. AUTHORS
Update the [AUTHORS] and [.mailmap] file

``` bash
git checkout main
git log --use-mailmap | grep ^Author: | cut -f2- -d' ' | sort | uniq > AUTHORS
git commit -am "Update AUTHORS"
```

## 2. Reference
``` bash
cd modules/install
```

Use the Ruby environment from `openvox-agent` (OpenVox >= 8.24 < 9, Ruby >= 3.2)
for every Ruby-based release tool. If [OpenVox Strings] is not installed:
``` bash
/opt/puppetlabs/puppet/bin/gem install openvox-strings -v '~> 7.2' --no-document
```
Generate [REFERENCE.md] via [OpenVox Strings]
``` bash
/opt/puppetlabs/bin/puppet strings generate --format markdown --out ../../REFERENCE.md
```

## 3. Version
Version numbers are incremented regarding the [SemVer 1.0.0] specification. 
Update the version number in `metadata.json` of puppet module `install`.

## 4. Changelog
Install [github-changelog-generator]
```bash
cd -
```

```bash
/opt/puppetlabs/puppet/bin/gem install github_changelog_generator --no-document
```

Generate [CHANGELOG.md]
```bash
/opt/puppetlabs/puppet/bin/github_changelog_generator --future-release=v1.0.0 -u netways -p icinga-installer
```

## 5. Git Tag
Provide the GitHub token through the tool's `CHANGELOG_GITHUB_TOKEN` environment
variable, not a command-line argument or a committed file.

Commit all changes to the `main` branch

``` bash
git commit -v -a -m "Release version <VERSION>"
git push
```

Tag the release

``` bash
git tag -m "Version <VERSION>" v<VERSION>
```

Push tags

``` bash
git push --tags
```

[github-changelog-generator]: https://github.com/skywinder/github-changelog-generator
[OpenVox Strings]: https://github.com/voxpupuli/openvox-strings
[SemVer 1.0.0]: http://semver.org/spec/v1.0.0.html
[CHANGELOG.md]: CHANGELOG.md
[AUTHORS]: AUTHORS
[.mailmap]: .mailmap

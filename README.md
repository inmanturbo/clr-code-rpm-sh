# Install and update vscode native on clear linux using supported tarball.

### A collection of simple bash scripts tied together with make, very easy to run.

## Includes script for adding it to swupd's "whitelist".

## How to use
Install dependencies
```bash
sudo swupd bundle-add wget jq make
```

Clone this repo.

```bash
git clone https://github.com/inmanturbo/clr-code-tar-sh.git
```
Change directory
```bash
cd clr-code-rpm-sh/
```

Check for an update with optional update/install
```bash
make
```
Also (alias)
```bash
make check
```
Fetch latest and update or install (do not bother checking or whitelisting, runs with no interaction)[You Could run this on a cron job]

```bash
sudo make fetch
```
Also (alias)
```bash
sudo make update
```
Download latest version
```bash
make download
```
Cleanup downloads
```bash
make clean
```
Uninstall
```bash
sudo make remove
```



# Install and update vscode native on clear linux using rpm.

### A collection of simple bash scripts tied together with make, very easy to run.

## Includes script for adding it to swupd's picky diagnose and repair "whitelist" using swupd [config](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#files).

## How to use
Install dependencies
```bash
sudo swupd bundle-add package-utils wget jq make
```

Clone this repo.

```bash
git clone https://github.com/inmanturbo/clr-code-rpm-sh.git
```
Change directory
```bash
cd clr-code-rpm-sh/
```

Install VsCode and build whitelist for swupd [optional]
```bash
sudo make install
```
````
Success. Rpm packages can be removed with 'rpm -e [release]'
Do you want to configure swupd to whitelist this package?
1) Yes
2) No
#?
````

Check for updates with optional update/install
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
Whitelist only
```bash
sudo make whitelist
```



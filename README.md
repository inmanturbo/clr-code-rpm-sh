# Install and update vscode on clear linux using rpm.

### A collection of simple bash scripts tied together with make, very easy to run.

## Includes script for adding it to swupd's "whitelist".

## How to use

Clone this repo.

```bash
git clone inmanturbo/clr-code-rpm-sh
```
Change directory
```bash
cd clr-code-rpm-sh/
```

Install VsCode and build whitelist for swupd [optional]
```bash
make install
```
````
Success. Rpm packages can be removed with 'rpm -e [release]'
Do you want to configure swupd to whitelist this package?
1) Yes
2) No
#? 
````

Check latest version with optional update/install
```bash
make
```
Also (alias)
```bash
make check
```
Fetch latest and update or install (do not bother checking or whitelisting -- no interaction)

```bash
make fetch
```
Also (alias)
```bash
make update
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
make remove
```
Whitelist only
```bash
make whitelist
```



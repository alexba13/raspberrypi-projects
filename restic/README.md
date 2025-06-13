# Restic

Restic will be used for creating the Nextcloud backup. To get this running, Restic needs to be installed first.

```
# Switch to sudo
sudo su -

# Get latest Linux ARM64 release from GitHub (https://github.com/restic/restic/releases)
wget https://github.com/restic/restic/releases/download/v0.18.0/restic_0.18.0_linux_arm64.bz2

# Unpack the file 
bzip2 -d restic_0.18.0_linux_arm64.bz2

# Rename the file and change permissions
mv restic_0.18.0_linux_arm64 restic && chmod a+x restic

# Move the file
mv restic /usr/local/bin/
```

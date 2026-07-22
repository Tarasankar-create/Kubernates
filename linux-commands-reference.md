# Linux Commands Reference

A practical reference of commonly used Linux commands, organized by category, with examples.

## 1. File & Directory Navigation

```bash
pwd                     # print current directory
ls -la                  # list all files, long format, including hidden
cd /var/log             # change directory
cd ..                   # go up one level
cd ~                    # go to home directory
tree -L 2               # show directory structure, 2 levels deep
find / -name "*.log"    # find files by name
find . -type f -mtime -7 # files modified in last 7 days
locate nginx.conf       # fast file search (uses indexed db)
```

## 2. File Operations

```bash
touch file.txt                  # create empty file
mkdir -p project/src/utils      # create nested directories
cp file.txt backup.txt          # copy file
cp -r dir1/ dir2/               # copy directory recursively
mv old.txt new.txt              # rename/move file
rm file.txt                     # delete file
rm -rf old_dir/                 # force delete directory recursively
ln -s /path/target link_name    # create symbolic link
```

## 3. Viewing & Editing Files

```bash
cat file.txt                    # print whole file
less file.txt                   # view file page by page
head -n 20 file.txt              # first 20 lines
tail -n 20 file.txt              # last 20 lines
tail -f /var/log/syslog          # follow log file live
nano file.txt                    # simple terminal editor
vim file.txt                     # vim editor
```

## 4. Permissions & Ownership

```bash
chmod 755 script.sh              # rwxr-xr-x
chmod +x deploy.sh               # make executable
chown user:group file.txt        # change owner and group
chown -R user:group /app         # recursive
umask 022                        # set default permission mask
```

## 5. Text Processing

```bash
grep "ERROR" app.log              # search for a pattern
grep -r "TODO" ./src              # recursive search
grep -i "warning" app.log         # case-insensitive
sed 's/foo/bar/g' file.txt        # replace foo with bar
awk '{print $1, $3}' file.txt     # print columns 1 and 3
sort file.txt                     # sort lines
sort -u file.txt                  # sort and remove duplicates
uniq -c sorted.txt                # count occurrences
wc -l file.txt                    # count lines
cut -d',' -f2 data.csv            # extract 2nd CSV column
diff file1.txt file2.txt          # compare files
```

## 6. Process Management

```bash
ps aux                    # list all running processes
ps aux | grep nginx       # find a specific process
top                       # live process/resource monitor
htop                      # nicer live monitor (if installed)
kill 1234                 # terminate process by PID
kill -9 1234              # force kill
killall node               # kill all processes by name
nohup ./script.sh &        # run in background, ignore hangups
jobs                       # list background jobs
fg %1                       # bring job 1 to foreground
```

## 7. Disk & Storage

```bash
df -h                      # disk space usage, human-readable
du -sh /var/log             # size of a directory
du -sh * | sort -rh         # sizes of items in current dir, sorted
mount /dev/sdb1 /mnt/data   # mount a device
umount /mnt/data            # unmount
lsblk                       # list block devices
fdisk -l                    # list disk partitions
```

## 8. Networking

```bash
ip addr show                 # show network interfaces/IPs
ping -c 4 google.com          # test connectivity
curl -I https://example.com   # fetch HTTP headers
curl -o file.zip <url>        # download a file
wget <url>                    # download a file
netstat -tulnp                # list listening ports (or ss below)
ss -tulnp                     # modern replacement for netstat
scp file.txt user@host:/path  # secure copy over SSH
ssh user@host                 # remote login
dig example.com                # DNS lookup
nslookup example.com           # DNS lookup (alt)
traceroute example.com         # trace network path
```

## 9. Package Management

```bash
# Debian/Ubuntu
sudo apt update                 # refresh package index
sudo apt install nginx          # install package
sudo apt remove nginx           # remove package
sudo apt upgrade                # upgrade all packages

# RHEL/CentOS
sudo yum install nginx
sudo dnf install nginx

# Snap
sudo snap install code
```

## 10. User & Group Management

```bash
sudo useradd -m devops          # create user with home dir
sudo passwd devops              # set password
sudo usermod -aG docker devops  # add user to group
sudo userdel -r devops          # delete user and home dir
groups devops                   # show user's groups
whoami                          # current user
id                              # current user's UID/GID/groups
```

## 11. Compression & Archives

```bash
tar -czvf archive.tar.gz dir/     # create gzipped tarball
tar -xzvf archive.tar.gz          # extract gzipped tarball
zip -r archive.zip dir/           # create zip
unzip archive.zip                 # extract zip
gzip file.txt                     # compress single file
gunzip file.txt.gz                # decompress
```

## 12. System Info & Monitoring

```bash
uname -a                # kernel/system info
uptime                   # how long system has been running
free -h                  # memory usage
lscpu                    # CPU info
whoami                   # current user
hostname                 # system hostname
history                  # command history
env                      # environment variables
which docker             # path of an executable
systemctl status nginx   # service status
journalctl -u nginx -f   # follow logs for a systemd service
```

## 13. Environment & Shell

```bash
export PATH=$PATH:/opt/bin        # add to PATH
echo $HOME                        # print variable
alias ll='ls -la'                 # create shortcut
source ~/.bashrc                  # reload shell config
chmod +x script.sh && ./script.sh # run a script
```

## 14. DevOps-Relevant Extras

```bash
# Docker
docker ps                         # running containers
docker build -t myapp:latest .    # build image
docker run -d -p 8080:80 myapp    # run container
docker logs -f <container>        # follow container logs
docker exec -it <container> bash  # shell into container

# Kubernetes
kubectl get pods                  # list pods
kubectl describe pod <name>       # pod details
kubectl logs -f <pod>             # follow pod logs
kubectl apply -f deployment.yaml  # apply manifest

# Git
git status
git log --oneline -10
git diff
```

---
**Tip:** `man <command>` or `<command> --help` gives full docs for anything above (e.g. `man tar`).

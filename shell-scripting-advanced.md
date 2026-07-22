# Shell Scripting — Advanced Topics

## 1. String Manipulation

```bash
str="Hello World"

echo "${#str}"            # length -> 11
echo "${str:0:5}"          # substring -> Hello
echo "${str:6}"            # from index 6 -> World
echo "${str^^}"            # uppercase -> HELLO WORLD
echo "${str,,}"            # lowercase -> hello world
echo "${str/World/Bash}"   # replace first match -> Hello Bash
echo "${str//o/0}"         # replace all matches -> Hell0 W0rld

filename="app.tar.gz"
echo "${filename%.gz}"     # remove shortest suffix match -> app.tar
echo "${filename%%.*}"     # remove longest suffix match -> app
echo "${filename#*.}"      # remove shortest prefix match -> tar.gz
```

## 2. Here-Documents

```bash
cat << EOF > config.yaml
name: myapp
env: production
port: 8080
EOF

# suppress variable expansion with quotes around delimiter
cat << 'EOF'
$HOME will print literally, not expand
EOF
```

## 3. Redirection & File Descriptors

```bash
command > out.txt          # stdout to file (overwrite)
command >> out.txt         # stdout to file (append)
command 2> err.txt         # stderr to file
command > out.txt 2>&1     # both stdout and stderr to same file
command &> out.txt         # shorthand for the above (bash)
command 2>/dev/null        # discard errors

exec 3> logfile.txt        # open custom file descriptor
echo "log line" >&3        # write to it
exec 3>&-                  # close it
```

## 4. Signal Trapping

```bash
cleanup() {
    echo "Cleaning up temp files..."
    rm -f /tmp/myscript.lock
}
trap cleanup EXIT              # run on any exit
trap 'echo "Interrupted"; exit 1' SIGINT   # handle Ctrl+C

# example: lock file pattern
touch /tmp/myscript.lock
# ... do work ...
# lock removed automatically on exit via trap
```

## 5. Subshells & Process Substitution

```bash
(cd /tmp && ls)         # runs in a subshell — doesn't change your actual cwd
{ cd /tmp && ls; }      # runs in current shell — cwd DOES change

# process substitution — treat command output as a file
diff <(ls dir1) <(ls dir2)
while read -r line; do echo "Line: $line"; done < <(grep ERROR app.log)
```

## 6. Arithmetic

```bash
a=5; b=3
echo $((a + b))         # 8
echo $((a * b))         # 15
echo $((a / b))         # 1 (integer division)
((a++))                 # increment
let "c = a + b"         # alt syntax

# floating point (bash can't do this natively)
echo "5 / 3" | bc -l
awk "BEGIN {print 5/3}"
```

## 7. Associative Arrays (bash 4+)

```bash
declare -A ports
ports[web]=80
ports[api]=8080
ports[db]=5432

echo "${ports[web]}"        # 80
for service in "${!ports[@]}"; do
    echo "$service -> ${ports[$service]}"
done
```

## 8. Getopts — Proper Flag Parsing

```bash
#!/bin/bash
verbose=false
env="dev"

while getopts "ve:" opt; do
    case $opt in
        v) verbose=true ;;
        e) env="$OPTARG" ;;
        *) echo "Usage: $0 [-v] [-e env]"; exit 1 ;;
    esac
done

echo "Verbose: $verbose, Env: $env"
# run as: ./script.sh -v -e production
```

## 9. Sourcing Other Scripts

```bash
# lib.sh
log() { echo "[$(date +%T)] $1"; }

# main.sh
source lib.sh      # or: . lib.sh
log "Starting deployment"
```

## 10. Cron & Scheduling

```bash
crontab -e                       # edit current user's cron jobs

# format: minute hour day month weekday command
0 2 * * * /opt/scripts/backup.sh          # every day at 2 AM
*/15 * * * * /opt/scripts/healthcheck.sh  # every 15 minutes
0 0 * * 0 /opt/scripts/weekly_cleanup.sh  # every Sunday at midnight
```

## 11. Bash vs POSIX `sh` Portability

```bash
#!/bin/sh
# POSIX sh doesn't support: arrays, [[ ]], ${var^^}, ((...)) in some shells,
# function keyword, local in some shells (dash notably)

# Portable conditional
if [ "$var" = "value" ]; then echo "match"; fi   # use = not ==, use [ ] not [[ ]]

# Check which shell is running
echo $0
readlink -f /bin/sh   # on Debian/Ubuntu this is often dash, not bash
```

---
**Rule of thumb:** if your script only needs to run on systems you control (e.g. your own servers with bash installed), use bash features freely. If it needs to run in minimal containers or on `/bin/sh`, stick to POSIX-safe syntax.

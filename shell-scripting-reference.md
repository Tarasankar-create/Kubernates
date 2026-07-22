# Shell Scripting Reference (Bash)

## 1. Basics

```bash
#!/bin/bash
# ^ shebang - tells the OS which interpreter to use

echo "Hello, World!"
```

```bash
chmod +x script.sh   # make executable
./script.sh          # run it
bash script.sh       # or run directly with bash
```

## 2. Variables

```bash
name="Tarasankar"
echo "Hello, $name"
echo "Hello, ${name}!"     # braces avoid ambiguity

readonly PI=3.14           # constant
unset name                 # delete a variable

# Command substitution
current_date=$(date +%F)
files=$(ls /var/log)
```

## 3. User Input & Arguments

```bash
# script arguments
echo "Script name: $0"
echo "First arg: $1"
echo "All args: $@"
echo "Arg count: $#"

# reading input
read -p "Enter your name: " username
echo "Hi, $username"
```

## 4. Conditionals

```bash
if [ "$1" == "start" ]; then
    echo "Starting service..."
elif [ "$1" == "stop" ]; then
    echo "Stopping service..."
else
    echo "Usage: $0 {start|stop}"
fi
```

Common test operators:
```bash
[ -f file.txt ]     # file exists
[ -d dir ]          # directory exists
[ -z "$var" ]       # string is empty
[ -n "$var" ]       # string is not empty
[ "$a" == "$b" ]    # string equal
[ "$a" -eq "$b" ]   # numeric equal
[ "$a" -gt "$b" ]   # numeric greater than
```

## 5. Loops

```bash
# for loop
for i in 1 2 3 4 5; do
    echo "Number: $i"
done

# range
for i in {1..5}; do echo $i; done

# looping over files
for file in /var/log/*.log; do
    echo "Processing $file"
done

# while loop
count=0
while [ $count -lt 5 ]; do
    echo "Count: $count"
    ((count++))
done

# until loop
until [ -f /tmp/ready ]; do
    echo "Waiting..."
    sleep 2
done
```

## 6. Functions

```bash
greet() {
    local name=$1
    echo "Hello, $name!"
}

greet "DevOps"

# function with return value
add() {
    echo $(( $1 + $2 ))
}
result=$(add 3 4)
echo "Sum: $result"
```

## 7. Arrays

```bash
servers=("web1" "web2" "db1")
echo "${servers[0]}"          # first element
echo "${servers[@]}"          # all elements
echo "${#servers[@]}"         # array length

for server in "${servers[@]}"; do
    echo "Pinging $server"
done
```

## 8. Case Statements

```bash
case "$1" in
    start)
        echo "Starting..."
        ;;
    stop)
        echo "Stopping..."
        ;;
    restart)
        echo "Restarting..."
        ;;
    *)
        echo "Usage: $0 {start|stop|restart}"
        ;;
esac
```

## 9. Exit Codes & Error Handling

```bash
set -e            # exit immediately if a command fails
set -u            # error on undefined variables
set -o pipefail   # fail if any command in a pipeline fails

command_that_might_fail
if [ $? -ne 0 ]; then
    echo "Command failed" >&2
    exit 1
fi
```

## 10. Practical DevOps Examples

**Backup script:**
```bash
#!/bin/bash
set -e
SRC="/var/www/myapp"
DEST="/backups/myapp_$(date +%F_%H%M%S).tar.gz"

tar -czf "$DEST" "$SRC"
echo "Backup created: $DEST"
```

**Health check loop:**
```bash
#!/bin/bash
URL="https://example.com/health"

while true; do
    status=$(curl -s -o /dev/null -w "%{http_code}" "$URL")
    if [ "$status" -ne 200 ]; then
        echo "ALERT: $URL returned $status"
    fi
    sleep 30
done
```

**Log cleanup script:**
```bash
#!/bin/bash
LOG_DIR="/var/log/myapp"
DAYS=7

find "$LOG_DIR" -name "*.log" -mtime +$DAYS -exec rm {} \;
echo "Removed logs older than $DAYS days"
```

**Deploy script skeleton:**
```bash
#!/bin/bash
set -euo pipefail

APP_DIR="/opt/myapp"
BRANCH="main"

echo "Pulling latest code..."
cd "$APP_DIR"
git pull origin "$BRANCH"

echo "Installing dependencies..."
pip install -r requirements.txt --break-system-packages

echo "Restarting service..."
sudo systemctl restart myapp

echo "Deployment complete."
```

## 11. Debugging

```bash
bash -x script.sh     # trace execution
set -x                # turn on tracing mid-script
set +x                # turn off tracing
```

---
**Tip:** Use [shellcheck](https://www.shellcheck.net/) to lint scripts and catch common bugs before running them.

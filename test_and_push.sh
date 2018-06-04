#!/bin/bash

# Safety measures
set -o errexit   # Leave immediately if a command returns an error
set -o nounset   # Leave immediately if an unitialized value is used
set -euo pipefail  # Leave immediately if a command fails in a pipe

# simple bash script: write a shell script that runs a test suite (npm test / mvn test / sbt test), if tests are OK, then do git push:
# Requirements:
# - set a bash as shebang
# - use a file, ie not only a command
# - use error codes, not the results of the tests
# - use a if then, ie, no one-liner

function exec_test_cmd() {
    CMD=$1
    $CMD test
}

COMMIT_MESSAGE=$2

exec_test_cmd $1

if test $? -eq 0; then
    echo "$CMD succeeded"
    git commit -m "$COMMIT_MESSAGE" && git push
else 
    echo "$CMD failed"
fi
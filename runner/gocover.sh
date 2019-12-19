#!/bin/ash
PROJECT=$1
OPTS=$2

echo "<!-- STEP: go get -->"

go get -d -t $PROJECT

if [ $? -gt 0 ]; then
    echo "Cannot get '$1'" >&2
    exit 1
fi

cd $PROJECT

echo "<!-- STEP: go test -->"

OUTPUT=`go test -covermode=count -coverprofile=c.out $OPTS 2>&1`

if [ $? -gt 0 ]; then
    echo "$OUTPUT"
    exit 2
fi

if [ ! -f c.out ]; then
    echo "No test files for '$1'" >&2
    exit 3
fi

COVERAGE=`echo $num | grep -o -E "[0-9.]+\%" | sed 's/%//'`

echo "<!-- STEP: go cover -->"

go tool cover -html=c.out -o=/dev/stdout

if [ $? -gt 0 ]; then
    echo "Cannot get coverage of '$1'" >&2
    exit 4
fi

echo "<!-- STEP: done -->"

echo "<!-- cov:$COVERAGE -->"

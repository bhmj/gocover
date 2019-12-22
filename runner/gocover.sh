#!/bin/ash
PROJECT=$1
OPTS=$2
BRANCH=$3
COMMIT=$4

echo "<!-- STEP: git clone -->"

# go get -d -t $PROJECT

if [ -z "$BRANCH" ]; then
    BRN="HEAD"
else
    BRN="refs/heads/$BRANCH"
fi
if [ -z "$COMMIT" ]; then
    COMMIT=`git ls-remote git://github.com/bhmj/jsonslice.git | grep $BRN | cut -f 1`
fi

mkdir -p $PROJECT
cd $PROJECT

if [ -z $BRANCH ]; then
    git clone --depth 5 git://${PROJECT}.git .
else
    git clone --depth 5 --branch $BRANCH git://${PROJECT}.git .
fi

if [ $? -gt 0 ]; then
    echo "Cannot clone '$1'" >&2
    exit 1
fi

git checkout -q $COMMIT

git status

if [ $? -gt 0 ]; then
    echo "Cannot checkout commit '$COMMIT'" >&2
    exit 1
fi

go get -t ./...

if [ $? -gt 0 ]; then
    echo "Cannot resolve dependencies" >&2
    exit 1
fi

echo "<!-- STEP: go test -->"

OUTPUT=`go test -covermode=count -coverprofile=c.out $OPTS 2>&1 | tee /dev/tty`

if [ $? -gt 0 ]; then
    echo "$OUTPUT"
    exit 2
fi

if [ ! -f c.out ]; then
    echo "No test files for '$1'" >&2
    exit 3
fi

COVERAGE=`echo $OUTPUT | grep -o -E "[0-9.]+\%" | sed 's/%//'`

echo "<!-- STEP: go cover -->"

go tool cover -html=c.out -o=/dev/stdout

if [ $? -gt 0 ]; then
    echo "Cannot get coverage of '$1'" >&2
    exit 4
fi

echo "<!-- STEP: done -->"

echo "<!-- cov:$COVERAGE -->"

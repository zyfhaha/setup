#!/bin/bash
# install boost
set -e

ROOTDIR=${ZZROOT:-$HOME/app}
NAME="boost"
TYPE=".tar.gz"
VERSION="1.76.0"
FILE="$NAME-$VERSION$TYPE"
DOWNLOADURL="https://boostorg.jfrog.io/artifactory/main/release/1.76.0/source/boost_1_76_0.tar.gz"
echo $NAME will be installed in "$ROOTDIR"

mkdir -p "$ROOTDIR/downloads"
cd "$ROOTDIR"

if [ -f "downloads/$FILE" ]; then
    echo "downloads/$FILE exist"
else
    echo "$FILE does not exist, downloading from $DOWNLOADURL"
    wget $DOWNLOADURL -O $FILE
    mv $FILE downloads/
fi

mkdir -p src/$NAME
tar xf downloads/$FILE -C src/$NAME --strip-components 1

# export CC=/mnt/lustre/lizz/app/bin/gcc
# export CXX=/mnt/lustre/lizz/app/bin/g++
# export CPLUS_INCLUDE_PATH="$CPLUS_INCLUDE_PATH:/mnt/lustre/lizz/anaconda3/include/python3.7m/"

cd src/$NAME
./bootstrap.sh --prefix="$ROOTDIR"
./b2 install

echo $NAME installed on "$ROOTDIR"
echo add following line to .zshrc
echo export BOOST_ROOT="$ROOTDIR"

#!/bin/bash

VERSION="2.5.2"
PACK="x86_64-unknown-linux-gnu-static-gmp"
ARCHIVE_NAME="yices-${VERSION}-${PACK}.tar.gz"

NATIVE_LINK="http://yices.csl.sri.com/cgi-bin/yices2-newnewdownload.cgi?file=${ARCHIVE_NAME}&accept=I+Agree"
PYTHON=`which python`
INCLUDE_DIR=yices-${VERSION}/include


echo "Downloading Yices..."
if [ ! -f ${ARCHIVE_NAME} ]; then
    curl ${NATIVE_LINK} -o ${ARCHIVE_NAME}
fi

echo "Building..."
tar xf ${ARCHIVE_NAME}
cd yices-${VERSION}
bash ./install-yices here
cd ..

# SWIG
$PYTHON ./setup.py -- egg_info --tag-date --tag-build=.dev bdist_wheel

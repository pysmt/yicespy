#!/bin/bash

VERSION="2.4.1"
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
# swig -I${include_dir} -I/usr/include/ -python -o yices_python_wrap.c yices_python.i
# ${python} ./setup.py build
# cp build/lib.linux*/_yices.so .
# cp build/lib.linux*/yices.py .

# echo "LD_LIBRAY_PATH=`pwd`/yices-${version}/lib/"
# "lib/python{$python_version}/site-packages/yicespy"
# PKG (This is done by travis-CI. It is left here for reference)
$PYTHON ./setup.py -- egg_info --tag-date --tag-build=.dev bdist_wheel
# mv yices.py yices3.py

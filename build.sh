#!/bin/bash

version="2.4.1"
pack="x86_64-unknown-linux-gnu-static-gmp"
archive_name="yices-${version}-${pack}.tar.gz"

native_link="http://yices.csl.sri.com/cgi-bin/yices2-newnewdownload.cgi?file=${archive_name}&accept=I+Agree"
python=`which python`
include_dir=yices-${version}/include


# echo "Download..."
# curl ${native_link} -o ${archive_name}

echo "Build"
tar xf ${archive_name}
cd yices-${version}
bash ./install-yices here
cd ..

# SWIG
swig -I${include_dir} -I/usr/include/ -python -o yices_python_wrap.c yices_python.i
${python} ./setup.py build
cp build/lib.linux*/_yices.so .
cp build/lib.linux*/yices.py .

echo "LD_LIBRAY_PATH=`pwd`/yices-${version}/lib/"
# "lib/python{$python_version}/site-packages/pyices"
# PKG (This is done by travis-CI. It is left here for reference)
# $PYTHON ./setup.py egg_info --tag-date --tag-build=.dev bdist_wheel

mv yices.py yices3.py

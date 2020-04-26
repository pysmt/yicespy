# yicespy

A **yicespy** is a Python wrapper for the Yices SMT solver (http://yices.csl.sri.com/). The wrapper is compatible with both Python 2 and 3, and is generated using SWIG.

We support the latest (as of April 2020) version of Yices: 2.6.2.

yicespy is a low-level wrapper providing all methods needed by pySMT (http://pysmt.org) to work, for this reason there are some functionality that might not have been wrapped. If you are interested, feel free to open a Pull Request.
yicespy is a low-level wrapper, and we recommend using it through its integration in pySMT. You might also be interested in the [official python interface](https://github.com/SRI-CSL/yices2/tree/master/src/bindings/python) recently released by the Yices Team.


# Installation

Assuming that the installation of Yices is in the same directory as setup.py, it is sufficient to do
```
 $ python ./setup.py build
```

The path to the Yices installation can be provided with the option ```--yices-dir```:
```
$ python ./setup.py --yices-dir /opt/yices build
```

Two scripts are provided:

* setup.py: Creates the python wrapper, assuming that yices is installed in the system.
* build.sh: Downloads yices and calls setup.py accordingly.

**Note** we are not distributing Yices, you need to check the website and make sure that you agree with the licensing terms.

# License

The wrapper is released open-source under APACHE 2.0 License.

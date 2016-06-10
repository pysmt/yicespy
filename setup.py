import os
from setuptools import setup
from distutils.extension import Extension
from datetime import datetime

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
YICES_VERSION="2.4.1"
YICES_DIR= os.path.join(BASE_DIR, "yices-%s" % YICES_VERSION)

PYICES_MINOR_VERSION='%s' % datetime.utcnow().strftime("%y%m%d")
# Major number is Yices Version, minor number creation date of the bindings
PYICES_VERSION='%s.%s' % (YICES_VERSION, PYICES_MINOR_VERSION)

yices_ext = Extension('_yices', #['yices_python_wrap.c'],
                      ['yices_python.i'],
                      swig_opts=['-I%s'%os.path.join(YICES_DIR, "include")],
                      include_dirs=[os.path.join(YICES_DIR, "include")],
                      library_dirs=[os.path.join(YICES_DIR, "lib")],
                      runtime_library_dirs=[os.path.join(YICES_DIR, "lib")],
                      libraries=['yices'],
                      language='c',
                    )

short_description="Yices SMT-Solver Wrapper"
long_description=\
"""
==========================
Yices SMT-Solver Wrapper
==========================

Provides a basic wrapping around the Yices 2 SMT Solver.

Yices is developed by SRI, for more information: http://XXXXX.
"""

setup(name='pyices',
      version=PYICES_VERSION,
      author='PySMT Team',
      author_email='info@pysmt.org',
      url='https://github.com/pysmt/pyices3/',
      license='BSD',
      description=short_description,
      long_description=long_description,
      ext_modules=[yices_ext],
      py_modules=['yices'],
      classifiers = [
        "Programming Language :: Python",
        "Programming Language :: Python :: 3",
        "Development Status :: 4 - Beta",
        "Intended Audience :: Developers",
        "Topic :: Software Development :: Libraries :: Python Modules",
      ],
)

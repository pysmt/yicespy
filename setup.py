import os, sys
import optparse

from setuptools import setup
from distutils.extension import Extension
from datetime import datetime


p = optparse.OptionParser('%prog [options] [-- [setup_options]]')
p.add_option('--yices-dir', help='directory of the yices SMT solver', default=None)

try:
    idx = sys.argv.index('--')
    optargs = sys.argv[1:idx]
    argv = sys.argv[idx+1:]
except ValueError:
    optargs, argv = sys.argv[1:], []

sys.argv = [sys.argv[0]] + argv

opts, args = p.parse_args(optargs)

if args:
    sys.argv = [sys.argv[0]] + args + sys.argv[1:]

YICES_DIR = None
YICES_VERSION = "2.5.1"

if opts.yices_dir is not None:
    YICES_DIR = opts.yices_dir
else:
    BASE_DIR = os.path.dirname(os.path.abspath(__file__))
    YICES_DIR = os.path.join(BASE_DIR, "yices-%s" % YICES_VERSION)


YICESPY_MINOR_VERSION='%s' % datetime.utcnow().strftime("%y%m%d")
# Major number is Yices Version, minor number creation date of the bindings
YICESPY_VERSION='%s.%s' % (YICES_VERSION, YICESPY_MINOR_VERSION)

extra_include = []
if 'C_INCLUDE_PATH' in os.environ:
    extra_include.append(os.environ['C_INCLUDE_PATH'])

yices_ext = Extension('_yicespy',
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

Yices is developed by SRI, for more information: http://yices.csl.sri.com/.
"""

setup(name='yicespy',
      version=YICESPY_VERSION,
      author='PySMT Team',
      author_email='info@pysmt.org',
      url='https://github.com/pysmt/yicespy/',
      license='BSD',
      description=short_description,
      long_description=long_description,
      ext_modules=[yices_ext],
      py_modules=['yicespy'],
      classifiers = [
        "Programming Language :: Python",
        "Programming Language :: Python :: 3",
        "Development Status :: 4 - Beta",
        "Intended Audience :: Developers",
        "Topic :: Software Development :: Libraries :: Python Modules",
      ],
)

/* -*- swig -*- */
/* SWIG interface file to create the Python API for Yices */
/* author: Marco Gario <marco.gario@gmail.com> */

%include "typemaps.i"

/***************************************************************************/

/* EXTRA_SWIG_CODE_TAG */
%typemap(out) int32_t {
    $result = PyInt_FromLong($1);
}

%typemap(out) int64_t {
    $result = PyInt_FromLong($1);
}

%typemap(in) uint32_t {
    $1 = PyInt_AsLong($input);
    assert($1 >= 0);
}

%typemap(in) uint64_t {
    $1 = PyInt_AsLong($input);
    assert($1 >= 0);
}


%typemap(in) term_t [] {
  size_t i;
  term_t *tmp;
  if (!PySequence_Check($input)) {
    PyErr_SetString(PyExc_ValueError,"Expected a sequence");
    return NULL;
  }
  size_t len = PySequence_Length($input);
  tmp = (term_t *) malloc(len*sizeof(term_t));
  for (i = 0; i < len; i++) {
      int r;
      PyObject *o = PySequence_ITEM($input,i);
      r = PyInt_Check(o);
      if (!SWIG_IsOK(r)) {
          free(tmp);
          Py_DECREF(o);
          PyErr_SetString(PyExc_TypeError, "Invalid for argument: expected term_t");
          return NULL;
      } else {
          tmp[i] = PyInt_AsLong(o);
          Py_DECREF(o);
      }
  }
  $1 = tmp;
}

%typemap(freearg) term_t * {
    assert(NULL != $1);
    if ($1) free($1);
}

%typemap(in) type_t [] {
  size_t i;
  type_t *tmp;
  if (!PySequence_Check($input)) {
    PyErr_SetString(PyExc_ValueError,"Expected a sequence");
    return NULL;
  }
  size_t len = PySequence_Length($input);
  tmp = (type_t *) malloc(len*sizeof(type_t));
  for (i = 0; i < len; i++) {
      int r;
      PyObject *o = PySequence_ITEM($input,i);
      r = PyInt_Check(o);
      if (! r) {
          free(tmp);
          Py_DECREF(o);
          PyErr_SetString(PyExc_TypeError, "Invalid for argument: expected type_t");
          return NULL;
      } else {
          tmp[i] = PyInt_AsLong(o);
          Py_DECREF(o);
      }
  }
  $1 = tmp;
}

%typemap(freearg) type_t * {
    assert(NULL != $1);
    if ($1) free($1);
}


%typemap(out) smt_status_t {
    $result = PyInt_FromLong($1);
}

%typemap(in) int32_t keep_subst {
    if ($input)
        $1 = 1;
    else
        $1 = 0;
}

%typemap(varin) const char * {
   SWIG_Error(SWIG_AttributeError,"Variable $symname is read-only.");
   SWIG_fail;
}

%apply int32_t *OUTPUT {int32_t * val};
%apply int64_t *OUTPUT {int64_t * val};

int32_t yices_get_rational32_value(model_t *mdl, term_t t, int32_t *OUTPUT, uint32_t *OUTPUT);
int32_t yices_get_rational64_value(model_t *mdl, term_t t, int64_t *OUTPUT, uint64_t *OUTPUT);


%typemap(in, numinputs=0) yval_t *val (yval_t temp) {
   $1 = &temp;
}
%typemap(argout) yval_t *val {
  PyObject *r;
  r = SWIG_NewPointerObj((yval_t *)memcpy((yval_t *)malloc(sizeof(yval_t)),
                                          &($1), sizeof(yval_t)),
                         SWIGTYPE_p_yval_s,
                         SWIG_POINTER_OWN);
  $result = SWIG_AppendOutput($result, r);
}

%rename(_yices_get_bv_value) yices_get_bv_value;

%typemap(in) (uint32_t width, int32_t val[]) {
   $1 = PyInt_AsLong($input);
   $2 = (int32_t*) malloc($1 * sizeof(int32_t));
}
%typemap(argout) (uint32_t width, int32_t val[]) {
  PyObject *lst;
  size_t i;
  lst = PyList_New($1);
  for (i=0; i<$1; i++) {
    PyObject* o;
    o = PyInt_FromLong($2[i]);
    PyList_SetItem(lst, i, o);
  }
  $result = SWIG_AppendOutput($result, lst);
}
%rename(yices_get_bv_value) yices_get_bv_value_width;

%module yicespy
%{
#include "yices_types.h"
#include "yices.h"
/* EXTRA_C_INCLUDE_TAG */
%}

%include "stdint.i"
%include "yices_types.h"
%include "yices.h"

/* EXTRA_SWIG_INCLUDE_TAG */

%{

/* EXTRA_C_STATIC_CODE_TAG */

%}


%inline %{

__YICES_DLLSPEC__ extern int32_t yices_get_bv_value_width(model_t *mdl,
                                                          term_t t,
                                                          uint32_t width,
                                                          int32_t val[])
{
  return yices_get_bv_value(mdl, t, val);
}

/* EXTRA_C_INLINE_CODE_TAG */

%}


%pythoncode %{

## EXTRA_PYTHON_CODE_TAG

%}

/* -*- swig -*- */
/* SWIG interface file to create the Python API for Yices */
/* author: Marco Gario <marco.gario@gmail.com> */

%include "typemaps.i"

/***************************************************************************/

/* EXTRA_SWIG_CODE_TAG */
%typemap(out) int32_t {
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
  void *ptr;
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
      r = SWIG_ConvertPtr(o, &ptr, SWIGTYPE_p_term_t, 0);
      Py_DECREF(o);
      if (!SWIG_IsOK(r)) {
          free(tmp);
          PyErr_SetString(PyExc_TypeError, "Invalid for argument: expected term_t");
          return NULL;
      } else {
          tmp[i] = *((term_t *)(o));
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
  void *ptr;
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
      r = SWIG_ConvertPtr(o, &ptr, SWIGTYPE_p_type_t, 0);
      Py_DECREF(o);
      if (!SWIG_IsOK(r)) {
          free(tmp);
          PyErr_SetString(PyExc_TypeError, "Invalid for argument: expected type_t");
          return NULL;
      } else {
          tmp[i] = *((type_t *)(o));
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


%typemap(out) int32_t yices_get_bool_value {
    $result = PyBool_FromLong($1);
}


%module yices
%{
#include "yices.h"
/* EXTRA_C_INCLUDE_TAG */
%}


%include "yices.h"
/* EXTRA_SWIG_INCLUDE_TAG */

%{

/* EXTRA_C_STATIC_CODE_TAG */

%}


%inline %{

/* EXTRA_C_INLINE_CODE_TAG */

%}


%pythoncode %{

## EXTRA_PYTHON_CODE_TAG

%}

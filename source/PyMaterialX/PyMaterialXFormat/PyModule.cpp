//
// TM & (c) 2017 Lucasfilm Entertainment Company Ltd. and Lucasfilm Ltd.
// All rights reserved.  See LICENSE.txt for license.
//

#include <PyMaterialX/PyMaterialX.h>

namespace py = pybind11;

void bindPyFile(py::module& mod);
void bindPyXmlIo(py::module& mod);

PYBIND11_MODULE(PyMaterialXFormat, mod)
{
    mod.doc() = "Module containing Python bindings for the MaterialXFormat library";

    py::module::import("MaterialX.PyMaterialXCore");

    bindPyFile(mod);
    bindPyXmlIo(mod);
}

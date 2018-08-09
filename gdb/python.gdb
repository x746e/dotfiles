# vim: ft=gdb

# TODO: py-nexti: move to next python opcode
# TODO: py-next: move to next python line
# TODO: py-step / py-stepi

# To print a str variable.
define ppstr
  printf "%s\n", ((PyStringObject*)$arg0)->ob_sval
end

# repr(python_var)
define ppr
  # TODO: Check if it's PyObject first, otherwise that would segfault.
  printf "%s\n", ((PyStringObject*)PyObject_Repr($arg0))->ob_sval
end

# Print dict.
# printf "%s\n", ((PyStringObject*)dict_repr((PyDictObject*)dict_var))->ob_sval

# Print dict's keys
# printf "%s\n", ((PyStringObject*)list_repr((PyListObject*)((PyListObject*)PyDict_Keys((PyDictObject*)dict_var))))->ob_sval

# Print list.
# printf "%s\n", ((PyStringObject*)list_repr((PyListObject*)list_var))->ob_sval

# Contents of a module (module dict)
# printf "%s\n", ((PyStringObject*)dict_repr((PyDictObject*)(((PyModuleObject*)module)->md_dict)))->ob_sval

# Variable names in a module (module dict's keys)
# printf "%s\n", ((PyStringObject*)list_repr((PyListObject*)((PyListObject*)PyDict_Keys((PyDictObject*)(((PyModuleObject*)module)->md_dict)))))->ob_sval



from sys import version_info
from sandbox import Sandbox, SandboxError, HAVE_CSANDBOX, HAVE_PYPY
from sandbox.test import (createSandbox, createSandboxConfig,
    SkipTest, TestException, skipIf)

# code constructor arguments
def get_code_args():
    def somme(a, b):
        return a+b
    fcode = somme.func_code
    if version_info >= (3, 0):
        return (
            fcode.co_argcount,
            fcode.co_kwonlyargcount,
            fcode.co_nlocals,
            fcode.co_stacksize,
            fcode.co_flags,
            fcode.co_code,
            fcode.co_consts,
            fcode.co_names,
            fcode.co_varnames,
            fcode.co_filename,
            fcode.co_name,
            fcode.co_firstlineno,
            fcode.co_lnotab,
        )
    else:
        return (
            fcode.co_argcount,
            fcode.co_nlocals,
            fcode.co_stacksize,
            fcode.co_flags,
            fcode.co_code,
            fcode.co_consts,
            fcode.co_names,
            fcode.co_varnames,
            fcode.co_filename,
            fcode.co_name,
            fcode.co_firstlineno,
            fcode.co_lnotab,
        )

def get_code_objects():
    try:
        yield compile("1", "<string>", "eval")
    except NameError:
        pass

    # Function code
    def func():
        pass
    try:
        yield func.__code__
    except (AttributeError, RuntimeError):
        pass

    # Generator code
    def generator():
        yield
    gen = generator()
    try:
        yield gen.gi_code
    except AttributeError:
        pass

    # Frame code
    import sys
    frame = sys._getframe(0)
    try:
        yield frame.f_code
    except AttributeError:
        pass

def create_code_objects(args):
    for code_obj in get_code_objects():
        code_type = type(code_obj)
        try:
            return code_type(*args)
        except SandboxError as err:
            assert str(err) == 'code() blocked by the sandbox'
    raise TestException("Unable to get code type")

def exec_bytecode(code_args):
    def func():
        pass
    function_type = type(func)
    fcode = create_code_objects(code_args)
    new_func = function_type(fcode, {}, "new_func")
    return new_func(1, 2)

def test_bytecode():
    if not HAVE_CSANDBOX:
        # restricted mode doesn't block creation of arbitrary code object
        raise SkipTest("require _sandbox")

    code_args = get_code_args()

    config = createSandboxConfig()
    config.allowModule('sys', '_getframe')
    try:
        Sandbox(config).call(exec_bytecode, code_args)
    except TestException as err:
        assert str(err) == "Unable to get code type"
    else:
        assert False

    assert exec_bytecode(code_args) == 3

def replace_func_code():
    def add(x, y):
        return x + y
    def substract(x, y):
        return x - y
    try:
        add.func_code = substract.func_code
    except (AttributeError, RuntimeError):
        add.__code__ = substract.__code__
    return add(52, 10)

# FIXME: reenable this test on PyPy
@skipIf(HAVE_PYPY, "test disabled on PyPy")
def test_func_code():
    sandbox = createSandbox()
    try:
        sandbox.call(replace_func_code)
    except AttributeError as err:
        assert str(err) == "'function' object has no attribute '__code__'"
    except RuntimeError as err:
        assert str(err) == "function attributes not accessible in restricted mode"
    else:
        assert False

    assert replace_func_code() == 42


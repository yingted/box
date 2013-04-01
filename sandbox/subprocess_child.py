from __future__ import with_statement
import sys
import os
import pickle
from sandbox import Sandbox

try:
    import resource
except ImportError:
    resource = None

PICKLE_PROTOCOL = pickle.HIGHEST_PROTOCOL

def set_process_limits(config):
    if resource is not None:
        # deny fork and thread
        resource.setrlimit(resource.RLIMIT_NPROC, (0, 0))

    if not config.has_feature("stdin"):
        stdin_fd = sys.__stdin__.fileno()
        devnull = os.open(os.devnull, os.O_RDONLY)
        os.dup2(devnull, stdin_fd)

    if not config.has_feature("stdout") \
    or not config.has_feature("stderr"):
        devnull = os.open(os.devnull, os.O_WRONLY)
        if not config.has_feature("stdout"):
            stdout_fd = sys.__stdout__.fileno()
            os.dup2(devnull, stdout_fd)
        if not config.has_feature("stderr"):
            stderr_fd = sys.__stderr__.fileno()
            os.dup2(devnull, stderr_fd)

    if config.max_memory:
        if not resource:
            raise NotImplementedError("SandboxConfig.max_memory is not implemented on your platform")
        resource.setrlimit(resource.RLIMIT_AS, (config.max_memory, -1))

def execute_child():
    input_filename = sys.argv[1]
    output_filename = sys.argv[2]
    output = open(output_filename, "wb")
    base_exception = BaseException
    try:
        with open(input_filename, 'rb') as input_file:
            input_data = pickle.load(input_file)
        code = input_data['code']
        config = input_data['config']
        locals = input_data['locals']
        globals = input_data['globals']
        set_process_limits(config)

        sandbox = Sandbox(config)
        result = sandbox._execute(code, globals, locals)

        output_data = {'result': result}
        if input_data['globals'] is not None:
            del globals['__builtins__']
            output_data['globals'] = globals
        if 'locals' in input_data:
            output_data['locals'] = locals
    except base_exception as err:
        output_data = {'error': err}
    pickle.dump(output_data, output, PICKLE_PROTOCOL)
    output.flush()
    output.close()

def call_child(wpipe, sandbox, func, args, kw):
    config = sandbox.config
    try:
        set_process_limits(config)
        result = sandbox._call(func, args, kw)
        data = {'result': result}
    except BaseException as err:
        data = {'error': err}
    output = os.fdopen(wpipe, 'wb')
    pickle.dump(data, output, PICKLE_PROTOCOL)
    output.flush()
    output.close()
    if config.has_feature("stdout"):
        sys.stdout.flush()
        sys.stdout.close()
    if config.has_feature("stderr"):
        sys.stderr.flush()
        sys.stderr.close()
    os._exit(0)

if __name__ == "__main__":
    execute_child()


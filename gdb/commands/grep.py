import shlex
import subprocess
import tempfile


class Grep(gdb.Command):
    """Execute GDB command and pass its output through `grep $first_arg`."""

    def __init__(self):
        super(Grep, self).__init__('grep', gdb.COMMAND_USER)

    def invoke(self, arg, from_tty):
        args = shlex.split(arg)
        output = gdb.execute(' '.join(args[1:]), to_string=True).encode('utf-8')
        with tempfile.NamedTemporaryFile() as output_file:
            output_file.write(output)
            output_file.flush()
            subprocess.call([b'grep', args[0], output_file.name])

Grep()

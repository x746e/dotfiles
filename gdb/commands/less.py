import subprocess
import tempfile


class Less(gdb.Command):
    """Execute GDB command and open its output in `less`."""

    def __init__(self):
        super(Less, self).__init__('less', gdb.COMMAND_USER)

    def invoke(self, arg, from_tty):
        output = gdb.execute(arg, to_string=True)
        with tempfile.NamedTemporaryFile() as output_file:
            output_file.write(output.encode('utf-8'))
            output_file.flush()
            subprocess.call('LESS= less %s' % output_file.name, shell=True)


Less()

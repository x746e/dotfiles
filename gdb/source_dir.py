import argparse
from pathlib import Path

import gdb


class SourceDir(gdb.Command):
    """Source all files from a directory named DIR.

    Usage: source-dir [-v] DIR
    -v: print the names of sourced files and source the files with `source -v`.
    """

    def __init__(self):
        super().__init__(name='source-dir', command_class=gdb.COMMAND_SUPPORT,
                         completer_class=gdb.COMPLETE_FILENAME)

    def invoke(self, arg_str: str, from_tty: bool) -> None:
        parser = argparse.ArgumentParser(exit_on_error=False)
        parser.add_argument('-v', dest='verbose', action='store_true')
        parser.add_argument('directory')
        try:
            args = parser.parse_args(gdb.string_to_argv(arg_str))
        except (argparse.ArgumentError, argparse.ArgumentTypeError) as e:
            raise gdb.GdbError(str(e))

        path = Path(args.directory).expanduser()
        if not path.is_dir():
            raise gdb.GdbError(f'{directory}: no such directory.')

        source_args = '-v' if args.verbose else ''
        for cmd_file in path.iterdir():
            if cmd_file.name.startswith('.'):
                continue
            if args.verbose:
                print(f'Sourcing {cmd_file}')
            gdb.execute(f'source {source_args} {cmd_file}', from_tty=from_tty)


SourceDir()

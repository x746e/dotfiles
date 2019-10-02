from __future__ import print_function
import fcntl
import os
import re
# import struct
import termios
import textwrap


# Copied from termcolor {{{
ATTRIBUTES = dict(
        list(zip([
            'bold',
            'dark',
            '',
            'underline',
            'blink',
            '',
            'reverse',
            'concealed'
            ],
            list(range(1, 9))
            ))
        )
del ATTRIBUTES['']


HIGHLIGHTS = dict(
        list(zip([
            'on_grey',
            'on_red',
            'on_green',
            'on_yellow',
            'on_blue',
            'on_magenta',
            'on_cyan',
            'on_white'
            ],
            list(range(40, 48))
            ))
        )


COLORS = dict(
        list(zip([
            'grey',
            'red',
            'green',
            'yellow',
            'blue',
            'magenta',
            'cyan',
            'white',
            ],
            list(range(30, 38))
            ))
        )


RESET = '\033[0m'


def colored(text, color=None, on_color=None, attrs=None):
    """Colorize text.

    Available text colors:
        red, green, yellow, blue, magenta, cyan, white.

    Available text highlights:
        on_red, on_green, on_yellow, on_blue, on_magenta, on_cyan, on_white.

    Available attributes:
        bold, dark, underline, blink, reverse, concealed.

    Example:
        colored('Hello, World!', 'red', 'on_grey', ['blue', 'blink'])
        colored('Hello, World!', 'green')
    """
    if os.getenv('ANSI_COLORS_DISABLED') is None:
        fmt_str = '\033[%dm%s'
        if color is not None:
            text = fmt_str % (COLORS[color], text)

        if on_color is not None:
            text = fmt_str % (HIGHLIGHTS[on_color], text)

        if attrs is not None:
            for attr in attrs:
                text = fmt_str % (ATTRIBUTES[attr], text)

        text += RESET
    return text
# }}}


def strip_ansi(s):
  return re.sub(r'\x1B\[[0-?]*[ -/]*[@-~]', '', s)


def real_len(s):
  return len(strip_ansi(s))


def get_term_width():
  raw = fcntl.ioctl(1, termios.TIOCGWINSZ, ' ' * 4)
  # `_struct` is not available everywhere.
  # height, width = struct.unpack('hh', raw)
  width = int(''.join(reversed(raw[2:])).encode('hex'), 16)
  return int(width)


class ColorfulBacktrace(gdb.Command):
  '''As `bt`, but with colors.'''

  FUNCTION_NAME_COLOR = 'green'
  ARG_COLOR = 'blue'

  def __init__(self):
    super(ColorfulBacktrace, self).__init__('ct', gdb.COMMAND_STACK)

  def invoke(self, arg, from_tty):
    frames = list(self.get_frames())
    if not frames:
      print('No stack.')
    idx_col_width = len('#') + len(str(len(frames) - 1)) + len('  ')
    for idx, frame in enumerate(frames):
      self.print_frame(frame, idx, idx_col_width=idx_col_width)

  def get_frames(self):
    frame = gdb.newest_frame()
    while frame:
      yield frame
      frame = frame.older()

  def print_frame(self, frame, frame_idx, idx_col_width):
    '''Prints `#N  foo::bar(arg=val, ...) at file:line` for the frame.'''
    idx_s = ('#%d' % frame_idx).ljust(idx_col_width, ' ')
    func_with_args = '%s(%s)' % (
      colored(frame.name(), self.FUNCTION_NAME_COLOR),
      self.format_args(frame),
    )
    source_location = 'at http://cs/%s:%s' % (
      frame.find_sal().symtab.filename,
      frame.find_sal().line,
    )
    line = func_with_args + ' ' + source_location

    # TODO: build with --stamp
    # + BuildData::Changelist()

    print(idx_s, end='')
    self.print_wrapped(line, second_line_indent=idx_col_width + 4)
    # print(' ' * idx_col_width + source_location)

  def print_wrapped(self, s, second_line_indent):
    '''Prints a string wrapping around terminal width.

    Splits the line on whitespace (with `str.split()`).
    `s` can contain ascii color codes.
    All lines except for the first should be indented by `second_line_indent`.
    '''
    nonlocals = {'first_line': True}

    def print_line(l):
      if nonlocals['first_line']:
        print(l)
        nonlocals['first_line'] = False
      else:
        print((' ' * second_line_indent) + l)

    width = get_term_width() - second_line_indent
    len_so_far = 0
    line = ''
    for part in s.split():
      maybe_new_line = line + ' ' + part if line else part
      if real_len(maybe_new_line) < width:
        line = maybe_new_line
        len_so_far = real_len(maybe_new_line)
      else:
        print_line(line)
        line = part
        len_so_far = real_len(line)
    else:
      print_line(line)

  def format_args(self, frame):
    return ', '.join(
      '%s=%s' % (colored(str(sym), self.ARG_COLOR), str(sym.value(frame)))
      for sym in frame.block()
      if sym.is_argument
    )

ColorfulBacktrace()

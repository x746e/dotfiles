class BreakReturn(gdb.Command):

    def __init__(self):
        super().__init__('break-return', gdb.COMMAND_BREAKPOINTS, gdb.COMPLETE_NONE)

    def invoke(self, arg, from_tty):
        set_break_on_return()

BreakReturn()


class TemporaryBreakReturn(gdb.Command):

    def __init__(self):
        super().__init__('tbreak-return', gdb.COMMAND_BREAKPOINTS, gdb.COMPLETE_NONE)

    def invoke(self, arg, from_tty):
        set_break_on_return(temporary=True)

TemporaryBreakReturn()


def set_break_on_return(temporary=False):
    frame = gdb.selected_frame()
    # TODO make this work if there is no debugging information, where .block() fails.
    block = frame.block()
    # Find the function block in case we are in an inner block.
    while block:
        if block.function:
            break
        block = block.superblock
    start = block.start
    end = block.end
    arch = frame.architecture()
    instructions = arch.disassemble(start, end - 1)
    return [
        gdb.Breakpoint('*{instruction["addr"]}', temporary=temporary)
        for instruction in instructions
        if instruction['asm'].startswith('retq ')
    ]


# break-return without arguments should break on all returns in the current function.
# break-return {func} should break on returns in {func}.

# 1. parse output of `disas /s` or `disas /s {func}` to get mapping of file:line -> list of instructions.
# 2. make a breakpoint fo each file:line which has retq in its instruction list.

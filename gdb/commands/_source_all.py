import os.path
import glob

cmd_dir = os.path.expanduser(os.path.dirname(__file__))
for cmd_file in glob.glob('%s/[a-zA-Z0-9]*.py' % cmd_dir):
  gdb.execute('source ' + cmd_file)

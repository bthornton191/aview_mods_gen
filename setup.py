import os
import sys
from pathlib import Path

CODE_DIR = Path(os.environ['CODE_DIR'])

# Add local libraries to path

def add_libs_to_path(libs, libs_dir: Path):

    for lib in libs:
        lib_dir = str(libs_dir / lib)
        if lib_dir not in sys.path:
            sys.path.insert(0, lib_dir)


if __name__ == '__main__':
    add_libs_to_path(['aviewpy',
                      'thornpy',
                      'adamspy',
                      'adams_shell_wear'],
                     libs_dir=CODE_DIR)
    
    from aviewpy.utils.excepthook import aview_excepthook                                           # isort: skip
    sys.excepthook = aview_excepthook
    
import os
import sys
from pathlib import Path

AVIEW_MOD_GEN = Path('C:/Program Files/MSC.Software/Adams/aview_mods_gen')
CODE_DIR = Path(os.environ['CODE_DIR'])
LOCAL_LIBS = ['aviewpy',
              'thornpy',
              'adamspy',
              'adams_shell_wear']

def add_libs_to_path(libs, libs_dir: Path):

    for lib in libs:
        lib_dir = str(libs_dir / lib)
        if lib_dir not in sys.path:
            sys.path.insert(0, lib_dir)

def check_cache():
    bin_file = Path(os.environ['TOPDIR']) / 'custom_binaries/aview.bin'
    bin_file.parent.mkdir(exist_ok=True)
    user_aview_bs = Path(os.environ.get('MSC_ADAMS_STARTIN_DIR', Path.home())) / 'aviewBS.cmd'

    use_cache = (bin_file.exists() 
                 and all(is_newer(file, bin_file) for file in AVIEW_MOD_GEN.iterdir() if file.is_file())
                 and (user_aview_bs.exists() is False or is_newer(bin_file, user_aview_bs)))
    
    return use_cache, bin_file.as_posix()

def is_newer(file_a: Path, file_b: Path):
    return file_b.stat().st_mtime > file_a.stat().st_mtime

if __name__ == '__main__':
    add_libs_to_path(LOCAL_LIBS,
                     libs_dir=CODE_DIR)
    
    from aviewpy.utils.excepthook import aview_excepthook                                           # isort: skip
    sys.excepthook = aview_excepthook
    
REG ADD HKEY_CLASSES_ROOT\Adams.msg /VE /T REG_SZ /D "Adams Message File" /F
REG ADD HKEY_CLASSES_ROOT\Adams.msg\DefaultIcon /VE /T REG_EXPAND_SZ /D "%%ADAMS_LAUNCH_COMMAND%%\..\icons\adams.ico" /F
REG ADD HKEY_CLASSES_ROOT\.msg /VE /T REG_SZ /D "Adams.msg" /F
REG ADD HKEY_CLASSES_ROOT\.msg\OpenWithProgids /V "Adams.msg" /T REG_NONE /F

REG ADD HKEY_CLASSES_ROOT\Adams.res /VE /T REG_SZ /D "Adams Results File" /F
REG ADD HKEY_CLASSES_ROOT\Adams.res\DefaultIcon /VE /T REG_EXPAND_SZ /D "%%ADAMS_LAUNCH_COMMAND%%\..\icons\adams.ico" /F
REG ADD HKEY_CLASSES_ROOT\.res /VE /T REG_SZ /D "Adams.res" /F
REG ADD HKEY_CLASSES_ROOT\.res\OpenWithProgids /V "Adams.res" /T REG_NONE /F

REG ADD HKEY_CLASSES_ROOT\Adams.req /VE /T REG_SZ /D "Adams Request File" /F
REG ADD HKEY_CLASSES_ROOT\Adams.req\DefaultIcon /VE /T REG_EXPAND_SZ /D "%%ADAMS_LAUNCH_COMMAND%%\..\icons\adams.ico" /F
REG ADD HKEY_CLASSES_ROOT\.req /VE /T REG_SZ /D "Adams.req" /F
REG ADD HKEY_CLASSES_ROOT\.req\OpenWithProgids /V "Adams.req" /T REG_NONE /F

REG ADD HKEY_CLASSES_ROOT\Adams.gra /VE /T REG_SZ /D "Adams Graphics File" /F
REG ADD HKEY_CLASSES_ROOT\Adams.gra\DefaultIcon /VE /T REG_EXPAND_SZ /D "%%ADAMS_LAUNCH_COMMAND%%\..\icons\adams.ico" /F
REG ADD HKEY_CLASSES_ROOT\.gra /VE /T REG_SZ /D "Adams.gra" /F
REG ADD HKEY_CLASSES_ROOT\.gra\OpenWithProgids /V "Adams.gra" /T REG_NONE /F

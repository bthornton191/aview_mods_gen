REG ADD HKEY_CLASSES_ROOT\directory\background\shell\adams_cmd /VE /T REG_SZ /D "Open Adams cmd" /F
REG ADD HKEY_CLASSES_ROOT\directory\background\shell\adams_cmd /V "Icon" /T REG_SZ /D "C:\Users\ben.thornton\Pictures\icons\cmd.ico" /F
REG ADD HKEY_CLASSES_ROOT\directory\background\shell\adams_cmd\command /VE /T REG_EXPAND_SZ /D ""%%ADAMS_LAUNCH_COMMAND%%\..\..\..\aview_mods_gen\open_adams_cmd_in_folder.bat" "%%1"" /F

REG ADD HKEY_CLASSES_ROOT\directory\background\shell\aview /VE /T REG_SZ /D "Open Adams View" /F
REG ADD HKEY_CLASSES_ROOT\directory\background\shell\aview /V "Icon" /T REG_EXPAND_SZ /D "%%ADAMS_LAUNCH_COMMAND%%\..\icons\adams.ico" /F
REG ADD HKEY_CLASSES_ROOT\directory\background\shell\aview\command /VE /T REG_EXPAND_SZ /D ""%%ADAMS_LAUNCH_COMMAND%%\..\..\..\aview_mods_gen\open_adams_view_in_folder.bat" "%%v"" /F

REG ADD HKEY_CLASSES_ROOT\directory\shell\adams_cmd /VE /T REG_SZ /D "Open Adams cmd" /F
REG ADD HKEY_CLASSES_ROOT\directory\shell\adams_cmd /V "Icon" /T REG_SZ /D "C:\Users\ben.thornton\Pictures\icons\cmd.ico" /F
REG ADD HKEY_CLASSES_ROOT\directory\shell\adams_cmd\command /VE /T REG_EXPAND_SZ /D ""%%ADAMS_LAUNCH_COMMAND%%\..\..\..\aview_mods_gen\open_adams_cmd_in_folder.bat" "%%1"" /F

REG ADD HKEY_CLASSES_ROOT\directory\shell\aview /VE /T REG_SZ /D "Open Adams View" /F
REG ADD HKEY_CLASSES_ROOT\directory\shell\aview /V "Icon" /T REG_EXPAND_SZ /D "%%ADAMS_LAUNCH_COMMAND%%\..\icons\adams.ico" /F
REG ADD HKEY_CLASSES_ROOT\directory\shell\aview\command /VE /T REG_EXPAND_SZ /D ""%%ADAMS_LAUNCH_COMMAND%%\..\..\..\aview_mods_gen\open_adams_view_in_folder.bat" "%%1"" /F

REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Classes\cmdfile\shell\adams /VE /T REG_SZ /D "Open with Adams" /F
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Classes\cmdfile\shell\adams /V "Icon" /T REG_EXPAND_SZ /D "%%ADAMS_LAUNCH_COMMAND%%\..\icons\adams.ico" /F
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Classes\cmdfile\shell\adams\command /VE /T REG_EXPAND_SZ /D ""%%ADAMS_LAUNCH_COMMAND%%\..\..\..\aview_mods_gen\open_with_adams_view.bat" "%%1"" /F
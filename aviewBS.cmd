! Aview startup commands

file log_file messages_include = on commands_include = on

! needed to be sure ADrill runs at optimum speed in batch mode
defaults solver compatibility_checking = off

colors modify color_name = Background red=(.43*.57) green=(.84*.57) blue=(.97*.57)
defaults icon_naming show_as = partial_name

! Load Custom Menu
interface menubar read menubar=.gui.main.mmenu_menu.mbar_refresh file="C:\Program Files\MSC.Software\Adams\aview_mods_gen\menu.mnu"

! Create Library
if condition=(eval(!db_exists(".athorn")))
	library create library_name = .athorn
end

! Load Macros
macro read macro_name = .MDI.delete_macro file="C:\Program Files\MSC.Software\Adams\aview_mods_gen\delete_macro.mac"
macro read macro_name = .athorn.mid_marker file="C:\Program Files\MSC.Software\Adams\aview_mods_gen\mid_marker.mac" user="athorn mid_marker"
macro read macro_name = .athorn.hide_others file="C:\Program Files\MSC.Software\Adams\aview_mods_gen\hide_others.mac" user="athorn hide_others"
macro read macro_name = .athorn.ppt_winmax file="C:\Program Files\MSC.Software\Adams\aview_mods_gen\ppt_winmax.mac" user="athorn ppt_winmax"
macro read macro_name = .athorn.pick_from_screen file="C:\Program Files\MSC.Software\Adams\aview_mods_gen\pick_from_screen.mac" user="athorn pick_from_screen"
macro read macro_name = .athorn.fbd file="C:\Program Files\MSC.Software\Adams\aview_mods_gen\fbd.mac" user="athorn fbd" create_panel=yes
macro read macro_name = .athorn.all_force_graphics file="C:\Program Files\MSC.Software\Adams\aview_mods_gen\all_force_graphics.mac" user="athorn all_force_graphics" create_panel=no

! Set Environment Variables
var set var=.mdi.tmp_int int=(eval(putenv("MDI_ONLINE_BROWSER", "C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe")))
var set var=.mdi.tmp_int int=(eval(putenv("NO_LAPI_MESSAGES​", "1")))

! Random Customizations
interface field    display field_name=.gui.sim_int_panel.c_interactive.step_size
interface field undisplay field_name=.gui.sim_int_panel.c_interactive.number_of_steps

! Hide buttons I don't use
int push_button undisplay push_button_name = .gui.main.standard_toolbar.view_fit 
int push_button undisplay push_button_name = .gui.main.standard_toolbar.zoom_box 
int push_button undisplay push_button_name = .gui.main.standard_toolbar.view_center 
int btn_stack undisplay btn_stack_name = .gui.main.standard_toolbar.dyn_view_tra_ro 
int btn_stack undisplay btn_stack_name = .gui.main.standard_toolbar.dyn_tra_depth 
int push_button undisplay push_button_name = .gui.main.standard_toolbar.view_zoom 
int field display field_name = .gui.main.standard_toolbar.*

! ---------------------------------------------------------------------
! Run Startup Scripts
! ---------------------------------------------------------------------
! file command read file = "C:\Program Files\MSC.Software\Adams\aview_mods_gen\part_multi_edit.cmd"
file command read file = "C:\Program Files\MSC.Software\Adams\aview_mods_gen\vis_buttons.cmd"

! ---------------------------------------------------------------------
! Settings
! ---------------------------------------------------------------------
! Units
default units &
   length=inch &
   mass=pound_mass &
   force=pound_force &
   time=second &
   angle=degrees &
   frequency=hz

! Plotting
defaults plt_attributes plot_auto_title = "on"
defaults plt_attributes plot_auto_subtitle = "on"
defaults plt_attributes plot_auto_date = "off"
defaults plt_attributes plot_auto_analysis_name = "off"
defaults plt_attributes plot_table = "no"
default plt_attributes legend_font_size=5
default plt_attributes date_note_font_size=5
default plt_attributes subtitle_font_size=5
default plt_attributes title_font_size=5
default plt_attributes table_font_size=5
default plotting axis_numbers_font_size=5
default plotting axis_label_font_size=5
default report base_font_size=5

! ---------------------------------------------------------------------
! Add Plotting Tools
! ---------------------------------------------------------------------
for var=.mdi.menu_bar  obj=(eval(db_immediate_children(.gui.ppt_main, "graphic_interface_menu_bar")))

    ! Hotkeys
    interface separator create separator_name=(eval(.mdi.menu_bar // ".tools.hotkeys_sep"))
    interface push_button create &
        push_button_name=(eval(.mdi.menu_bar // ".tools.btn_plot_tracking")) &
        label = "Plot Tracking::Ctrl+T" &
        commands = "interface push_button execute push_button_name = .gui.ppt_main.ppt_tbar1.plotting_cont.tracking action = single_click"

    interface push_button create   &
        push_button_name=(eval(.mdi.menu_bar // ".tools.btn_treeview_visibility")) &
        label = "Toggle Sidebar::Shift+Ctrl+E" &
        commands = "if condition=(.gui.ppt_main.sash1.treeview.displayed)", &
                "    mdi toolbar display toolbar=treeview state=off", &
                "    int tog set state=off tog=.gui.ppt_main.ppt_tbar1.treeview_visibility", &
                    "else", &
                    "    mdi toolbar display toolbar=treeview state=on", &
                    "    int tog set state=on tog=.gui.ppt_main.ppt_tbar1.treeview_visibility", &
                    "end" !"

    interface push_button create &
        push_button_name=(eval(.mdi.menu_bar // ".tools.btn_cockpit_visibility")) &
        label = "Toggle Sidebar::Ctrl+J" &
        commands = "if condition=(.gui.ppt_main.sash1.sash2.cockpit.displayed)", &
                "    mdi toolbar display toolbar=dashboard state=off", &
                "    int tog set state=off tog=.gui.ppt_main.ppt_tbar1.cockpit_visibility", &
                    "else", &
                    "    mdi toolbar display toolbar=dashboard state=on", &
                    "    int tog set state=on tog=.gui.ppt_main.ppt_tbar1.cockpit_visibility", &
                    "end" !"

    ! Free Body Diagram Button
    interface separator create separator_name=(eval(.mdi.menu_bar // ".tools.fbd_sep"))
    interface push_button create   &
        push_button_name=(eval(.mdi.menu_bar // ".tools.btn_fbd")) &
        label = "Free Body Diagram..." &
        commands = "interface dialog display dialog=.gui.dbox_fbd"

    ! Force Graphics
    interface push_button create   &
        push_button_name=(eval(.mdi.menu_bar // ".tools.btn_all_force_graphics")) &
        label = "Turn on all force graphics" &
        commands = "athorn all_force_graphics"
end


! ---------------------------------------------------------------------
! Run Python Setup
! ---------------------------------------------------------------------
file python read file="C:\Program Files\MSC.Software\Adams\aview_mods_gen\setup.py"

! ---------------------------------------------------------------------
! Load user aviewBS.cmd
! ---------------------------------------------------------------------
if condition=(eval(file_exists(getenv("MSC_ADAMS_STARTIN_DIR") // "\\aviewBS.cmd")))
	file command read file_name=(eval(getenv("MSC_ADAMS_STARTIN_DIR") // "\\aviewBS.cmd"))
end



! Add some paths
! aview toolkit putenv &
!     env = "PATH" &
!     value = (eval(str_replace_all(getenv("topdir"), "/", "\\\\") // "python\\\\win64;" // str_replace_all(getenv("topdir"), "/", "\\\\") // "python\\\\win64\\\\DLLs;" // str_replace_all(getenv("topdir"), "/", "\\\\") // "python\\\\win64\\\\Scripts;" // str_replace_all(getenv("path"), "\\", "\\\\")))

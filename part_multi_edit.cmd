! This script modifies the GUI to allow modification of multiple parts in the part_cremod dialog box
! Current Limitations:
! * User must open the part_cremod dialog box for a single part, then add additional parts to the body field
! * Currently only works on velocity ics
! * Bug when selecting a non-unique body name from the browser

int field modify &
    field_name = .gui.part_cremod.f_body &
    number_of_values = 0 &
    commands =  "file log command = off", &
                "if condition = ( db_object_count({$_value}) && DB_EXISTS({$_value}[1]) )", &
                "   interface dialog display dialog = $_parent parameter=\"$_value\", \"$o_category\"", &
                "!else", &
                "!   interface dialog display dialog = $_parent parameter=\"\", \"$o_category\"", &
                "end ! IF ON BODY EXISTS CHECK"

! "

interface container modify &
    container_name = .gui.part_cremod.c_ic_vel &
    execution_commands = "", &
                        "for var = $_self.body object=$f_body type=\"part\"", &
                        "    if condition = ( DB_TYPE(eval($_self.body)) == \"part\" )", &
                        "        part modify rigid_body initial_velocity  &", &
                        "            part_name = (eval($_self.body))  &", &
                        "            no_vx = true  &", &
                        "            no_vy = true  &", &
                        "            no_vz = true  &", &
                        "            no_wx = true  &", &
                        "            no_wy = true  &", &
                        "            no_wz = true  &", &
                        "            vm = (none)   &", &
                        "            wm = (none)", &
                        "        part modify rigid_body initial_velocity  &", &
                        "            part_name = (eval($_self.body))  &", &
                        "            `vm = $tra_ref_coord_f`  &", &
                        "            `wm = $rot_ref_coord_f`  &", &
                        "            `vx = $f_vx`  &", &
                        "            `vy = $f_vy`  &", &
                        "            `vz = $f_vz`  &", &
                        "            `wx = $f_wx`  &", &
                        "            `wy = $f_wy`  &", &
                        "            `wz = $f_wz`  ", &
                        "    elseif cond=( DB_TYPE(eval($_self.body)) == \"flexible_body\" )", &
                        "        part modify flexible_body initial_velocity  &", &
                        "            flexible_body = (eval($_self.body))  &", &
                        "            no_vx = true  &", &
                        "            no_vy = true  &", &
                        "            no_vz = true  &", &
                        "            no_wx = true  &", &
                        "            no_wy = true  &", &
                        "            no_wz = true  &", &
                        "            vm = (none)   &", &
                        "            wm = (none)", &
                        "        part modify flexible_body initial_velocity  &", &
                        "            flexible_body = (eval($_self.body))  &", &
                        "            `vm = $tra_ref_coord_f`  &", &
                        "            `wm = $rot_ref_coord_f`  &", &
                        "            `vx = $f_vx`  &", &
                        "            `vy = $f_vy`  &", &
                        "            `vz = $f_vz`  &", &
                        "            `wx = $f_wx`  &", &
                        "            `wy = $f_wy`  &", &
                        "            `wz = $f_wz`  ", &
                        "    elseif cond=( DB_TYPE((eval($_self.body))) == \"External_System\" )", &
                        "        part modify external_system initial_velocity  &", &
                        "            external_system = (eval($_self.body))  &", &
                        "            no_vx = true  &", &
                        "            no_vy = true  &", &
                        "            no_vz = true  &", &
                        "            no_wx = true  &", &
                        "            no_wy = true  &", &
                        "            no_wz = true  &", &
                        "            vm = (none)   &", &
                        "            wm = (none)", &
                        "    part modify external_system initial_velocity  &", &
                        "        external_system = (eval($_self.body))  &", &
                        "            `vm = $tra_ref_coord_f`  &", &
                        "            `wm = $rot_ref_coord_f`  &", &
                        "            `vx = $f_vx`  &", &
                        "            `vy = $f_vy`  &", &
                        "            `vz = $f_vz`  &", &
                        "            `wx = $f_wx`  &", &
                        "            `wy = $f_wy`  &", &
                        "            `wz = $f_wz`  ", &
                        "    elseif cond=( DB_TYPE((eval($_self.body)))  == \"point_mass\" )", &
                        "        part modify point_mass initial_velocity  &", &
                        "            point_mass = (eval($_self.body))  &", &
                        "            no_vx = true  &", &
                        "            no_vy = true  &", &
                        "            no_vz = true  &", &
                        "            vm = (none)", &
                        "        part modify point_mass initial_velocity  &", &
                        "            point_mass = (eval($_self.body))  &", &
                        "            `vm = $tra_ref_coord_f`  &", &
                        "            `vx = $f_vx`  &", &
                        "            `vy = $f_vy`  &", &
                        "            `vz = $f_vz`", &
                        "    else", &
                        "        mdi gui_utl_alert_box_1 &", &
                        "            type = \"fault\" &", &
                        "            text = \"Unimplemented body type.\"", &
                        "        return", &
                        "    end", &
                        "end" & !"
    start_commands = "", &
                    "for var = $_self.body object=$f_body type=\"part\"", &
                    "   if condition = ( DB_EXISTS(eval($_self.body // \".vm\")))", &
                    "      int field set field = $_self.tra_ref_coord_f dat = (eval($_self.body // \".vm\"))", &
                    "      int radio set radio = $_self.radio_vel choice = \"Marker\"", &
                    "      int radio execute radio = $_self.radio_vel", &
                    "   else", &
                    "      int field set field = $_self.tra_ref_coord_f string = \"\"", &
                    "      int radio set radio = $_self.radio_vel choice = \"Ground\"", &
                    "      int radio execute radio = $_self.radio_vel", &
                    "   end", &
                    "   if condition = ( DB_EXISTS(eval($_self.body // \".vx\")))", &
                    "      int field set field = $_self.f_vx dat = (eval($_self.body // \".vx\"))", &
                    "      int toggle set toggle = $_self.toggle_vx state = on exe = yes", &
                    "   else", &
                    "      int field set field = $_self.f_vx string = \"\"", &
                    "      int toggle set toggle = $_self.toggle_vx state = off exe = yes", &
                    "   end", &
                    "   !", &
                    "   if condition = ( DB_EXISTS(eval($_self.body // \".vy\")))", &
                    "      int field set field = $_self.f_vy dat = (eval($_self.body // \".vy\"))", &
                    "      int toggle set toggle = $_self.toggle_vy state = on exe = yes", &
                    "   else", &
                    "      int field set field = $_self.f_vy string = \"\"", &
                    "      int toggle set toggle = $_self.toggle_vy state = off exe = yes", &
                    "   end", &
                    "   !", &
                    "   if condition = ( DB_EXISTS(eval($_self.body // \".vz\")))", &
                    "      int field set field = $_self.f_vz dat = (eval($_self.body // \".vz\"))", &
                    "      int toggle set toggle = $_self.toggle_vz state = on exe = yes", &
                    "  else", &
                    "     int field set field = $_self.f_vz string = \"\"", &
                    "     int toggle set toggle = $_self.toggle_vz state = off exe = yes", &
                    "  end", &
                    "!", &
                    "  if condition = ( (DB_TYPE(eval($_self.body)) == \"point_mass\" ))", &
                    "     interface label  modify label  = $_self.ang_vel_label   enabled = no", &
                    "     interface toggle modify toggle = $_self.toggle_wx       enabled = no", &
                    "     interface toggle modify toggle = $_self.toggle_wy       enabled = no", &
                    "     interface toggle modify toggle = $_self.toggle_wz       enabled = no", &
                    "     interface field  modify field  = $_self.rot_ref_coord_f enabled = no", &
                    "     interface field  modify field  = $_self.f_wx            enabled = no", &
                    "     interface field  modify field  = $_self.f_wy            enabled = no", &
                    "     interface field  modify field  = $_self.f_wz            enabled = no", &
                    "     interface radio  modify radio  = $_self.radio_rot_vel   enabled = no", &
                    "  else", &
                    "     interface label  modify label  = $_self.ang_vel_label   enabled = yes", &
                    "     interface toggle modify toggle = $_self.toggle_wx       enabled = yes", &
                    "     interface toggle modify toggle = $_self.toggle_wy       enabled = yes", &
                    "     interface toggle modify toggle = $_self.toggle_wz       enabled = yes", &
                    "     interface field  modify field  = $_self.rot_ref_coord_f enabled = yes", &
                    "     interface field  modify field  = $_self.f_wx            enabled = yes", &
                    "     interface field  modify field  = $_self.f_wy            enabled = yes", &
                    "     interface field  modify field  = $_self.f_wz            enabled = yes", &
                    "     interface radio  modify radio  = $_self.radio_rot_vel   enabled = yes", &
                    "     if condition = ( DB_TYPE(eval($_self.body)) == \"flexible_body\" )", &
                    "        int radio modify radio = $_self.radio_rot_vel  &", &
                    "           choices = \"Part BCS\", \"Marker\" current_choice = \"Part BCS\"", &
                    "     else", &
                    "        int radio modify radio = $_self.radio_rot_vel  &", &
                    "           choices = \"Part CM\", \"Marker\" current_choice = \"Part CM\"", &
                    "     end", &
                    "!", &
                    "     if condition = ( eval(DB_EXISTS($_self.body // \".wm\")))", &
                    "        int field set field = $_self.rot_ref_coord_f dat = (eval($_self.body // \".wm\"))", &
                    "        int radio set radio = $_self.radio_rot_vel  value = \"marker\"", &
                    "        int radio execute radio = $_self.radio_rot_vel", &
                    "     else", &
                    "        int field set field = $_self.rot_ref_coord_f string = \"\"", &
                    "        int radio set radio = $_self.radio_rot_vel value = \"cm\"", &
                    "        int radio execute radio = $_self.radio_rot_vel", &
                    "     end", &
                    "!", &
                    "     if condition = ( eval(DB_EXISTS($_self.body // \".wx\")))", &
                    "        int field set field = $_self.f_wx dat = (eval($_self.body // \".wx\"))", &
                    "        int toggle set toggle = $_self.toggle_wx state = on exe = yes", &
                    "     else", &
                    "        int field set field = $_self.f_wx string = \"\"", &
                    "        int toggle set toggle = $_self.toggle_wx state = off exe = yes", &
                    "     end", &
                    "!", &
                    "      if condition = ( eval(DB_EXISTS($_self.body // \".wy\")))", &
                    "         int field set field = $_self.f_wy dat = (eval($_self.body // \".wy\"))", &
                    "        int toggle set toggle = $_self.toggle_wy state = on exe = yes", &
                    "     else", &
                    "        int field set field = $_self.f_wy string = \"\"", &
                    "        int toggle set toggle = $_self.toggle_wy state = off exe = yes", &
                    "     end", &
                    "!", &
                    "      if condition = ( eval(DB_EXISTS($_self.body // \".wz\")))", &
                    "         int field set field = $_self.f_wz dat = (eval($_self.body // \".wz\"))", &
                    "        int toggle set toggle = $_self.toggle_wz state = on exe = yes", &
                    "     else", &
                    "        int field set field = $_self.f_wz string = \"\"", &
                    "        int toggle set toggle = $_self.toggle_wz state = off exe = yes", &
                    "     end", &
                    "  end", &
                    "  break", &
                    "end" ! "


int push_button modify push_button_name = .gui.part_cremod.b_apply &
    commands = "", &
        "file log command=off", &
        "!", &
        "if condition = (STR_IS_SPACE(\"$o_category\"))", &
        "   interface container execute container = $_parent.c_ground undisplay = no", &
        "else", &
        "   interface container execute container = $_parent.c_$o_category undisplay = no", &
        "end", &
        "!", &
        "if condition=(rows({$f_body})<2)", &
        "    ", &
        "    if condition = ( DB_TYPE($f_body) == \"part\" )", &
        "        file log command = on", &
        "        part modify rigid_body name_and_position  &", &
        "            part_name = $f_body comments = (eval( $_parent.entity_comments ))", &
        "        file log command = off", &
        "    elseif cond=( db_type( $f_body ) == \"flexible_body\" )", &
        "        file log command = on", &
        "        part modify flexible_body name_and_position  &", &
        "            flexible_body = $f_body comments = (eval( $_parent.entity_comments ))", &
        "        file log command = off", &
        "    elseif cond=( db_type( $f_body )  == \"point_mass\" )", &
        "        file log command = on", &
        "        part modify point_mass name_and_position  &", &
        "            point_mass = $f_body comments = (eval( $_parent.entity_comments ))", &
        "        file log command = off", &
        "    end", &
        "end", &
        "!", &
        "interface dialog display dialog = $_parent parameter = \"$f_body\", \"$o_category\"" !"

int push_button modify push_button_name = .gui.part_cremod.b_ok &
    commands = "", &
        "interface container execute container = $_parent.c_$o_category undisplay = no", &
        "if condition=(rows({$f_body})<2)", &
        "    if condition = ( DB_TYPE($f_body) == \"part\" )", &
        "        file log command = on", &
        "        part modify rigid_body name_and_position  &", &
        "            part_name = $f_body comments = (eval( $_parent.entity_comments ))", &
        "        file log command = off", &
        "    elseif condition =( DB_TYPE($f_body) == \"flexible_body\" )", &
        "        file log command = on", &
        "        part modify flexible_body name_and_position  &", &
        "            flexible_body = $f_body comments = (eval( $_parent.entity_comments ))", &
        "        file log command = off", &
        "    elseif condition = ( DB_TYPE($f_body)  == \"point_mass\" )", &
        "        file log command = on", &
        "        part modify point_mass name_and_position  &", &
        "            point_mass = $f_body comments = (eval( $_parent.entity_comments ))", &
        "        file log command = off", &
        "    end", &
        "end", &
        "if cond=(.mdi.errno==0)", &
        "    interface dialog undisplay dialog = $_parent", &
        "end" ! "

interface dialog_box modify  &
    dialog_box_name = .gui.part_cremod  &
    start_commands = "! -------------------------------------------- $_1: Body",  &
                     "! -------------------------------------------- $_2: Category",  &
                     "",  &
                     "! -------------------------------------------- SECURITY CHECK",  &
                     "if condition = ( !STR_IS_SPACE( \"$_1\" ) )",  &
                     "    interface field set field = $_self.f_body &",  &
                     "        string = (EVAL(db_default_name({$_1}[1])))",  &
                     "end ! IF ON BLANK NAME CHECK",  &
                     "",  &
                     "if condition = ( EVAL(user_string(\"$f_body.ground_part\") == \"True\") )",  &
                     "   interface container undisplay container = $_self.*",  &
                     "   interface container display container = $_self.c_ground",  &
                     "   interface option set option = $_self.o_category choice = \"Ground Part\"",  &
                     "   interface option modify option = $_self.o_category enabled = no",  &
                     "   interface label modify label = $_self.l_category enabled = no",  &
                     "",  &
                     "else",  &
                     "   interface option modify option = $_self.o_category enabled = yes",  &
                     "   interface label modify label = $_self.l_category enabled = yes",  &
                     "   !",  &
                     "   if condition = ( DB_TYPE(eval({$_1}[1])) == \"part\" )",  &
                     "     interface option_menu modify  &",  &
                     "        option_menu_name = $_self.o_category  &",  &
                     "        choices = \"Name and Position\", \"Mass Properties\",  &",  &
                     "                  \"Position Initial Conditions\", \"Velocity Initial Conditions\",  &",  &
                     "                  \"Ground Part\"  &",  &
                     "        current_choice = \"Mass Properties\"  &",  &
                     "        values = \"name\", \"mass\", \"ic_pos\", \"ic_vel\", \"ground\"  ",  &
                     "   elseif condition = ( DB_TYPE(eval({$_1}[1])) == \"flexible_body\" )",  &
                     "     interface option_menu modify  &",  &
                     "        option_menu_name = $_self.o_category  &",  &
                     "        choices = \"Name and Position\", &",  &
                     "                  \"Position Initial Conditions\", \"Velocity Initial Conditions\"  &",  &
                     "        current_choice = \"Name and Position\"  &",  &
                     "        values = \"name\", \"ic_pos\", \"ic_vel\" ",  &
                     "   elseif condition = ( DB_TYPE(eval({$_1}[1])) == \"point_mass\" )",  &
                     "     interface option_menu modify  &",  &
                     "        option_menu_name = $_self.o_category  &",  &
                     "        choices = \"Name and Position\",  &",  &
                     "                  \"Position Initial Conditions\", \"Velocity Initial Conditions\"  &",  &
                     "        current_choice = \"Name and Position\"  &",  &
                     "        values = \"name\", \"ic_pos\", \"ic_vel\"",  &
                     "   elseif condition = ( DB_TYPE(eval({$_1}[1])) == \"External_System\" )",  &
                     "     interface option_menu modify  &",  &
                     "        option_menu_name = $_self.o_category  &",  &
                     "        choices = \"Name and Position\",  &",  &
                     "                  \"Velocity Initial Conditions\"  &",  &
                     "        current_choice = \"Name and Position\"  &",  &
                     "        values = \"name\", \"ic_vel\"",  &
                     "   end ! IF ON BODY TYPE CHECK",  &
                     "   !",  &
                     "   if condition = (!str_is_space(\"$_2\"))",  &
                     "      interface option set option = $_self.o_category value = \"$_2\"",  &
                     "   end ! IF ON 2ND PARAMETER CHECK",  &
                     "   ! ",  &
                     "   interface option execute option = $_self.o_category",  &
                     "end ! IF ON GROUND PART CHECK",  &
                     "",  &
                     "",  &
                     "! ------------------------------------------------------- COMMENTS",  &
                     "variable set variable = $_self.entity_comments &",  &
                     "   string_value = ( EVAL( DB_EXISTS(\"$f_body.comments\") ? $f_body.comments : \"\" ))",  &
                     "",  &
                     "! Add all bodies to body field",  &
                     "if condition = ( db_object_count( {$_1} ) )",  &
                     "    interface field set field = $_self.f_body string=\"\"",  &
                     "    for var=$_self.idx_  start=1 end=(rows({$_1}))",  &
                     "        var set var=$_self.idx int = (eval(nint($_self.idx_)))",  &
                     "        var set var=$_self.strs str=(eval(db_default_name({$_1}[$_self.idx]))) index=(eval($_self.idx))",  &
                     "    end",  &
                     "    interface field set field = $_self.f_body &",  &
                     "       string = (EVAL(str_merge_strings(\",\", $_self.strs)))",  &
                     "end" ! "

interface container modify &
    container = .gui.part_cremod.c_mass &
    start_commands = "", &
        "var set var=$_self.show_only_mass_inertia int=0", &
        "if condition=(eval(db_object_count({$f_body}) < 2) && db_object_count({$_1}) < 2)", &
        "    if condition = ( ! $'f_body'.use_calculated_mass )", &
        "        int option set option = $_self.mass_option choice=\"User Input\"", &
        "    else", &
        "        int option set option = $_self.mass_option &", &
        "            choice=(eval( $_1.material != (none) ? \"Geometry and Material Type\" : \"Geometry and Density\" ))", &
        "    end", &
        "   int field set field=$_self.c_material_type.f_material_type dat=\"$_1.material_type\"", &
        "   int option execute option = $_self.mass_option", &
        "   int field set field=$_self.c_mass.f_mass dat=\"$_1.mass\"", &
        "   int field set field=$_self.c_mass.f_center_of_mass_marker dat=\"$_1.center_of_mass_marker\"", &
        "   int field set field=$_self.c_mass.f_inertia_marker dat=\"$_1.inertia_marker\"", &
        "   int field set field=$_self.c_mass.f_ixx dat=\"$_1.ixx\"", &
        "   int field set field=$_self.c_mass.f_iyy dat=\"$_1.iyy\"", &
        "   int field set field=$_self.c_mass.f_izz dat=\"$_1.izz\"", &
        "   int field set field=$_self.c_mass.f_ixy dat=\"$_1.ixy\"", &
        "   int field set field=$_self.c_mass.f_izx dat=\"$_1.izx\"", &
        "   int field set field=$_self.c_mass.f_iyz dat=\"$_1.iyz\"", &
        "   int field set field=$_self.c_density.f_density dat=\"$_1.density\"", &
        "end" ! "

interface container modify &
    container = .gui.part_cremod.c_mass &
    execution_commands = (eval(.gui.part_cremod.c_mass.start_commands))

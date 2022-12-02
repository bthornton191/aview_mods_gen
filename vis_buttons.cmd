
if condition=(eval(db_exists(".gui.main.vis_toolbar")))
    interface toolbar delete toolbar_name=.gui.main.vis_toolbar
end
interface toolbar create &
    toolbar = .gui.main.vis_toolbar &
    location = 0,0 &
    width = 100 &
    height = 25 &
    units = pixel &
    top = no &
    rank = 1

interface toolbar display toolbar=.gui.main.vis_toolbar


if condition=(eval(db_exists(".gui.ppt_main.vis_toolbar")))
    interface toolbar delete toolbar_name=.gui.ppt_main.vis_toolbar
end
interface toolbar create &
    toolbar = .gui.ppt_main.vis_toolbar &
    location = 0,0 &
    width = 100 &
    height = 25 &
    units = pixel &
    top = no &
    rank = 1

interface toolbar display toolbar=.gui.ppt_main.vis_toolbar

for var=.mdi.toolbar  obj=.gui.main.vis_toolbar, .gui.ppt_main.vis_toolbar
    
    var set var=.mdi.types str="part", "marker", "constraint", "force", "spring"
    for var=.mdi.idx_ start_value=1 end_value=(rows(.mdi.types))
        var set var=.mdi.idx int=(eval(nint(.mdi.idx_)))
        var set var=.mdi.type str=(eval(.mdi.types[.mdi.idx]))

        if condition=(eval(db_exists(.mdi.toolbar // ".show_" // .mdi.type // "s")))
            interface toggle_button delete toggle_button_name=(eval(.mdi.toolbar // ".show_" // .mdi.type // "s"))
        end

        if condition=(eval(.mdi.idx==1))
            var set var=.mdi.location real=(eval(.gui.main.width-100)), 4
        else
            var set var=.mdi.prev_type str=(eval(.mdi.types[.mdi.idx-1]))
            var set var=.mdi.prev_button obj=(eval(.mdi.toolbar // ".show_" // .mdi.prev_type // "s"))
        
            var set var=.mdi.location real=(eval(.mdi.prev_button.object_value.location[1]-40)), 4

        end
        
        if condition=(eval(.mdi.type=="constraint"))
            var set var=.mdi.icon str = "joint"
        elseif condition=(eval(.mdi.type=="force"))
            var set var=.mdi.icon str = "Force_Vector"
        else
            var set var=.mdi.icon str = (eval(.mdi.type))
        end
      
        interface toggle_button create &
            toggle_button_name=(eval(.mdi.toolbar // ".show_" // .mdi.type // "s")) &
            ! label=(eval(.mdi.type // "s")) &
            hit = (eval(.mdi.icon) // "_H.png") &
            icon = (eval(.mdi.icon) // ".png") & 
            location=(eval(.mdi.location)) &
            height = 16 &
            width = 40 &
            units = pixel &
            vert_resizing = attach_bottom &
            horiz_resizing = attach_right &
            commands = (eval("entity attributes entity_name = * type_filter = " // .mdi.type // " visibility=(eval(($_self.state==1)? 'off':'on'))")), "interface model_browser refresh" &
            state = on
    end

    if condition=(eval(db_exists(.mdi.toolbar // ".transparency_slider")))
        interface slider delete slider_name=(eval(.mdi.toolbar.object_value.transparency_slider))
    end

    int separator create &
        separator_name = (eval(.mdi.toolbar.object_value // ".sep_1")) &
        location = (eval(stoo(.mdi.toolbar // ".show_" // .mdi.type // "s").location[1]-20)), (eval(stoo(.mdi.toolbar // ".show_" // .mdi.type // "s").location[2])) &
        height = 16 &
        width = 10 &
        units = pixel &
        isvertical = yes &
        vert_resizing = attach_bottom &
        horiz_resizing = attach_right

    int slider create &
        slider_name = (eval(.mdi.toolbar.object_value // ".transparency_slider")) &
        location = (eval(.mdi.toolbar.object_value.sep_1.location[1]-115)), (eval(stoo(.mdi.toolbar // ".show_" // .mdi.type // "s").location[2])) &
        height = 16 &
        width = 100 &
        units = pixel &
        vert_resizing = attach_bottom &
        horiz_resizing = attach_right &
        help_text = "Transparency of selected object(s)" &
        minimum = 0 &
        maximum = 99 &
        value = 0 &
        show_value = no &
        commands =          "if condition=(eval(DB_COUNT(.select_list, \"objects_in_group\")))", & 
                    (eval(  "   entity attributes entity_name = (eval(.SELECT_LIST.objects)) transparency=(eval($_self.value))")), & ! "
                            "end" &
        live_drag = yes

    int separator create &
        separator_name = (eval(.mdi.toolbar.object_value // ".sep_2")) &
        location = (eval(.mdi.toolbar.object_value.transparency_slider.location[1]-20)), (eval(stoo(.mdi.toolbar // ".show_" // .mdi.type // "s").location[2])) &
        height = 16 &
        width = 10 &
        units = pixel &
        isvertical = yes &
        vert_resizing = attach_bottom &
        horiz_resizing = attach_right
    

    int slider create &
        slider_name = (eval(.mdi.toolbar.object_value // ".force_graphic_slider")) &
        location = (eval(.mdi.toolbar.object_value.sep_2.location[1]-105)), (eval(stoo(.mdi.toolbar // ".show_" // .mdi.type // "s").location[2])) &
        height = 7 &
        width = 100 &
        units = pixel &
        vert_resizing = attach_bottom &
        horiz_resizing = attach_right &
        minimum = -1 &
        maximum = 1 &
        value = 1 &
        show_value = no &
        commands = "default force force_scale=(eval(($_self.value>0)? .system_defaults.force_force_scale*2:.system_defaults.force_force_scale/2))" & 
        live_drag = yes


    int slider create &
        slider_name = (eval(.mdi.toolbar.object_value // ".torque_graphic_slider")) &
        location = (eval(.mdi.toolbar.object_value.sep_2.location[1]-105)), (eval(stoo(.mdi.toolbar // ".show_" // .mdi.type // "s").location[2]+9)) &
        height = 7 &
        width = 100 &
        units = pixel &
        vert_resizing = attach_bottom &
        horiz_resizing = attach_right &
        minimum = -1 &
        maximum = 1 &
        value = 1 &
        show_value = no &
        commands = "default force torque_scale=(eval(($_self.value>0)? .system_defaults.force_torque_scale*2:.system_defaults.force_torque_scale/2))" & 
        live_drag = yes
    

    interface push_button create &
        push_button_name = (eval(.mdi.toolbar.object_value // ".force_wireframe_chckbx")) &
        ! label="wire" &
        icon = "C:/Program Files/MSC.Software/Adams/aview_mods_gen/wire_force_vector.bmp" &
        location = (eval(.mdi.toolbar.object_value.force_graphic_slider.location[1]-35)), (eval(stoo(.mdi.toolbar // ".show_" // .mdi.type // "s").location[2])) &
        height = 16 &
        width = 30 &
        units = pixel &
        vert_resizing = attach_bottom &
        horiz_resizing = attach_right &
        commands = (eval("default force display_wireframe=(eval((.system_defaults.force_display_wireframe==0)? 'yes':'no'))"))

    int tool mod tool=.gui.main.status_toolbar rank = 2
    var del var=.mdi.types, .mdi.type, .mdi.location, .mdi.prev_button, .mdi.prev_type, .mdi.idx



end
redrawGUI() {
    global config_path
    IniRead, gui_position, %config_path%, %A_ComputerName%, gui_position, "x534 y273 w766 h569"
    wdth := StrSplit(gui_position, " ")[3]
    GuiControl, MoveDraw, CB_Display, %wdth%                                    
    Gui, 2: show, %gui_position%                                            
    return
}
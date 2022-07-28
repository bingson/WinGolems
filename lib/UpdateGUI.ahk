UpdateGUI(new_txt = "" , new_title_file = "") {
    global config_path, med, CB_hwnd, C
    CoordMode, Mouse, screen
    MouseGetPos, StartX, StartY   
    ; Gui, 2: +LastFound
    d := "x" A_ScreenWidth//2 " y0 w" A_ScreenWidth//2 " h" A_ScreenHeight//2
    CB_position := GC("CB_position", d), display := GC("CB_Display", 1)      ;    GetConfig(section, default_value = "")
    title_state  := GC("CB_Titlebar", 1), ldspl   := GC("CB_last_display")
    ScrollBars   := GC("CB_ScrollBars", 0) ;, InputBox_width := GC("CB_InputBox_width")
    old_title_bar := GC("CBtitle")
    wdth := StrSplit(CB_position, " ")[3]

    if (!title_state) 
        Gui, 2: -Caption
    else 
    {
        Gui, 2: +Caption
            RegExMatch(old_title_bar, ".*(?=\|  )", v)                         ; get everything before the last title separator and store in v
        if new_title_file {
            Gui, 2: Show, , %v%|    %new_title_file%
            CC("CB_title_file", new_title_file)
        } else {
            ; GC("CB_title_file")
            Gui, 2: Show, , % v " |    " GC("CB_title_file")
        }
    }
    
    if (!display) {
        Guicontrol, 2: ,CB_Display, %A_space%
        t_color := GC("CBt_color")
        w_color := GC("CBw_color")
        ; Gui, 2: Font, +c%t_color% +Redraw
        GuiControl, 2: Font +c%t_color% +Redraw, UserInput
        Gui, 2: Color,,%w_color%
        Gui, 2: show, hide 
    } else if (display) {
        if (new_txt) {
            ; Gui, 2: Font, +c000000 +Redraw
            input_txt := % GC("CB_reenterInput", 1) ? GC("last_user_input", "?") : ((input_txt = "Error") ? ("?") : input_txt) 
            GuiControl, 2: +c000000 +Redraw, UserInput
            GuiControl, 2: Text, UserInput, %input_txt%
            GuiControl, 2:, CB_Display, %new_txt%
            GuiControl, 2: MoveDraw, CB_Display
            AutoXYWH("w*h", "CB_Display")
        } 
        else {
            txt :=  AccessCache(ldspl,, 0)
            GuiControl, 2:, CB_Display, %txt%
        }
        
        Gui, 2: Color,,FFFFFF 
        Gui, 2: show, hide
        

    }

    if !GC("CB_ScrollBars", 0)
        GuiControl, 2: -HScroll -VScroll, CB_Display
    else 
        GuiControl, 2: +HScroll +VScroll, CB_Display 
    
    GuiControl, 2: Focus, UserInput 
    Send % GC("CB_reenterInput", 1) ? ("^a") : ("")

    Gui, 2: show, hide AutoSize 
    WinSet, Redraw,, ahk_id %CB_hwnd%
    Gui, 2: show, %CB_position%                                                 ;  Gui, 2: show, hide AutoSize

    GuiControl, 2: +HScroll +VScroll, CB_Display
    DllCall("SetCursorPos", "int", StartX, "int", StartY)                       ; necessary for multi-monitor setups over MouseMove
  }
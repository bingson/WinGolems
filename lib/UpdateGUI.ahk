UpdateGUI(new_txt = "" , new_title_file = "") {
    global config_path, med, CB_hwnd, C
    Gui, 2: +LastFound
    d := "x" A_ScreenWidth//2 " y0 w" A_ScreenWidth//2 " h" A_ScreenHeight//2
    CB_position := GC("CB_position", d), display := GC("CB_Display", 1)      ;    GetConfig(section, default_value = "")
    title_state  := GC("CB_Titlebar", 1), ldspl   := GC("CB_last_display")
    ScrollBars   := GC("CB_ScrollBars", 0), InputBox_width := GC("CB_InputBox_width")
    old_title_file := GC("CBtitle")
    wdth := StrSplit(CB_position, " ")[3]

    if (!title_state) 
        Gui, 2: -Caption
    else 
    {
        Gui, 2: +Caption
        if new_title_file {
            RegExMatch(old_title_file, ".*(?=\|  )", v)                         ; get everything before the last title separator and store in v
            Gui, 2: Show, , %v%|    %new_title_file%
        }
    }
    
    if (!display) {
        Guicontrol, ,CB_Display, %A_space%
        t_color := GC("CBt_color")
        w_color := GC("CBw_color")
        ; Gui, 2: Font, +c%t_color% +Redraw
        GuiControl, Font +c%t_color% +Redraw, UserInput
        Gui, 2: Color,,%w_color%
        Gui, 2: show, hide 
    } else if (display) {
        if (new_txt) {
            ; Gui, 2: Font, +c000000 +Redraw
            GuiControl, +c000000 +Redraw, UserInput
            GuiControl, 2:, CB_Display, %new_txt%
            GuiControl, MoveDraw, CB_Display
            AutoXYWH("w*h", "CB_Display")
        } 
        else {
            txt :=  AccessCache(ldspl,, 0)
            GuiControl, 2:, CB_Display, %txt%
        }
        
        Gui, 2: Color,,FFFFFF 
        Gui, 2: show, hide
        

    }

    CtrXpos := (SubStr(wdth, 2) - InputBox_width) // 2
    
    GuiControl, MoveDraw,UserInput, x%CtrXpos%                                 ; set the width to the edit box to value stored in ini file
    if !GC("CB_ScrollBars", 0)
        GuiControl, 2: -HScroll -VScroll, CB_Display
    else 
        GuiControl, 2: +HScroll +VScroll, CB_Display 

    Gui, 2: show, hide AutoSize 
    WinSet, Redraw,, ahk_id %CB_hwnd%
    Gui, 2: show, %CB_position%                                                ;  Gui, 2: show, hide AutoSize
    GuiControl, 2: +HScroll +VScroll, CB_Display
  }
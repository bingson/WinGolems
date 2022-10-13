UpdateGUI(new_txt = "" , new_title_file = "") {
    global config_path, med, CB_hwnd, C, CB_DisplayVar
    
    SetBatchLines, -1
    SetWinDelay, -1
    Process, Priority,, High
    ; timecode()

    GuiMinState := DllCall("IsIconic", "Ptr", CB_hwnd, "UInt") ; GUI minimized = 1
    Gui, 2: +LastFound ;+E0x08000000                                     ;prevent GUI from stealing focus https://www.autohotkey.com/boards/viewtopic.php?t=99728

    MI := StrSplit(GetMonInfo()," ")                                            ; get monitor dimensions
    hh := MI[4]*.455
    hw := MI[3]*.495
    d := "x" MI[1]+hw " y" MI[2]+hh " w" hw " h" hh                      ;(2) calc default window dimensions to load when saved position data is not valid

    CB_position := GC("CB_position", d)

    CB_position := GC("CB_position", d), display := GC("CB_Display", 1)
    title_state := GC("CB_Titlebar", 1), ldspl   := GC("CB_last_display")
    ScrollBars  := GC("CB_ScrollBars", 0)
    title_bar   := GC("CBtitle")
    wrap        := GC("CB_Wrap",0) ? " +Wrap" : " -Wrap"
    wdth        := StrSplit(CB_position, " ")[3]

    if (!title_state) 
        Gui, 2: -Caption
    else 
    {
        Gui, 2: +Caption
        
        ; optn := GetCurrentGUIoptions()

        ; if new_title_file {
        ;     title :=  GC("CB_tgtExe") GC("CB_sfx") " | " optn new_title_file
        ;     CC("CB_last_display", new_title_file)
        ; } else {
        ;     title :=  GC("CB_tgtExe") GC("CB_sfx") " | " optn GC("CB_last_display")
        ; }
        new_title_file ? CC("CB_last_display", new_title_file) : ""
        title :=  GC("CB_tgtExe") GC("CB_sfx") "  |  " GetCurrentGUIoptions() (new_title_file ? new_title_file : GC("CB_last_display"))
        Gui, 2: Show, , % title 
    }

    t_color := GC("CBt_color")
    
    if !GC("CB_ScrollBars", 0)
        GuiControl, 2: -HScroll -VScroll, CB_DisplayVar
    else 
        GuiControl, 2: +HScroll +VScroll, CB_DisplayVar 


    Gui, 2: show, hide AutoSize 
    WinSet, Redraw,, ahk_id %CB_hwnd%
    Gui, 2: show, % CB_position . (GC("CB_appActive", 0) ? (" NoActivate") : (" Restore"))                                                ;  Gui, 2: show, hide AutoSize

    ;DllCall("SetCursorPos", "int", StartX, "int", StartY)                       ; used instead of MouseMove for multi-monitor setups 
    
    Gui, 2: Color, % GC("CB_clr")
    if (!display) {
        Guicontrol, 2: ,CB_DisplayVar, %A_space%
    } else if (display) {
        Gui, 2: Font, +c%t_color%  ; If desired, use a line like this to set a new default font for the window.
        GuiControl, 2: Font, CB_DisplayVar
        if (new_txt) {
            GuiControl, 2:, CB_DisplayVar, %new_txt%
        } 
    }


    if GC("CB_appActive", 0) {
        ; ActivateWin("ahk_id " GC("TGT_hwnd")) 
        ActivateApp(GC("CB_tgtExe"))
    } 
    if !GC("CB_ScrollBars", 0) 
        settimer, addHiddenScrollBar,-300

    ; SendMessage,0x00B1,-1,0,, % "ahk_id " CB_Display ; EM_SETSEL=0x00B1
    
    ; timecode()
    SetWinDelay, 100
    SetBatchLines, 10ms
    Process, Priority, , A

    return
}
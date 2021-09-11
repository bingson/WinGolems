 CommandBox(suffix = "" , byref w_color = "F6F7F1", t_color = "000000", ProcessMod = "ProcessCommand"
            , fwt = "500", show_txt = "", title = "",  input_txt = "") {
    CoordMode, Mouse, Screen
    BlockInput, MouseMove
    settimer, BlockInputTimeOut,-300
    MouseGetPos, StartX, StartY
    global long, med, short, C, config_path, CB_Display := ""
        , UserInput := "", tgt_hwnd := "", CB_hwnd := ""
    
    tgt_hwnd := WinExist() 

    CC("CB_sfx", suffix)    , CC("TGT_hwnd",tgt_hwnd) 
    CC("CBw_color",w_color) , CC("CBt_color",t_color)                           ;(1) save/store command box calling parameters in config.ini
    CC("CB_ProcessMod", ProcessMod)                                             ; config.ini used to preserve/change CB parameter information between redraws
    
    redrawGUI:
    Gui, 2: +LastFound
    Gui, 2: Destroy          
    
    suffix  := GC("CB_sfx")            , tgt_hwnd := GC("TGT_hwnd")
    w_color := GC("CBw_color")         , t_color  := GC("CBt_color")
    fnt     := GC("CBfnt", "Consolas") , fsz      := GC("CBfsz", "10")
    fwt     := GC("CBfwt", "500")               

    MI := StrSplit(GetMonInfo()," ")                                            ; get monitor dimensions
    d := "x" MI[3] // 2 " y0 w" MI[3] // 2 " h" MI[4] // 2                      ;(2) calc default window dimensions to load when saved position data is not valid
    CB_position := GC("CB_position", d)
    WP := StrSplit(CB_position, " ")
    if (WP[4] < 10)                                                             ; check if monitor dimensions valid
       CB_position := d
    wdth := WP[3]
    IBwidth := 400
    CC("CB_InputBox_width", IBwidth)

    display  := GC("CB_Display",1) , title_state := GC("CB_Titlebar",1)         ;(2a) get other CB window data
    wrap_txt := GC("CB_Wrap",0)    , ldspl       := GC("CB_last_display")

                                                                               
    UserInput := ""
    winget, Process_Name, ProcessName, A                                        ;(3) build title bar
    CC("CB_tgtExe", Process_Name)
    l := "    |    ", s := "  "                                                 
    FormatTime, MyTime,, hh:mm tt               
    CB_Title_ID := s MyTime l                                                   ; CB_Title_ID2 := s "(-(-_(-_-)_-)-)" s "COMMAND BOX" l       
    
    title_text := Capitalize1stLetter(Process_Name,0, 0)
    ldspl .= RetrieveExt(A_ScriptDir "\mem_cache\" ldspl)  
    ndspl := GC("CB_title")
    title := CB_Title_ID title_text suffix l (ndspl ? ndspl : ldspl) 
    CC("CBtitle",title)

    Gui, 2: New ;,,%title%                                                      ;(4) set GUI options
    Gui, 2: +LastFound +OwnDialogs +Owner +E0x00200 -DPIscale +AlwaysOnTop +Resize     ; +E0x08000000 +Resize  
    Gui, 2: Color, %w_color%
    Gui, font, c%t_color% s%fsz% w%fwt%, %fnt%
    
    if (!title_state) 
        Gui, 2: -Caption
    else 
        Gui, 2: +Caption

    if (show_txt = "") {                                                        ; reload last diplayed txt 
        txt_file := GC("CB_last_display", "help.txt")
        if (txt_file = "help.txt")
            title := CB_Title_ID title_text suffix l txt_file
    } else {                                    
        txt_file := show_txt 
        IniWrite, %txt_file%, %config_path%, %A_ComputerName%, CB_last_display
        title := CB_Title_ID title_text suffix l txt_file RetrieveExt(A_ScriptDir "\mem_cache\" txt_file)
    }
    
    txt  := AccessCache(txt_file,, False)
    rows := countrows(txt)
    rows := (rows < 2) ? 2 : (rows > 30) ? 30 : rows


    Gui, 2: Margin, 2, 2
    wrap := wrap_txt ? "+Wrap" : ""
    Gui, 2: Add, Edit, section x5 %wdth% R%rows% %wrap% HScroll VScroll ReadOnly -WantReturn -E0x200 vCB_Display         ; https://www.autohotkey.com/boards/viewtopic.php?f=5&t=16964
    if display {
        Guicontrol, ,CB_Display, %txt%
        Gui, 2: font ,s%fsz% c000000, %fnt%
    }

    ; input_txt := % (input_txt = "!") ? GC("last_user_input") : input_txt        ; determines what is pre-entered in the input box
    
    if (!display) {
        Guicontrol, ,CB_Display, %A_space%
        Gui, 2: Font, c%t_color%
        Gui, 2: Color,,%w_color% 
    }
        
    CtrX    := (SubStr(wdth, 2) - IBwidth) // 2
    Gui, 2: Add, Edit, x%CtrX% w%IBwidth% r1 vUserInput, %input_txt% 
    Gui, 2: Add, Button, Default Hidden x0 y0 gEnter_Button                     ; Gui, 2: Add, Button, ys h35 x+5 w80 Default gEnter_Button, Enter ;
    

    Gui, 2: +LastFound
    CB_hwnd  := WinExist() 
    CC("CB_hwnd", CB_hwnd)

    if !GC("CB_ScrollBars", 0)
        GuiControl, 2: -HScroll -VScroll, CB_Display                            ; remove scrollbars before the GUI draw command
    
    Gui, 2: show, hide AutoSize,%title%
    if GC("CB_appActive", 0)
        Gui, Show, %CB_position% NoActivate
    else    
        Gui, Show, %CB_position% Restore
    
    MouseMove, StartX, StartY
    BlockInput, MouseMoveOff
    if (!GC("CB_appActive", 0))
        GuiControl, Focus, UserInput 
    if GC("CB_appActive", 0) 
        ActivateWin("ahk_id " tgt_hwnd) 
    return
   
    2GuiSize: 
        If A_EventInfo = 1                                                      ; window has been minimized.  No action needed.
            Return
        AutoXYWH("wh*", "CB_Display")
        CtrXpos := (A_GuiWidth - GC("CB_InputBox_width")) // 2
        GuiControl, MoveDraw, UserInput, x%CtrXpos%
        AutoXYWH("y*", "UserInput")
        GuiControl, 2: -HScroll -VScroll, CB_Display
        Gui, 2: show
        settimer, InvisibleScrollbar,-400
        gosub, save_win_coord
        Return

    InvisibleScrollbar:                                                         ; hack to create invisible scroll bars 
        GuiControl, 2: +HScroll +VScroll, CB_Display                            ; adds invisible scroll bar using settimer with > 200 ms delay after drawing a GUI with no scrollbars
        return
        
    2GuiEscape:
    2GuiClose:
        Gui, 2: +LastFound
        gosub, save_win_coord
        Gui, 2: destroy
        exit

    Enter_Button:
        Gui, 2: Submit, Hide
        leave_CB_open := ""
        CC("last_user_input", UserInput)                                        ; store key history
        GuiControl, 2:, UserInput,
        if GC("CB_hist",0)
            FileAppend,% "`n" UserInput, %A_ScriptDir%\mem_cache\_hist.txt 
        if !IsFunc(ProcessMod) 
            afterExecution := ProcessCommand(UserInput, suffix, title, fsz, fnt, w_color, w_color)
        else 
            afterExecution := %ProcessMod%(UserInput, suffix, title, fsz, fnt, w_color, t_color)
        
        afterExecution := (GC("CB_persistent", 0) = 1) ? 2 : afterExecution

        switch afterExecution
        {
            case "1": 
                ldspl := GC("CB_last_display")
            case "2": 
                goto, redrawGUI
            default:
                goto, 2GuiClose
        }
        return
                                                            
    save_win_coord:
        WinGetPos(CB_hwnd, x, y, w, h, 1)
        if (h > 0) 
            CC("CB_position", "x" x " y" y " w" w " h" h)
        else {
            MI := StrSplit(GetMonInfo()," ")                                    ; get monitor dimensions
            d := "x" MI[3] // 2 " y0 w" MI[3] // 2 " h" MI[4] // 2
            CC("CB_position", d)
        } 
        return


 }


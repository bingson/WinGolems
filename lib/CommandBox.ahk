 CommandBox(suffix = "" , byref w_color = "F6F7F1", t_color = "000000", ProcessMod = "ProcessCommand"
            , fwt = "500", show_txt = "", title = "",  input_txt = "") {

  ; SAVE INITIALIZATION SETTINGS TO CONFIG.INI -- -- -- -- -- -- -- -- -- -- 
    ; CoordMode, Mouse, Screen
    ; BlockInput, MouseMove
    ; settimer, BlockInputTimeOut,-300
    ; MouseGetPos, StartX, StartY

    global long, med, short, C, config_path, CB_Display := ""
        , UserInput := "", tgt_hwnd := "", CB_hwnd := ""
    static PArr := [], ro := -1                                                  ; search position array
    tgt_hwnd := WinExist()                                                      ; save window ID of active application when CB was called (tgt window to act upon) 

    CC("CB_sfx", suffix)    , CC("TGT_hwnd",tgt_hwnd) 
    CC("CBw_color",w_color) , CC("CBt_color",t_color)                           ;(1) save/store command box calling parameters in config.ini
    CC("CB_ProcessMod", ProcessMod)                                             ; config.ini used to preserve/change CB parameter information between redraws

    ChangeFont := RegisterCallback("ChangeFont")
  
  ; RETRIEVE SETTINGS FROM CONFIG.INI -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    redrawGUI:

    Gui, 2: +LastFound
    Gui, 2: Destroy          
    
    suffix  := GC("CB_sfx")            , tgt_hwnd := GC("TGT_hwnd")
    w_color := GC("CBw_color")         , t_color  := GC("CBt_color")
    fnt     := GC("CBfnt", "Consolas") , fsz      := GC("CBfsz", "10")
    fwt     := GC("CBfwt", "500")               

  ; VALIDATE GUI DIMENSIONS -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
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

  ; BUILD TITLE BAR -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    UserInput := ""
    winget, Process_Name, ProcessName, A                                        ;(3) build title bar
    CC("CB_tgtExe", Process_Name)
    l := "  |  ", s := "  "                                                 
    FormatTime, MyTime,, hh:mm tt               
    CB_Title_ID := s MyTime l                                                   ; CB_Title_ID2 := s "(-(-_(-_-)_-)-)" s "COMMAND BOX" l       
    
    title_text := Capitalize1stLetter(Process_Name,0, 0)
    ldspl .= RetrieveExt(A_ScriptDir "\mem_cache\" ldspl)                       ; last display  
    ndspl := GC("CB_title")                                                     ; new display (if new file was loaded) 
    title := CB_Title_ID title_text suffix l (ndspl ? ndspl : ldspl) 
    CC("CBtitle",title)
    
  ; SET GUI OPTIONS -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- - 
    Gui, 2: New                                                                 
    Gui, 2: +LastFound +OwnDialogs +Owner +E0x00200 -DPIscale +AlwaysOnTop +Resize     ; +E0x08000000 
    Gui, 2: Color, %w_color%
    Gui, font, c%t_color% s%fsz% w%fwt%, %fnt%
    
    if (!title_state) 
        Gui, 2: -Caption
    else 
        Gui, 2: +Caption

  ; ADD GUI CONTROLS -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    
    ; BUILD TEXT DISPLAY BOX ... ... ... ... ... ... ... ... ... ... ... ... ... 
    if (show_txt = "") {                                                        ; reload last diplayed txt                                  
        txt_file := GC("CB_last_display", "help.txt")
        if (txt_file = "help.txt")
            title := CB_Title_ID title_text suffix l txt_file
    } else {                                    
        txt_file := show_txt 
        IniWrite, %txt_file%, %config_path%, %A_ComputerName%, CB_last_display
        title := CB_Title_ID title_text suffix l txt_file RetrieveExt(A_ScriptDir "\mem_cache\" txt_file)
    }

    switch ndspl 
    {
        case "First Line of 0-9.txt": 
            txt := GetNumMemLines()
            ; msgbox % GetNumMemLines()
        case    "Clipboard Contents": txt := Clipboard
        default:                      txt := AccessCache(txt_file,, False)
    }

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

    ; build GUI controls ... ... ... ... ... ... ... ... ... ... ... ... ... ... 
    CtrX    := (SubStr(wdth, 2) - IBwidth) // 2
    Gui, 2: Add, Edit, x%CtrX% w%IBwidth% r1 vUserInput, %input_txt% 
    Gui, 2: Add, Button, Default Hidden gEnter_Button                           ; Gui, 2: Add, Button, ys h35 x+5 w80 Default gEnter_Button, Enter  ;Gui, 2: Add, Button, Default Hidden x0 y0 gEnter_Button
    Gui  2: Add, Button, Hidden gSearch_button, &n
    Gui  2: Add, Button, Hidden gReverseSearch_button, &p

  ; DRAW GUI -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    Gui, 2: +LastFound
    CB_hwnd  := WinExist()                                                      ; save window handle of Command Box 
    CC("CB_hwnd", CB_hwnd)

    if !GC("CB_ScrollBars", 0)
        GuiControl, 2: -HScroll -VScroll, CB_Display                            ; remove scrollbars before the GUI draw command

    Gui, 2: show, hide AutoSize,%title%
    if GC("CB_appActive", 0)
        Gui, Show, %CB_position% NoActivate
    else    
        Gui, Show, %CB_position% Restore
    
    ; MouseMove, StartX, StartY
    ; BlockInput, MouseMoveOff
    
    if (!GC("CB_appActive", 0))
        GuiControl, Focus, UserInput 
    if GC("CB_appActive", 0) 
        ActivateWin("ahk_id " tgt_hwnd) 
    return
  
  ; LABELS -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
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

    InvisibleScrollbar:                                                         ; hides the scroll bar only if settimer with > 200 ms delay
        GuiControl, 2: +HScroll +VScroll, CB_Display
        return
        
    2GuiEscape:
    2GuiClose:
        Gui, 2: +LastFound
        gosub, save_win_coord
        Gui, 2: destroy
        exit

    ReverseSearch_button:
        Gui, 2: Submit, Nohide
        if (UserInput != lastFind) 
        {
            PArr := []
            CC("CB_LastSrchPos","")
        }
        GuiControl 2:Focus, CB_Display                                          ; focus on main help window to show selection                               
        
        SrchArrPos := HasVal(PArr, GC("CB_LastSrchPos"))
        if (PArr.MaxIndex() <= 1) or (HasVal(PArr, GC("CB_LastSrchPos")) <= 1) {
            pos := JEE_InStrEx(CB_display, userinput, 0, -strlen(userinput) , ro) - 1
        } else {
            pos := PArr[(SrchArrPos - 1)]
        }
        StringLeft __s, CB_Display, %pos%                                       ; cut off end to count lines                        
        StringReplace __s,__s,`n,`n,UseErrorLevel                               ; Errorlevel <- line number           
        addToPos=%Errorlevel%
        SendMessage 0xB6, 0, ErrorLevel, Edit1, ahk_id %CB_hwnd%                ; Scroll to visible                                    
        SendMessage 0xB1, pos + addToPos, pos + addToPos + Strlen(UserInput), Edit1, ahk_id %CB_hwnd%     ; Select search text
        SendMessage, EM_SCROLLCARET := 0xB7, 0, 0, Edit1, ahk_id %CB_hwnd%      ; Scroll the caret into view in an edit
        offset := pos - Strlen(UserInput)
        if ((HasVal(PArr, pos) = 0) and (pos > 0) and addToPos) {
            PArr.Push(pos)
            writetocache("1f", , ,  "`n pos: " pos " addToPos: "  addToPos, 1,1)
        }
        ro--
        Gui, 2: Show, , % GC("CBtitle") "  |  line: " . addToPos + 1 . "  (" . PArr.MaxIndex() . (PArr.MaxIndex() = 1 ? " hit" : " hits") . ")"
        CC("CB_LastSrchPos", pos)
        return

    Search_button: 
        Gui, 2: Submit, Nohide
        if (UserInput != lastFind) 
        {
            PArr := []
            CC("CB_LastSrchPos","")
            offset = 0
        }
        GuiControl 2:Focus, CB_Display                                          ; focus on main help window to show selection                               
        SendMessage 0xB6, 0, -999, Edit1, ahk_id %CB_hwnd%                      ; Scroll to top     
        StringGetPos pos, CB_Display, %UserInput% ,,offset                      ; find the position of the search string        
            
        if (pos = -1)
        {
            if (offset = 0) 
            {
                Gui, 2: Show, , % GC("CBtitle") "  |  '" . UserInput . "' not found"
                return
            }
            else 
            {
                Gui, 2: Show, , % GC("CBtitle") "  |  No more occurrences" . "  (" . PArr.MaxIndex() . (PArr.MaxIndex() = 1 ? " hit" : " hits") . ")1"
                pos := PArr[1]
            }
        }
        if (pos = GC("CB_LastSrchPos")) and (PArr.MaxIndex() > 1)
        {
            SrchArrPos := HasVal(PArr, GC("CB_LastSrchPos")) + 1
            pos := PArr[SrchArrPos]
        }

        StringLeft __s, CB_Display, %pos%                                       ; cut off end to count lines                        
        StringReplace __s,__s,`n,`n,UseErrorLevel                               ; Errorlevel <- line number           
        addToPos=%Errorlevel%
        SendMessage 0xB6, 0, ErrorLevel, Edit1, ahk_id %CB_hwnd%                ; Scroll to visible                                    
        SendMessage 0xB1, pos + addToPos, pos + addToPos + Strlen(UserInput), Edit1, ahk_id %CB_hwnd%     ; Select search text
        SendMessage, EM_SCROLLCARET := 0xB7, 0, 0, Edit1, ahk_id %CB_hwnd%      ; Scroll the caret into view in an edit
        
        offset := pos + Strlen(UserInput)
        lastFind = %UserInput%
        
        if ((HasVal(PArr, pos) = 0) and (pos > 0) and addToPos) {
            writetocache("1f", , ,  "`n pos: " pos " addToPos: "  addToPos, 1,1)
            PArr.Push(pos)
        } 


        Gui, 2: Show, , % GC("CBtitle") "  |  line: " . addToPos + 1 . "  (" . PArr.MaxIndex() . (PArr.MaxIndex() = 1 ? " hit" : " hits") . ")"
        CC("CB_LastSrchPos", pos)
        Return

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

/* editbox width research
https://www.autohotkey.com/boards/viewtopic.php?t=67650

*/

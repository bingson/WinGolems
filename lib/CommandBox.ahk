CommandBox(suffix = "" , byref w_color = "F6F7F1", t_color = "000000", ProcessMod = "ProcessCommand" , fwt = "500", show_txt = "", title = "",  input_txt = "?") {
  ; BUFFER KEYSTROKES AND SPEED UP GUI LOADING -- -- -- -- -- -- -- -- -- -- -- 

    W("lw") ; wait for lwin key up
    SetBatchLines, -1
    SetkeyDelay, -1
    SetWinDelay, -1
    Process, Priority,, High

    ; BufferKeystrokes() 
    ; BlockInput, Mousemove
    ; ReleaseModifiers()
    ;timecode()
  ; SAVE GUI INITIALIZATION SETTINGS TO CONFIG.INI -- -- -- -- -- -- -- -- -- --; saves information between script reloads. 


    global long, med, short, C, config_path, UserInput := "", tgt_hwnd := "", CB_hwnd := "", input_buffer, CB_DisplayVar
    static PArr := []                                                           ; search position array                                                
    
    tgt_hwnd := WinExist("A")                                                      ; save window ID of active application when CB was called (tgt window to act upon) s
    WinGetPos, X, Y, W, H, A  ; "A" to get the active window's pos.
    CC("CB_sfx", suffix) , CC("TGT_hwnd",tgt_hwnd) 
    CC("CB_clr",w_color) , CC("CBt_color",t_color)                              ;(1) save/store command box calling parameters in config.ini
    CC("CB_ProcessMod", ProcessMod)                                             ; config.ini used to preserve/change CB parameter information between redraws
    
    ; ChangeFont := RegisterCallback("ChangeFont")
  
  ; RETRIEVE SETTINGS FROM CONFIG.INI -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    
    suffix  := GC("CB_sfx")            , tgt_hwnd := GC("TGT_hwnd")
    w_color := GC("CB_clr")            , t_color  := GC("CBt_color")
    fnt     := GC("CBfnt", "Consolas") , fsz      := GC("CBfsz", "10")
    fwt     := GC("CBfwt", "500")           

    display  := GC("CB_Display",1) , title_state := GC("CB_Titlebar",1)         ;(2a) get other CB window data
    wrap_txt := GC("CB_Wrap",0)    , ldspl       := GC("CB_last_display")
    

  ; VALIDATE GUI DIMENSIONS -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 


    MI := StrSplit(GetMonInfo()," ")                                            ; get monitor dimensions
    hh := MI[4]*.455
    hw := MI[3]*.495
    d := "x" MI[1]+hw " y" MI[2]+hh " w" hw " h" hh                             ;(2) calc default window dimensions to load when saved position data is not valid
    
    CB_position := GC("CB_position", d)
    WP := StrSplit(CB_position, " ")
    SysGet, mcount, MonitorCount
    
    if (WP[4] < 10) OR (mcount != GC("CB_MntrCnt")) {    
       CB_position := d
    }
    wdth := WP[3]

    
  ; BUILD TITLE BAR -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    UserInput := ""
    winget, Process_Name, ProcessName, A                                        ;(3) build title bar
    CC("CB_tgtExe", Process_Name)
    l := " | ", s := "  "                                                 

    txt := GetLastDisplayedText(GC("CB_last_display"))                                          
    title_text := Capitalize1stLetter(Process_Name,0, 0)
    ldspl := GC("CB_last_display")
    ldspl .= RetrieveExt(A_ScriptDir "\mem_cache\" ldspl)                       ; last display  
    GUIoptn := GetCurrentGUIoptions()

    title := title_text suffix "  |  " GUIoptn ldspl 
    ; title := RegExReplace(title, "S) +", A_Space A_Space)
    CC("CBtitle",title)
    
  ; SET GUI OPTIONS -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- - 
    OnTop := GC("CB_alwaysOnTop",0) ? "+AlwaysOnTop" : ""
    ClickablebutNoActive := "+E0x08000000"
    
    Gui, 2: New                                                                 
    Gui, 2: +LastFound +OwnDialogs +Owner +Resize %OnTop% ; +E0x00200 +E0x08000000 
    ; Gui, 2: +LastFound +OwnDialogs +Owner +E0x00200 +Resize %ClickablebutNoActive% %ES_NOHIDESEL% %OnTop%
    Gui, 2: Color, %w_color%
    Gui, 2: font, c%t_color% s%fsz% w%fwt%, %fnt%
    
    if (!title_state) 
        Gui, 2: -Caption
    else 
        Gui, 2: +Caption

  ; ADD GUI INTERFACE ELEMENTS -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
   ; BUILD TEXT DISPLAY BOX ... ... ... ... ... ... ... ... ... ... ... ... ... 
    if (show_txt = "") {                                                        ; reload last diplayed txt
        txt_file := GC("CB_last_display", "help.txt")
        txt_file := RegExReplace(txt_file, "\[.+?\]")                           ; removes any text surrounded by square brackets 
    } else {                                    
        txt_file := show_txt
        CC("CB_last_display", show_txt)
    }
    
    ES_NOHIDESEL := 0x100	; don't hide selection when GUI not active https://www.autohotkey.com/docs/misc/Styles.htm
    setCaretWidth(9)  

    Gui, 2: Margin, 2, 2
    rows := (rows < 2) ? 2 : (rows > 30) ? 30 : rows
    wrap := wrap_txt ? "+Wrap" : ""
    Gui, 2: Add, Edit, section %wdth% R%rows% %wrap% HScroll VScroll %ES_NOHIDESEL% ReadOnly -WantReturn -E0x200 vCB_DisplayVar ;hwndDisplay         ; hwndhDisplay https://www.autohotkey.com/boards/viewtopic.php?f=5&t=16964
    
    if display {
        Gui, 2: font ,s%fsz% c000000, %fnt%
    }
    
    if (!display) {
        Gui, 2: Margin, 2, 2
        Guicontrol,2: ,CB_DisplayVar, %A_space%
        Gui, 2: Font, c%t_color%
        Gui, 2: Color,,%w_color% 
    }

   ; BUILD GUI CONTROLS ... ... ... ... ... ... ... ... ... ... ... ... ... ... 

    backColor := 0xFDFCA3
    input_txt := % GC("CB_reenterInput", 0) ? GC("last_user_input") : ""        ; determines what is pre-entered in the input box
    Gui, 2: Add, Edit, section wp r1 vUserInput hwndHED, %input_txt% 
    SetFocusedBkColor(HED, BackColor), OnMessage(0x0133, "SetFocusedBkColor")   ; highlight userinput edit box when focussed
    Gui, 2: Add, Button, Default Hidden gEnter_Button                           ; Gui, 2: Add, Button, ys h35 x+5 w80 Default gEnter_Button, Enter  ;Gui, 2: Add, Button, Default Hidden x0 y0 gEnter_Button
    Gui  2: Add, Button, Hidden gSearch_button, &n
    Gui  2: Add, Button, Hidden gReverseSearch_button, &p

  ; DRAW GUI -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    Gui, 2: +LastFound
    
    CB_hwnd  := WinExist()                                                      ; save window handle of Commandbuffer Box 
    CC("CB_hwnd", CB_hwnd)

    if !GC("CB_ScrollBars", 0)
        GuiControl, 2: -HScroll -VScroll,  CB_DisplayVar                            ; remove scrollbars before the GUI draw command
        ; GuiControl, 2: -HScroll -VScroll,  % "ahk_id " hDisplay                            ; remove scrollbars before the GUI draw command
    Gui, 2: -DPIScale
    Gui, 2: show, hide AutoSize,%title%
    Gui, 2: Show, % CB_position . ((GC("CB_appActive", 0)) ? (" NoActivate") : (" Restore"))
    GuiControl, 2:, CB_DisplayVar, %txt%
    ; SendMessage,0x00B1,-1,0,, % "ahk_id " CB_Display ; EM_SETSEL=0x00B1

    ; GuiControl, 2: Focus, UserInput 
    if GC("CB_appActive", 0) {
        ActivateApp(GC("CB_tgtExe"))
    } 
    ;timecode()
    /*
    */

    SetWinDelay, 10
    SetBatchLines, 10ms
    SetKeyDelay, 10, 50
    Process, Priority, , A
    ; BlockInput, MousemoveOff
    ; BlockInput OFF
    ; WinWaitClose
    return
  
  ; LABELS -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

    2GuiSize: 
        If A_EventInfo = 1                                                      ; window has been minimized.  No action needed.
            Return
        AutoXYWH("wh*", "CB_DisplayVar")
        CtrXpos := substr(WP[1],2) 
        AutoXYWH("yw*", "UserInput")
        GuiControl, MoveDraw, UserInput
        if !GC("CB_ScrollBars", 0)
            GuiControl, 2: -HScroll -VScroll, CB_DisplayVar
        Gui, 2: show
        settimer, addHiddenScrollBar,-400
        settimer, save_win_coord,-300
        Return
        
    2GuiEscape:
    2GuiClose:
        Gui, 2: +LastFound 
        gosub, save_win_coord
        Gui, 2: cancel
        CC("CB_hist_counter",0)
        exit

    ReverseSearch_button:
        Gui, 2: Submit, Nohide
        if (UserInput != lastFind) 
        {
            PArr := []
            CC("CB_LastSrchPos","")
        }
        GuiControl 2:Focus, CB_DisplayVar                                          ; focus on main help window to show selection                               
        
        SrchArrPos := HasVal(PArr, GC("CB_LastSrchPos"))
        if (PArr.MaxIndex() <= 1) or (HasVal(PArr, GC("CB_LastSrchPos")) <= 1) {
            pos := JEE_InStrEx(CB_displayVar, userinput, 0, -strlen(userinput) , ro) - 1
        } else {
            pos := PArr[(SrchArrPos - 1)]
        }
        StringLeft __s, CB_DisplayVar, %pos%                                       ; cut off end to count lines                        
        StringReplace __s,__s,`n,`n,UseErrorLevel                               ; Errorlevel <- line number           
        addToPos=%Errorlevel%
        SendMessage 0xB6, 0, ErrorLevel, Edit1, ahk_id %CB_hwnd%                ; Scroll to visible                                    
        SendMessage 0xB1, pos + addToPos, pos + addToPos + Strlen(UserInput), Edit1, ahk_id %CB_hwnd%     ; Select search text
        SendMessage, EM_SCROLLCARET := 0xB7, 0, 0, Edit1, ahk_id %CB_hwnd%      ; Scroll the caret into view in an edit
        offset := pos - Strlen(UserInput)
        if ((HasVal(PArr, pos) = 0) and (pos > 0) and addToPos) {
            PArr.Push(pos)
        }
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
        GuiControl 2:Focus, CB_DisplayVar                                          ; focus on main help window to show selection                               
        SendMessage 0xB6, 0, -999, Edit1, ahk_id %CB_hwnd%                      ; Scroll to top     
        StringGetPos pos, CB_DisplayVar, %UserInput% ,,offset                      ; find the position of the search string        
            
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

        StringLeft __s, CB_DisplayVar, %pos%                                       ; cut off end to count lines                        
        StringReplace __s,__s,`n,`n,UseErrorLevel                               ; Errorlevel <- line number           
        addToPos=%Errorlevel%
        SendMessage 0xB6, 0, ErrorLevel, Edit1, ahk_id %CB_hwnd%                ; Scroll to visible                                    
        SendMessage 0xB1, pos + addToPos, pos + addToPos + Strlen(UserInput), Edit1, ahk_id %CB_hwnd%     ; Select search text
        SendMessage, EM_SCROLLCARET := 0xB7, 0, 0, Edit1, ahk_id %CB_hwnd%      ; Scroll the caret into view in an edit
        
        offset := pos + Strlen(UserInput)
        lastFind = %UserInput%
        
        if ((HasVal(PArr, pos) = 0) and (pos > 0) and addToPos) {
            PArr.Push(pos)
        } 


        Gui, 2: Show, , % GC("CBtitle") "  |  line: " . addToPos + 1 . "  (" . PArr.MaxIndex() . (PArr.MaxIndex() = 1 ? " hit" : " hits") . ")"
        CC("CB_LastSrchPos", pos)
        Return

    Enter_Button:
        CC("CB_hist_counter",0)
        Gui, 2: Submit, Hide
        GuiControl, 2:, UserInput,
        GC("CB_hist",1) ? FilePrepend(A_ScriptDir "\mem_cache\_hist.txt", UserInput) : ("")

        afterExecution := IsFunc(ProcessMod) 
                        ? %ProcessMod%(UserInput, suffix, title, fsz, fnt, w_color, t_color)
                        : ProcessCommand(UserInput, suffix, title, fsz, fnt, w_color, w_color)
        
        afterExecution := (GC("CB_persistent", 0) = 1) ? 2 : afterExecution
        switch afterExecution
        {
            case "1":  ;screen update occurs elsewhere 
                ldspl := GC("CB_last_display","list.txt") 
            case "2": 
                sleep, 0
            case "3": 
                goto, 2GuiClose
            default:
                sleep, 0
                ; Try {   
                ;     goto, redrawGUI
                ; } catch e {
                ;     return
                ; }
        }
        ; Gui, 2: Destroy
        return
                                                            
    save_win_coord:
        WinGetPos(CB_hwnd, x, y, w, h, 1)
        ; WinGetPos, x, y, w, h, A
        if (h > 0) {
            CC("CB_position", "x" x " y" y " w" w " h" h)
            CC("CB_MonIdx", GetCurrentMonitorIndex())
        } else {
            CC("CB_position", d)
        } 
        SysGet, mcount, MonitorCount
        CC("CB_MntrCnt", mcount)  ;monitor count
        return

}


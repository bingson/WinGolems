 CommandBox(suffix = "" , byref w_color = "F6F7F1", t_color = "000000", ProcessMod = "ProcessCommand"
    , fnt = "Consolas", fsz = "13", fwt = "500", show_txt = "", title = "",  input_txt = "!") {
    
    global long, med, short, C, config_path, CB_Display := ""
        , UserInput := "", TgtWinID := "", ghwnd := "", InputBox_width := "400"
    
    CC("CBw_color",w_color), CC("CBt_color",t_color)                            ;(1a) store color of called box
    TgtWinID := WinExist() , CC("CB_tgt_hwnd",TgtWinID)                         ;(1b) store win ID of active application before calling GUI 
    
    d := "x" A_ScreenWidth/2 " y0 w" A_ScreenWidth/2 " h" A_ScreenHeight/2      ;(2) calc default window dimensions to load when no saved position data found
    gui_position := GC("gui_position", d), display := GC("GUI_Display" , 1)     ;    GetConfig(section, default_value = "")
    title_state  := GC("GUI_Titlebar", 1), ldspl   := GC("CB_last_display")
    
    wdth := StrSplit(gui_position, " ")[3]

    Gui, 2: +LastFound
    Gui, 2: Destroy                                                             
    UserInput := ""
    redrawGUI:                                                                                
    winget, output, ProcessName, A                                              ;(3) build title bar                                     
    l := "    |    ", s := FillChar("4", " ", 0, 1)                                               
    CB_Title_ID := s "(-(-_(-_-)_-)-)" s "COMMAND BOX" l                      
    
    title_text := Capitalize1stLetter(output,0, 0)
    lastDisplay .= RetrieveExt(A_ScriptDir "\mem_cache\" ldspl)                           
    title := (title) ? title : CB_Title_ID title_text suffix l lastDisplay 

    Gui, 2: New, ,%title%                                                       ;(4) GUI options
    Gui, 2: +LastFound +Resize +OwnDialogs +AlwaysOnTop +Owner -DPIscale +E0x00200
    Gui, font, c%t_color% s%fsz% w%fwt%, %fnt%
    Gui, 2: Color, %w_color%
    
    ; if !GUI_Display
    ;     GuiControl, hide, CB_Display

    if (!title_state) 
        Gui, 2: -Caption
    else 
        Gui, 2: +Caption

    if (show_txt = "") {                                                        ; reload last diplayed txt 
        txt_file := GC("CB_last_display", "help.txt")
    } else {                                    
        txt_file := show_txt 
        IniWrite, %txt_file%, %config_path%, %A_ComputerName%, CB_last_display
        title := CB_Title_ID title_text suffix l txt_file RetrieveExt(A_ScriptDir "\mem_cache\" txt_file)
        Gui, 2: show, ,%title%
    }

    Try {                                                                       ;(5) load txt file into CB Display
        txt  := AccessCache(txt_file,, False)
        rows := countrows(txt)
        rows := (rows < 2) ? 2 : (rows > 30) ? 30 : rows
        Width := StringWidth(txt, fnt, fsz)
        Width := (Width < 200) ? 200 : (Width > 800) ? 800 : Width
        Gui, 2: Margin, 10, 10
        Gui, 2: Add, Edit, section x5 w%Width% R%rows% HScroll VScroll ReadOnly -WantReturn vCB_Display -E0x200         ; https://www.autohotkey.com/boards/viewtopic.php?f=5&t=16964
        Guicontrol, ,CB_Display, %txt%
    } 
    
    ; IniRead, last_submit, %config_path%, %A_ComputerName%, last_user_input, ""
    
    input_txt := % (input_txt = "!") ? GC("last_user_input") : input_txt                    ; determines what is pre-entered in the input box
    
    Gui, 2: Margin, 1, 1
    Gui, font ,s%fsz% c000000, %fnt%
    CtrXpos := (SubStr(wdth, 2) - InputBox_width) // 2
    Gui, 2: Add, Edit, x%CtrXpos% w%InputBox_width% vUserInput r1, %input_txt% 
    Gui, 2: Add, Button, Default Hidden x0 y0 gEnter_Button                     ; Gui, 2: Add, Button, ys h35 x+5 w80 Default gEnter_Button, Enter ; w1sdfdfsdfdf
    GuiControl, Focus, UserInput 
    Gui, 2: +LastFound 
    
    ghwnd  := WinExist()                                                       
    IniWrite, %ghwnd%, %config_path%, %A_ComputerName%, CB_GUI_hwnd
    GuiControl, MoveDraw, CB_Display, %wdth%     
    ; IniRead, ScrollBars, %config_path%, %A_ComputerName%, GUI_ScrollBars, 0

    

    if !GC("GUI_ScrollBars", 0)
        GuiControl, 2: -HScroll -VScroll, CB_Display                            ; remove scrollbars before the GUI draw command
    
    if (!display) 
    {
        ; GuiControl, 2: -HScroll -VScroll, CB_Display 
        ; WinSet, TransColor,% w_color
        ; WinSet, TransColor,% t_color
        WinSet, TransColor,% w_color
        GuiControl, hide, CB_Display
        ; WinMove,A,, x, y, w, h
        Gui, 2: show, hide autosize

        GC("MonDim") 
        n := GetCurrentMonitorIndex()
        coords := GC("MonDim" n, d)
        ; coords  
        Gui, 2: show, 
        ; WinMaximize, ahk_id %ghwnd%

    } 
    else
    {
        Gui, 2: show, hide AutoSize 
        Gui, 2: show, %gui_position%
        GuiControl, 2: +HScroll +VScroll, CB_Display                                ; add scroll bars back without redrawing them to add scrolling without visible scroll bars
    }
    
    sendinput {home}+{end}
    WinWaitClose                                                                
    return

    2GuiSize: 
        If A_EventInfo = 1                                                      ; window has been minimized.  No action needed.
            Return

        gosub, save_win_coord
        ; sleep 100
        CtrXpos := (A_GuiWidth - InputBox_width) // 2
        AutoXYWH("wh", "CB_Display"), AutoXYWH("y", "UserInput")
        GuiControl, MoveDraw, UserInput, x%CtrXpos%
        GuiControl, 2: -HScroll -VScroll, CB_Display
        Gui, 2: show, hide AutoSize 
        Gui, 2: show
        GuiControl, 2: +HScroll +VScroll, CB_Display
        Return

    2GuiEscape:
    2GuiClose:
        gosub, save_win_coord
        Gui 2: Destroy
        Exit 
    
    Enter_Button:
        gosub, save_win_coord
        Gui, 2: +LastFound
        Gui, 2: Submit, Hide
        leave_GUI_open := ""
        CC("last_user_input", UserInput)                                        ; store key history
        FileAppend,% "`n" UserInput, %A_ScriptDir%\mem_cache\b\_hist.txt 
        If !IsFunc(ProcessMod) 
            leave_GUI_open := ProcessCommand(UserInput, suffix, title, fsz, fnt, w_color, w_color)
        else 
            leave_GUI_open := %ProcessMod%(UserInput, suffix, title, fsz, fnt, w_color, t_color)

        if (GC("GUI_Display", 1) = 0)                                           ; docked CB mode (
            goto, redrawGUI
        else if (!leave_GUI_open) 
        {
            Gui, 2: Destroy
            Exit 
        }
        input_txt := UserInput
        goto, redrawGUI
        return
                                                             ; 
    save_win_coord:
        WinGetPos(ghwnd, x, y, w, h, 1)
        CC("gui_position", "x" x " y"y " w"w " h"h)
        return

 }


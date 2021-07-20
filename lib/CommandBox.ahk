 CommandBox(suffix = "" , w_color = "F6F7F1", t_color = "000000", ProcessMod = "ProcessCommand", show_txt = "" 
    , title = "", fsz = "13.5", fnt = "Consolas", input_txt = "") {

    global long, med, short, lgreen, config_path, CB_Display := "", UserInput := "", TgtWinID := ""
    
    TgtWinID := WinExist()                                                      ; store win ID of active application before calling GUI 
    IniWrite, %TgtWinID%, %config_path%, %A_ComputerName%, CB_tgt_hwnd
    
    Gui, 2: +LastFound
    Gui, 2: Destroy                                                             ; Gui, 2: +LastFound
    UserInput := ""
    
    winget, output, ProcessName, A                                              ;
    l := "    |    "                                                            ;
    s := FillChar("5", " ", 0, 1)                                               ;
    CB_Title_ID := s . "(-(-_(-_-)_-)-)" s "COMMAND BOX" l                      ;
    IniRead, out, %config_path%, %A_ComputerName%, CB_last_display, ""          ;
    title_text := EveryFirstLetterCapitalized(output,0, True)                   ;
    title := (title) ? title : CB_Title_ID title_text suffix l out . ".txt"     ;
    Gui, 2: New, ,%title%

    Gui, 2: +LastFound -dpiscale +Resize +MinSize200x80 +OwnDialogs +AlwaysOnTop 
    
    Gui, font ,s%fsz% c%t_color% ,%fnt%

    if (show_txt = "") 
    {
        IniRead, txt_file, %config_path%, %A_ComputerName%, CB_last_display, ""
        if (txt_file == "") or 
        {
            IniWrite, help, %config_path%, %A_ComputerName%, CB_last_display
            txt_file := "help"
            title := CB_Title_ID title_text suffix l "help.txt"
        }
    } 
    else 
    {                                    
        txt_file := show_txt 
        IniWrite, %txt_file%, %config_path%, %A_ComputerName%, CB_last_display
        title := CB_Title_ID title_text suffix l txt_file ".txt"
        Gui, 2: show, ,%title%
    }

    Try {
        txt  := AccessCache(txt_file,, False)
        rows := countrows(txt)
        rows := (rows < 2) ? 2 : (rows > 30) ? 30 : rows
        Width := StringWidth(txt, fnt, fsz)
        Width := (Width < 200) ? 200 : (Width > 800) ? 800 : Width
        Gui, 2: Margin, 10, 10
        Gui, 2: Add, Edit, section x5 w%Width% R%rows% HScroll VScroll ReadOnly vCB_Display         ; https://www.autohotkey.com/boards/viewtopic.php?f=5&t=16964
        Guicontrol, ,CB_Display, %txt%
    } 


    IniRead, last_submit, %config_path%, %A_ComputerName%, last_user_input, ""
    input_txt := !input_txt ? last_submit : input_txt
    Gui, font ,s%fsz% c000000 ,%fnt%
    Gui, 2: Add, Edit, section w450 h35 vUserInput, %input_txt%
    fsb := fsz - 2
    Gui, font ,s%fsb% c000000, Segoe UI
    Gui, 2: Add, Button, ys h35 x+5 w100 Default gEnter_Button, Enter
    Gui, 2: Color, %w_color%
    GuiControl, Focus, UserInput 
    Gui, 2: +LastFound 
    hwnd  := WinExist()
    IniWrite, %hwnd%, %config_path%, %A_ComputerName%, CB_GUI_hwnd
    IniRead, gui_position, %config_path%, %A_ComputerName%, gui_position, "x534 y273 w766 h569"
    wdth := StrSplit(gui_position, " ")[3]
    GuiControl, MoveDraw, CB_Display, %wdth%                                        
    ; GuiControl, MoveDraw, UserInput, h35                                            
    ; GuiControl, MoveDraw, Enter_Button, h35                                         
    Gui, 2: show, hide AutoSize
    Gui, 2: show, %gui_position%
    sendinput {home}+{end}
    WinWaitClose                                                                
    return

    2GuiSize: 
        If A_EventInfo = 1                                                      ; window has been minimized.  No action needed.
            Return
        AutoXYWH("wh", "CB_Display")
        AutoXYWH("y", "UserInput", "Enter")
        Return

    2GuiEscape:
    2GuiClose:
    2Cancel_Button:
        gosub, save_win_coord
        Gui 2: Destroy
        Exit 

    Enter_Button:
        gosub, save_win_coord
        Gui, 2: +LastFound
        Gui, 2: Submit, Hide
        leave_GUI_open := ""
        IniWrite, %UserInput%, %config_path%, %A_ComputerName%, last_user_input
        
        If !IsFunc(ProcessMod) 
            leave_GUI_open := ProcessCommand(UserInput, suffix, title, fsz, fnt, w_color, t_color)
        else 
            leave_GUI_open := %ProcessMod%(UserInput, suffix, title, fsz, fnt, w_color, t_color)
        sleep 200
        if (!leave_GUI_open)
            Gui, 2: Destroy
        return                                                                  ; 
    
    save_win_coord:
        WinGetPos(hwnd, x, y, w, h, 1)
        IniWrite, x%x% y%y% w%w% h%h%, %config_path%, %A_ComputerName%, gui_position
        return

 }


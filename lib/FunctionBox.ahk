
FunctionBox(func="", input_dict="", w_color = "CEDFBF", t_color = "000000", name_dict = "", grps = 0, title="", p*) {
 
    ; opens an input box offering choices based on input_dict variadic
    ; dictionary, name_dict(optional) will replace labels Programmatically generated
    ; from input_dict.
    ;
    ; func: calls a function that accepts values from the input array
    
    ; the value of input_dict will be treated as a parameter to that function. 

    global UserInput, med, config_path
    
    sleep ,med                                                                  ; short wait to delete hotstring
    TOC := (name_dict) ? BuildTOC(name_dict, grps) : BuildTOC(input_dict)
    default_title := (!title) ? AddSpaceBtnCaseChange(func, 0) : title
    default_title .= "  (-_-)  "                                                ; l := "    |    " 
    winget, output, ProcessName, A    
    title_app := Capitalize1stLetter(output,0, True)
    default_title := title_app "  " default_title
    
    ; IniWrite, %FB_tgt_hwnd%, %config_path%, %A_ComputerName%, FB_tgt_hwnd
    FB_tgt_hwnd := WinExist("A")                                                  ; store win ID of active application before calling GUI 
    
    FunctionBoxGUI(TOC, default_title, w_color, t_color) 
    
    ; Iniread, tgt_winID, %config_path%, %A_ComputerName%, FB_tgt_hwnd
    ActivateWin("ahk_id " FB_tgt_hwnd)
    UserInput := trim(UserInput)
    if (func and input_dict[UserInput]) {
        if !(p.MaxIndex() > 0) 
            %func%(input_dict[UserInput])
        else 
            %func%(input_dict[UserInput], p*)
    } else if (!func and input_dict[UserInput]) {
        try 
        {
            command := input_dict[UserInput]
            %command%.call()
        }
    } else if UserInput                                                         
        FunctionBox(func,input_dict, w_color, t_color, title, name_dict)
    else
    return
}
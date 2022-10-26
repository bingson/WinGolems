ProcessCommand(UserInput, suffix = "", title = "", fsz = "", fnt = "", w_color = "", t_color = "") {
    global config_path, long, med, short, tgt_hwnd, CB_hwnd, C
    1stChar := SubStr(UserInput, 1, 1)

    suffix := suffix ? suffix : GC("CB_sfx", "~win")
    w_color := w_color ? w_color : GC("CB_clr")
    t_color := t_color ? t_color : GC("CBt_color")
    
    sleep, 50
    ; msgbox % userinput
    if (1stChar ~= "[\\\.\,>0-9A-Z\?jk:\[\]\{\}\;]") {                                    ; equivalent to: if RegExMatch(1stChar,"[0-9A-Z\?jk:]") 

        ; substitute period|comma alias
        if (UserInput ~= "^(?>[OALVCDP])(>|\|)?(\.|\,|\;|\[|\]|\{|\})(\S.*)?$|( )(\.|\,|\;|\[|\]|\{|\})(\S*)$") {
            if instr(UserInput,":") {
                dPos        := InStr(UserInput, ":")
                text_to_add := substr(UserInput, dPos+1)
                UserInput   := substr(UserInput, 1, dPos)
                UserInput   := ReplaceAlias(UserInput)
                UserInput   := UserInput . text_to_add
            } else {
                UserInput := strReplace(UserInput, ".txt")
                UserInput := ReplaceAlias(UserInput)
            }
        } 
        sleep, 100
        C_input := SubStr(UserInput, 2)                                         ; everything after the first character
        SplitPath, C_input, FileName, Dir, Extension, NameNoExt                 ; parses everything after the command character as a file path 
        dir := dir ? dir . "\" : ""
        2ndChar := SubStr(UserInput, 2 , 1)
        f_path := A_ScriptDir "\mem_cache\" 
        ((substr(UserInput,0) = "~") or !UserInput) ? ("") : CC("last_user_input", trim(UserInput))   ; store key history, except keys ending in "~" (shutdown related)    
        
        sleep, 100

        Switch 1stChar                                                          ; free: h,i,u,x,y
        { 
            Case 1,2,3,4,5,6,7,8,9,0:
                if (UserInput ~= "^(\d)$") {
                    NameNoExt := 1stChar
                    C_input := 1stChar
                    txt  := AccessCache(NameNoExt,dir, False)  
                    txt := !txt ? "-empty-" : txt 
                    UpdateGUI(txt,dir NameNoExt ".txt") 
                } else {
                    RunLinkFn(C_input, 1stChar)
                }
            Case ".",",","'",";","[","]","{","}":
                C2_Remainder := substr(C_input,1)
                Switch 1stChar
                {   
                    case ".": CC("PeriodAlias", C2_Remainder),    PU(". alias set to: " C2_Remainder)
                    case ",": CC("CommaAlias", C2_Remainder),     PU(", alias set to: " C2_Remainder)
                    case ";": CC("SemicolonAlias", C2_Remainder), PU("; alias set to: " C2_Remainder)
                    case "[": CC("LSBracketAlias", C2_Remainder), PU("[ alias set to: " C2_Remainder)
                    case "]": CC("RSBracketAlias", C2_Remainder), PU("] alias set to: " C2_Remainder)
                    case "{": CC("LCBracketAlias", C2_Remainder), PU("{ Alias set to: " C2_Remainder)
                    case "}": CC("RCBracketAlias", C2_Remainder), PU("} alias set to: " C2_Remainder)
                }
                updateGUI()
                ; return 1
            case "\":
                UpdateGUI(GetIniSect("PATHS",0) , "Saved PATHS")
            Case ">":
                c_input := ">"
                goto, load
            Case "?":                                                           ; load help.txt file in display                                                    
                NameNoExt := "help"
                C_input := "help"
                gosub, Load
                ; return 1
            Case "A", "P":                                                      ; append|prepend text to file
                if (instr(UserInput,"!")) {                                     ; # delete lines
                
                    rows := RegExReplace(C_input, "^([A-Z!]*)(\d+)(!)?", "$2")
                    rows := (rows = "!") ? 1 : rows
                    path := f_path RegExReplace(GC("CB_last_display",""), "\[.+?\]")
                    If IfMemFileExist(path) {
                        % (1stChar == "A") 
                            ? NewText := TF_RemoveLines(AccessCache(path,,0),rows * -1) 
                            : NewText := TF_RemoveLines(AccessCache(path,,0),1,rows) 
                        WriteToCache(path,,,NewText,,1)
                        UpdateGUI(NewText, ltrim(path,f_path))
                    }
                    return
                } else if (SubStr(UserInput, 2 , 2) = ">:") {                          ;# append|prepend manually entered text to clipboard
                    dPos        := InStr(C_input, ":")
                    text_to_add := substr(C_input, dPos+1)
                    sleep, long
                    C_input := ">"
                    goto, addTextToClipboard
                } else if (C_input == ">") {                                     ;# append|prepend selected text to clipboard                                  
                    AA(GC("CB_tgtExe"))
                    text_to_add := trim(clip()," `t`n`r")
                    sleep, long
                    C_input := ">"
                    goto, addTextToClipboard

                } else if (substr(C_input,0) = ">") AND (strlen(C_input) > 1) {                           ;# append|prepend file to clipboard                                     
                    SplitPath,% trim(C_input,">"), FileName, Dir, Extension, NameNoExt
                    dir := dir ? dir . "\" : "" 
                    text_to_add := AccessCache(NameNoExt, dir, false)
                    sleep, long
                    C_input := ">"
                    goto, addTextToClipboard
                    
                } else if (substr(C_input,1,1) = ">") AND (strlen(C_input) > 1) {                         ;# append|prepend clipboard to file                     
                    C_input := trim(C_input,">")
                    SplitPath,C_input, FileName, Dir, Extension, NameNoExt
                    dir := dir ? dir . "\" : "" 
                    ; sleep, long * 1.2
                    savedCB := clipboardall
                    text_to_add := clipboard
                    sleep, med * 3
                    clipboard := ""
                    clipboard := savedCB
                    clipwait 
                    while (ErrorLevel)
                        sleep 50
                    goto, addTextToFile
                } else if (instr(UserInput, ":") and !instr(UserInput, ">")) {  ;# append|prepend manually entered text to file       
                    dPos        := InStr(C_input, ":")
                    text_to_add := substr(C_input, dPos+1)
                    if (substr(C_input,1,1) == ":") {
                        dir := ""
                        namenoext := GC("CB_last_display","")                         
                    } else {
                        file_path   := substr(C_input, 1, dPos-1)
                        SplitPath, file_path, , dir, Extension, NameNoExt 
                        dir := dir ? dir . "\" : ""
                    }
                    goto, addTextToFile

                } else if (C_input ~= " .+") {                                  ;# append|prepend 1st file to 2nd file; RegExMatch(C_input, " .+")                         
                    arr := StrSplit(C_input, " ")
                    SplitPath,% arr[1], oFileName, oDir, oExtension, oNameNoExt 
                    SplitPath,% arr[2], nFileName, nDir, nExtension, nNameNoExt 
                    odir := odir ? odir . "\" : "" 
                    ndir := ndir ? ndir . "\" : ""
                    text_to_add := AccessCache(oNameNoExt, odir, false)
                    sleep, long 
                    ; path        = %f_path%%oDir%%oNameNoExt%.txt
                    NameNoExt  := nNameNoExt
                    dir        := nDir
                    goto, addTextToFile
                } else {                                                        ;# append|prepend selected text to file                                                         
                    ActivateApp(GC("CB_tgtExe"))
                    text_to_add := trim(clip()," `t`n`r")
                    namenoext := namenoext ? namenoext : GC("CB_last_display","")
                    goto, addTextToFile                                         ; since all the  goto, addTextToFile are at the end of the if statement, they're uncessary because the addTextToFile: label will be run automatically
                }
                return

                addTextToFile:
                    path := path ? path : f_path . dir . NameNoExt
                    path := (substr(path,-3) == ".txt") ? path : path . ".txt"
                    % (1stChar == "A") 
                        ? FileAppend(path, text_to_add)
                        : FilePrepend(path, text_to_add)
                    sleep, med*2
                    current_file := strReplace(substr(path, strlen(f_path)+1),".txt") == strReplace(GC("CB_last_display",""),".txt") ;checks whether appended file is the current file in CB display
                    if GC("CB_persistent",0) or current_file {                            ; if no CB exists, indicates append/prepend accessed by rerun last CB submission hotkey
                        txt  := AccessCache(NameNoExt,dir, False)
                        UpdateGUI(txt, dir NameNoExt)
                        ; CB(GC("CB_sfx"),GC("CB_clr"))
                    }
                    ; ActivateTgt()
                    ; ActivateApp("ahk_exe " GC("CB_tgtExe"))
                    return                                                         ; next label will be automatically run otherwise 

                addTextToClipboard:
                    var := clipboard                                            ; [stability] placeholder var allows usage of clipwait errorLevel
                    clipboard := ""                                             ; to monitor when the append|prepend is complete 
                    % (1stChar == "A") 
                        ? (var .= "`n" text_to_add) 
                        : (var := text_to_add "`n" var)
                    clipboard := var
                    clipwait 
                    while (ErrorLevel)
                        sleep 10
                    goto, Load
                    return

            Case "L":                                                           ; display file in command box
                Load:        
                tgt := tgt ? tgt : f_path dir NameNoExt
                if !GC("CB_Display") {
                    CC("CB_Display", 1), CC("CB_Titlebar", 1), CC("CB_ScrollBars", 0)
                    MI := StrSplit(GetMonInfo()," ")                            ; get monitor dimensions
                    d := "x" MI[3] // 2 " y0 w" MI[3] // 2 " h" MI[4] // 2 
                    CC("CB_position", d)
                }
                if (C_input = "?") or (C_input = "") {                          ; load list of files in mem_cache
                    NameNoExt := "list"
                    CC("CB_last_display", NameNoExt)
                    txt := CreateCacheList(,GC("rowMax",26))
                    tgt := f_path dir NameNoExt
                    UpdateGUI(txt, NameNoExt)
                } else if IfMemFileExist(tgt) {                                 ; load mem file Contents
                    ldspl := dir NameNoExt RetrieveExt(A_ScriptDir "\mem_cache\" dir NameNoExt)
                    ldspl := ldspl ? ldspl : ""
                    CC("CB_last_display", ldspl ) 
                    txt  := AccessCache(NameNoExt,dir, False)  
                    UpdateGUI(txt,ldspl) 
                } else if (C_input = "~") {
                    NameNoExt := "config.ini"
                    RegExMatch(config_path, ".*(?=config.ini)", dir)            ; get everything before the last title separator and store in v
                    CC("CB_last_display", dir NameNoExt)
                    txt  := AccessCache(NameNoExt,dir, False)
                    tgt := f_path dir NameNoExt
                    UpdateGUI(txt,dir NameNoExt) 
                } else if (C_input = "$") or (C_input = "$$") {                 ; list of all hotkeys 

                    NameNoExt := "HotKey_List"
                    dir := "..\"
                    if !FileExist(NameNoExt ".txt") or (C_input = "$$")
                        GenerateHotkeyList()
                    CC("CB_last_display", dir NameNoExt)
                    txt := AccessCache(NameNoExt,dir, False)
                    tgt := f_path dir NameNoExt
                    UpdateGUI(txt,dir NameNoExt) 
                } else if (C_input = ">") {                                     ; clipboard 
                    try {
                        UpdateGUI(Clipboard,"Clipboard Contents") 
                        ; return 1
                    } 
                } else if (C_input = "%") {                                     ; User Input History 
                    NameNoExt := "_hist.txt [starting with most recent]"
                    dir := ""
                    CC("CB_last_display", dir NameNoExt)
                    CleanHist(100)
                    txt  := AccessCache(RegExReplace(NameNoExt, "\[.+?\]"),dir, False)  ; "\[.+?\]" removes any text surrounded by square brackets 
                    UpdateGUI(txt,dir NameNoExt) 
                } else if (2ndChar = "|") {                                     ; get first lines from 0-9.txt memory files                        
                    remainder   := substr(C_input,2)
                    if InStr(C_input, ":") {                                    ; set number of rows to show
                        dPos      := InStr(C_input, ":")
                        rows      := substr(C_input, dPos+1)
                        file_path := substr(C_input, 2, dPos-1)
                    } else {
                        file_path := remainder
                        rows := 1
                    }
                    SplitPath, file_path, , dir, Extension, NameNoExt 
                    dir := dir ? dir . "\" : ""
                    txt := See1stLines(dir,"\S+",,rows)
                    NameNoExt := "First lines of " dir
                    UpdateGUI(txt, NameNoExt) 
                } else if (2ndChar = "#") {                                     ; get first lines from 0-9.txt memory files                        
                    remainder := substr(C_input,2)
                    MatchPat := "^[0-9]\.txt"
                    txt := % regexmatch(remainder, "\d+") ? See1stLines(,MatchPat,,remainder) : See1stLines(,MatchPat)
                    NameNoExt := "First lines of 0-9.txt"
                    dir := ""
                    UpdateGUI(txt,dir NameNoExt) 
                } else if (2ndChar = "@") {                                     ; get first lines from 0-9.txt memory files   
                    remainder := substr(C_input,2)
                    MatchPat := "^[0-9A-Za-z]\.txt"
                    txt := % regexmatch(remainder, "\d+") ? See1stLines(,MatchPat,,remainder) : See1stLines(,MatchPat)
                    NameNoExt := "First lines of 1 character files"
                    dir := ""
                    UpdateGUI(txt,dir NameNoExt) 
    
                } else if ((!IfMemFileExist(C_input)) or (instr(C_input,"*"))) {   ; load folders and files that match string entered after ":"
                    
                    dir := CS(dir,,"(:|\*\*|\*)")
                    txt := CreateCacheList(dir NameNoExt, GC("rowMax",26))
                    new_title_file := (strlen(dir NameNoExt) = 0)
                        ? "list"
                        : dir NameNoExt 
                    if (TF_CountLines(txt) == 1) {
                        file_name := LineStr(txt, 1, 1)
                        txt := AccessCache(file_name,,0)
                        new_title_file := file_name RetrieveExt(A_ScriptDir "\mem_cache\" file_name)
                    } 
                    UpdateGUI(txt, new_title_file)
                } else if (SubStr(UserInput,2 , 2) = "r:") {                    ; change # of rows displayed in a file listing command
                    CC("rowMax", SubStr(UserInput,4))
                    UpdateGUI() 
                }

            Case "O":                                                           ; overwrite file/clipboard
                C_input := RegExReplace(C_input, "S) +", A_Space)               ; replaces multiple spaces w/ 1        
                If (SubStr(UserInput, 2) == ">") {
                    SplitPath,% GC("CB_last_display",""), FileName, dir, Extension, NameNoExt
                    dir := dir ? dir . "\" : ""
                    if FileExist(f_path dir NameNoExt "." (Extension ? Extension : "txt")) {
                        clipboard := AccessCache(NameNoExt,dir, False)
                        goto, load
                    }
                } else If (SubStr(C_input,1,2) = ">:") {                         ; if C_input ends in ">" overwrite clipboard with file contents  
                    dPos        := InStr(C_input, ":")
                    clipboard   := substr(C_input, dPos+1)
                    sleep, long * 0.8
                    C_input := ">" ; for loading clipboard into CB display 
                    goto, load
                } else If ((2ndChar == ">") and RegExMatch(C_input,"[0-9A-Za-z]")) {   ; if C_input starts with ">" and there's a file name overwrite file w/ clipboard
                    NameNoExt := trim(C_input, " >")
                    dir := (InStr(dir, ">")) ? "" : dir
                    dir := (InStr(dir, ":")) ? "" : dir
                    WriteToCache(namenoext,,dir,clipboard)   
                    goto, load
                } else If (SubStr(C_input, 0) == ">") {                         ; if C_input ends in ">" overwrite clipboard with file contents  
                    C_input := trim(C_input, " >")
                    SplitPath, C_input, , Dir, , NameNoExt 
                    clipboard := AccessCache(NameNoExt,dir, False)
                    C_input := ">" ; for loading clipboard into CB display 
                    goto, load
                } else If (InStr(SubStr(C_input, 2), ":")) {
                    dPos        := InStr(C_input, ":")
                    SplitPath,% substr(C_input, 1, dPos-1), FileName, Dir, Extension, NameNoExt        ; parses everything after the command character as a file pathNameNoExt               
                    dir := dir ? dir . "\" : ""
                    text_to_add := substr(C_input, dPos+1)
                    
                    if !InStr(FileExist(f_path dir), "D") and dir
                    {                                      
                        msg := "WinGolems can't find the folder`n`n" . dir . "`n`nWould you like to create it?"
                        MsgBox,4100,Create Folder,%msg% 
                        IfMsgBox Yes
                        {
                            FileCreateDir, %f_path%%dir%
                            WriteToCache(namenoext,,dir,text_to_add)
                        } else 
                            return
                            ; return 1
                    } else if FileExist(f_path Dir NameNoExt ".txt") {                                      
                        msg := "Overwrite " . Dir NameNoExt ".txt"
                        MsgBox,4100,Overwrite File,%msg% 
                        IfMsgBox Yes
                        {
                            WriteToCache(namenoext,,dir,text_to_add)
                        } else 
                            return
                            ; return 1
                    } else {
                        WriteToCache(namenoext,,dir,text_to_add)
                    }
                    goto, load

                } else If RegExMatch(C_input, "^((?!\s).)+$") {                 ; if there's no second file name, overwrite with selected text                    
                    
                    SplitPath, C_input, FileName, Dir, Extension, NameNoExt     ; parses everything after the command character as a file path
                    dir := dir ? dir . "\" : ""
                    new_title_file := dir . NameNoExt . ".txt"
                    
                    ActivateApp(GC("CB_tgtExe"))
                    text_to_add := trim(clip())
                    tgt_path := f_path dir namenoext . "txt"
                    FileDelete, tgt_path 
                    if !InStr(FileExist(f_path dir), "D") and dir
                    {                                      
                        msg := "WinGolems can't find the folder`n`n" . dir . "`n`nWould you like to create it?"
                        MsgBox,4100,Create folder,%msg% 
                        IfMsgBox Yes
                            FileCreateDir, %f_path%%dir%
                        else 
                            return 
                            ; return 1
                    } else if FileExist(f_path Dir NameNoExt ".txt") {                                      
                        msg := "Overwrite " . Dir NameNoExt ".txt"
                        MsgBox,4100,Overwrite File,%msg% 
                        IfMsgBox Yes
                        {
                            WriteToCache(namenoext,,dir,text_to_add)
                        } else 
                            return
                            ; return 1
                    } else {
                        WriteToCache(namenoext,,dir,text_to_add)
                    }
                    ; WriteToCache(namenoext,, dir)   
                    goto, Load

                } else If RegExMatch(C_input, "\S+ \S+") {                      ; remaining case: two filenames given, w/ 1st overwriting the 2nd 
                    arr := StrSplit(C_input, " ")
                    SplitPath,% arr[1], 1FileName, 1Dir, 1Extension, 1NameNoExt
                    SplitPath,% arr[2], FileName, Dir, Extension, NameNoExt 
                    1dir := 1dir ? 1dir . "\" : ""
                    dir := dir ? dir . "\" : ""
                    if !InStr(FileExist(f_path dir), "D") and dir
                    {                                      
                        msg := "WinGolems can't find the folder`n`n" . dir . "`n`nWould you like to create it?"
                        MsgBox,4100,Create Folder,%msg% 
                        IfMsgBox Yes
                        {
                            FileCreateDir, %f_path%%dir%
                        } else 
                            return
                            ; return 1
                    } 
                    
 
                    if FileExist(f_path 1dir 1NameNoExt ".txt")
                    {
                        if FileExist(f_path Dir NameNoExt ".txt") {                                      
                            msg := "Overwrite " . Dir NameNoExt ".txt"
                            MsgBox,4100,Overwite File,%msg% 
                            IfMsgBox Yes
                            {
                                Filecopy,% f_path . 1Dir . 1NameNoExt . ".txt",% f_path . Dir . NameNoExt . ".txt", 1
                            } else 
                                return
                                ; return 1
                        } else {
                            try {
                                Filecopy,% f_path . 1Dir . 1NameNoExt . ".txt",% f_path . Dir . NameNoExt . ".txt", 1
                            } catch {
                                PU("invalid path",C.lgreen,C.bgreen,,,-2000)
                                UpdateGUI()
                            }
                        }
                    }
                    goto, load
                } else {
                    msgbox % "`nC_input: " . C_input
                }
                updateGUI() ;test
            Case "V":                                                           ; paste file contents
                ; sleep, short
                paste:
                namenoext := namenoext ? namenoext : GC("CB_last_display","")
                AA(GC("CB_tgtExe"))
                AccessCache(namenoext, dir)
                ; return 3
            Case "E":                                                           ; edit file
                path := f_path RegExReplace(GC("CB_last_display",""), "\[.+?\]")   ; "\[.L+?\]" removes any text surrounded by square brackets 
                if substr(path,-3) != ".txt"
                    path .= ".txt"
                if !C_input && FileExist(path) {
                    EF(path)
                    Gui, 2:Cancel
                    ; return
                } else if (InStr(C_input, "~") && FileExist(path)) {
                    E_Input := substr(C_input,2)
                    switch 
                    {
                        case E_Input == "dd": 
                            NewText := TF_RemoveDuplicateLines(AccessCache(path,,0),,,1,false) ; remove consecutive duplicates
                        case E_Input == "d": 
                            NewText := TF_RemoveDuplicateLines(AccessCache(path,,0),,,,false)  ; remove any duplicates
                        case E_Input == "t": 
                            NewText := RegExReplace(AccessCache(path,,0), "m)^( +|`t+)( +)")   ; trim leading tabs and spaces
                        case E_Input == "ts": 
                            NewText := RegExReplace(AccessCache(path,,0), "m)^( +|`t+)( +)")   ; trim leading spaces
                        case E_Input == "tt": 
                            NewText := RegExReplace(AccessCache(path,,0),  "m)^`t+")           ; trim leading tabs
                            NewText := RegExReplace(NewText,  " [ `t]+", " ")
                        case E_Input == "cl":                                                  ; replace multiple consecutive blank lines with 1
                            NewText := RegExReplace(AccessCache(path,,0), "(`r`n){2,}", "`r`n`n")
                        case E_Input = "l":                                                  ; remove blank lines
                            NewText := RemoveBlankLines(,AccessCache(path,,0))
                        case substr(E_Input, 1,1) = "i":                                       ; insert line line (E~i2:example -> insert the word "example" at line 2)
                            dPos      := InStr(E_Input, ":")
                            text_to_add := substr(E_Input, dPos+1)
                            rowIndex  := substr(E_Input,2,-strlen(text_to_add)-1)              ;last term is length not end position
                            NewText := TF_InsertLine(AccessCache(path,,0), rowIndex,rowIndex,text_to_add)
                        case substr(E_Input, 1,1) = "r":                                       ; remove line (E~r2:example -> line 2 )
                            rowIndex  := substr(E_Input,2)              ;last term is length not end position
                            NewText := (rowIndex > 0) ? TF_RemoveLines(AccessCache(path,,0), rowIndex, rowIndex) 
                                                      : TF_RemoveLines(AccessCache(path,,0), rowIndex) 
                        default:
                            msgbox % "error E_input:" E_Input " strlen(E_input):" strlen(E_Input)
                    }
                    WriteToCache(path,,,NewText,,1)
                    UpdateGUI(NewText, ltrim(path,f_path))

                } else if !InStr(C_input, "~") {
                    input := f_path Dir FileName
                    if FileExist(input ".txt") 
                        input .= ".txt"
                    else if FileExist(input ".ini") 
                        input .= ".ini"
                    EditFile(input)
                }
                ; updateGUI()
                return 1
            Case "C":                                                           ; copy file
                If !RegExMatch(C_input, " .+")                                  ; if no second file name given add suffix  
                {
                    PU("DUPLICATE DETECTED!`nappending suffix to filename", lpurple,purple )
                    var := 1
                    source := f_path . Dir . namenoext . "." . (Extension ? Extension : "txt")
                    dest := f_path . Dir . namenoext . "_" . var . "." . (Extension ? Extension : "txt")
                    Filecopy,%source%,%dest%,0
                    exist = %ErrorLevel%                                        ; get the error level 0 = no errors
                    while exist > 0                                             ; what to do if there is an error like filename already exists
                    {
                        PU("DUPLICATE DETECTED!`nappending suffix to filename", lpurple,purple )
                        ++var
                        Filecopy,%f_path%%Dir%%namenoext%.txt, %f_path%%Dir%%namenoext%_%var%.txt,0
                        exist = %ErrorLevel%
                    }
                }
                else                                                            ; if two files names given 
                {
                    try {
                        arr := StrSplit(C_input, " ")
                        SplitPath,% arr[1], oFileName, oDir, oExtension, oNameNoExt 
                        SplitPath,% arr[2], nFileName, nDir, nExtension, nNameNoExt 
                        odir := odir ? odir . "\" : ""
                        ndir := ndir ? ndir . "\" : ""
                        dest_path := C_input := f_path . nDir . nNameNoExt . "." . (nExtension ? nExtension : "txt")
                        source_path :=  f_path oDir oNameNoExt . "." . (oExtension ? oExtension : "txt")
                        
                        if !InStr(FileExist(f_path ndir), "D") and ndir
                        {                                      
                            msg := "WinGolems can't find the folder`n`n" . ndir . "`n`nWould you like to create it?"
                            MsgBox,4100,Create folder,%msg% 
                            IfMsgBox Yes
                            {
                                FileCreateDir, %f_path%%ndir%
                            } else 
                                return 1
                        } 
    
                        ; Msgbox % "`ndest_path: " . dest_path . "`n source_path: " .  source_path
                        Filecopy,%source_path%,%dest_path%,1    ; 1 = overwrite 
                        ; PU(oFileName . " copied to " . nFileName,lgreen,C.bgreen,,,-2000)
                    } catch {
                        PU("invalid file path",C.lgreen,C.bgreen,,,-2000)
                    }
                }
                goto, Load
            Case "D":                                                           ; delete file
                if (UserInput == "D") {
                    SplitPath,% GC("CB_last_display"), FileName, Dir, Extension, NameNoExt
                    dir := dir ? dir . "\" : ""
                    FileDelete,% f_path . Dir . NameNoExt . "." . (Extension ? Extension : "txt")
                } else if InStr(UserInput, ",") {
                    arrD := StrSplit(C_input, ",")
                    loop % arrD.MaxIndex()
                    {
                        SplitPath,% trim(arrD[A_index]), FileName, Dir, Extension, NameNoExt
                        FileDelete,% f_path . (dir ? dir . "\" : "") . NameNoExt . "." . (Extension ? Extension : "txt")
                    }

                } else {
                    FileDelete,% f_path . Dir . NameNoExt . "." . (Extension ? Extension : "txt")
                }
                updateGUI(CreateCacheList(,GC("rowMax",26)),"list")
            Case "R":                                                           ; replace string 
                C_3          := SubStr(C_input, 1, 3) , sep1 := GC("Rsep1","~")
                C4_Remainder := SubStr(C_input, 4)    , sep2 := GC("Rsep2","__") 

                if (C_input ~= "^~~\S{1,2}$") {
                    new_sep := substr(C_input,3)
                    CC("Rsep2", new_sep), PU("Rsep2: " new_sep,,,,,2000), UpdateGUI()
                    return 1
                } else if (C_input ~= "^~\S$") {
                    new_sep := substr(C_input,0)
                    CC("Rsep1", new_sep), PU("Rsep1: " new_sep,,,,,2000), UpdateGUI()
                    return 1
                } 
                
                        
                switch C_3
                {
                    case "1~:":
                        CC("Rsep1", C4_Remainder), PU("Rsep1: " C4_Remainder,,,,,2000), UpdateGUI()
                        return 1
                    case "2~:":
                        CC("Rsep2", C4_Remainder), PU("Rsep2: " C4_Remainder,,,,,2000), UpdateGUI()
                        return 1
                    case "??":
                        PU("Rsep 1:" GC("Rsep1", "~") "2:"  GC("Rsep2", "__"),,,,,2000)
                    case "!!":
                        DC("Rsep2"), DC("Rsep1"), PU("Rsep reset to 1:~ 2:__",,,,,2000) 
                    Case "f~:":
                        OuterArr := StrSplit(C4_Remainder, " ")
                        InnerArr := StrSplit(OuterArr[1], sep1)
                        SplitPath,% InnerArr[1], oFileName, oDir, oExtension, oNameNoExt
                        SplitPath,% InnerArr[2], pFileName, pDir, pExtension, pNameNoExt
                        SplitPath,% OuterArr[2], nFileName, nDir, nExtension, nNameNoExt
                        odir := odir ? odir . "/" : ""
                        pdir := pdir ? pdir . "/" : ""
                        ndir := ndir ? ndir . "/" : ""
                        otxt := AccessCache(oNameNoExt,oDir, False)
                        ptxt := AccessCache(pNameNoExt,pDir, False)
                        ptxt := StrReplace(ptxt, "`n")
                        ptxt := StrReplace(ptxt, "`r")
                        pArr := StrSplit(ptxt, GC("Rsep2", "__"))
                        ntxt := otxt
                        loop % pArr.MaxIndex()
                        {
                            AB := StrSplit(pArr[A_index], sep1)
                            ntxt := ReplaceAwithB(AB[1], AB[2],ntxt,0,0)
                        }
                        FileDelete,% f_path . nDir . nNameNoExt . ".txt"
                        FileAppend, %ntxt%, %f_path%%nDir%%nNameNoExt%.txt    
                        return

                    default:
                        sleep short
                        StringCaseSense, On
                        ActivateApp(GC("CB_tgtExe"))  
                        vtext := clip()                       
                        arrN := StrSplit(C_input, GC("Rsep2", "__"))  
                        loop % arrN.MaxIndex()
                        {
                            AB := StrSplit(arrN[A_index], GC("Rsep1", "~"))
                            vtext := ReplaceAwithB(AB[1], AB[2],vtext,0,0)
                        }
                        StringCaseSense, Off
                        clip(vtext)   
                        return 3

                }        
                return 3
            Case "F":                                                           ; fill space with char 
                sleep, short
                ActivateApp(GC("CB_tgtExe"))
                if !InStr(C_input, "~") AND !InStr(C_input, ",") {
                    FillChar(50, C_input, 0)
                } else {                          
                    arr := (InStr(C_input, "~")) ? StrSplit(C_input, "~") 
                                                : StrSplit(C_input, ",")
                    FillChar(arr[2], arr[1], 0)
                } 
                return 3
            case "I":                                                           ; change retrieve path letter variable  
                if (2ndChar = ":") 
                    CC("chr2_path", ConvertUpper(ltrim(C_input,":"),0))
                else
                    CC("chr_path", ConvertUpper(trim(C_input),0))
                PU("Pinned Letter Path: " GC((2ndChar = ":") ? "chr2_path" : "chr_path"))
                return 1
            Case "G":                                                           ; run function 
                
                C_First2chr := SubStr(C_input, 1, 2) 
                C3_Remainder := SubStr(C_input, 3)
                ; msgbox % C_First2chr
                switch 
                {   
                    case SubStr(C_input, 1 , 1) = ":":
                        ; implement option here to run native ahk syntax
                        return 1
                    case C_First2chr = "f:":                                   ; create function name alias
                        arr := StrSplit(C3_Remainder, "~")
                        IniWrite,% arr[2], %f_path%ALIAS.ini, function,% arr[1]
                        UpdateGUI()
                        return 1
                    case C_First2chr = "p:":                                   ; create parameter alias
                        arr := StrSplit(C3_Remainder, "~")
                        IniWrite,% arr[2], %f_path%ALIAS.ini, parameter,% arr[1]
                        UpdateGUI()
                        return 1
                    
                    default:
                        ActivateWin("ahk_id" tgt_hwnd)
                        arrO := StrSplit(C_input, "__")
                        
                        loop % arrO.MaxIndex()
                        {
                            arr := StrSplit(arrO[A_index], ",")
                            RunFunction(arr*)
                        }
                }
                return
            Case "J":                                                           ; select|goto rows below
                if RegExMatch(c_input,"[a-ik-zA-IK-Z]")                         ; if there are any other letters of the alphabet in the input
                    RunLabel(UserInput, suffix, tgt_hwnd)                       ; reject user input as valid Case "J" or "K" command
                else
                {
                    ActivateWin("ahk_id " . tgt_hwnd)
                    if (1stChar == "j")
                        UDSelect("down", "10", C_input, false)                  ; no selection just row movement
                    else
                        UDSelect("down", "10", C_input)k
                }
                return
            Case "K":                                                           ; select|goto rows above
                if RegExMatch(c_input,"[a-jl-zA-JL-Z]")                         ; if there are any other letters of the alphabet in the input
                    RunLabel(UserInput, suffix, tgt_hwnd)
                else 
                {
                    ActivateWin("ahk_id " . tgt_hwnd)                           ; select|goto rows above
                    if (1stChar == "k")
                        UDSelect("Up", "10", C_input, false)
                    else
                        UDSelect("Up", "10", C_input)
                }
                return
            Case "H","N":
                RunOtherCBsfx(C_input, 1stChar) 
            
            Case "Q","W","B","U": ; free
            Case "M":                                                           ; move tgt window
                MoveWin(C_input)
            Case "S":                                                           ; search selected text in chosen search engine msft
                
                if (InStr(C_input, ":") AND !InStr(C_input, ":>")) {                                      ; get search string from command box if colon detected
                    dPos  := InStr(C_input, ":")
                    case  := substr(C_input, 1, dPos-1)
                    strng := substr(C_input, dPos+1)
                }
                else if (InStr(C_input, ":>")) {                                      ; get search string from command box if colon detected
                    dPos  := InStr(C_input, ">")
                    case  := substr(C_input, 1, dPos-1)
                    strng := clipboard . substr(C_input, dPos+1)
                }
                else                                                            ; get search string from selected text
                {
                    case := C_input
                    strng := ""
                    AA(GC("CB_tgtExe"))
                }
                switch case
                {
                    Case "a"       : search("www.autohotkey.com/docs/search.htm?q=", strng, "&m=2")
                    Case "ae"      : search("www.aliexpress.com/wholesale?catId=0&initiative_id=SB_20210825091515&SearchText=", strng)
                    Case "az","amz": search("www.amazon.ca/s?k=", strng) 
                    Case "bv"      : search("www.bing.com/videos/search?q=", strng) 
                    Case "d"       : search("www.dictionary.com/browse/", strng)  
                    Case "da"      : search("https://www.macmillandictionary.com/us/dictionary/american/", strng)                                 
                    Case "e","ebay": search("www.ebay.ca/sch/", strng)
                    Case "f"       : search("www.finviz.com/quote.ashx?t=", strng) 
                    Case "imdb"    : search("www.imdb.com/find?q=", strng) 
                    Case "io","fd" : search("www.investopedia.com/search?q=", strng) 
                    Case "m"       : search("https://www.google.com/maps/search/", strng) 
                    Case "mse"     : search("math.stackexchange.com/search?q=", strng) 
                    Case "n"       : search("news.google.com/search?q=", strng) 
                    Case "p"       : search("https://www.listennotes.com/search/?q=", strng,"&sort_by_date=1&scope=episode&offset=0&language=Any%20language&len_min=0") 
                    Case "r"       : search("https://www.reddit.com/search/?q=", strng) 
                    Case "se"      : search("stackexchange.com/search?q=", strng) 
                    Case "so"      : search("www.stackoverflow.com/search?q=", strng) 
                    Case "t"       : search("www.thesaurus.com/browse/", strng)    
                    Case "ta"      : search("www.macmillanthesaurus.com/", strng)                                 
                    Case "tr"      : search("https://translate.google.ca/?sl=auto&tl=en&text=", strng)    
                    Case "twt"     : search("www.twitter.com/search?q=", strng)
                    Case "w"       : search("en.wikipedia.org/w/index.php?search=", strng) 
                    Case "yf"      : search("ca.finance.yahoo.com/quote/", strng) 
                    case "i"       : search("www.google.com/search?tbm=isch&q=", strng)
                    case "y"       : search("www.youtube.com/results?search_query=", strng)
                    default : 
                        search(, strng)                                         ; defaults to google search
                }            
                SetTimer, CFW, -600
                return 3
            
            Case "X":
            Case "Y":
                if (SubStr(C_input, 1, 2) = "s:") {
                    C3_Remainder := SubStr(C_input, 3)
                    CC("CL_sfx", C3_Remainder)
                } else if (SubStr(C_input, 1, 2) = "p:") {
                    C3_Remainder := SubStr(C_input, 3)
                    CC("CL_pfx", C3_Remainder)
                }
                return
            Case "Z":
                
                if (C_input == "d") {
                    CC("CBfnt", "Consolas"), CC("CBfsz", "11"), CC("CBfwt", "500")               
                } else if RegExMatch(c_input,"[bfBF]:") {
                    C_2 := SubStr(C_input, 1, 2)
                    C3_Remainder := SubStr(C_input, 3)
                    switch C_2
                    {
                        Case "b:"   : CC("CBfwt", C3_Remainder)  
                        Case "f:"   : CC("CBfnt", C3_Remainder)  
                        default : return 1
                    }            
                } else {
                    CC("CBfsz",C_input)
                    reloadWG()
                }
                AutoXYWH("wh*", "CB_Display")
                CtrXpos := (A_GuiWidth - GC("CB_InputBox_width")) // 2
                GuiControl, MoveDraw, UserInput, x%CtrXpos%
                AutoXYWH("y*", "UserInput")
                updateGUI()
                return 1
            Case "T":
                C_First2chr := SubStr(C_input, 1, 2) 
                C3_Remainder := SubStr(C_input, 3)
                Switch C_input 
                {
                    case "persistent"  ,"p"  : TC("CB_persistent" , "Toggle Persistent GUI: ")
                    case "scrollbars"  ,"s"  : TC("CB_ScrollBars" , "Toggle Scrollbars: ")
                    case "title"       ,"t"  : TC("CB_Titlebar"   , "Toggle Titlebar: ")
                    case "Always On Top","ot","aot" : TC("CB_alwaysOnTop", "Toggle Always On Top: ")
                    case "focus"       ,"a"  : TC("CB_appActive"  , "Toggle application focus: ")
                    case "renter input","r"  : TC("CB_reenterInput" , "Re-enter last submit: ")
                    case "lrows"  : TC("CB_reenterInput" , "Re-enter last submit: ")
                    case "wrap_text" ,"w"    : TC("CB_Wrap", "Toggle text wrap: ")
                    case "default"   ,"d"    : ToggleDisplay("display")
                    case "minimized" ,"m"    : ToggleDisplay("minimal")
                    Case "lshift", "ls"      : TC("T_lshift", "Toggle Lshift HJKL") 
                    default:
                }
                Gui, 2: +LastFound
                CommandBox(GC("CB_sfx"),GC("CB_clr"))

            Default:
                return 
        } 
    } 
    Else 
    {
        RunLabel(UserInput, suffix, tgt_hwnd)
        if GC("CB_persistent", 0)
            Commandbox(GC("CB_sfx"),GC("CB_clr"))
        ; else 
            ; WinMinimize, % "ahk_id " CB_hwnd
    }
    ; settimer, ActivateTgt, -300
    ; ActivateApp(GC("CB_tgtExe"))
    ; return 
}


 
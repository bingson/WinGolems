; query 412

ProcessCommand(UserInput, suffix = "~win", title = "", fsz = "", fnt = "", w_color = "", t_color = "") {
    global config_path, long, med, short, tgt_hwnd, CB_hwnd, C
    1stChar := SubStr(UserInput, 1, 1), 2ndChar := SubStr(UserInput, 2 , 1)
    f_path := A_ScriptDir "\mem_cache\" 

    (substr(UserInput,0) = "~") ? ("") : CC("last_user_input", UserInput)   ; store key history, except keys ending in "~" (shutdown related)   

    ; if RegExMatch(1stChar,"[0-9A-Z\?jk:]") 
    if (1stChar ~= "[\.\,>0-9A-Z\?jk:]") {
        C_input := SubStr(UserInput, 2)                                         ; everything after the first character
        SplitPath, C_input, FileName, Dir, Extension, NameNoExt                 ; parses everything after the command character as a file path 
        dir := dir ? dir . "\" : ""
        Switch 1stChar                                                          ; free: h,i,u,x,y
        { 
            
            Case 1,2,3,4,5,6,7,8,9,0:
                NameNoExt := 1stChar
                C_input := 1stChar
                gosub, Load
                return 1
            Case ".",",":
                C2_Remainder := substr(C_input,2)
                if (substr(C_input,1,1) = ":") {
                    (1stChar = ".") ? (CC("PeriodAlias", "V" C2_Remainder), PU("PeriodAlias set to: V" C2_Remainder))
                                    : (CC("CommaAlias", "V" C2_Remainder), PU("Commaalias set to: V" C2_Remainder))
                } else if (substr(C_input,1,1) = "!") {
                    (1stChar = ".") ? (DC("Periodalias"), PU("PeriodAlias reset to V"))
                                    : (DC("CommaAlias"), PU("CommaAlias reset to V"))
                }
                return 2
            Case ">":
                c_input := ">"
                goto, load
            Case "?":                                                           ; load help.txt file in display                                                    
                NameNoExt := "help"
                C_input := "help"
                gosub, Load
                return 1
            Case "A", "P":                                                      ; append|prepend text to file
                if (SubStr(UserInput, 2 , 2) = ">:") {                          ;# append|prepend manually entered text to clipboard
                    dPos        := InStr(C_input, ":")
                    text_to_add := substr(C_input, dPos+1)
                    sleep, long * 0.8
                    C_input := ">"
                    goto, addTextToClipboard
                } else if (C_input = ">") {                                     ;# append|prepend selected text to clipboard                                  
                    ActivateWin("ahk_id " tgt_hwnd), s("") 
                    text_to_add := trim(clip()," `t`n`r")
                    sleep, long * 0.8
                    C_input := ">"
                    goto, addTextToClipboard

                } else if (substr(C_input,0) = ">") {                           ;# append|prepend file to clipboard                                     
                    SplitPath,% trim(C_input,">"), FileName, Dir, Extension, NameNoExt
                    dir := dir ? dir . "\" : "" 
                    text_to_add := AccessCache(NameNoExt, dir, false)
                    sleep, long * 0.8
                    C_input := ">"
                    goto, addTextToClipboard
                    
                } else if (substr(C_input,1,1) = ">") {                         ;# append|prepend clipboard to file                     
                    C_input := trim(C_input,">")
                    SplitPath,C_input, FileName, Dir, Extension, NameNoExt
                    dir := dir ? dir . "\" : "" 
                    sleep, long * 1.2
                    savedCB := clipboardall
                    text_to_add := clipboard
                    clipboard := ""
                    clipboard := savedCB
                    clipwait 
                    while (ErrorLevel)
                        sleep 50
                    goto, addTextToFile
                } else if (instr(UserInput, ":") and !instr(UserInput, ">")) {  ;# append|prepend manually entered text to file            
                    dPos        := InStr(C_input, ":")
                    text_to_add := substr(C_input, dPos+1)
                    file_path   := substr(C_input, 1, dPos-1)
                    SplitPath, file_path, , dir, Extension, NameNoExt 
                    dir := dir ? dir . "\" : ""
                    sleep, long * 0.8
                    goto, addTextToFile

                } else if (C_input ~= " .+") {                                  ;# append|prepend 1st file to 2nd file; RegExMatch(C_input, " .+")                         
                    arr := StrSplit(C_input, " ")
                    SplitPath,% arr[2], oFileName, oDir, oExtension, oNameNoExt 
                    SplitPath,% arr[1], nFileName, nDir, nExtension, nNameNoExt 
                    odir := odir ? odir . "\" : "" 
                    ndir := ndir ? ndir . "\" : ""
                    text_to_add := AccessCache(nNameNoExt, ndir, false)
                    path        = %f_path%%oDir%%oNameNoExt%.txt
                    NameNoExt  := oNameNoExt
                    dir        := oDir
                    goto, addTextToFile
                } else {                                                        ;# append|prepend selected text to file                                                         
                    text_to_add := trim(clip()," `t`n`r")
                    goto, addTextToFile                                         ; since all the  goto, addTextToFile are at the end of the if statement, they're uncessary because the addTextToFile: label will be run automatically
                }
                
                addTextToFile:
                    path = %f_path%%Dir%%NameNoExt%.txt
                    % (1stChar == "A") 
                        ? FileAppend(path, text_to_add)
                        : FilePrepend(path, text_to_add)
                    if WinExist("ahk_id " CB_hwnd) {                            ; if no CB exists, indicates append/prepend accessed by rerun last CB submission hotkey
                        goto, Load
                    }

                return                                                           ; label will be automatically run otherwise 

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

            Case "L":                                                           ; display file in command box

                Load:         

                tgt := tgt ? tgt : f_path dir NameNoExt
                
                if !GC("CB_Display") {
                    CC("CB_Display", 1), CC("CB_Titlebar", 1), CC("CB_ScrollBars", 0)
                    MI := StrSplit(GetMonInfo()," ")                            ; get monitor dimensions
                    d := "x" MI[3] // 2 " y0 w" MI[3] // 2 " h" MI[4] // 2 
                    CC("CB_position", d)
                }
                
                if (C_input = "~") {
                    NameNoExt := "config.ini"
                    RegExMatch(config_path, ".*(?=config.ini)", dir)            ; get everything before the last title separator and store in v
                    CC("CB_last_display", dir NameNoExt)
                    txt  := AccessCache(NameNoExt,dir, False)
                    tgt := f_path dir NameNoExt

                } else if (C_input = "$") or (C_input = "$$") {                 ; list of all hotkeys 

                    NameNoExt := "HotKey_List"
                    dir := "..\"
                    if !FileExist(NameNoExt ".txt") or (C_input = "$$")
                        GenerateHotkeyList()
                    CC("CB_last_display", dir NameNoExt)
                    txt := AccessCache(NameNoExt,dir, False)
                    tgt := f_path dir NameNoExt

                } else if (C_input = ">") {                                     ; clipboard 
                    try {
                        txt := Clipboard
                        NameNoExt := "Clipboard Contents", dir := ""
                        goto, updateGUI
                    } catch e {
                        PU("Sorry the CB only displays text strings", , ,, , drtn = "-2000") 
                        return 1
                    }
                } else if (C_input = "%") {                                     ; User Input History 
                    NameNoExt := "_hist.txt [starting with most recent]"
                    dir := ""
                    CC("CB_last_display", dir NameNoExt)
                    CleanHist(100)
                    txt  := AccessCache(RegExReplace(NameNoExt, "\[.+?\]"),dir, False)  ; "\[.+?\]" removes any text surrounded by square brackets 
                } else if (2ndChar = "#") {                                     ; get first lines from 0-9.txt memory files                        
                    remainder := substr(C_input,2)
                    txt := % regexmatch(remainder, "\d+") ? GetNumMemLines(,remainder) : GetNumMemLines()
                    NameNoExt := "First lines of 0-9.txt"
                    dir := ""
                } else if (2ndChar = "@") {                                     ; get first lines from 0-9.txt memory files   
                    remainder := substr(C_input,2)
                    txt := % regexmatch(remainder, "\d+") ? GetNumMemLines(,remainder,,1) : GetNumMemLines(,,,1)
                    NameNoExt := "First lines of 1 character files"
                    dir := ""

                } else if (2ndChar = ",") or (2ndChar = ".") {                                     ; PeriodAlias: folder contents
                    
                    after2char := SubStr(C_input, 2)
                    NameNoExt := after2char
                    dir := (2ndChar = ".") ? GC("PeriodAlias") : GC("CommaAlias")
                    dir := (dir != "ERROR") ? substr(dir,2) : ""

                    if (after2char != "") {
                        CC("CB_last_display", dir . after2char)
                        txt  := AccessCache(after2char, dir, False)
                    } else {
                        NameNoExt := "*.*"
                        ; NameNoExt := "*.*" . " [ " . 2ndChar . " ]"
                        CC("CB_last_display", dir NameNoExt)
                        txt := CreateCacheList("list", dir, GC("rowMax",26))
                        tgt := f_path dir NameNoExt
                    }
                } else if (2ndChar = ":") {                                     ; load folders and files that match string entered after ":"
                    dir := SubStr(C_input, 2)
                    dir := CS(dir,,"(\*\.\*|\*)")
                    NameNoExt := "*.*"
                    CC("CB_last_display", dir NameNoExt)
                    txt := CreateCacheList("list", dir, GC("rowMax",26))
                    tgt := f_path dir NameNoExt
                } else if (SubStr(UserInput,2 , 2) = "r:") {                                     ; load folders and files that match string entered after ":"
                    CC("rowMax", SubStr(UserInput,4))
                    return 2
                } else if (!FileExist(tgt ".txt") and !FileExist(tgt ".ini"))   ; load list of files in mem_cache
                  or (C_input = "?") {
                    NameNoExt := "list"
                    CC("CB_last_display", NameNoExt)
                    txt := CreateCacheList("list",,GC("rowMax",26))
                    tgt := f_path dir NameNoExt

                ; } else if (!FileExist(tgt ".txt") and !FileExist(tgt ".ini"))   ; todo: A>3 GUIupdate

                } else {
                    CC("CB_last_display", dir NameNoExt)
                    txt  := AccessCache(NameNoExt,dir, False)
                }
                
                updateGUI:
                    new_title_file := dir . NameNoExt . RetrieveExt(tgt)            ; new_title_file := """" dir """" . NameNoExt . RetrieveExt(tgt)
                    ; msgbox % 1 new_title_file "`n" 2 "`n" txt
                    CC("CB_title_file", new_title_file)
                    UpdateGUI(txt, new_title_file)
                    return 1

            Case "O":                                                           ; overwrite file/clipboard
                C_input := RegExReplace(C_input, "S) +", A_Space)               ; replaces multiple spaces w/ 1        
                
                If (SubStr(UserInput, 2) == ">") {
                    SplitPath,% GC("CB_title_file",""), FileName, dir, Extension, NameNoExt
                    dir := dir ? dir . "\" : ""
                    if FileExist(f_path dir NameNoExt "." (Extension ? Extension : "txt")) {
                        clipboard := AccessCache(NameNoExt,dir, False)
                        goto, load
                    }
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
                        MsgBox,4100,Create Hotstring,%msg% 
                        IfMsgBox Yes
                        {
                            FileCreateDir, %f_path%%dir%
                        } else 
                            return 1
                    } 

                    WriteToCache(namenoext,,dir,text_to_add)
                    goto, load

                } else If !RegExMatch(C_input, " .+") {                         ; if there's no second file name, overwrite with selected text                    
                
                    ActivateWin("ahk_id " tgt_hwnd) 
                    text_to_add := trim(clip())
                    tgt_path := f_path dir namenoext . "txt"
                    FileDelete, tgt_path
                    if !InStr(FileExist(f_path dir), "D") and dir
                    {                                      
                        msg := "WinGolems can't find the folder`n`n" . dir . "`n`nWould you like to create it?"
                        MsgBox,4100,Create Hotstring,%msg% 
                        IfMsgBox Yes
                            FileCreateDir, %f_path%%dir%
                        else 
                            return 1
                    }
                    WriteToCache(namenoext,, dir)   
                    goto, Load

                } else If RegExMatch(C_input, " .+") {                          ; remaining case: two filenames given, w/ 1st overwriting the 2nd                         
                    arr := StrSplit(C_input, " ")
                    SplitPath,% arr[1], 1FileName, 1Dir, 1Extension, 1NameNoExt
                    SplitPath,% arr[2], FileName, Dir, Extension, NameNoExt 
                    1dir := 1dir ? 1dir . "\" : ""
                    dir := dir ? dir . "\" : ""
                    if !InStr(FileExist(f_path dir), "D") and dir
                    {                                      
                        msg := "WinGolems can't find the folder`n`n" . dir . "`n`nWould you like to create it?"
                        MsgBox,4100,Create Hotstring,%msg% 
                        IfMsgBox Yes
                        {
                            FileCreateDir, %f_path%%dir%
                        } else 
                            return 1
                    } 
 
                    if FileExist(f_path 1dir 1NameNoExt ".txt")
                    {
                        try {
                            Filecopy,% f_path . 1Dir . 1NameNoExt . ".txt",% f_path . Dir . NameNoExt . ".txt", 1
                        } catch {
                            PU("invalid path",C.lgreen,C.bgreen,,,-2000)
                            UpdateGUI()
                        }
                    }
                    goto, load
                }
                return 2
            Case "V":                                                           ; paste file contents
                ; sleep, short
                paste:

                if InStr(UserInput, ":") {
                    C_First2chr := SubStr(C_input, 1, 2) 
                    C_First3chr := SubStr(C_input, 1, 3) 
                    C3_Remainder := SubStr(C_input, 3)
                    Switch
                    {
                        case C_First3chr = "l:!", C_First3chr = ",:!":
                            PU("CommaAlias reset to V")
                            sleep 200
                            DC("CommaAlias")
                            CreateCacheList("list",,GC("rowMax",26))
                            return 
                        case C_First3chr = "l:?": 
                            TC("LaltList", "Toggle LaltCommand Cache List: ")
                            return 2
                        case C_First3chr = "r:!", C_First3chr = ".:!":
                            PU("PeriodAlias reset to V")
                            sleep 200
                            DC("PeriodAlias")
                            return 
                        case C_First2chr = "l:" or C_First2chr = ",:":
                            PU("CommaAlias set to: V" C3_Remainder)
                            sleep 200
                            CC("CommaAlias", "V" . C3_Remainder)
                            CreateCacheList("list", substr(GC("CommaAlias"),2), GC("rowMax",26))
                            return 
                        case C_First2chr = "r:", C_First2chr = ".:":
                            PU("PeriodAlias set to: V" C3_Remainder)
                            sleep 200
                            CC("PeriodAlias", "V" . C3_Remainder)
                            return 
                        case C_First2chr = ":!":
                            PU("Alt Space Commands reset to V")
                            sleep 200
                            DC("CommaAlias")
                            DC("PeriodAlias")
                            CreateCacheList("list",,GC("rowMax",26))
                            return 
                        default:
                            
                    }
                } else if (2ndChar = ",") or (2ndChar = ".") {                                     ; PeriodAlias: folder contents
                    
                    after2char := SubStr(C_input, 2)
                    NameNoExt := after2char
                    dir := (2ndChar = ".") ? GC("PeriodAlias") : GC("CommaAlias")
                    dir := (dir != "ERROR") ? substr(dir,2) : ""

                    if (after2char != "") {
                        CC("CB_last_display", dir . after2char)
                        txt  := AccessCache(after2char, dir)
                    } else {
                        NameNoExt := "list"
                        CC("CB_last_display", dir NameNoExt)
                        txt := CreateCacheList("list", dir, GC("rowMax",26))
                        tgt := f_path dir NameNoExt
                        goto, load
                    }
                } else {
                    namenoext := namenoext ? namenoext : GC("CB_title_file","")
                    ActivateWin("ahk_id"  tgt_hwnd)
                    AccessCache(namenoext, dir)
                }
                return 3
            Case "E":                                                           ; edit file
                path := f_path RegExReplace(GC("CB_title_file",""), "\[.+?\]")   ; "\[.+?\]" removes any text surrounded by square brackets 
                if !C_input && FileExist(path) {
                    EF(path)
                } else if (InStr(C_input, "~") && FileExist(path)) {
                    EditFunc := substr(C_input,2,2)
                    switch EditFunc
                    {
                        case "t": ;trime leading tabs and spaces
                            NewText := RegExReplace(AccessCache(path,,0), "m)^( +|`t+)( +)")
                            ; NewText := RegExReplace(AccessCache(path,,0), "m)^( +)|(`t+)")
                            ; NewText := RegExReplace(AccessCache(path,,0), "m)^ +") ;removes just leading spaces
                            ; NewText := RegExReplace(NewText, "m)(^\s+)")
                            ; NewText := RegExReplace(NewText, " [ `t]+")
                            ; NewText := RegExReplace(NewText, "[ `t]{2,}")
                            ; NewText := RegExReplace(NewText,  " {2,}", " ")
                            ; NewText := RegExReplace(NewText, "m)(^\s+)|(\s+$)")
                        case "ts":                                              ; trim leading spaces
                            NewText := RegExReplace(AccessCache(path,,0), "m)^( +|`t+)( +)")
                        case "tt":                                              ; trim leading tabs
                            NewText :=   RegExReplace(AccessCache(path,,0),  "m)^`t+")
                            NewText := RegExReplace(NewText,  " [ `t]+", " ")
                        case "cl":                                              ; replaces multiple blank lines with 1
                            NewText := RegExReplace(AccessCache(path,,0), "(`r`n){2,}", "`r`n`n")
                        case "!l","nl":                                         ; removes all blank lines
                            NewText := RemoveBlankLines(,AccessCache(path,,0))
                        case "i:":                                              ;insert line line
                            dPos := InStr(C_input, ":")
                            lines := substr(C_input,4,dPos-4)                   ;last term is length not end position
                            text_to_add := !substr(C_input, dPos+1) ? "`n" : substr(C_input, dPos+1)
                            NewText := TF_InsertLine(AccessCache(path,,0), lines, , text_to_add)
                        default:
                            msgbox, error
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
                return 2
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
                            MsgBox,4100,Create Hotstring,%msg% 
                            IfMsgBox Yes
                            {
                                FileCreateDir, %f_path%%ndir%
                            } else 
                                return 1
                        } 
    
                        Msgbox % "`ndest_path: " . dest_path . "`n source_path: " .  source_path
                        Filecopy,%source_path%,%dest_path%,1    ; 1 = overwrite 
                        ; PU(oFileName . " copied to " . nFileName,lgreen,C.bgreen,,,-2000)
                    } catch {
                        PU("invalid file path",C.lgreen,C.bgreen,,,-2000)
                    }
                }
                goto, Load
            Case "D":                                                           ; delete file
                if (UserInput == "D") {
                    SplitPath,% GC("CB_title_file",""), FileName, Dir, Extension, NameNoExt
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
                sleep med
                C_input := "l"
                gosub, Load
                return 1
            Case "R":                                                           ; replace string 
                C_3          := SubStr(C_input, 1, 3) , sep1 := GC("Rsep1","~")
                C4_Remainder := SubStr(C_input, 4)    , sep2 := GC("Rsep2","__") 
                        
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
                        ActivateWin("ahk_id " tgt_hwnd)      
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
                ActivateWin("ahk_id " tgt_hwnd)   
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
            Case "G":                                                           ; run function (broken right now)
                
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
                        UDSelect("down", "10", C_input)
                }
                ;GUI 2: destroy
                return 3
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
                GUI 2: destroy
                return
            Case "H","N","Q":
                RunOtherCB(C_input, 1stChar) 
            
            Case "W": SaveLinkOps(C_input,"W_LINKS","Saved W_Links")
                
            Case "B": SaveLinkOps(C_input,"B_LINKS","Saved B_Links")
                
            Case "U": SaveLinkOps(C_input,"U_LINKS","Saved U_Links")
            Case "M":                                                           ; move tgt window
                switch C_input
                {
                      case "q", "TL"   : MoveWin("TL")                          ;move tgt window to top left                      
                      case "e", "TR"   : MoveWin("TR")                          ;move tgt window to top right                     
                      case "z", "BL"   : MoveWin("BL")                          ;move tgt window to bottom left                   
                      case "c", "BR"   : MoveWin("BR")                          ;move tgt window to bottom right                  
                      case "w", "T"    : MoveWin("T")                           ;move tgt window to top half                      
                      case "s", "B"    : MoveWin("B")                           ;move tgt window to bottom half                   
                      case "a", "L"    : MoveWin("L")                           ;move tgt window to left half                     
                      case "d", "R"    : MoveWin("R")                           ;move tgt window to right half                    
                      case "+a", "LS"  : MoveWin("LS")                          ;move tgt window to left side small               
                      case "+d", "RS"  : MoveWin("RS")                          ;move tgt window to right side small              
                      case "+w", "TS"  : MoveWin("TS")                          ;move tgt window to top half small                
                      case "+s", "BS"  : MoveWin("BS")                          ;move tgt window to bottom half small             
                      case "<+q", "L1" : MoveWin("L1")                          ;move tgt window to top left small      
                      case "L2"        : MoveWin("L2")                          ;move tgt window to top left small      
                      case "L3"        : MoveWin("L3")                          ;move tgt window to top left small      
                      case "<+z", "L4" : MoveWin("L4")                          ;move tgt window to bottom left small   
                      case "<+e", "R1" : MoveWin("R1")                          ;move tgt window to top right small     
                      case "R2"        : MoveWin("R2")                          ;move tgt window to top right small     
                      case "R3"        : MoveWin("R3")                          ;move tgt window to top right small     
                      case "<+c", "R4" : MoveWin("R4")                          ;move tgt window to bottom right small  
                      case ">+q", "L1v": MoveWin("L1v")                         ;move tgt window to top left small (portrait)    
                      case ">+e", "R1v": MoveWin("R1v")                         ;move tgt window to top right small (portrait)   
                      case ">+z", "L4v": MoveWin("L4v")                         ;move tgt window to bottom left small (portrait) 
                      case ">+c", "R4v": MoveWin("R4v")                         ;move tgt window to bottom right small (portrait)
                      case "^e", "R1s" : MoveWin("R1s")                         ;move tgt window to top right smallest            
                      case "^q", "L1s" : MoveWin("L1s")                         ;move tgt window to top left smallest             
                      case "^z", "L4s" : MoveWin("L4s")                         ;move tgt window to bottom left smallest          
                      case "^c", "R4s" : MoveWin("R4s")                         ;move tgt window to bottom right smallest         
                }
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
                }
                switch case
                {
                    Case "ta"      : search("www.macmillanthesaurus.com/", strng)                                 
                    Case "da"      : search("https://www.macmillandictionary.com/us/dictionary/american/", strng)                                 
                    Case "t"       : search("www.thesaurus.com/browse/", strng)    
                    Case "m"       : search("https://www.google.com/maps/search/", strng)    
                    Case "d"       : search("www.dictionary.com/browse/", strng)  
                    Case "f"       : search("www.finviz.com/quote.ashx?t=", strng) 
                    Case "yf"      : search("ca.finance.yahoo.com/quote/", strng) 
                    case "y"       : search("www.youtube.com/results?search_query=", strng)
                    case "i"       : search("www.google.com/search?tbm=isch&q=", strng)
                    Case "w"       : search("en.wikipedia.org/w/index.php?search=", strng) 
                    Case "n"       : search("news.google.com/search?q=", strng) 
                    Case "a"       : search("www.autohotkey.com/docs/search.htm?q=", strng, "&m=2")
                    Case "ae"      : search("www.aliexpress.com/wholesale?catId=0&initiative_id=SB_20210825091515&SearchText=", strng)
                    Case "e","ebay": search("www.ebay.ca/sch/", strng)
                    Case "so"      : search("www.stackoverflow.com/search?q=", strng) 
                    Case "mse"     : search("math.stackexchange.com/search?q=", strng) 
                    Case "se"      : search("stackexchange.com/search?q=", strng) 
                    Case "bv"      : search("www.bing.com/videos/search?q=", strng) 
                    Case "imdb"    : search("www.imdb.com/find?q=", strng) 
                    Case "io","fd" : search("www.investopedia.com/search?q=", strng) 
                    Case "az","amz": search("www.amazon.ca/s?k=", strng) 
                    Case "twt"     : search("www.twitter.com/search?q=", strng)
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
                return 2
            Case "T":
                C_First2chr := SubStr(C_input, 1, 2) 
                C3_Remainder := SubStr(C_input, 3)
                Switch C_input 
                {
                    case "persistent"  ,"p"  : TC("CB_persistent" , "Toggle persistent mode: ")
                    case "scrollbars"  ,"s"  : TC("CB_ScrollBars" , "Toggle scrollbars: ")
                    case "title"       ,"t"  : TC("CB_Titlebar"   , "Toggle titlebar: ")
                    case "focus"       ,"a"  : TC("CB_appActive"  , "Toggle application focus: ")
                        return 2
                    case "renter input","r"  : TC("CB_reenterInput" , "Re-enter last submit: ")
                    case "lrows"  : TC("CB_reenterInput" , "Re-enter last submit: ")
                    case "wrap_text" ,"w"    : TC("CB_Wrap", "Toggle text wrap: ")
                        return 2
                    case "default"   ,"d"    : ToggleDisplay("display")
                    case "minimized" ,"m"    : ToggleDisplay("minimal")
                    Case "lshift", "ls"      : TC("T_lshift", "Toggle Lshift HJKL") 
                    default:
                }

                UpdateGUI()
                return 2
                ; return 1

            Default:
                return 1
        } 
        return 1
    } 
    Else 
    {
        RunLabel(UserInput, suffix, tgt_hwnd)
    }
    return
 }


 
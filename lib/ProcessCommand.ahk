; query 412

ProcessCommand(UserInput, suffix, title, fsz, fnt, w_color, t_color) {
    global config_path, long, med, short, tgt_hwnd, CB_hwnd, C
    1stChar := SubStr(UserInput, 1, 1), 2ndChar := SubStr(UserInput, 2 , 1)
    f_path := A_ScriptDir "\mem_cache\" 

    ; if RegExMatch(1stChar,"[0-9A-Z\?jk:]") 
    if (1stChar ~= "[0-9A-Z\?jk:]")
    {
        C_input := SubStr(UserInput, 2)                                         ; everything after the first character
        SplitPath, C_input, FileName, Dir, Extension, NameNoExt                 ; parses everything after the command character as a file path 
        dir := dir ? dir . "\" : ""
        Switch 1stChar                                                        ; free: h,i,u,x,y
        { 
            Case 1,2,3,4,5,6,7,8,9,0:
                NameNoExt := 1stChar
                C_input := 1stChar
                gosub, Load
                return 1
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
                    SplitPath, file_path, , Dir, Extension, NameNoExt 
                    sleep, long * 0.8
                    goto, addTextToFile

                } else if (C_input ~= " .+") {                          ;# append|prepend 1st file to 2nd file; RegExMatch(C_input, " .+")                         
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
                    path         = %f_path%%Dir%%NameNoExt%.txt
                }

                addTextToFile:
                    path = %f_path%%Dir%%NameNoExt%.txt
                    % (1stChar == "A") 
                        ? FileAppend(path, text_to_add)
                        : FilePrepend(path, text_to_add)
                    goto, Load

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
                
                if (C_input = "C") {
                    NameNoExt := "config.ini"
                    RegExMatch(config_path, ".*(?=config.ini)", dir)           ; get everything before the last title separator and store in v
                    CC("CB_last_display", dir NameNoExt)
                    txt  := AccessCache(NameNoExt,dir, False)
                    tgt := f_path dir NameNoExt

                } else if (C_input = "K") {                                     ; shortcut list 
                    NameNoExt := "HotKey_List"
                    dir := "..\"
                    CC("CB_last_display", dir NameNoExt)
                    txt  := AccessCache(NameNoExt,dir, False)
                    tgt := f_path dir NameNoExt

                } else if (C_input = ">") or (C_input = ":")  {                                     ; clipboard 
                    try {
                        txt := Clipboard
                        NameNoExt := "Clipboard Contents", dir := ""
                        goto, updateGUI
                    } catch e {
                        PopUp("Sorry the CB only displays text strings", , ,, , drtn = "-2000") 
                        return 1
                    }
                } else if (C_input = "H") {                                     ; User Input History 
                    NameNoExt := "_hist.txt [starting with most recent]"
                    dir := ""
                    CC("CB_last_display", dir NameNoExt)
                    txt  := AccessCache(RegExReplace(NameNoExt, "\[.+?\]"),dir, False)
                } else if (2ndChar = "#") {                                     ; get first lines from 0-9.txt memory files                        
                    remainder := substr(C_input,2)
                    txt := % regexmatch(remainder, "\d+") ? GetNumMemLines(,remainder) : GetNumMemLines()
                    NameNoExt := "First lines of 0-9.txt"
                    dir := ""
                } else if (2ndChar = "@") or (2ndChar = "I") {                  ; get first lines from 0-9.txt memory files 
                    remainder := substr(C_input,2)
                    txt := % regexmatch(remainder, "\d+") ? GetNumMemLines(,remainder,,1) : GetNumMemLines(,,,1)
                    NameNoExt := "First lines of 1 character files"
                    dir := ""
                } else if (!FileExist(tgt ".txt") and !FileExist(tgt ".ini")) 
                  or (C_input = "L") {
                    NameNoExt := "list"
                    CC("CB_last_display", dir NameNoExt)
                    txt := CreateCacheList("list")
                    tgt := f_path dir NameNoExt

                } else {
                    CC("CB_last_display", dir NameNoExt)
                    txt  := AccessCache(NameNoExt,dir, False)
                }

                updateGUI:
                new_title_file := dir . NameNoExt . RetrieveExt(tgt)            ; new_title_file := """" dir """" . NameNoExt . RetrieveExt(tgt)
                CC("CB_title", new_title_file)
                UpdateGUI(txt, new_title_file)
                return 1

            Case "O":                                                           ; overwrite file/clipboard
                C_input := RegExReplace(C_input, "S) +", A_Space)               ; replaces multiple spaces w/ 1        

                If ((2ndChar == ">") or (2ndChar == ":")) and RegExMatch(C_input,"[0-9A-Za-z]") { ; if C_input starts with ">" and there's a file name overwrite file w/ clipboard
                    NameNoExt := trim(C_input, " >:")
                    dir := (InStr(dir, ">")) ? "" : dir
                    dir := (InStr(dir, ":")) ? "" : dir
                    WriteToCache(namenoext,,dir,clipboard)   
                    goto, load
                } else If ((SubStr(C_input, 0) == ">") or (SubStr(C_input, 0) == ":")) {                           ; if C_input ends in ">" overwrite clipboard with file contents                           
                    
                    C_input := trim(C_input, " >:")
                    SplitPath, C_input, , Dir, , NameNoExt 
                    clipboard := AccessCache(NameNoExt,dir, False)
                    C_input := ">"
                    goto, load
                } else If (InStr(SubStr(C_input, 2), ":")) {
                    dPos        := InStr(C_input, ":")
                    SplitPath,% substr(C_input, 1, dPos-1), FileName, Dir, Extension,                               ; parses everything after the command character as a file pathNameNoExt               
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
                } else If RegExMatch(C_input, " .+") {                                                        ; remaining case: two filenames given, w/ 1st overwriting the 2nd
                    arr := StrSplit(C_input, " ")
                    SplitPath,% arr[1], 1FileName, 1Dir, 1Extension, 1NameNoExt
                    SplitPath,% arr[2], FileName, Dir, Extension, NameNoExt 
                    1dir := 1dir ? 1dir . "\" : ""
                    dir := dir ? dir . "\" : ""
                    if FileExist(f_path 1dir 1NameNoExt ".txt")
                    {
                        try {
                            Filecopy,% f_path . 1Dir . 1NameNoExt . ".txt",% f_path . Dir . NameNoExt . ".txt", 1
                        } catch {
                            PopUp("invalid path",C.lgreen,C.bgreen,,,-2000)
                            UpdateGUI()
                        }
                    }
                    goto, load
                }
                return 2
            Case "V":                                                           ; paste file contents
                ; sleep, short
                namenoext := namenoext ? namenoext : GC("CB_title","")
                ActivateWin("ahk_id"  tgt_hwnd)
                AccessCache(namenoext, dir)
                ; PopUp(namenoext " pasted",C.lgreen,"000000", "230", "70", "-300", "14", "610")
                return
            Case "E":                                                           ; edit file
                if !C_input {
                    path := f_path dir RegExReplace(GC("CB_title",""), "\[.+?\]")
                    if FileExist(path) 
                        EF(path)
                } else {
                    input := f_path Dir FileName
                    if FileExist(input ".txt") 
                        input .= ".txt"
                    else if FileExist(input ".ini") 
                        input .= ".ini"
                    EditFile(input)
                }
                return 1
            Case "C":                                                           ; copy file
                If !RegExMatch(C_input, " .+")                                  ; if no second file name given add suffix  
                {
                    PopUp("DUPLICATE DETECTED!`nappending suffix to filename", lpurple,purple )
                    var := 1
                    Filecopy,%f_path%%C_input%.txt,%f_path%%Dir%%namenoext%_%var%.txt,0
                    exist = %ErrorLevel%                                        ; get the error level 0 = no errors
                    while exist > 0                                             ; what to do if there is an error like filename already exists
                    {
                        PopUp("DUPLICATE DETECTED!`nappending suffix to filename", lpurple,purple )
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
                        dest_path := C_input := f_path . nDir . nNameNoExt . ".txt"
                        source_path :=  f_path oDir oNameNoExt ".txt"
                        Filecopy,%source_path%,%dest_path%, 1    ; 1 = overwrite 
                        ; PopUp(oFileName . " copied to " . nFileName,lgreen,C.bgreen,,,-2000)
                    } catch {
                        PopUp("invalid file path",C.lgreen,C.bgreen,,,-2000)
                    }
                }
                goto, Load
            Case "D":                                                           ; delete file
                if (C_input == "D") {
                    namenoext := RegExReplace(GC("CB_title",""), "\[.+?\]")
                    FileDelete,% f_path . NameNoExt 
                } else {
                    if (extension) {
                        FileDelete,% f_path . Dir . NameNoExt . "." . extension
                    } else {
                        FileDelete,% f_path . Dir . NameNoExt . ".txt"
                    }
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
                        CC("Rsep1", C4_Remainder), PU("Rsep1: " C4_Remainder), UpdateGUI()
                        return 1
                    case "2~:":
                        CC("Rsep2", C4_Remainder), PU("Rsep2: " C4_Remainder), UpdateGUI()
                        return 1
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
                        ActivateWin("ahk_id " tgt_hwnd)      
                        vtext := clip()                       
                        arrN := StrSplit(C_input, GC("Rsep2", "__"))  
                        loop % arrN.MaxIndex()
                        {
                            AB := StrSplit(arrN[A_index], GC("Rsep1", "~"))
                            vtext := ReplaceAwithB(AB[1], AB[2],vtext,0,0)
                        }
                        clip(vtext)   
                        return

                }        
                return
            Case "F":                                                           ; fill space with char 
                sleep, short
                ActivateWin("ahk_id " tgt_hwnd)                             
                arr := StrSplit(C_input, "~")
                FillChar(arr[2], arr[1], 0)
                return 
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

                switch 
                {   
                    case SubStr(C_input, 1 , 1) == ":":
                        ; implement option here to run native ahk syntax
                        return 1
                    case C_First2chr == "f:":                                   ; create function name alias
                        arr := StrSplit(C3_Remainder, "~")
                        IniWrite,% arr[2], %f_path%ALIAS.ini, function,% arr[1]
                        UpdateGUI()
                        return 1
                    case C_First2chr == "p:":                                   ; create parameter alias
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
                GUI 2: destroy
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
                GUI 2: destroy
                return
            Case "W","B","N","M":
                
                RunOtherCB(C_input, 1stChar) 
            Case "Q":                                                           ; query selected text in chosen search engine msft
                
                if (InStr(C_input, ":")) {                                      ; get search string from command box if colon detected
                    dPos  := InStr(C_input, ":")
                    case  := substr(C_input, 1, dPos-1)
                    strng := substr(C_input, dPos+1)
                }
                else                                                            ; get search string from selected text
                {
                    case := C_input
                    strng := ""
                }
                switch case
                {
                    Case "t"       : search("www.thesaurus.com/browse/", strng)                                 
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
                    Case "bv"      : search("www.bing.com/videos/search?q=", strng) 
                    Case "imdb"    : search("www.imdb.com/find?q=", strng) r
                    Case "id","fd" : search("www.investopedia.com/search?q=", strng) 
                    Case "az","amz": search("www.amazon.ca/s?k=", strng) 
                    Case "twt"     : search("www.twitter.com/search?q=", strng)
                    default : 
                        search(, strng)                                         ; defaults to google search
                }            
                SetTimer, CFW, -600
                return
            Case "S":                                                           ; search selected text
                OpenFolder("mem_cache\")
                ActivateApp("explorer.exe", A_ScriptDir "\mem_cache\", False)
                sleep 400
                SelectByRegEx(C_input)
                return
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
                Switch C_input 
                {
                    case "persistent"  ,"p"  : TC("CB_persistent" , "Toggle persistent mode: ")
                    case "scrollbars"  ,"s"  : TC("CB_ScrollBars" , "Toggle scrollbars: ")
                    case "title"       ,"t"  : TC("CB_Titlebar"   , "Toggle titlebar: ")
                    case "focus"       ,"a"  : 
                        TC("CB_appActive"  , "Toggle application focus: ")
                        return 2
                    case "renter input","r"  : TC("CB_reenterInput" , "Re-enter last submit: ")
                    case "wrap_text" ,"w": 
                        TC("CB_Wrap", "Toggle text wrap: ")
                        return 2
                    case "default"   ,"d": 
                        ToggleDisplay("display")
                    case "minimized" ,"m": 
                        ToggleDisplay("minimal")
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
    return 1
 }
ProcessCommand(UserInput, suffix, title, fsz, fnt, w_color, t_color) {
    global config_path, File_DICT, Folder_DICT, long, med, short, tgt_hwnd, CB_hwnd, C
    FirstChar := SubStr(UserInput, 1 , 1)
    f_path := A_ScriptDir "\mem_cache\" 

    if RegExMatch(FirstChar,"[0-9A-Z\?jk:]") 
    {
        C_input := SubStr(UserInput, 2)                                         ; everything after the first character
        SplitPath, C_input, FileName, Dir, Extension, NameNoExt                 ; msgbox % C_input "`n`nFileName: " FileName "`nDir: " Dir "`nExtension: " Extension "`nNameNoExt: " NameNoExt
        dir := dir ? dir . "\" : ""
        Switch FirstChar                                                        ; free: h,i,u,x,y
        { 
            Case 1,2,3,4,5,6,7,8,9,0:
                NameNoExt := FirstChar
                C_input := FirstChar
                gosub, Load
                return 1
            Case "?":                                                           ; load help.txt file in display
                NameNoExt := "help"
                C_input := "help"
                gosub, Load
                return 1
            Case "A", "P":                                                      ; append|prepend selected text
                ActivateWin("ahk_id " tgt_hwnd) 
                sleep, short
                text_to_add := "`n" . trim(clip())
                if (InStr(C_input, ":")) {
                    
                    dPos  := InStr(C_input, ":")
                    SplitPath,% substr(C_input, 1, dPos-1), FileName, Dir, Extension, NameNoExt
                    text_to_add := substr(C_input, dPos+1)
                    if (FirstChar == "A") {
                        FileAppend,% "`n" text_to_add, %f_path%%Dir%%NameNoExt%.txt    
                        PopUp( """" text_to_add """" " added to bottom of`n" NameNoExt ,C.lgreen)  
                    } else if (FirstChar == "P") {
                        FilePrepend(f_path Dir NameNoExt ".txt", text_to_add "`n") 
                        PopUp("added to top of`n" NameNoExt ,C.lgreen)
                    }
                    return 1
                }
                else if RegExMatch(C_input, " .+") {
                    arr := StrSplit(C_input, " ")
                    SplitPath,% arr[2], oFileName, oDir, oExtension, oNameNoExt 
                    SplitPath,% arr[1], nFileName, nDir, nExtension, nNameNoExt 
                    odir := odir ? odir . "/" : "" 
                    ndir := ndir ? ndir . "/" : ""
                    donorText := AccessCache(nNameNoExt, ndir, false)
                    PU(odir)
                    if (FirstChar == "A") {
                        FileAppend, % "`n" donorText, %f_path%%oDir%%oNameNoExt%.txt    
                        PopUp( nNameNoExt " added to bottom of`n" oNameNoExt ,C.lgreen)  
                    } else if (FirstChar == "P") {
                        FilePrepend(f_path Dir NameNoExt ".txt", donorText "`n") 
                        PopUp(nNameNoExt " added to top of`n" oNameNoExt ,C.lgreen)
                    }               

                } else if (FirstChar == "A") {
                    append_file:
                    FileAppend,% "`n" text_to_add, %f_path%%Dir%%NameNoExt%.txt    
                    PopUp("added to bottom of`n" NameNoExt ,C.lgreen)  
                } else if (FirstChar == "P") {
                    FilePrepend(f_path Dir NameNoExt ".txt", text_to_add "`n") 
                    PopUp("added to top of`n" NameNoExt ,C.lgreen)
                }    
                gosub, Load
                return 1    
            Case "L":                                                           ; display file in command box

                Load:         

                if !GC("CB_Display") {
                    CC("CB_Display", 1), CC("CB_Titlebar", 1), CC("CB_ScrollBars", 0)
                    MI := StrSplit(GetMonInfo()," ")                            ; get monitor dimensions
                    d := "x" MI[3] // 2 " y0 w" MI[3] // 2 " h" MI[4] // 2 
                    CC("CB_position", d)
                }

                tgt := f_path dir NameNoExt

                if (C_input = "H" or C_input = "C") {
                    NameNoExt := (C_input = "H") ? ("HotKey_List") : ("config.ini")
                    RegExMatch(config_path, ".*(?=config.ini)", cpth)           ; get everything before the last title separator and store in v
                    dir := (C_input = "H") ? ("..\") : cpth
                    CC("CB_last_display", dir NameNoExt)
                    txt  := AccessCache(NameNoExt,dir, False)
                    tgt := f_path dir NameNoExt

                } else if (C_input = ";") {
                    try {
                        txt := Clipboard
                        NameNoExt := "Clipboard Contents", dir := ""
                    } catch e {
                        PopUp("Sorry the CB only displays text strings", , ,, , drtn = "-2000") 
                        return 1
                    }

                } else if (substr(C_input,1,1) = "#") {                         ; get first lines from 0-9.txt memory files 
                    txt := GetNumMemLines()
                    NameNoExt := "First Line of 0-9.txt", dir := ""
                    
                } else if (!FileExist(tgt ".txt") and !FileExist(tgt ".ini")) 
                  or (C_input = "l") {
                    NameNoExt := "list"
                    CC("CB_last_display", dir NameNoExt)
                    txt := CreateCacheList("list")
                    tgt := f_path dir NameNoExt

                } else {
                    CC("CB_last_display", dir NameNoExt)
                    txt  := AccessCache(NameNoExt,dir, False)
                }
                new_title_file := dir . NameNoExt . RetrieveExt(tgt)            ; new_title_file := """" dir """" . NameNoExt . RetrieveExt(tgt)
                CC("CB_title", new_title_file)
                UpdateGUI(txt, new_title_file)
                return 1

            Case "O":                                                           ; overwrite file/clipboard
                C_input := RegExReplace(C_input, "S) +", A_Space)               
                If (SubStr(C_input, 1 , 1) == ";")                              ; if C_input starts in ";" overwrite clipboard with file contents
                {
                    C_input := trim(SubStr(C_input, 2))
                    SplitPath, C_input, , Dir, , NameNoExt 
                    clipboard := AccessCache(NameNoExt,dir, False)
                    return 1
                }
                else If (SubStr(C_input, 0) == ";")                             ; if C_input ends in ";" overwrite file with clipboard contents
                {
                    NameNoExt := rtrim(C_input, ";")
                    dir := (InStr(dir, ";")) ? "" : dir
                    WriteToCache(namenoext,,dir,clipboard)   
                    return 1
                }
                else If !RegExMatch(C_input, " .+")                             ; if there's no second file name, overwrite with selected text
                { 
                    
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
                    gosub, Load
                    return 1 

                } else {                                                        ; remaining case must be two filenames given, w/ 2nd overwriting the 1st 
                    arr := StrSplit(C_input, " ")
                    SplitPath,% arr[1], oFileName, oDir, oExtension, oNameNoExt 
                    SplitPath,% arr[2], nFileName, nDir, nExtension, nNameNoExt 
                    odir := odir ? odir . "/" : ""
                    ndir := ndir ? ndir . "/" : ""
                    if FileExist(f_path ndir nNameNoExt ".txt")
                    {
                        try {
                            Filecopy,% f_path . nDir . nNameNoExt . ".txt",% f_path . oDir . oNameNoExt . ".txt", 1
                            PopUp(oFileName . " overwritten with " . nFileName,C.lgreen,C.bgreen,,,-1000)
                            txt  := AccessCache(oNameNoExt,dir, False)
                            new_title_file := oNameNoExt . ".txt" 
                        } catch {
                            PopUp("invalid path",C.lgreen,C.bgreen,,,-2000)
                            UpdateGUI()
                        }
                    }
                    UpdateGUI(txt, new_title_file)
                }
                return 1
            Case "V":                                                           ; paste file contents
                sleep, short
                ActivateWin("ahk_id"  tgt_hwnd)
                AccessCache(namenoext, dir)
                PopUp(namenoext " pasted",C.lgreen,"000000", "230", "70", "-600", "14", "610")
                return
            Case "E":                                                           ; edit file
                if !C_input
                    FunctionBox("EditFile", File_DICT, lgreen)
                else if (C_input == "F")
                    FunctionBox("OpenFolder", Folder_DICT, lblue)
                else    
                {
                    input := f_path Dir FileName
                    if FileExist(input ".txt") 
                        input .= ".txt"
                    else if FileExist(input ".ini") 
                        input .= ".ini"
                    EditFile(input)
                }
                return
            Case "C":                                                           ; copy file
                If !RegExMatch(C_input, " ")
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
                else
                {
                    try {
                        arr := StrSplit(C_input, " ")
                        SplitPath,% arr[1], oFileName, oDir, oExtension, oNameNoExt 
                        SplitPath,% arr[2], nFileName, nDir, nExtension, nNameNoExt 
                        odir := odir ? odir . "/" : ""
                        ndir := ndir ? ndir . "/" : ""
                        Filecopy,% f_path . oDir . oNameNoExt . ".txt",% f_path . nDir . nNameNoExt . ".txt", 1    ; 1 = overwrite 
                        PopUp(oFileName . " copied to " . nFileName,lgreen,C.bgreen,,,-2000)
                    } catch {
                        PopUp("invalid file path",C.lgreen,C.bgreen,,,-2000)
                    }
                }
                return 1
            Case "D":                                                           ; delete file
                if (extension) {
                    FileDelete,% f_path . Dir . NameNoExt . "." . extension
                } else {
                    FileDelete,% f_path . Dir . NameNoExt . ".txt"
                }
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
                arr := StrSplit(C_input, ",")
                FillChar(arr[2], arr[1], 0)
                return 
            Case "G":                                                           ; run function (broken right now)
                
                C_First2chr := SubStr(C_input, 1, 2) 
                C3_Remainder := SubStr(C_input, 3)

                switch 
                {   
                    case SubStr(C_input, 1 , 1) == ":":
                        msgbox % 2
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
                    if (FirstChar == "j")
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
                    if (FirstChar == "k")
                        UDSelect("Up", "10", C_input, false)
                    else
                        UDSelect("Up", "10", C_input)
                }
                GUI 2: destroy
                return
            Case "W","B","N","M":
                
                RunOtherCB(C_input, FirstChar) 
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

                return
            Case "S":                                                           ; search selected text
                OpenFolder("mem_cache\")
                ActivateApp("explorer.exe", A_ScriptDir "\mem_cache\", False)
                sleep 400
                SelectByRegEx(C_input)
                return
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
                    CC("CBfnt", "Consolas"), CC("CBfsz", "13"), CC("CBfwt", "500")               
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
                    reload
                }
                AutoXYWH("wh*", "CB_Display")
                CtrXpos := (A_GuiWidth - GC("CB_InputBox_width")) // 2
                GuiControl, MoveDraw, UserInput, x%CtrXpos%
                AutoXYWH("y*", "UserInput")
                return 2
            Case "T":
                Switch C_input 
                {
                    case "persistent","p": TglCFG("CB_persistent", "Toggle persistent mode: ")
                    case "scrollbars","s": TglCFG("CB_ScrollBars", "Toggle scrollbars: ")
                    case "title"     ,"t": TglCFG("CB_Titlebar"  , "Toggle titlebar: ")
                    case "focus"     ,"a": TglCFG("CB_appActive" , "Toggle application focus: ")
                    case "wrap_text" ,"w": 
                        TglCFG("CB_Wrap", "Toggle text wrap: ")
                        return 2
                    case "default"   ,"d": 
                        CC("CB_Display", 1), CC("CB_Titlebar", 1), CC("CB_ScrollBars", 0),CC("CB_persistent",0),CC("CB_appActive",0),CC("CB_Wrap",0)
                        , MI := StrSplit(GetMonInfo()," "), CC("CBfsz", "10")                              
                        , d := "x" MI[3] // 2 " y0 w" MI[3] // 2 " h" MI[4] // 2 
                        , CC("CB_position", d)
                    case "minimized" ,"m": 
                        CC("CB_Titlebar",0), CC("CB_Display",0) ,CC("CB_persistent",0),CC("CB_appActive",0),CC("CB_Wrap",0) 
                        , IBw := GC("CB_InputBox_width"), CC("CBfsz", "10")
                        , MI := StrSplit(GetMonInfo()," ")                                
                        , cX := (MI[3] - IBw) // 2
                        , bY := MI[4] - 25
                        , mw := IBw + 4
                        , mh := 40 
                        , CC("CB_position","x" cX " y" bY " w" mw " h" mh)
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
    GUI 2: destroy
    return 1
 }
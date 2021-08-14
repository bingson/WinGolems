FModuleDefault(UserInput, FirstChar, title) {
    global config_path, File_DICT, Folder_DICT, long, med
    global lg, pink, lblue, black, lpurple, purple, green, red, lgreen
    f_path := A_ScriptDir "\mem_cache\" 
    C_input := SubStr(UserInput, 2)                                         ; everything after the first character
    SplitPath, C_input, FileName, Dir, Extension, NameNoExt                 ; msgbox % C_input "`n`nFileName: " FileName "`nDir: " Dir "`nExtension: " Extension "`nNameNoExt: " NameNoExt
    ; msgbox % C_input "`n`nFileName: " FileName "`nDir: " Dir "`nExtension: " Extension "`nNameNoExt: " NameNoExt
    dir := dir ? dir . "\" : ""
    
    Switch FirstChar
    {
        Case 1,2,3,4,5,6,7,8,9,0:
            NameNoExt := FirstChar
            C_input := FirstChar
            gosub, Load
            return 1
        Case "?":
            NameNoExt := "help"
            C_input := "help"
            gosub, Load
            return 1
        Case "A", "P":                                                      ; append|prepend selected text
            ActivateWindow("ahk_id " tgt_winID) 
            text_to_add := "`n" . trim(clip())
            if (FirstChar == "A") {
                FileAppend, %text_to_add%, %f_path%%Dir%%NameNoExt%.txt    
                PopUp("added to bottom of`n" NameNoExt ,,"250",,,,,lgreen)  
            } else {
                FilePrepend(f_path Dir NameNoExt ".txt", text_to_add) 
                PopUp("added to top of`n" NameNoExt ,,"250",,,,,lgreen)
            }    
            sleep 800
            gosub, Load
            return 1    
        Case "L":                                                           ; display file in command box
            Load:                                                    
            if !FileExist(f_path dir NameNoExt ".txt") or (C_input = "list") {
                txt  := CreateCacheList("list")
            } else {
                IniWrite, %dir%%NameNoExt%, %config_path%, %A_ComputerName%, CB_last_display
                txt  := AccessCache(NameNoExt,dir, False)
            }
            new_title_file := dir . NameNoExt . ".txt"
            UpdateGUI(txt, new_title_file)
            sleep med
            return 1
        Case "O":                                                           ; overwrite file/clipboard
            C_input := RegExReplace(C_input, "S) +", A_Space)
            If (SubStr(C_input, 1 , 1) == ":") 
            {
                C_input := trim(SubStr(C_input, 2))
                SplitPath, C_input, , Dir, , NameNoExt 
                clipboard := AccessCache(NameNoExt,dir, False)
                return
            }
            else If !RegExMatch(C_input, " .+")
            {                    
                ActivateWindow("ahk_id " tgt_winID) 
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
                sleep 800
                gosub, Load
                return 1 
            } else {
                arr := StrSplit(C_input, " ")
                SplitPath,% arr[1], oFileName, oDir, oExtension, oNameNoExt 
                SplitPath,% arr[2], nFileName, nDir, nExtension, nNameNoExt 
                odir := odir ? odir . "/" : ""
                ndir := ndir ? ndir . "/" : ""

                if FileExist(f_path odir oNameNoExt ".txt") and FileExist(f_path ndir nNameNoExt ".txt")
                {
                    try {
                        Filecopy,% f_path . nDir . nNameNoExt . ".txt",% f_path . oDir . oNameNoExt . ".txt", 1
                        PopUp(oFileName . " overwritten with " . nFileName,green,,,-1000,,,lgreen)
                        sleep 800
                        txt  := AccessCache(oNameNoExt,dir, False)
                        new_title_file := oNameNoExt . ".txt" 
                    } catch {
                        PopUp("invalid path",green,,,-2000,,,lgreen)
                        sleep 800
                        redrawGUI()
                    }
                }
                UpdateGUI(txt, new_title_file)
            }
            return 1
        Case "V":                                                           ; paste file contents
            ActivateWindow("ahk_id" tgt_winID)
            AccessCache(namenoext, dir)
            PopUp(namenoext " pasted", "000000", "230", "70", "-600", "14", "610", lgreen)
            return
        Case "E":                                                           ; edit file
            if !C_input
                FunctionBox("EditFile", File_DICT, lgreen)
            else if (C_input == "F")
                FunctionBox("OpenFolder", Folder_DICT, lblue)
            else    
            {
                FileName := !Extension ? FileName . ".txt" : FileName
                EditFile(f_path Dir FileName)
            }
            return
        Case "C":                                                           ; copy file
            If !RegExMatch(C_input, " ")
            {
                PopUp("DUPLICATE DETECTED!`nappending suffix to filename", purple,,,,,,lp )
                var := 1
                Filecopy,%f_path%%C_input%.txt,%f_path%%Dir%%namenoext%_%var%.txt,0
                exist = %ErrorLevel%                                        ; get the error level 0 = no errors
                while exist > 0                                             ; what to do if there is an error like filename already exists
                {
                    PopUp("DUPLICATE DETECTED!`nappending suffix to filename", purple,,,,,,lp )
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
                    Filecopy,% f_path . oDir . oNameNoExt . ".txt",% f_path . nDir . nNameNoExt . ".txt", 1  ; 1 = overwrite 
                    PopUp(oFileName . " copied to " . nFileName,green,,,-2000,,,lgreen)
                } catch {
                    PopUp("invalid file path",green,,,-2000,,,lgreen)
                }
            }
            return 1
        Case "R":                                                           ; replace string 
            C_First2chr := SubStr(C_input, 1, 2) 
            remainder := SubStr(C_input, 3)
            switch C_First2chr
            {
                case "1~":
                    IniWrite,%remainder%, %config_path%, %A_ComputerName%, Rsep1
                    return 1
                case "2~":
                    IniWrite,%remainder%, %config_path%, %A_ComputerName%, Rsep2
                    return 1
                Case "f~":
                    OuterArr := StrSplit(remainder, " ")
                    InnerArr := StrSplit(outerArr[1], "~")
                    SplitPath,% InnerArr[1], oFileName, oDir, oExtension, oNameNoExt                 ; msgbox % C_input "`n`nFileName: " FileName "`nDir: " Dir "`nExtension: " Extension "`nNameNoExt: " NameNoExt
                    SplitPath,% InnerArr[2], pFileName, pDir, pExtension, pNameNoExt
                    SplitPath,% OuterArr[2], nFileName, nDir, nExtension, nNameNoExt
                    odir := odir ? odir . "/" : ""
                    pdir := pdir ? pdir . "/" : ""
                    ndir := ndir ? ndir . "/" : ""
                    
                    otxt := AccessCache(oNameNoExt,oDir, False)
                    ptxt := AccessCache(pNameNoExt,pDir, False)
                    ptxt := StrReplace(ptxt, "`n")
                    ptxt := StrReplace(ptxt, "`r")
                    pArr := StrSplit(ptxt, "__")
                    
                    ntxt := otxt
                    loop % pArr.MaxIndex()
                    {
                        AB := StrSplit(pArr[A_index], "~")
                        ntxt := ReplaceAwithB(AB[1], AB[2],ntxt,0,0)
                    }
                    FileDelete,% f_path . nDir . nNameNoExt . ".txt"
                    FileAppend, %ntxt%, %f_path%%nDir%%nNameNoExt%.txt    
                    return

                default:
                    ActivateWindow("ahk_id " tgt_winID)      
                    vtext := clip()                       
                    arrN := StrSplit(C_input, "__")
                    loop % arrN.MaxIndex()
                    {
                        AB := StrSplit(arrN[A_index], "~")
                        vtext := ReplaceAwithB(AB[1], AB[2],vtext,0,0)
                    }
                    clip(vtext)   
                    
                    return

            }        
            return
        Case "F":                                                           ; fill space with char
            ActivateWindow("ahk_id " tgt_winID)                             
            arr := StrSplit(C_input, ",")
            FillChar(arr[2], arr[1], 0)
            return 
        Case "G":                                                           ; run function
            ActivateWindow("ahk_id" tgt_winID)
            arr := StrSplit(C_input, ",")
            if arr.MaxIndex() > 1 
            {
                params := ""
                p_num := arr.MaxIndex() - 1
                func := arr[1]
                arr.RemoveAt(1)
                for k, v in arr
                    params .= (k < p_num) ? v . "," : v
                %func%(params)
            }
            else
                %C_input%()
            return
        Case "J":                                                           ; select|goto rows below
            ActivateWindow("ahk_id " . tgt_winID)
            if (FirstChar == "j")
                UDSelect("down", "10", C_input, false)                      ; no selection just row movement
            else
                UDSelect("down", "10", C_input)
            return
        Case "K":
            ActivateWindow("ahk_id " . tgt_winID)                           ; select|goto rows above
            if (FirstChar == "k")
                UDSelect("Up", "10", C_input, false)
            else
                UDSelect("Up", "10", C_input)
            return
        Case "W":
            return
        Case "S":                                                           ; open cache folder in explorer and (case-insensitive) select files according to match string  
            OpenFolder("mem_cache\")
            WinWait, mem_cache,, 3
            SelectByRegEx(C_input)
            return
        Case "H":
            
            
            return
        Default:
            return 1
    } 
}
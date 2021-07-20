CreateCacheList(name = "l") {
    Global strFile := A_ScriptDir . "\mem_cache\" . name . ".txt"
    Global strDir  := A_ScriptDir . "\mem_cache\"
    FileDelete %strFile%
    Global cache_list := ""
    ShowPopUp("Type ""D" . name . """ to see a cache list",black,"250","120","-1000",,,lb)
    sleep 2000
    IniWrite, l, %config_path%, %A_ComputerName%, CB_last_display
    Loop Files, %strDir%*.txt, R  ; Recurse into subfolders.
    {   

        file := SubStr(A_LoopFileFullPath, strlen(strDir) + 1) . "`n"
        cache_list .= file
    }
    cache_list := "CACHE FOLDER LIST`n" 
    TF_MakeFile(Text, Lines = 1, 2)
    FileAppend, %cache_list%, mem_cache\%name%.txt
    return
 }

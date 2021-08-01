CreateCacheList(name = "cc") {
    Global strFile := A_ScriptDir . "\mem_cache\" . name . ".txt"
    Global strDir  := A_ScriptDir . "\mem_cache\"
    FileDelete %strFile%
    Global cacheList := ""
    global config_path
    IniWrite, %name%, %config_path%, %A_ComputerName%, CB_display
    
    max_len := count := 0
    Loop Files, %strDir%*.txt, R  ; Recurse into subfolders.
    {   
        file := SubStr(A_LoopFileFullPath, strlen(strDir) + 1) . "`n"
        count := count + 1
        cacheList .= file
        max_len := max(strlen(file), max_len)
    }
    halfCount := round(count/2,0) + 1
    arr := StrSplit(cacheList , "`n","`n",halfCount)
    right_arr := arr.Pop()
    Rarr := StrSplit(right_arr, "`n", "`n")
    cache_contents := ""
    char_width := 0
    loop % halfCount
    {
        space_len  := (max_len - strlen(arr[A_Index]))  
        s := RepeatString(" ", space_len)
        line := arr[A_Index] . s . Rarr[A_Index] . "`n" 
        cache_contents .= line
        char_width := max(strlen(line), char_width)

    }
    cache_contents := "CACHE CONTENTS`n" . RepeatString("-", char_width) . "`n`r" . cache_contents
    ; FileAppend, %cache_contents%, mem_cache\%name%.txt
    return % cache_contents
 }
OverwriteMemory(del_toggle = false) {
    global lb, short
    ;ReleaseModifiers()
    slot := substr(A_ThisHotkey, 0)        
    ; del_toggle := Instr(A_ThisHotkey, "del") ? True : False               ;     cut selected text hot key condition  
    WriteToCache(slot, del_toggle)                                          ;     note: if no text selected, no overwrite will occur 
    return
}

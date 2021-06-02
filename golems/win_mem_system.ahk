; MEMORY SYSTEM ________________________________________________________________
 
 ^#0::                                                                          ;[MS] copy selected text and overwrite mem slot 0
 ^#9::                                                                          ;[MS] copy selected text and overwrite mem slot 9
 ^#8::                                                                          ;[MS] copy selected text and overwrite mem slot 8
 ^#7::                                                                          ;[MS] copy selected text and overwrite mem slot 7
 ^#6::                                                                          ;[MS] copy selected text and overwrite mem slot 6
 ^#5::                                                                          ;[MS] copy selected text and overwrite mem slot 5
 ^#4::                                                                          ;[MS] copy selected text and overwrite mem slot 4
 ^#3::                                                                          ;[MS] copy selected text and overwrite mem slot 3
 ^#2::                                                                          ;[MS] copy selected text and overwrite mem slot 2
 ^#1::                                                                          ;[MS] copy selected text and overwrite mem slot 1
    OverwriteMemory(del_toggle = false) {
        ReleaseModifiers()
        slot := substr(A_ThisHotkey, 0)                                 
        ; del_toggle := Instr(A_ThisHotkey, "del") ? True : False               ;     cut selected text hot key condition  
        WriteToCache("m" slot, del_toggle)                                      ;     note: if no text selected, no overwrite will occur 
        ShowPopup("m" slot "`noverwritten",,"200")
        return
    }
 
 !#0::                                                                          ;[MS] copy selection and add to bottom of mem slot 0
 !#9::                                                                          ;[MS] copy selection and add to bottom of mem slot 9
 !#8::                                                                          ;[MS] copy selection and add to bottom of mem slot 8
 !#7::                                                                          ;[MS] copy selection and add to bottom of mem slot 7
 !#6::                                                                          ;[MS] copy selection and add to bottom of mem slot 6
 !#5::                                                                          ;[MS] copy selection and add to bottom of mem slot 5
 !#4::                                                                          ;[MS] copy selection and add to bottom of mem slot 4
 !#3::                                                                          ;[MS] copy selection and add to bottom of mem slot 3
 !#2::                                                                          ;[MS] copy selection and add to bottom of mem slot 2
 !#1::                                                                          ;[MS] copy selection and add to bottom of mem slot 1 
    AddToMemory(del_after_copy = "0", prepend = False){
        ReleaseModifiers()
        slot            := substr(A_ThisHotkey, 0)
        new_text_to_add := trim(clip())
        if (prepend = True) {
            FilePrepend("mem_cache\m" slot ".txt", new_text_to_add) 
            ShowPopup("added to top `nm" slot ,,"250")
        } else {
            FileAppend % "`n" . new_text_to_add, mem_cache\m%slot%.txt           
            ShowPopup("added to bottom `nm" slot ,,"250")
        }
        ; cut := Instr(A_ThisHotkey, "!") ? True : False 
        if (cut = true)
           send {del}
        return
   } 

 +#0::                                                                          ;[MS] paste contents of mem slot 0 
 +#9::                                                                          ;[MS] paste contents of mem slot 9   
 +#8::                                                                          ;[MS] paste contents of mem slot 8   
 +#7::                                                                          ;[MS] paste contents of mem slot 7 
 +#6::                                                                          ;[MS] paste contents of mem slot 6    
 +#5::                                                                          ;[MS] paste contents of mem slot 5   
 +#4::                                                                          ;[MS] paste contents of mem slot 4   
 +#3::                                                                          ;[MS] paste contents of mem slot 3   
 +#2::                                                                          ;[MS] paste contents of mem slot 2   
 +#1::                                                                          ;[MS] paste contents of mem slot 1 
 ^#LButton::                                                                    ;[MS] paste contents of mem slot 1 
 #!LButton::                                                                    ;[MS] paste contents of mem slot # entered at prompt
 :*:m>::                                                                        ;[MS] paste contents of mem slot # entered at prompt 
    RetrieveMemory() {
        global med
        global short
        ReleaseModifiers()
        hotkey_pressed := Instr(A_ThisHotkey, "#") ? True : False
        if (hotkey_pressed = False) or Instr(A_ThisHotkey, "!LButton") 
        {
            if Instr(A_ThisHotkey, "#!LButton") {
                DoubleClick()
                sleep, short * 2 
            }
            ShowPopup("PASTE SLOT #", "000000", "200", "45", "-5000", "14", "610", "DEF2F1")
            input, mem_slot, L1 T5
            ClosePopup() 
        } else {
            if Instr(A_ThisHotkey, "^#LButton") 
            {
                DoubleClick()
                sleep, short * 2
                mem_slot := "1"
                ShowPopup("SLOT 1 PASTED", "000000", "200", "45", "-5000", "14", "610", "DEF2F1")
            }
            else 
                mem_slot := substr(A_ThisHotkey, 0) 
        }
        AccessCache("m" mem_slot)  
        return
    } 
     
     
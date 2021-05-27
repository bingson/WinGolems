ins & 9::                                                                      ;[MS] cut selected text and overwrite mem slot 9
 ins & 8::                                                                      ;[MS] cut selected text and overwrite mem slot 8
 ins & 7::                                                                      ;[MS] cut selected text and overwrite mem slot 7
 ins & 6::                                                                      ;[MS] cut selected text and overwrite mem slot 6
 ins & 5::                                                                      ;[MS] cut selected text and overwrite mem slot 5
 ins & 4::                                                                      ;[MS] cut selected text and overwrite mem slot 4
 ins & 3::                                                                      ;[MS] cut selected text and overwrite mem slot 3
 ins & 2::                                                                      ;[MS] cut selected text and overwrite mem slot 2
 ins & 1::                                                                      ;[MS] cut selected text and overwrite mem slot 1
 ins & 0::                                                                      ;[MS] cut selected text and overwrite mem slot 0
 del & 9::                                                                      ;[MS] copy selected text and overwrite mem slot 9
 del & 8::                                                                      ;[MS] copy selected text and overwrite mem slot 8
 del & 7::                                                                      ;[MS] copy selected text and overwrite mem slot 7
 del & 6::                                                                      ;[MS] copy selected text and overwrite mem slot 6
 del & 5::                                                                      ;[MS] copy selected text and overwrite mem slot 5
 del & 4::                                                                      ;[MS] copy selected text and overwrite mem slot 4
 del & 3::                                                                      ;[MS] copy selected text and overwrite mem slot 3
 del & 2::                                                                      ;[MS] copy selected text and overwrite mem slot 2
 del & 1::                                                                      ;[MS] copy selected text and overwrite mem slot 1
 del & 0::                                                                      ;[MS] copy selected text and overwrite mem slot 0
    OverwriteMemory() {
        slot       := substr(A_ThisHotkey, 0)                                 
        del_toggle := Instr(A_ThisHotkey, "ins") ? True : False                 
        WriteToCache("m" slot, del_toggle)                                      ; note: if no text selected, no overwrite will occur
        ShowModePopup("m" slot "`noverwritten",,"200")
        return
    }
 
 ^#9::                                                                          ;[MS] copy selection and add to bottom of mem slot 9
 ^#8::                                                                          ;[MS] copy selection and add to bottom of mem slot 8
 ^#7::                                                                          ;[MS] copy selection and add to bottom of mem slot 7
 ^#6::                                                                          ;[MS] copy selection and add to bottom of mem slot 6
 ^#5::                                                                          ;[MS] copy selection and add to bottom of mem slot 5
 ^#4::                                                                          ;[MS] copy selection and add to bottom of mem slot 4
 ^#3::                                                                          ;[MS] copy selection and add to bottom of mem slot 3
 ^#2::                                                                          ;[MS] copy selection and add to bottom of mem slot 2
 ^#1::                                                                          ;[MS] copy selection and add to bottom of mem slot 1
 ^#0::                                                                          ;[MS] cut selection and add to bottom of mem slot 0
 #!9::                                                                          ;[MS] cut selection and add to top of mem slot 9
 #!8::                                                                          ;[MS] cut selection and add to top of mem slot 8
 #!7::                                                                          ;[MS] cut selection and add to top of mem slot 7
 #!6::                                                                          ;[MS] cut selection and add to top of mem slot 6
 #!5::                                                                          ;[MS] cut selection and add to top of mem slot 5
 #!4::                                                                          ;[MS] cut selection and add to top of mem slot 4
 #!3::                                                                          ;[MS] cut selection and add to top of mem slot 3
 #!2::                                                                          ;[MS] cut selection and add to top of mem slot 2
 #!1::                                                                          ;[MS] cut selection and add to top of mem slot 1 
 #!0::                                                                          ;[MS] cut selection and add to top of mem slot 0
    AddToMemory(del_after_copy = "0", prepend = False){
        slot            := substr(A_ThisHotkey, 0)
        new_text_to_add := trim(clip())
        cut         := Instr(A_ThisHotkey, "!") ? True : False
        if (prepend = True) {
            FilePrepend("mem_cache\m" slot ".txt", new_text_to_add) 
            ShowModePopup("added to top `nm" slot ,,"250")
        } else {
            FileAppend % "`n" . new_text_to_add, mem_cache\m%slot%.txt           
            ShowModePopup("added to bottom `nm" slot ,,"250")
        }
        if (cut = true)
           send {del}
        return
   } 

 +#9::                                                                          ;[MS] paste contents of mem slot 9   
 +#8::                                                                          ;[MS] paste contents of mem slot 8   
 +#7::                                                                          ;[MS] paste contents of mem slot 7 
 +#6::                                                                          ;[MS] paste contents of mem slot 6    
 +#5::                                                                          ;[MS] paste contents of mem slot 5   
 +#4::                                                                          ;[MS] paste contents of mem slot 4   
 +#3::                                                                          ;[MS] paste contents of mem slot 3   
 +#2::                                                                          ;[MS] paste contents of mem slot 2   
 +#1::                                                                          ;[MS] paste contents of mem slot 1 
 +#0::                                                                          ;[MS] paste contents of mem slot 0 
 :*:m>::                                                                        ;[MS] paste contents of mem slot # by typing "m>" followed by the slot number 
    RetrieveMemory() {
        hotstring_pressed := Instr(A_ThisHotkey, "#") ? True : False
        if (hotstring_pressed = False)
            input, mem_slot, L1 T5
        else
            mem_slot := substr(A_ThisHotkey, 0) 
        AccessCache("m" mem_slot)  
        return
    } 
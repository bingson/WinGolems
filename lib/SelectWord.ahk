SelectWord() { 
    ; select the word at the text caret position 
    ; (or mouse position for non editable areas) and return it 
    ; https://www.autohotkey.com/boards/viewtopic.php?t=23842
    ; Bing: I modified the mouse movement and sleep periods to make script work 
    ; more reliably in word 2019
    ClipSaved := ClipboardAll

    ; get letter on the Left
    Clipboard :=
    SendInput +{Left}^c{Right}
    ClipWait, 0.4
    charLeft := Clipboard

    if (charLeft == "") {       
        global short                                                ; a non editable area
        CoordMode, Mouse, Screen
        MouseGetPos, X_1, Y_1, ID_1, Control_1 
        sleep, short
        X_1 += 3                                                                ; shift cursor a bit to prevent dblclick from selecting the whole line
        Try DllCall("SetCursorPos", int, %X_1%, int, %Y_1%)                     ; changed from MouseMove, %X_1%, %Y_1%  (original)
        Click 2                                                                 ; bing: works better with multi-monitor configurations and word 2019
        Clipboard :=                                                            ; added try statement to surpress error msg when no valid text cursor 
        SendInput, ^c
        ClipWait, 0.4
        X_1 -= 3 ; restore mouse
        
        Try DllCall("SetCursorPos", int, %X_1%, int, %Y_1%)                     ; MouseMove, %X_1%, %Y_1% (original)
    
    } else {                                                                    ; editable area
        Clipboard :=
        if (RegExMatch(charLeft,"[[:alnum:]]")) {                               ; char on the Left is alphanumeric
            SendInput ^{Left}+^{Right}^c
        } else {                                                                ; char on the Left is either space or punctuation
            SendInput +^{Right}^c
        }
        ClipWait, 0.1
    
        
        t := "x" Clipboard                                                      ; preserve   by adding non-space char
        t = %t%                                                                 ; autotrim trailing white-space
        nBlankOnRight := StrLen(Clipboard)-StrLen(t)+1
        if (nBlankOnRight>0) {
            Clipboard :=
            SendInput +{Left %nBlankOnRight%}^c                                 ; unselect spaces on the Right
            ClipWait, 0.1
        }
    }
    
    w := Clipboard
    Clipboard := ClipSaved
    return w
}
SelectWordPDF() { 
    global short, med, long
    ; select the word at the text caret position 
    ; (or mouse position for non editable areas) and return it 
    ; https://www.autohotkey.com/boards/viewtopic.php?t=23842
    ; Bing: I modified the mouse movement and sleep periods to make script work 
    ; more reliably in word 2019
    ; keywait()
    ClipSaved := ClipboardAll

    ; get letter on the Left
    Clipboard :=
    Send +{Left}^c ;{Right}
    ClipWait, 0.4
    charLeft := Clipboard
    
    if (trim(charLeft) == "") {
        Send +^{right}
    } Else {
        Send ^{left}+^{right}
    }
    
    Clipboard := ClipSaved
    return
}
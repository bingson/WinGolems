Clip(Text = "", Reselect = False) { 

    ; SEND AND RETRIEVE CLIPOARD TEXT
    
    ; useful function that allows you to manipulate what's in the 
    ; clipboard by allowing you to retrieve and replace its contents
    ; by berban - updated February 18, 2019
    ; https://www.autohotkey.com/boards/viewtopic.php?f=6&t=62156
    
    Static BackUpClip, Stored, LastClip
    If (A_ThisLabel = A_ThisFunc) {
        If (Clipboard == LastClip)
            Clipboard := BackUpClip
        BackUpClip := LastClip := Stored := ""
    } Else {
        If !Stored {
            Stored := True
            ; ClipboardAll must be on its own line
            BackUpClip := ClipboardAll 

        } Else
            SetTimer, %A_ThisFunc%, Off
        LongCopy := A_TickCount, Clipboard := "", LongCopy -= A_TickCount       ; LongCopy gauges the amount of time it takes to empty the clipboard
        If (Text = "") {                                                        ; which lets us predict how long the subsequent clipwait will need   
            Clipboard := ""                                                     
            SendInput, ^c
            ; ClipWait, LongCopy ? 10 : 5, True
            ClipWait, LongCopy ? 0.6 : 0.2, True
        } Else {
            Clipboard := LastClip := Text
            ; ClipWait,,1                                                            
            ClipWait, 10                                                        ; ClipWait (might work better defaults to 0.5)
            Send, ^v
            ; SendInput, ^v
        }
        SetTimer, %A_ThisFunc%, -700                                            ; Short sleep in case Clip() is followed by more keystrokes 

        If (Text = "")
        {
            Return LastClip := Clipboard
        }
        Else If ReSelect and ((ReSelect = True) or (StrLen(Text) < 3000))
        {
            sleep 100
            SendInput, % "{Shift Down}{Left " StrLen(StrReplace(Text, "`r")) "}{Shift Up}"
        }
    }
    Return
    
    Clip:
    Return Clip()
}

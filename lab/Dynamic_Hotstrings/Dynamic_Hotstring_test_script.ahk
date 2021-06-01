{ ; INITS
	#Singleinstance Force
	SetTitleMatchMode, 2
	; #If WinActive("ahk_class Notepad++") 
	#If WinActive("Notepad++") 
	#Include %A_ScriptDir%
	; #Include WinGolems.ahk
}



:*?:>/::
Input, UserInput,v L4 C, d{enter}.{esc}{tab}, btw,otoh,fl,ahk,ca

send msgbox, UserInput: %UserInput%

if (ErrorLevel = "Max")
{
    MsgBox, You entered "%UserInput%", which is the maximum length of text.
    return
}
if (ErrorLevel = "Timeout")
{
    MsgBox, You entered "%UserInput%" at which time the input timed out.
    return
}
if (ErrorLevel = "NewInput")
    return
If InStr(ErrorLevel, "EndKey:")
{
    MsgBox, You entered "%UserInput%" and terminated the input with %ErrorLevel%.
    return
}
; Otherwise, a match was found.
if (UserInput = "btw")
    Send, {backspace 4}by the way
else if (UserInput = "otoh")
    Send, {backspace 5}on the other hand
else if (UserInput = "fl")
    Send, {backspace 3}Florida
else if (UserInput = "ca")
    Send, {backspace 3}California
else if (UserInput = "ahk")
    Run, https://www.autohotkey.com
return

activate_window(title="Chrome"){ 
; activate window that contains title string
	SetTitleMatchMode,2 ;match anywhere in title
	IfWinExist, %title%
		WinActivate 
	return

}



{ ; 
	^#t:: reload
	
	#IfWinActive
	+^#t:: ExitApp
}

/*

; #t:: 
; #p:: 
; #t:: 
; ^#p:: 


https://www.autohotkey.com/docs/misc/EscapeChar.htm

#Hotstring EndChars -()[]{}:;'"/\,.?!`n `t
Hotstring("EndChars", "-()[]{}:;")|\?/

Unless the asterisk option is in effect, you must type an ending character after a hotstring's abbreviation to trigger it. 
Ending characters initially consist of the following: -()[]{}':;"/\,.?!`n `t (note that `n is Enter, `t is Tab, and there 
is a plain space between `n and `t). This set of characters can be changed by editing the following example, which sets 
the new ending characters for all hotstrings, not just the ones beneath it:




|| WinActive("Notepad") 
|| (WinActive("ahk_exe chrome.exe")	
&& (WinActive("JupyterLab") 
||  WinActive("1_DAG") 
||  WinActive("TUT_") 
||  WinActive("R4DS_") 
||  WinActive(WinESC)
. )) 


YYYY	The 4-digit year
MM		The 2-digit month (01-12)
DD		The 2-digit day of the month (01-31)
HH24	The 2-digit hour in 24-hour format (00-23). For example, 09 is 9am and 21 is 9pm.
MI		The 2-digit minutes (00-59)
SS		The 2-digit seconds (00-59)

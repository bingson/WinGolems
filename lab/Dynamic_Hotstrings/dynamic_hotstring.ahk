;-----------------------------------------;
; Settings

#NoEnv
#SingleInstance force
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
SendMode Input

#Include part_list.ahk

;-----------------------------------------;
; Format templates

f_bold := "^b<Part> - <Desc>^b"
f_desc := "<Desc>"
f_enter := "<Part>{Enter}<Desc>{Enter 2}"
f_tab := "<Part>{Tab}<Desc>"
f_bracket := "<Part> (<Desc>)"

;-----------------------------------------;

#MaxThreadsPerHotkey 100

:*?B0:b.::
launchInput(f_bold)
Return

:*?B0:d.::
launchInput(f_desc)
Return

:*?B0:e.::
launchInput(f_enter)
Return

:*?B0:t.::
launchInput(f_tab)
Return

:*?B0:p.::
launchInput(f_bracket)
Return

#MaxThreadsPerHotkey 1



launchInput(format) {
	Input part_number, L20 v, {Enter}{Tab}{Space}
	if (InStr(ErrorLevel, "EndKey")) {
		replacePartDesc(part_number, format)
	}
}

replacePartDesc(part_number, format) {
	global part_list
	desc := part_list["" . part_number]
	
	if (desc) {
		remove_amount := StrLen(part_number) + 3
		Send {BackSpace %remove_amount%}
		
		msg := StrReplace(format, "<Part>", part_number)
		msg := StrReplace(msg, "<Desc>", desc)
		
		Send % msg
	}
}
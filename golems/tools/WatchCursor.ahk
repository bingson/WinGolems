#Persistent
SetTimer, WatchCursor, 500
return

WatchCursor:
MouseGetPos, , , id, control
WinGetTitle, title, ahk_id %id%
WinGetClass, class, ahk_id %id%
ControlGetFocus, ActiveWin, A
ToolTip, Unique ID: ahk_id %id%`nTitle: %title%`nClass: ahk_class %class%`nControl: %control%`nActive Control: %ActiveWin%`n`nCTRL+WIN+T to Toggle On and Off`nCTRL+F12 to Copy to Clipboard
return

^#T:: 
SetTimer, WatchCursor, % (Toggle:=!Toggle) ? "Off" : "On"
If Toggle
 ToolTip
Return

^F12::ClipBoard := "Unique ID: ahk_id " . id . Chr(13) . Chr(10) . "Title: " . title . Chr(13) . Chr(10) . "Class: ahk_class" .  class . Chr(13) . Chr(10) . "Control: " . control . Chr(13) . Chr(10) . "Active Control: " . ActiveWin



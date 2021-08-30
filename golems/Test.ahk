AutoExecution_test:

; KeyName := GetKeyName("sc3a")
; KeyName := GetKeyName("sc029")
; Menu, Tray, Tip, Switch between windows of the same applications with 'Alt+%KeyName%'

; intitialize variables & arrays

return ;________________________________________________________________________
#IfWinActive


:X:t1~win::
{
    key  := "capslock" ; Any key can be used here.
    name := GetKeyName(key)
    vk   := GetKeyVK(key)
    sc   := GetKeySC(key)

    MsgBox, % Format("Name:`t{}`nVK:`t{:X}`nSC:`t{:X}", name, vk, sc)
    return
}

; ChgAppInstance() 
; *!capslock:: ChgAppInstance()

; *!sc029:: 


; Switch between windows of the same application with Alt+(key above Tab)
; Icon: made by Freepik (www.freepik.com), licence CC 3.0 BY
;       from https://www.flaticon.com/free-icon/switch-window_71630
; Script Licence: CC0 (Public Domain)
; Source: https://framagit.org/dr4Ke/AutoHotkey_scripts




; SCRIPT OPTIMIZATION SETTINGS _________________________________________________

  SetWorkingDir %A_ScriptDir%                                                   ; https://www.autohotkey.com/boards/viewtopic.php?f=7&t=6413
  #MenuMaskKey vk07                                                             ; prevents windows speech recognition from activating https://www.autohotkey.com/boards/viewtopic.php?t=29595
  #MaxHotkeysPerInterval 99000000
  ; SetBatchLines -1
  SetBatchLines, 20ms
  ListLines on                                                                  ; ListLines/KeyHistory are used to log keys for debugging
  #KeyHistory 100                                                               ; replace with higher number for debugging
  #UseHook                                                
  #InstallKeybdHook                                               
  #InstallMouseHook                                             
  #Singleinstance Force                                                         ; only one instance of this script can be active
  Process, Priority, , A                                                          
  SetKeyDelay, 10, 50
  SetWinDelay, 10                                                                
  SetControlDelay, 20                                                             
  SendMode Event                                                                ; faster input
  SetMouseDelay, 10                                                             ; mouse click commands become less reliable at lower settings
  SetDefaultMouseSpeed, 0                                                      
  ; SetTimer, reload, 60000                                                     ; reloads the script once every minute; makes the script more reliable when running multiple ahk scripts on older hardware. needs reload: label
  
; INITIALIZE GLOBAL VARIABLES __________________________________________________




;test 

;time> 
02:37:42 PM
02:38:02 PM
02:42:47 PM
02:47:49 PM
03:55:54 PM










#Include golems.golems                                                         ; ***end of auto-execution section***
; AUTOEXEC ENDED ____________________________________________________________________

+#enter::CB("~t",C.lbrown)
#If WinExist("ahk_id " CB_hwnd) and !WinAcaddTextToClipboard:
                    var := clipboard                                            ; [stability] placeholder var allows usage of clipwait errorLevel
                    clipboard := ""                                             ; to monitor when the append|prepend is complete 
                    % (FirstChar == "A") 
                        ? (var .= "`n" text_to_add) 
                        : (var := text_to_add "`n" var)
                    clipboard := var
                    clipwait 
                    while (ErrorLevel)
                        sleep 10
                    goto, Loadtive("ahk_id " CB_hwnd) and (GC("CB_sfx") == "~t")
^#r::   Reload                                                          ;AHK: reload ahk script
#if
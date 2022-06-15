
#IF
; ACTIVATE APPS (GREEN) ________________________________________________________
  ; AA("application_exe_path")
  ; SaveWinID("unique_string")
  ; ActivateWinID("unique_string")
  #IF GC("T_base",1) 
  #q::                AA("xls_path")                                            ;Apps| Activate Excel
  #w::                AA("doc_path")                                            ;Apps| Activate Word
  #a::                AA("pdf_path")                                            ;Apps| Activate pdf viewer
  #s::                AA("html_path")                                           ;Apps| Activate web browser
  #z::                AA("editor_path")                                         ;Apps| Activate default editor
  #x::                AA("ppt_path")                                            ;Apps| Activate PowerPoint
  #b::                AA("explorer.exe")                                        ;Apps| Activate File Explorer         
  #t::                AA("cmd.exe")                                             ;Apps| Activate Command window     
  #c::                ActivateCalc()                                            ;Apps| Activate Calculator  

  ^!F1::                                                                        ;Apps: Save window for win+F1 activation 
  ^!F2::                                                                        ;Apps: Save window for win+F2 activation
  ^!F3::                                                                        ;Apps: Save window for win+F3 activation
  ^!F4::                                                                        ;Apps: Save window for win+F4 activation
  ^!F5::                                                                        ;Apps: Save window for win+F5 activation
  ^!F6::                                                                        ;Apps: Save window for win+F6 activation
  ^!F7::                                                                        ;Apps: Save window for win+F7 activation
  ^!F8::              SaveWinID(ltrim(A_ThisHotkey, "^!"))                      ;Apps: Save window for win+F8 activation

  #F1::                                                                         ;Apps: Activate saved F1 window
  #F2::                                                                         ;Apps: Activate saved F2 window
  #F3::                                                                         ;Apps: Activate saved F3 window
  #F4::                                                                         ;Apps: Activate saved F4 window
  #F5::                                                                         ;Apps: Activate saved F5 window
  #F6::                                                                         ;Apps: Activate saved F6 window
  #F7::                                                                         ;Apps: Activate saved F7 window
  #F8::                ActivateWinID(ltrim(A_ThisHotkey, "#"))                  ;Apps: Activate saved F8 window         



; NAVIGATION (PURPLE) __________________________________________________________
  
  $#j::               Sendinput {WheelDown 2}                                   ;Navigation: mouse scroll down 2 lines
  $#k::               Sendinput {WheelUp 2}                                     ;Navigation: mouse scroll down 2 lines
  $>!#j::             Sendinput {WheelDown 6}                                   ;Navigation: mouse scroll down 6 lines
  $>!#k::             Sendinput {WheelUp 6}                                     ;Navigation: mouse scroll down 6 lines
  $#>+j::             Sendinput {Wheelleft 6}                                   ;Navigation: mouse scroll left 
  $#>+k::             Sendinput {WheelRight 6}                                  ;Navigation: mouse scroll right 
  ^!h::               sendinput {home}                                          ;Navigation: Home
  ^!l::               sendinput {end}                                           ;Navigation: End
  
; CONVENIENCE (ORANGE) _________________________________________________________
  
  #SC035::            search()                                                  ;Convenience: google search selected text
  !Backspace::        delLine()                                                 ;Convenience: delete current line of text
  #Esc::              suspend                                                   ;WinGolems: toggle all hotkeys ON|OFF except for this one
  !SC027::            Send {esc}                                                ;WinOS: simulate esc key (alt + semicolon)
  ^SC027::            Send {AppsKey}                                            ;WinOS: simulate appkey
  $^#Enter::          send ^{esc}                                               ;WinOS: open start menu 
  $^!space up::       MaximizeWin()                                             ;WindowMgmt: maximize window
  $#SC027::           MinimizeWin()                                             ;WindowMgmt: minimize window
  #del::              AlwaysOnTop(1)                                            ;WindowMgmt: Window always on top: ON
  #ins::              AlwaysOnTop(0)                                            ;WindowMgmt: Window always on top: OFF
  >^capslock::        Send {capslock}                                           ;Convenience: capslock                                                                                 
  +#capslock::        W("ls","lwin"), ActivatePrevInstance()                    ;WindowMgmt: rotate through app instances from most recent                   
  #capslock::         S("{blind}"), ActivateNextInstance()                      ;WindowMgmt: rotate through app instances from oldest (no thumbnail previews)
  >!.::               moveWinBtnMonitors(), CFW()                               ;WindowMgmt: move window btn monitors, cursor follows active windows
  !#b::               BluetoothSettings()                                       ;WinSetting: bluetooth settings (reassign less used windows sys shortcuts)
  !#d::               DisplaySettings()                                         ;WinSetting: display settings
  !#n::               NotificationWindow()                                      ;WinSetting: notification window
  !#r::               RunProgWindow()                                           ;WinSetting: run program
  !#p::               PresentationDisplayMode()                                 ;WinSetting: presentation display mode
  !#i::               WindowsSettings()                                         ;WinSetting: windows settings

; MEMORY FILE FUNCTIONS (BLUE)__________________________________________________
  
  ; Note: The below memory functions use the last key pressed to identify which memory file to operate on.
  ;       enter "?" in a command box to see additional memory file commands
  ; e.g., ^!a = AddToMemory() ; ctrl+alt+a -> will save selected text to a file called a.txt in the WinGolems/mem_cache folder

  #IF GC("T_mem",1) 
  ^!0::                                                                         ;Mem: overwrite 0.txt with selected text 
  ^!9::                                                                         ;Mem: overwrite 9.txt with selected text 
  ^!8::                                                                         ;Mem: overwrite 8.txt with selected text 
  ^!7::                                                                         ;Mem: overwrite 7.txt with selected text 
  ^!6::                                                                         ;Mem: overwrite 6.txt with selected text 
  ^!5::                                                                         ;Mem: overwrite 5.txt with selected text 
  ^!4::                                                                         ;Mem: overwrite 4.txt with selected text 
  ^!3::                                                                         ;Mem: overwrite 3.txt with selected text 
  ^!2::                                                                         ;Mem: overwrite 2.txt with selected text 
  ^!1::              OverwriteMemory()                                          ;Mem: overwrite 1.txt with selected text 
  
  +#0::                                                                         ;Mem: add selected text to the bottom of 0.txt
  +#9::                                                                         ;Mem: add selected text to the bottom of 9.txt
  +#8::                                                                         ;Mem: add selected text to the bottom of 8.txt
  +#7::                                                                         ;Mem: add selected text to the bottom of 7.txt
  +#6::                                                                         ;Mem: add selected text to the bottom of 6.txt
  +#5::                                                                         ;Mem: add selected text to the bottom of 5.txt
  +#4::                                                                         ;Mem: add selected text to the bottom of 4.txt
  +#3::                                                                         ;Mem: add selected text to the bottom of 3.txt
  +#2::                                                                         ;Mem: add selected text to the bottom of 2.txt
  +#1::              AddToMemory()                                              ;Mem: add selected text to the bottom of 1.txt

  ^#0::                                                                         ;Mem: add selected text to the bottom of 0.txt with breaks removed
  ^#9::                                                                         ;Mem: add selected text to the bottom of 9.txt with breaks removed
  ^#8::                                                                         ;Mem: add selected text to the bottom of 8.txt with breaks removed
  ^#7::                                                                         ;Mem: add selected text to the bottom of 7.txt with breaks removed
  ^#6::                                                                         ;Mem: add selected text to the bottom of 6.txt with breaks removed
  ^#5::                                                                         ;Mem: add selected text to the bottom of 5.txt with breaks removed
  ^#4::                                                                         ;Mem: add selected text to the bottom of 4.txt with breaks removed
  ^#3::                                                                         ;Mem: add selected text to the bottom of 3.txt with breaks removed
  ^#2::                                                                         ;Mem: add selected text to the bottom of 2.txt with breaks removed
  ^#1::              AddToMemory(,1,1)                                          ;Mem: add selected text to the bottom of 1.txt with breaks removed
  
  !#0::                                                                         ;Mem: add selected text to the bottom of 0.txt with leading spaces removed
  !#9::                                                                         ;Mem: add selected text to the bottom of 9.txt with leading spaces removed
  !#8::                                                                         ;Mem: add selected text to the bottom of 8.txt with leading spaces removed
  !#7::                                                                         ;Mem: add selected text to the bottom of 7.txt with leading spaces removed
  !#6::                                                                         ;Mem: add selected text to the bottom of 6.txt with leading spaces removed
  !#5::                                                                         ;Mem: add selected text to the bottom of 5.txt with leading spaces removed
  !#4::                                                                         ;Mem: add selected text to the bottom of 4.txt with leading spaces removed
  !#3::                                                                         ;Mem: add selected text to the bottom of 3.txt with leading spaces removed
  !#2::                                                                         ;Mem: add selected text to the bottom of 2.txt with leading spaces removed
  !#1::              AddToMemory(,,1,1)                                         ;Mem: add selected text to the bottom of 1.txt with leading spaces removed

  #0::                                                                          ;Mem: paste contents of 0.txt 
  #9::                                                                          ;Mem: paste contents of 9.txt   
  #8::                                                                          ;Mem: paste contents of 8.txt   
  #7::                                                                          ;Mem: paste contents of 7.txt 
  #6::                                                                          ;Mem: paste contents of 6.txt    
  #5::                                                                          ;Mem: paste contents of 5.txt   
  #4::                                                                          ;Mem: paste contents of 4.txt   
  #3::                                                                          ;Mem: paste contents of 3.txt   
  #2::                                                                          ;Mem: paste contents of 2.txt   
  #1::                RetrieveMemory()                                          ;Mem: paste contents of 1.txt
  
  <!space::           W("a"), RunCmd(GC("LaltSpaceCommand","V"))                ;Mem: (V command) selects last word typed and replaces it with \mem_cache .txt file with the corresponding name (e.g., typing "1" + !space => paste 1.txt).      
  >!space::           W("a"), RunCmd(GC("RaltSpaceCommand","V"))                ;Mem: (V command) selects last word typed and replaces it with \mem_cache .txt file with the corresponding name (e.g., typing "1" + !space => paste 1.txt).        

#IF
/*

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

; NAVIGATION (PURPLE) __________________________________________________________
  
  $#j::               Sendinput {Blind}{WheelDown 2}                            ;Navigation: mouse scroll down 2 lines
  $#k::               Sendinput {Blind}{WheelUp 2}                              ;Navigation: mouse scroll down 2 lines
  $>!#j::             Sendinput {Blind}{WheelDown 6}                            ;Navigation: mouse scroll down 6 lines
  $>!#k::             Sendinput {Blind}{WheelUp 6}                              ;Navigation: mouse scroll down 6 lines
  $#>!h::             Sendinput {Blind}{Wheelleft 6}                            ;Navigation: mouse scroll left 
  $#>!l::             Sendinput {Blind}{WheelRight 6}                           ;Navigation: mouse scroll right 
  ^!h::               sendinput {home}                                          ;Navigation: Home
  ^!l::               sendinput {end}                                           ;Navigation: End
  
  #IF GC("T_tabNav",1)                                                          ; can be toggled on/off by entering Gtc,T_tabNav in a CB 
  ^b::                sendinput ^{PgUp}                                         ;Navigation: navigate to left tab
  ^space::            sendinput ^{PgDn}                                         ;Navigation: navigate to right tab
  #IF GC("T_base",1) 
  
; CONVENIENCE (ORANGE) _________________________________________________________
  !b::                send ^b                                                   ;Convenience: Lshift+b = ctrl+b (taken over by tab movement function)
  
  $<!^mButton::                                                                 ;MouseFn: move mouse cursor to center of active application window 
  ~lwin & ~rshift::   CursorJump("C")                                           ;MouseFn: move mouse cursor to center of active application window
  $<^mButton::        CursorJump("BL")                                          ;MouseFn: move mouse cursor to BOTTOM LEFT of active app
  $+<!mButton::       CursorJump("BR")                                          ;MouseFn: move mouse cursor to BOTTOM RIGHT of active app
  $<+mButton::        CursorJump("TL")                                          ;MouseFn: move mouse cursor to TOP LEFT of active app
  $<!mButton::        CursorJump("TR")                                          ;MouseFn: move mouse cursor to TOP RIGHT of active app
  #SC035::            search()                                                  ;Convenience: google search selected text
  !Backspace::        delLine()                                                 ;Convenience: delete current line of text
  ^#O::               suspend                                                   ;WinGolems: toggle all hotkeys ON|OFF except for this one
  !SC027::            Send {esc}                                                ;WinOS: simulate esc key (alt + semicolon)
  ^SC027::            Send {AppsKey}                                            ;WinOS: simulate appkey
  #Lbutton::                                                                    ;WinOS: open start menu (alt: Ctrl+Esc)
  $^#Enter::          send ^{esc}                                               ;WinOS: open start menu 
  #esc::              reloadWG()                                                ;WinGolems: reload WinGolems 
  ^#sc027::           Send {lwin down}d{lwin up}                                ;WindowMgmt: show desktop
  #sc028::                                                                      ;WindowMgmt: maximize window
  ^!space::           WinMaximize,A                                             ;WindowMgmt: maximize window
  #SC027::            WinMinimize,A                                             ;WindowMgmt: minimize window
  #del::              AlwaysOnTop(1)                                            ;WindowMgmt: Window always on top: ON
  #ins::              AlwaysOnTop(0)                                            ;WindowMgmt: Window always on top: OFF
  +#capslock::        s("{blind}"), ActivatePrevInstance()                      ;WindowMgmt: rotate through app instances from most recent
  printscreen & rshift::                                                        ;WindowMgmt: rotate through app instances from oldest (no thumbnail previews)
  #capslock::         s("{blind}"), ActivateNextInstance()                      ;WindowMgmt: rotate through app instances from oldest (no thumbnail previews)
  ^#q::                                                                         ;WindowMgmt: close active window 
  +#q::               WinClose,A                                                ;WindowMgmt: close active window
  !#q::               CloseClass()                                              ;WindowMgmt: close all instances of the active program
  >!m::               moveWinBtnMonitors(), CFW()                               ;WindowMgmt: move window btn monitors, cursor follows active windows
  !#b::               BluetoothSettings()                                       ;WinSetting: bluetooth settings (reassign less used windows sys shortcuts)
  !#d::               DisplaySettings()                                         ;WinSetting: display settings
  !#n::               NotificationWindow()                                      ;WinSetting: notification window
  !#r::               RunProgWindow()                                           ;WinSetting: run program
  !#p::               PresentationDisplayMode()                                 ;WinSetting: presentation display mode
  !#i::               WindowsSettings()                                         ;WinSetting: windows settings
  $>+>!o::            % (t := !t) ? WinToDesktop("2") : WinToDesktop("1")       ;VirtualDesktop: Move active Window to other desktop (between desktops 1 and 2)
  >!sc028::           GotoDesktop("1")                                          ;VirtualDesktop: Switch to desktop 1
  >!enter::           GotoDesktop("2")                                          ;VirtualDesktop: Switch to desktop 1
  
  ;>!enter::           % (t := !t) ? GotoDesktop("2") : GotoDesktop("1")         ;VirtualDesktop: Switch between desktop 1 and 2

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
  
  <!space::          RunCmd(GC("LaltSpaceCommand","V"))                        ;Mem: (V command) selects last word typed and replaces it with \mem_cache .txt file with the corresponding name (e.g., typing "1" + !space => paste 1.txt).
  >!space::          RunCmd(GC("RaltSpaceCommand","V"))                        ;Mem: (V command) selects last word typed and replaces it with \mem_cache .txt file with the corresponding name (e.g., typing "1" + !space => paste 1.txt).
  
  $^!lbutton::        s("{blind}",,100),RetrieveMemory(A_ThisHotkey,,,1)        ;Mem: double click and paste contents of 1.txt at cursor position       
  $^#lbutton::        s("{blind}",,100),RetrieveMemory(,A_ThisHotkey)           ;Mem: double click and paste contents of number entered at prompt   
  $<!lbutton up::     s("{blind}",,100), Clicks(2), s("^v")                     ;MouseFn: triple click, paste clipboard contents
  $<+<!lbutton up::    s("{blind}",,100), Clicks(3), s("^v")                    ;MouseFn: double click, paste clipboard contents


#IF
/*
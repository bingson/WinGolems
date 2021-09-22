
#IF
; ACTIVATE APPS (GREEN) ________________________________________________________
  ; AA("application_exe_path")
  ; SaveWinID("unique_string")
  ; ActivateWinID("unique_string")

  #q::                AA("xls_path")                                            ;Apps| Activate Excel
  #w::                AA("doc_path")                                            ;Apps| Activate Word
  #a::                AA("pdf_path")                                            ;Apps| Activate pdf viewer
  #s::                AA("html_path")                                           ;Apps| Activate web browser
  #z::                AA("editor_path")                                         ;Apps| Activate default editor
  #x::                AA("ppt_path")                                            ;Apps| Activate PowerPoint
  #b::                AA("explorer.exe")                                        ;Apps| Activate File Explorer         
  #t::                AA("cmd.exe")                                             ;Apps| Activate Command window     
  #c::                ActivateCalc()                                            ;Apps| Activate Calculator   
  ^!F1::              SaveWinID("F1")                                           ;Apps: Save window for win+F1 activation 
  ^!F2::              SaveWinID("F2")                                           ;Apps: Save window for win+F2 activation
  ^!F3::              SaveWinID("F3")                                           ;Apps: Save window for win+F3 activation
  ^!F4::              SaveWinID("F4")                                           ;Apps: Save window for win+F4 activation
  ^!F5::              SaveWinID("F5")                                           ;Apps: Save window for win+F5 activation
  ^!F6::              SaveWinID("F6")                                           ;Apps: Save window for win+F6 activation
  ^!F7::              SaveWinID("F7")                                           ;Apps: Save window for win+F7 activation
  ^!F8::              SaveWinID("F8")                                           ;Apps: Save window for win+F8 activation
  #F1::               ActivateWinID("F1")                                       ;Apps: Activate saved F1 window
  #F2::               ActivateWinID("F2")                                       ;Apps: Activate saved F2 window
  #F3::               ActivateWinID("F3")                                       ;Apps: Activate saved F3 window
  #F4::               ActivateWinID("F4")                                       ;Apps: Activate saved F4 window
  #F5::               ActivateWinID("F5")                                       ;Apps: Activate saved F5 window
  #F6::               ActivateWinID("F6")                                       ;Apps: Activate saved F6 window
  #F7::               ActivateWinID("F7")                                       ;Apps: Activate saved F7 window
  #F8::               ActivateWinID("F8")                                       ;Apps: Activate saved F8 window

; NAVIGATION (PURPLE) __________________________________________________________
  
  $#j::               Sendinput {Blind}{WheelDown 2}                            ;Navigation: mouse scroll down 2 lines
  $#k::               Sendinput {Blind}{WheelUp 2}                              ;Navigation: mouse scroll down 2 lines
  $>!#j::             Sendinput {Blind}{WheelDown 6}                            ;Navigation: mouse scroll down 6 lines
  $>!#k::             Sendinput {Blind}{WheelUp 6}                              ;Navigation: mouse scroll down 6 lines
  $#>!h::             Sendinput {Blind}{Wheelleft 6}                            ;Navigation: mouse scroll left 
  $#>!l::             Sendinput {Blind}{WheelRight 6}                           ;Navigation: mouse scroll right 
  ^!h::               sendinput {home}                                          ;Navigation: Home
  ^!l::               sendinput {end}                                           ;Navigation: End
  !b::                send ^{PgUp}                                              ;Navigation: navigate to left tab
  !space::            s("{blind}"), s("^{PgDn}")                                ;Navigation: navigate to right tab
  
; CONVENIENCE (ORANGE) _________________________________________________________
  
  ~ralt & ~rshift::                                                             ;Convenience: move mouse cursor to center of active application window
  ~lwin & ~rshift::   CursorJump("C")                                           ;Convenience: move mouse cursor to center of active application window
  #SC035::            search()                                                  ;Convenience: google search selected text
  !Backspace::        delLine()                                                 ;Convenience: delete current line of text
  #esc::              suspend                                                   ;WinGolems: toggle all hotkeys ON|OFF except for this one
  !SC027::            Send {esc}                                                ;WinOS: simulate esc key (alt + semicolon)
  ^SC027::            Send {AppsKey}                                            ;WinOS: simulate appkey
  #Lbutton::                                                                    ;WinOS: open start menu (alt: Ctrl+Esc)
  $^#Enter::          send ^{esc}                                               ;WinOS: open start menu 
  lshift & rshift::                                                             ;WinGolems: reload WinGolems (update running script for changes, fixes sticky keys)
  rshift & lshift::   reloadWG()                                                ;WinGolems: reload WinGolems 
  ^#sc027::           Send {lwin down}d{lwin up}                                ;WindowMgmt: show desktop
  #sc028::                                                                      ;WindowMgmt: maximize window
  ^!space::           WinMaximize,A                                             ;WindowMgmt: maximize window
  #SC027::            WinMinimize,A                                             ;WindowMgmt: minimize window
  #del::              AlwaysOnTop(1)                                            ;WindowMgmt: Window always on top: ON
  #ins::              AlwaysOnTop(0)                                            ;WindowMgmt: Window always on top: OFF
  *!capslock::        ChgInstance("capslock")                                   ;WindowMgmt: rotate through app instances with thumbnails(+!capslock for other direction)
  +#capslock::        s("{blind}"), ActivatePrevInstance()                      ;WindowMgmt: rotate through app instances from most recent
  #capslock::         s("{blind}"), ActivateNextInstance()                      ;WindowMgmt: rotate through app instances from oldest (no thumbnail previews)
  +#q::               WinClose,A                                                ;WindowMgmt: close active window
  !#q::               CloseClass()                                              ;WindowMgmt: close all instances of the active program
  ralt & sc034::      moveWinBtnMonitors(), CFW()                               ;WindowMgmt: move window btn monitors, cursor follows active windows
  !#b::               BluetoothSettings()                                       ;WinSetting: bluetooth settings (reassign less used windows sys shortcuts)
  !#d::               DisplaySettings()                                         ;WinSetting: display settings
  !#n::               NotificationWindow()                                      ;WinSetting: notification window
  !#r::               RunProgWindow()                                           ;WinSetting: run program
  !#p::               PresentationDisplayMode()                                 ;WinSetting: presentation display mode
  !#i::               WindowsSettings()                                         ;WinSetting: windows settings
  >+>!o::             % (t := !t) ? WinToDesktop("2") : WinToDesktop("1")       ;VirtualDesktop: Move active Window to other desktop (between desktops 1 and 2)
  >!sc028::           GotoDesktop("1")                                          ;VirtualDesktop: Switch to desktop 1
  >!enter::           % (t := !t) ? GotoDesktop("2") : GotoDesktop("1")         ;VirtualDesktop: Switch between desktop 1 and 2

; MEMORY FILE FUNCTIONS (BLUE)__________________________________________________
  
  ; Note: The below memory functions use the last key pressed to identify which memory file to operate on.
  ;       enter "?" in a command box to see additional memory file commands
  ; e.g., ^!a = AddToMemory() ; ctrl+alt+a -> will save selected text to a file called a.txt in the WinGolems/mem_cache folder

  
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

  #0::                                                                          ;Mem: paste contents of 0.txt 
  #9::                                                                          ;Mem: paste contents of 9.txt   
  #8::                                                                          ;Mem: paste contents of 8.txt   
  #7::                                                                          ;Mem: paste contents of 7.txt 
  #6::                                                                          ;Mem: paste contents of 6.txt    
  #5::                                                                          ;Mem: paste contents of 5.txt   
  #4::                                                                          ;Mem: paste contents of 4.txt   
  #3::                                                                          ;Mem: paste contents of 3.txt   
  #2::                                                                          ;Mem: paste contents of 2.txt   
  #1::               RetrieveMemory()                                           ;Mem: paste contents of 1.txt
  
  $+^mButton::        RetrieveMemory(A_ThisHotkey)                               ;Mem: double click and paste contents of 0.txt at cursor position
  $^mButton::        RetrieveMemory(,A_ThisHotkey)                              ;Mem: double click and paste contents of number entered at prompt

; COMMAND BOX __________________________________________________________________                             
  #enter::                                                                      ;CommandBox: opens command box that runs ~win suffix CB keys; enter "?" for help
  #space::           CB("~win")                                                 ;CommandBox: opens command box that runs ~win suffix CB keys; enter "?" for help
  :X:tt~win::        TC("T_TM","Text_Manipulation: ")                       ;CommandBox: Toggle Text_Manipulation template ON|OFF by typing "tt" in a Command Box or "tt~win" anywhere in windows
  :X:tf~win::        TC("T_FM","File_Management: ")                         ;CommandBox: Toggle File_Navigation template ON|OFF


#IF
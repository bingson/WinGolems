#IfWinActive
; The following interface elements are valid anywhere in Windows 10

; ACTIVATE APPLICATION (GREEN)__________________________________________________
 
  ^#z::              s("{blind}"), SaveWinID("z")                               ;ActvateApp: Save window ID for subsequent activation 
  ^#x::              s("{blind}"), SaveWinID("x")                               ;ActvateApp: Save window ID for subsequent activation 
  ^#c::              s("{blind}"), SaveWinID("c")                               ;ActvateApp: Save window ID for subsequent activation 
  ^#f::              s("{blind}"), SaveWinID("f")                               ;ActvateApp: Save window ID for subsequent activation 
  #z::               s("{blind}"), ActivateWinID("z")                           ;ActvateApp: Activate previously saved window ID
  #x::               s("{blind}"), ActivateWinID("x")                           ;ActvateApp: Activate previously saved window ID
  #c::               s("{blind}"), ActivateWinID("c")                           ;ActvateApp: Activate previously saved window ID
  #f::               s("{blind}"), ActivateWinID("f")                           ;ActvateApp: Activate previously saved window ID
     
  #q::               s("{blind}"), ActivateApp("ppt_path")                      ;ActvateApp:1 Activate PowerPoint
  #w::               s("{blind}"), ActivateApp("doc_path")                      ;ActvateApp:1 Activate Word
  #e::               s("{blind}"), ActivateApp("xls_path")                      ;ActvateApp:1 Activate Excel
  #a::               s("{blind}"), ActivateApp("editor_path")                   ;ActvateApp:1 Activate default editor
  #s::               s("{blind}"), ActivateApp("html_path")                     ;ActvateApp:1 Activate web browser
  #d::               s("{blind}"), ActivateApp("pdf_path")                      ;ActvateApp:1 Activate pdf viewer
  #b::               s("{blind}"), ActivateApp("explorer.exe")                  ;ActvateApp:1 Activate File explorer         
  
  /* SAMPLE CODE                                                                          
  #x::         s("{blind}"), ActivateApp("Convenience:\Everything\Everything.exe")        ;ActvateApp: e.g., accepts full file path
  */

; MEMORY FUNCTIONS (BLUE)_______________________________________________________
  ; modifier keys (+#^) can be swapped around to change the key combinations
  ; to call the below memory function but must always end in the numbers 0-9 
  
  
  +#0::                                                                         ;Memory: overwrite 0.txt with selected text 
  +#9::                                                                         ;Memory: overwrite 9.txt with selected text 
  +#8::                                                                         ;Memory: overwrite 8.txt with selected text 
  +#7::                                                                         ;Memory: overwrite 7.txt with selected text 
  +#6::                                                                         ;Memory: overwrite 6.txt with selected text 
  +#5::                                                                         ;Memory: overwrite 5.txt with selected text 
  +#4::                                                                         ;Memory: overwrite 4.txt with selected text 
  +#3::                                                                         ;Memory: overwrite 3.txt with selected text 
  +#2::                                                                         ;Memory: overwrite 2.txt with selected text 
  +#1::              OverwriteMemory()                                          ;Memory: overwrite 1.txt with selected text 

  ^#0::                                                                         ;Memory: add selected text to the bottom of 0.txt
  ^#9::                                                                         ;Memory: add selected text to the bottom of 9.txt
  ^#8::                                                                         ;Memory: add selected text to the bottom of 8.txt
  ^#7::                                                                         ;Memory: add selected text to the bottom of 7.txt
  ^#6::                                                                         ;Memory: add selected text to the bottom of 6.txt
  ^#5::                                                                         ;Memory: add selected text to the bottom of 5.txt
  ^#4::                                                                         ;Memory: add selected text to the bottom of 4.txt
  ^#3::                                                                         ;Memory: add selected text to the bottom of 3.txt
  ^#2::                                                                         ;Memory: add selected text to the bottom of 2.txt
  ^#1::              AddToMemory()                                              ;Memory: add selected text to the bottom of 1.txt

  #0::                                                                          ;Memory: paste contents of 0.txt 
  #9::                                                                          ;Memory: paste contents of 9.txt   
  #8::                                                                          ;Memory: paste contents of 8.txt   
  #7::                                                                          ;Memory: paste contents of 7.txt 
  #6::                                                                          ;Memory: paste contents of 6.txt    
  #5::                                                                          ;Memory: paste contents of 5.txt   
  #4::                                                                          ;Memory: paste contents of 4.txt   
  #3::                                                                          ;Memory: paste contents of 3.txt   
  #2::                                                                          ;Memory: paste contents of 2.txt   
  #1::               RetrieveMemory()                                           ;Memory: paste contents of 1.txt
    
  ^#LButton::        RetrieveMemory("^#LButton")                                ;Memory:| double click and paste contents of 1.txt at cursor position
  #!LButton::        RetrieveMemory(,"#!LButton")                               ;Memory:| paste contents of single digit .txt file entered at prompt
 
; CONVENIENCE (ORANGE) _________________________________________________________
  
  #SC035::           search()                                                   ;Convenience: google search selected text
  #sc028::                                                                      ;Convenience: maximize window
  ^!space::          s("{blind}"), MaximizeWin()                                ;Convenience: maximize window
  #SC027::           WinMinimize,A                                              ;Convenience: minimize window
  #del::             AlwaysOnTop(1)                                             ;Convenience: Window always on top: ON
  #ins::             AlwaysOnTop(0)                                             ;Convenience: Window always on top: OFF 
  +#capslock::                                                                  ;Convenience: rotate through application instances starting from oldest
  !capslock::        s("{blind}"), ActivatePrevInstance()                       ;Convenience: rotate through application instances starting from oldest
  +!capslock::                                                                  ;Convenience: rotate through application instances starting from newest
  #capslock::        s("{blind}"), ActivateNextInstance()                       ;Convenience: rotate through application instances starting from newest
  !SC027::           Send {esc}                                                 ;Convenience: simulate esc key (alt + semicolon)
  ^SC027::           Send {AppsKey}                                             ;Convenience: simulate appkey 
  ^#w::              WinClose,A                                                 ;Convenience: close active window 
  ^#q::              CloseClass()                                               ;Convenience: close all instances of the active program
  *LWin::            Send {Blind}{LWin Down}                                    ;Convenience:1 makes windows key inert so it can act as a modifier key 
  LWin Up::          Send {Blind}{vk00}{LWin Up}                                ;Convenience:1 makes windows key inert so it can act as a modifier key
  #Lbutton::                                                                    ;Convenience:1 open start menu (alt: Ctrl+Esc)
  $^#Enter::         send ^{esc}                                                ;Convenience:1 open start menu (alt: Ctrl+Esc)
  ~lwin & ~rshift::  CursorJump("C")                                            ;Convenience: move mouse cursor to center of active application window
  !sc034::           moveWinBtnMonitors()                                       ;Convenience: move window btn monitors
  $^!j::             s("{blind}"), s("^{sc00D}")                                ;Convenience: zoom in (simulate: ctrl + plus)
  $^!k::             s("{blind}"), s("^{sc00C}")                                ;Convenience: zoom out (simulate: ctrl + minus)
  !Backspace:: SendInput {End}{ShiftDown}{Home 2}{Left}{ShiftUp}{Delete}{Right} ;Convenience: Delete current line of text

  lshift & rshift::                                                             ;Convenience: reload WinGolems (update running script for changes, fixes sticky keys)
  rshift & lshift::  reload                                                     ;Convenience: reload WinGolems

  !#b::              BluetoothSettings()                                        ;Convenience:2 bluetooth settings (reassign less used windows sys shortcuts)
  !#d::              DisplaySettings()                                          ;Convenience:2 display settings
  !#n::              NotificationWindow()                                       ;Convenience:2 notification window
  !#r::              RunProgWindow()                                            ;Convenience:2 run program
  !#p::              PresentationDisplayMode()                                  ;Convenience:2 presentation display mode
  !#i::              WindowsSettings()                                          ;Convenience:2 windows settings

; NAVIGATION (PURPLE) __________________________________________________________

  #j::               Sendinput {Blind}{WheelDown 2}                             ;Navigation: scroll wheel down
  #k::               Sendinput {Blind}{WheelUp 2}                               ;Navigation: scroll wheel Up
  $#>!h::            Sendinput {Blind}{Wheelleft 6}                             ;Navigation: scroll wheel left
  $#>!l::            Sendinput {Blind}{WheelRight 6}                            ;Navigation: scroll wheel right
      
  #o::               send ^{home}                                               ;Navigation: Ctrl + Home
  #p::               send ^{end}                                                ;Navigation: Ctrl + end
  ^!h::              sendinput {home}                                           ;Navigation: Home
  ^!l::              sendinput {end}                                            ;Navigation: End
    
  !b::               send ^{PgUp}                                               ;Navigation: universal navigate to left tab
  !space::           s("{blind}"), s("^{PgDn}")                                 ;Navigation: universal navigate to right tab

; COMMAND BOX __________________________________________________________________; shared by all Command Boxes 

  #space::           CB("~win")                                                 ;Convenience: opens command box that runs ~win suffix CB keys; "?" for cheat sheet

  #IF WinActive("ahk_id " CB_hwnd)                                              ; If command Box active
  
  !q::               MoveWin("TL")                                              ;CommandBox: move CB window to top left
  !e::               MoveWin("TR")                                              ;CommandBox: move CB window to top right
  !z::               MoveWin("BL")                                              ;CommandBox: move CB window to bottom left
  !c::               MoveWin("BR")                                              ;CommandBox: move CB window to bottom right
  !w::               MoveWin("T")                                               ;CommandBox: move CB window to top half
  !s::               MoveWin("B")                                               ;CommandBox: move CB window to bottom half
  #left::                                                                       ;CommandBox: move CB window to left half
  !a::               MoveWin("L")                                               ;CommandBox: move CB window to left half
  #right::                                                                      ;CommandBox: move CB window to right half
  !d::               MoveWin("R")                                               ;CommandBox: move CB window to right half
  #space::           GUISubmit()                                                ;CommandBox: submit GUI input 
  $!x::              ToggleDisplay()                                            ;CommandBox: toggle Command Box display|minimalist mode
  !r::               GUIRecall()                                                ;CommandBox: reenter last command
  
  #IF WinExist("ahk_id " CB_hwnd) and !WinActive("ahk_id " CB_hwnd)             ; If command Box exists but not active
  
  $<^space::                                                                    ;CommandBox: activate CB if exists and move focus to inputbox 
  $>^space::         ActivateWin("ahk_id " CB_hwnd)                             ;CommandBox: activate CB if exists and move focus to inputbox
  
  #IF                                                                           ; end context specific assignments
  
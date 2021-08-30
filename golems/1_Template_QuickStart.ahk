#IF
; The following interface elements are valid anywhere in Windows 10
; ACTIVATE APPLICATION (GREEN)__________________________________________________
 
  +#F1::              s("{blind}"), SaveWinID("F1")                             ;ActvateApp: Save window ID for subsequent activation 
  +#F2::              s("{blind}"), SaveWinID("F2")                             ;ActvateApp: Save window ID for subsequent activation 
  +#F3::              s("{blind}"), SaveWinID("F3")                             ;ActvateApp: Save window ID for subsequent activation 
  +#F4::              s("{blind}"), SaveWinID("F4")                             ;ActvateApp: Save window ID for subsequent activation 
  +#F5::              s("{blind}"), SaveWinID("F5")                             ;ActvateApp: Save window ID for subsequent activation 
  +#F6::              s("{blind}"), SaveWinID("F6")                             ;ActvateApp: Save window ID for subsequent activation 
  +#F7::              s("{blind}"), SaveWinID("F7")                             ;ActvateApp: Save window ID for subsequent activation 
  +#F8::              s("{blind}"), SaveWinID("F8")                             ;ActvateApp: Save window ID for subsequent activation 
  #F1::               s("{blind}"), ActivateWinID("F1")                         ;ActvateApp: Activate previously saved window ID
  #F2::               s("{blind}"), ActivateWinID("F2")                         ;ActvateApp: Activate previously saved window ID
  #F3::               s("{blind}"), ActivateWinID("F3")                         ;ActvateApp: Activate previously saved window ID
  #F4::               s("{blind}"), ActivateWinID("F4")                         ;ActvateApp: Activate previously saved window ID
  #F5::               s("{blind}"), ActivateWinID("F5")                         ;ActvateApp: Activate previously saved window ID
  #F6::               s("{blind}"), ActivateWinID("F6")                         ;ActvateApp: Activate previously saved window ID
  #F7::               s("{blind}"), ActivateWinID("F7")                         ;ActvateApp: Activate previously saved window ID
  #F8::               s("{blind}"), ActivateWinID("F8")                         ;ActvateApp: Activate previously saved window ID
     
  #q::                s("{blind}"), ActivateApp("xls_path")                     ;ActvateApp:1 Activate Excel
  #w::                s("{blind}"), ActivateApp("doc_path")                     ;ActvateApp:1 Activate Word
  #a::                s("{blind}"), ActivateApp("pdf_path")                     ;ActvateApp:1 Activate pdf viewer
  #s::                s("{blind}"), ActivateApp("html_path")                    ;ActvateApp:1 Activate web browser
  #z::                s("{blind}"), ActivateApp("editor_path")                  ;ActvateApp:1 Activate default editor
  #x::                s("{blind}"), ActivateApp("ppt_path")                     ;ActvateApp:1 Activate PowerPoint
  #b::                s("{blind}"), ActivateApp("explorer.exe")                 ;ActvateApp:1 Activate File explorer         
  #t::                s("{blind}"), ActivateApp("cmd.exe")                      ;ActvateApp:1 Activate command window         
  
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
 
; CONVENIENCE (ORANGE) _________________________________________________________https://xhamster.com/videos/april-part-4-3443348
  
  #SC035::           search()                                                   ;Convenience: google search selected text
  #sc028::                                                                      ;Convenience: maximize window
  ^!space::          s("{blind}"), MaximizeWin()                                ;Convenience: maximize window
  #SC027::           WinMinimize,A                                              ;Convenience: minimize window
  #del::             AlwaysOnTop(1)                                             ;Convenience: Window always on top: ON
  #ins::             AlwaysOnTop(0)                                             ;Convenience: Window always on top: OFF 
  *!capslock::       ChgInstance()                                              ;Convenience: go through application instances with thumbnails(+!capslock for other direction)
  +#capslock::       s("{blind}"), ActivatePrevInstance()                       ;Convenience: rotate through app instances starting from most recent (no thumbnails, faster)
  #capslock::        s("{blind}"), ActivateNextInstance()                       ;Convenience: rotate through app instances starting from oldest (no thumbnail previews)
  
  !SC027::           Send {esc}                                                 ;Convenience: simulate esc key (alt + semicolon)
  ^SC027::           Send {AppsKey}                                             ;Convenience: simulate appkey 
  #esc::             WinClose,A                                                 ;Convenience: close active window 
  +#esc::            CloseClass()                                               ;Convenience: close all instances of the active program
  ~LWin::            Send {Blind}{vkE8}                                         ; https://www.autohotkey.com/docs/commands/_MenuMaskKey.htm
  #Lbutton::                                                                    ;Convenience:1 open start menu (alt: Ctrl+Esc)
  $^#Enter::         send ^{esc}                                                ;Convenience:1 open start menu (alt: Ctrl+Esc)
  ~ralt & ~rshift::                                                             ;Convenience: move mouse cursor to center of active application window
  ~lwin & ~rshift::  CursorJump("C")                                            ;Convenience: move mouse cursor to center of active application window
  !sc034::           moveWinBtnMonitors(), CFW()                                ;Convenience: move window btn monitors, cursor follows active windows
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
      
  #u::               send ^{home}                                               ;Navigation: Ctrl + Home
  #y::               send ^{end}                                                ;Navigation: Ctrl + end
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
  
#IF                                                                             ; end context dependent assignments
  
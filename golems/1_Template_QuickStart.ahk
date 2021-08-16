#IfWinActive
; The following interface elements are valid anywhere in Windows 10

; ACTIVATE APPLICATION (GREEN)__________________________________________________
 
  ^#z::              s("{blind}"), SaveWinID("z")                               ;AA: Save window ID for subsequent activation w/ win + r
  ^#x::              s("{blind}"), SaveWinID("x")                               ;AA: Save window ID for subsequent activation w/ win + t
  ^#c::              s("{blind}"), SaveWinID("c")                               ;AA: Save window ID for subsequent activation w/ win + g
  ^#f::              s("{blind}"), SaveWinID("f")                               ;AA: Save window ID for subsequent activation w/ win + g
  #z::               s("{blind}"), ActivateWinID("z")                           ;AA: Activate previously saved window ID
  #x::               s("{blind}"), ActivateWinID("x")                           ;AA: Activate previously saved window ID
  #c::               s("{blind}"), ActivateWinID("c")                           ;AA: Activate previously saved window ID
  #f::               s("{blind}"), ActivateWinID("f")                           ;AA: Activate previously saved window ID
     
  #q::               s("{blind}"), ActivateApp("ppt_path")                      ;AA: Activate Powerpoint
  #w::               s("{blind}"), ActivateApp("doc_path")                      ;AA: Activate Word
  #e::               s("{blind}"), ActivateApp("xls_path")                      ;AA: Activate Excel
  #a::               s("{blind}"), ActivateApp("editor_path")                   ;AA: Activate default editor
  #s::               s("{blind}"), ActivateApp("html_path")                     ;AA: Activate web browser
  #d::               s("{blind}"), ActivateApp("pdf_path")                      ;AA: Activate pdf viewer
  #b::               s("{blind}"), ActivateApp("explorer.exe")                  ;AA: Activate File explorer         
  
  /* SAMPLE CODE                                                                          
  #x::         s("{blind}"), ActivateApp("C:\Everything\Everything.exe")        ;AA: e.g., accepts full file path
  */

; MEMORY FUNCTIONS (BLUE)_______________________________________________________
  ; hotkey modifier keys (+#^) can be swapped around for the below memory function hotkeys, 
  ; however the assignment must end in the numbers 0-9 
  
  +#0::                                                                         ;MF: overwrite 0.txt with selected text 
  +#9::                                                                         ;MF: overwrite 9.txt with selected text 
  +#8::                                                                         ;MF: overwrite 8.txt with selected text 
  +#7::                                                                         ;MF: overwrite 7.txt with selected text 
  +#6::                                                                         ;MF: overwrite 6.txt with selected text 
  +#5::                                                                         ;MF: overwrite 5.txt with selected text 
  +#4::                                                                         ;MF: overwrite 4.txt with selected text 
  +#3::                                                                         ;MF: overwrite 3.txt with selected text 
  +#2::                                                                         ;MF: overwrite 2.txt with selected text 
  +#1::              OverwriteMemory()                                          ;MF: overwrite 1.txt with selected text 

  ^#0::                                                                         ;MF: add selected text to the bottom of 0.txt
  ^#9::                                                                         ;MF: add selected text to the bottom of 9.txt
  ^#8::                                                                         ;MF: add selected text to the bottom of 8.txt
  ^#7::                                                                         ;MF: add selected text to the bottom of 7.txt
  ^#6::                                                                         ;MF: add selected text to the bottom of 6.txt
  ^#5::                                                                         ;MF: add selected text to the bottom of 5.txt
  ^#4::                                                                         ;MF: add selected text to the bottom of 4.txt
  ^#3::                                                                         ;MF: add selected text to the bottom of 3.txt
  ^#2::                                                                         ;MF: add selected text to the bottom of 2.txt
  ^#1::              AddToMemory()                                              ;MF: add selected text to the bottom of 1.txt

  #0::                                                                          ;MF: paste contents of 0.txt 
  #9::                                                                          ;MF: paste contents of 9.txt   
  #8::                                                                          ;MF: paste contents of 8.txt   
  #7::                                                                          ;MF: paste contents of 7.txt 
  #6::                                                                          ;MF: paste contents of 6.txt    
  #5::                                                                          ;MF: paste contents of 5.txt   
  #4::                                                                          ;MF: paste contents of 4.txt   
  #3::                                                                          ;MF: paste contents of 3.txt   
  #2::                                                                          ;MF: paste contents of 2.txt   
  #1::               RetrieveMemory()                                           ;MF: paste contents of 1.txt
    
  ^#LButton::        RetrieveMemory("^#LButton")                                ;MF: mouse: double click and paste contents of 1.txt at cursor position
  #!LButton::        RetrieveMemory(,"#!LButton")                               ;MF: mouse: paste contents of single digit .txt file entered at prompt
 
; CONVENIENCE (ORANGE) _________________________________________________________
  
  #space::           CB("~win")                                                 ;C: opens command box that runs ~win suffix CB keys; "?" for cheat sheet
  #SC035::           search()                                                   ;C: google search selected text
  #sc028::                                                                      ;C: maximize window
  ^!space::          s("{blind}"), MaximizeWin()                                ;C: maximize window
  #SC027::           WinMinimize,A                                              ;C: minimize window
  #del::             AlwaysOnTop(1)                                             ;C: Always on top: ON
  #ins::             AlwaysOnTop(0)                                             ;C: Always on top: OFF 
  +#capslock::                                                                  ;C: rotate through active program instances starting from oldest
  !capslock::        s("{blind}"), ActivatePrevInstance()                       ;C: rotate through active program instances starting from oldest
  +!capslock::                                                                  ;C: rotate through active program instances starting from newest
  #capslock::        s("{blind}"), ActivateNextInstance()                       ;C: rotate through active program instances starting from newest
  !SC027::           Send {esc}                                                 ;C: simulate esc key (alt + semicolon)
  ^SC027::           Send {AppsKey}                                             ;C: simulate appkey 
  ^#w::              WinClose,A                                                 ;C: close active window 
  ^#q::              CloseClass()                                               ;C: close all instances of the active program
  *LWin::            Send {Blind}{LWin Down}                                    ;C: renders windows key inert so it can act as a modifier key for AHK hotkeys (start menu: ^#enter or lwin + left mouse click)
  LWin Up::          Send {Blind}{vk00}{LWin Up}                                ;C: renders windows key inert so it can act as a modifier key for AHK hotkeys (start menu: ^#enter or lwin + left mouse click)
  ~lwin & ~rshift::  CursorJump("C")                                            ;C: move mouse cursor to center of active application window
  !sc034::           moveWinBtnMonitors()                                       ;C: move window btn monitors
  $^!j::             s("{blind}"), s("^{sc00D}")                                ;C: zoom in (simulate: ctrl + plus)
  $^!k::             s("{blind}"), s("^{sc00C}")                                ;C: zoom out (simulate: ctrl + minus)

                                                                                ; reassign less used windows system shortcuts
  !#b::              BluetoothSettings()                                        ;C: system: bluetooth settings 
  !#d::              DisplaySettings()                                          ;C: system: display settings
  !#n::              NotificationWindow()                                       ;C: system: notification window
  !#r::              RunProgWindow()                                            ;C: system: run program
  !#p::              PresentationDisplayMode()                                  ;C: system: presentation display mode
  !#i::              WindowsSettings()                                          ;C: system: windows settings

; NAVIGATION (PURPLE) __________________________________________________________

  #j::               Sendinput {Blind}{WheelDown 2}                                    ;N: scroll wheel down                                               
  #k::               Sendinput {Blind}{WheelUp 2}                                      ;N: scroll wheel Up           
  $#>!h::            Sendinput {Blind}{Wheelleft 6}                             ;N: scroll wheel left
  $#>!l::            Sendinput {Blind}{WheelRight 6}                            ;N: scroll wheel right
      
  #o::               send ^{home}                                               ;N: Ctrl + Home
  #p::               send ^{end}                                                ;N: Ctrl + end
  ^!h::              sendinput {home}                                           ;N: Home
  ^!l::              sendinput {end}                                            ;N: End
    
  !b::               send ^{PgUp}                                               ;N: universal navigate to left tab
  !space::           s("{blind}"), s("^{PgDn}")                                 ;N: universal navigate to right tab

; CB hotkeys ___________________________________________________________________; shared by all Command Boxes 

  #IF WinActive("ahk_id " CB_hwnd)                                              ; If command Box active
  
  !q::               MoveWin("TL")                                              ;CB: move CB window to top left
  !e::               MoveWin("TR")                                              ;CB: move CB window to top right
  !z::               MoveWin("BL")                                              ;CB: move CB window to bottom left
  !c::               MoveWin("BR")                                              ;CB: move CB window to bottom right
  !w::               MoveWin("T")                                               ;CB: move CB window to top half
  !s::               MoveWin("B")                                               ;CB: move CB window to bottom half
  #left::                                                                       ;CB: move CB window to left half
  !a::               MoveWin("L")                                               ;CB: move CB window to left half
  #right::                                                                      ;CB: move CB window to right half
  !d::               MoveWin("R")                                               ;CB: move CB window to right half
  #space::           GUISubmit()                                                ;CB: submit GUI input 
  $!x::              ToggleDisplay()                                            ;CB: toggle Command Box display/minimalist mode
  !r::               GUIRecall()                                                ;CB: reenter last command
  
  #IF WinExist("ahk_id " CB_hwnd) and !WinActive("ahk_id " CB_hwnd)             ; If command Box exists
  
  $<^space::                                                                    ;CB: activate CB if exists and move focus to inputbox
  $>^space::         ActivateWin("ahk_id " CB_hwnd)                             ;CB: activate CB if exists and move focus to inputbox
  
  #IF                                                                           ; end context specific assignments
  
#IfWinActive
; The following interface layers are valid anywhere in Windows 10

; ACTIVATE APPLICATION (GREEN)__________________________________________________

  #F1::          Send #1                                                        ;AA: activate app 1 in task bar 
  #F2::          Send #2                                                        ;AA: activate app 2 in task bar 
  #F3::          Send #3                                                        ;AA: activate app 3 in task bar 
  #F4::          Send #4                                                        ;AA: activate app 4 in task bar 
  #F5::          Send #5                                                        ;AA: activate app 5 in task bar 
  #F6::          Send #6                                                        ;AA: activate app 6 in task bar 
  #F7::          Send #7                                                        ;AA: activate app 7 in task bar 
  #F8::          Send #8                                                        ;AA: activate app 8 in task bar 
  #F9::          Send #9                                                        ;AA: activate app 9 in task bar 
  
  ^#r::          SaveWinID("r")                                                 ;AA: Save window ID for subsequent activation w/ win + r
  ^#t::          SaveWinID("t")                                                 ;AA: Save window ID for subsequent activation w/ win + t
  ^#g::          SaveWinID("g")                                                 ;AA: Save window ID for subsequent activation w/ win + g
  ^#f::          SaveWinID("f")                                                 ;AA: Save window ID for subsequent activation w/ win + f
  #r::           ActivateWinID("r")                                             ;AA: Activate previously saved window ID
  #t::           ActivateWinID("t")                                             ;AA: Activate previously saved window ID
  #g::           ActivateWinID("g")                                             ;AA: Activate previously saved window ID
  #f::           ActivateWinID("f")                                             ;AA: Activate previously saved window ID
  
  #q::           ActivateApp("ppt_path")                                        ;AA: Activate Powerpoint
  #w::           ActivateApp("doc_path")                                        ;AA: Activate Word
  #e::           ActivateApp("xls_path")                                        ;AA: Activate Excel
  #a::           ActivateApp("editor_path")                                     ;AA: Activate default editor
  #s::           ActivateApp("html_path")                                       ;AA: Activate web browser
  #d::           ActivateApp("pdf_path")                                        ;AA: Activate pdf viewer
  #b::           ActivateApp("explorer.exe")                                    ;AA: Activate File explorer                                                                                   
  #c::           ActivateCalc()                                                 ;AA: Activate Calculator
 
; CONVENIENCE (ORANGE) _________________________________________________________
  
  #SC035::       search()                                                       ;C: google search selected text
  #sc028::                                                                      ;C: maximize window
  ^!space::      MaximizeWin()                                                  ;C: maximize window
  #SC027::       WinMinimize,A                                                  ;C: minimize window
  #del::         AlwaysOnTop(1)                                                 ;C: Always on top: ON
  #ins::         AlwaysOnTop(0)                                                 ;C: Always on top: OFF
  +#tab::        ActivatePrevInstance()                                         ;C: rotate through active program instances starting from oldest
  #tab::         ActivateNextInstance()                                         ;C: rotate through active program instances starting from newest
  !SC027::       Send {esc}                                                     ;C: alternate esc key (alt + semicolon)
  ^SC027::       Send {AppsKey}                                                 ;C: appkey press
  ^#w::          WinClose,A                                                     ;C: close active window 
  ^#q::          CloseClass()                                                   ;C: close all instances of the active program
  *LWin::        Send {Blind}{LWin Down}                                        ;C: renders windows key inert so it can act as a modifier key for AHK hotkeys (start menu: ^#enter or lwin + left mouse click)
  LWin Up::      Send {Blind}{vk00}{LWin Up}                                    ;C: renders windows key inert so it can act as a modifier key for AHK hotkeys (start menu: ^#enter or lwin + left mouse click)
                                                                                ; https://autohotkey.com/board/topic/29443-disable-opening-the-start-menu/

  $^!j::         Sendinput ^{sc00D}                                             ;C: zoom in
  $^!k::         Sendinput ^{sc00C}                                             ;C: zoom out
                                                                                
  !b::           send ^{PgUp}                                                   ;C: navigate to right tab
  !space::                                                                      ;C: navigate to left tab
    send {Blind}                                                                ; fixes issue with alt key opening application menues
    send ^{PgDn}                                                                
    return

  :X:tc~win::                                                                   ;C: Toggle capslocks = del key
    CC("T_capslock_del","!")                                                    ; change config.ini by toggling entry for "T_capslock_del"
    ShowPopup("capslocks => delete: " GC("T_text_opt"))
    return
  
  #IF GC("T_capslock_del",0)                                                    ; must be turned on by entering "tc" in CB("~win") or typing "tc~win" anywhere in windows
    capslock::del                                                               ;C: makes capslock key function as a delete key. (toggle capslock: alt + capslock)   
    !capslock::CapsLock                                                         ;C: toggle capslock
  #IF                                                                           ; removes context sensitivity for keys below

; MEMORY FUNCTIONS (BLUE)_______________________________________________________
  ; hotkey modifier keys (+#^) can be swapped around for the below hotkeys, 
  ; however the assignment must end in the numbers 0-9 for the memory system to work 
  
  $+#0::                                                                        ;MF: overwrite 0.txt with selected text 
  $+#9::                                                                        ;MF: overwrite 9.txt with selected text 
  $+#8::                                                                        ;MF: overwrite 8.txt with selected text 
  $+#7::                                                                        ;MF: overwrite 7.txt with selected text 
  $+#6::                                                                        ;MF: overwrite 6.txt with selected text 
  $+#5::                                                                        ;MF: overwrite 5.txt with selected text 
  $+#4::                                                                        ;MF: overwrite 4.txt with selected text 
  $+#3::                                                                        ;MF: overwrite 3.txt with selected text 
  $+#2::                                                                        ;MF: overwrite 2.txt with selected text 
  $+#1::         OverwriteMemory()                                              ;MF: overwrite 1.txt with selected text 

  !#0::                                                                         ;MF: add selected text to the bottom of 0.txt
  !#9::                                                                         ;MF: add selected text to the bottom of 9.txt
  !#8::                                                                         ;MF: add selected text to the bottom of 8.txt
  !#7::                                                                         ;MF: add selected text to the bottom of 7.txt
  !#6::                                                                         ;MF: add selected text to the bottom of 6.txt
  !#5::                                                                         ;MF: add selected text to the bottom of 5.txt
  !#4::                                                                         ;MF: add selected text to the bottom of 4.txt
  !#3::                                                                         ;MF: add selected text to the bottom of 3.txt
  !#2::                                                                         ;MF: add selected text to the bottom of 2.txt
  !#1::          AddToMemory()                                                  ;MF: add selected text to the bottom of 1.txt

  #0::                                                                          ;MF: paste contents of 0.txt 
  #9::                                                                          ;MF: paste contents of 9.txt   
  #8::                                                                          ;MF: paste contents of 8.txt   
  #7::                                                                          ;MF: paste contents of 7.txt 
  #6::                                                                          ;MF: paste contents of 6.txt    
  #5::                                                                          ;MF: paste contents of 5.txt   
  #4::                                                                          ;MF: paste contents of 4.txt   
  #3::                                                                          ;MF: paste contents of 3.txt   
  #2::                                                                          ;MF: paste contents of 2.txt   
  #1::           RetrieveMemory()                                               ;MF: paste contents of 1.txt  

  ^#LButton::    RetrieveMemory("^#LButton")                                    ;MF: mouse: double click and paste contents of 1.txt at cursor position
  #!LButton::    RetrieveMemory(,"#!LButton")                                   ;MF: mouse: paste contents of single digit .txt file entered at prompt

; TEXT (PURPLE) ________________________________________________________________

  #y::           % (t := !t) ? ConvertUpper() : ConvertLower()                  ;T: Toggle: change selected text to uppercase or lowercase  
  +#y::          % (t := !t) ? Capitalize1stLetter(,,0) : Capitalize1stLetter() ;T: Toggle: capitalize the first letter of all selected words (title case) or only the first word
  #i::           ReplaceAwithB()                                                ;T: replace multiple consecutive spaces w/ one space in selected text
  #o::           RemoveBlankLines()                                             ;T: remove blank lines in selected text
  !#space::      ReplaceAwithB(" ")                                             ;T: remove all spaces from selected text
  ^#space::      ReplaceAwithB()                                                ;T: replace multiple consecutive spaces w/ a single space in selected text
  #j::           Sendinput {WheelDown 5}                                        ;NT: scroll wheel down                                               
  #k::           Sendinput {WheelUp 5}                                          ;NT: scroll wheel Up           
  ^!h::          sendinput {home}                                               ;NT: Home
  ^!l::          sendinput {end}                                                ;NT: End
  #u::           SelectWord()                                                   ;ST: select word at text cursor position

  :X:tt~win::                                                                   ;ST|NT: toggle text navigation and selection supplemental hotkeys
    CC("T_text_opt","!")                                                        ; change config.ini by toggling entry for "T_text_opt"
    ShowPopup("Text selection & navigation hotkeys: " GC("T_text_opt"))
    return

  
 ; TEXT SELECTION AND NAVIGATION -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --; must be turned on by entering "tt" in CB("~win") or typing "tt~win" anywhere in windows
   #IF GC("T_text_opt",0)                                                       ; get config.ini value for T_text_opt, default to false (0) if no value found.
                             
   ; SELECT TEXT ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... 
 
    $!f::        SelectWord()                                                   ;ST: select word at text cursor position
    $+!f::       SelectLine()                                                   ;ST: select current line starting from begining of line
    $^!f::       Sendinput {end}+{home}                                         ;ST: select line starting from end of line
    
    $^#h::       sendinput +{Home}                                              ;ST: select to beginning of line
    $^#l::       sendinput +{End}                                               ;ST: select to end of line
    $+^j::       Sendinput +{down}                                              ;ST: select to next line
    $+^k::       Sendinput +{up}                                                ;ST: select to line above
    
    $^#j::       sendinput ^+{end}                                              ;ST: select all below
    $^#k::       sendinput ^+{home}                                             ;ST: select all above
    
    $+#h::       Sendinput +^{Left}                                             ;ST: extend selection Left  1 word
    $+#l::       Sendinput +^{Right}                                            ;ST: extend selection Right 1 word
    
    $+!l::       Sendinput +{Right}                                             ;ST: extend selection Right 1 character
    $+!h::       Sendinput +{Left}                                              ;ST: extend selection Left  1 character
    +!j::        sendinput +{down}                                              ;ST: extend selection down  1 row
    +!k::        sendinput +{up}                                                ;ST: extend selection up    1 row
    
  ; NAVIGATE TEXT ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... 

    #p::         sendinput ^{home}                                              ;NT: Ctrl + Home
    #SC01A::     sendinput ^{end}                                               ;NT: Ctrl + End  (note: SC01A = "[" to see a SC code reference table type "Lsck" in a Command Box)
    $#h::        sendinput ^{Left}                                              ;NT: jump to next word = simulate ctrl+Left
    $#l::        sendinput ^{Right}                                             ;NT: jump to next word = simulate ctrl+Right
    $!h::        sendinput {Left}                                               ;NT: Left
    $!l::        sendinput {Right}                                              ;NT: Right
    *$#k::                                                                      ;NT: Up
    *$!k::       sendinput {Up}                                                 ;NT: Up
    *$#j::                                                                      ;NT: Down
    *$!j::       sendinput {Down}                                               ;NT: Down
  
; CHANGE FOLDER IN FILELISTERS _________________________________________________
  
  SetTitleMatchMode, 2
  #IfWinActive ahk_group FileListers                                            ; ChangeFolders works in file explorer and open file + save as dialogue boxes
  
  >+sc029::     ChangeFolder(A_ScriptDir)                                       ;CF: AHK folder
  >+m::         ChangeFolder(A_ScriptDir "\mem_cache\")                         ;CF: mem_cache
  
  /* SAMPLE CODE

     >+c::        ChangeFolder(hdrive)                                          ;CF: %Homedrive% (C:)
     >+o::        ChangeFolder(A_ProgramFiles)                                  ;CF: C:\Program Files
     >+!o::       ChangeFolder(PF_x86)                                          ;CF: C:\Program Files(x86)
     >+u::        ChangeFolder(UProfile)                                        ;CF: %UserProfile%
     >+p::        ChangeFolder(UProfile "\Pictures\")                           ;CF: Pictures
     >+g::        ChangeFolder(UProfile "\Google Drive")                        ;CF: google drive
     >+j::        ChangeFolder(UProfile "\Downloads")                           ;CF: Downloads
     >+d::        ChangeFolder(UProfile "\Documents")                           ;CF: Documents
     >+r::        ChangeFolder("`:`:{645FF040-5081-101B-9F08-00AA002F954E}")    ;CF: Recycle bin (doesn't work for save as diag)
     >+t::        ChangeFolder("`:`:{20D04FE0-3AEA-1069-A2D8-08002B30309D}")    ;CF: This PC / My Computer
 
  */

#IfWinActive

  




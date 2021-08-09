#IfWinActive
; The following interface layers are valid anywhere in Windows 10
; ACTIVATE APPLICATION (GREEN)__________________________________________________

  #F1::          Send #1                                                        ;[A] activate app 1 in task bar 
  #F2::          Send #2                                                        ;[A] activate app 2 in task bar 
  #F3::          Send #3                                                        ;[A] activate app 3 in task bar 
  #F4::          Send #4                                                        ;[A] activate app 4 in task bar 
  #F5::          Send #5                                                        ;[A] activate app 5 in task bar 
  #F6::          Send #6                                                        ;[A] activate app 6 in task bar 
  #F7::          Send #7                                                        ;[A] activate app 7 in task bar 
  #F8::          Send #8                                                        ;[A] activate app 8 in task bar 
  #F9::          Send #9                                                        ;[A] activate app 9 in task bar 
  
  ^#r::          SaveWinID("r")                                                 ;[A] Save window ID for subsequent activation w/ win + r
  ^#t::          SaveWinID("t")                                                 ;[A] Save window ID for subsequent activation w/ win + t
  ^#g::          SaveWinID("g")                                                 ;[A] Save window ID for subsequent activation w/ win + g
  ^#f::          SaveWinID("f")                                                 ;[A] Save window ID for subsequent activation w/ win + f
  #r::           ActivateWinID("r")                                             ;[A] Activate previously saved window ID
  #t::           ActivateWinID("t")                                             ;[A] Activate previously saved window ID
  #g::           ActivateWinID("g")                                             ;[A] Activate previously saved window ID
  #f::           ActivateWinID("f")                                             ;[A] Activate previously saved window ID
  
  #q::           ActivateApp("ppt_path")                                        ;[A] Activate Powerpoint
  #w::           ActivateApp("doc_path")                                        ;[A] Activate Word
  #e::           ActivateApp("xls_path")                                        ;[A] Activate Excel
  #a::           ActivateApp("editor_path")                                     ;[A] Activate default editor
  #s::           ActivateApp("html_path")                                       ;[A] Activate web browser
  #d::           ActivateApp("pdf_path")                                        ;[A] Activate pdf viewer
  #b::           ActivateApp("explorer.exe")                                    ;[A] Activate File explorer                                                                                   
  #c::           ActivateCalc()                                                 ;[A] Activate Calculator
 
; CONVENIENCE (ORANGE) _________________________________________________________
  
  ^!space::      MaximizeWin()                                                  ;[C] toggle maximize/restore window
  #SC027::       WinMinimize,A                                                  ;[C] minimize window
  #del::         AlwaysOnTop(1)                                                 ;[C] Always on top: ON
  #ins::         AlwaysOnTop(0)                                                 ;[C] Always on top: OFF
  +#tab::        ActivatePrevInstance()                                         ;[C] rotate through active program instances starting from oldest
  #tab::         ActivateNextInstance()                                         ;[C] rotate through active program instances starting from newest
  !SC027::       Send {esc}                                                     ;[C] alternate esc key (alt + semicolon)

; MEMORY FUNCTIONS (BLUE)_______________________________________________________
  ; hotkey modifier keys (+#^) can be changed, however the hotkey assignment 
  ; must end in the numbers 0-9 for memory keyboard shortcuts
  
  $+#0::                                                                        ;[M] overwrite 0.txt with selected text 
  $+#9::                                                                        ;[M] overwrite 9.txt with selected text 
  $+#8::                                                                        ;[M] overwrite 8.txt with selected text 
  $+#7::                                                                        ;[M] overwrite 7.txt with selected text 
  $+#6::                                                                        ;[M] overwrite 6.txt with selected text 
  $+#5::                                                                        ;[M] overwrite 5.txt with selected text 
  $+#4::                                                                        ;[M] overwrite 4.txt with selected text 
  $+#3::                                                                        ;[M] overwrite 3.txt with selected text 
  $+#2::                                                                        ;[M] overwrite 2.txt with selected text 
  $+#1::         OverwriteMemory()                                              ;[M] overwrite 1.txt with selected text 

  !#0::                                                                         ;[M] add selected text to the bottom of 0.txt
  !#9::                                                                         ;[M] add selected text to the bottom of 9.txt
  !#8::                                                                         ;[M] add selected text to the bottom of 8.txt
  !#7::                                                                         ;[M] add selected text to the bottom of 7.txt
  !#6::                                                                         ;[M] add selected text to the bottom of 6.txt
  !#5::                                                                         ;[M] add selected text to the bottom of 5.txt
  !#4::                                                                         ;[M] add selected text to the bottom of 4.txt
  !#3::                                                                         ;[M] add selected text to the bottom of 3.txt
  !#2::                                                                         ;[M] add selected text to the bottom of 2.txt
  !#1::          AddToMemory()                                                  ;[M] add selected text to the bottom of 1.txt

  #0::                                                                          ;[M] paste contents of 0.txt 
  #9::                                                                          ;[M] paste contents of 9.txt   
  #8::                                                                          ;[M] paste contents of 8.txt   
  #7::                                                                          ;[M] paste contents of 7.txt 
  #6::                                                                          ;[M] paste contents of 6.txt    
  #5::                                                                          ;[M] paste contents of 5.txt   
  #4::                                                                          ;[M] paste contents of 4.txt   
  #3::                                                                          ;[M] paste contents of 3.txt   
  #2::                                                                          ;[M] paste contents of 2.txt   
  #1::           RetrieveMemory()                                               ;[M] paste contents of 1.txt  

  ^#LButton::    RetrieveMemory("^#LButton")                                    ;[M] double click and paste contents of 1.txt at cursor position
  #!LButton::    RetrieveMemory(,"#!LButton")                                   ;[M] paste contents of single digit .txt file entered at prompt

; TEXT (PURPLE) ________________________________________________________________

  ; MANIPULATE TEXT -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

    #y::         % (t := !t) ? ConvertUpper() : ConvertLower()                  ;[MT] Toggle transform selected text to uppercase or lowercase  
    +#y::        % (t := !t) ? Capitalize1stLetter(,,0) : Capitalize1stLetter() ;[MT] Toggle capitalize the first letter of all selected words (title case) vs only the first word
    #i::         ReplaceAwithB()                                                ;[MT] replace multiple consecutive spaces w/ one space in selected text
    #o::         RemoveBlankLines()                                             ;[MT] remove blank lines in selected text

  ; SELECT TEXT-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

    #u::                                                                        ;[ST] select word at text cursor
    $!f::        SelectWord()                                                   ;[ST] select word at text cursor
    $+!f::       SelectLine()                                                   ;[ST] select current line starting from begining of line
    $^!f::       Sendinput {end}+{home}                                         ;[ST] select line starting from end of line
    
    $^#h::       sendinput +{Home}                                              ;[ST] select to beginning of line
    $^#l::       sendinput +{End}                                               ;[ST] select to end of line
    $+^j::       Sendinput +{down}                                              ;[ST] select to next line
    $+^k::       Sendinput +{up}                                                ;[ST] select to line above
    
    $^#j::       sendinput ^+{end}                                              ;[ST] select all below
    $^#k::       sendinput ^+{home}                                             ;[ST] select all above
    
    $+#h::       Sendinput +^{Left}                                             ;[ST] extend selection Left  1 word
    $+#l::       Sendinput +^{Right}                                            ;[ST] extend selection Right 1 word
    
    $+!l::       Sendinput +{Right}                                             ;[ST] extend selection Right 1 character
    $+!h::       Sendinput +{Left}                                              ;[ST] extend selection Left  1 character
    +!j::        sendinput +{down}                                              ;[ST] extend selection down  1 row
    +!k::        sendinput +{up}                                                ;[ST] extend selection up    1 row
    
  ; NAVIGATE TEXT -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
  
    
    ^!h::        sendinput {home}                                               ;[NT] Home
    ^!l::        sendinput {end}                                                ;[NT] End
    #j::         Sendinput {WheelDown 5}                                        ;[NT] scroll wheel down                                               
    #k::         Sendinput {WheelUp 5}                                          ;[NT] scroll wheel Up           
    #p::         sendinput ^{home}                                              ;[NT] Ctrl + Home
    #SC01A::     sendinput ^{end}                                               ;[NT] Ctrl + End  (note: SC01A = "[" to see a SC code reference table type "Lsck" in a Command Box)
    $#h::        sendinput ^{Left}                                              ;[NT] jump to next word = simulate ctrl+Left
    $#l::        sendinput ^{Right}                                             ;[NT] jump to next word = simulate ctrl+Right
    $!h::        sendinput {Left}                                               ;[NT] Left
    $!l::        sendinput {Right}                                              ;[NT] Right
    *$#k::                                                                      ;[NT] Up
    *$!k::       sendinput {Up}                                                 ;[NT] Up
    *$#j::                                                                      ;[NT] Down
    *$!j::       sendinput {Down}                                               ;[NT] Down
  

#IfWinActive

  




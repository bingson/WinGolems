#IfWinActive
; The following interface layers are valid anywhere in Windows 10
; ACTIVATE APPLICATION (GREEN)__________________________________________________

  #F1::          Send #1                                                        ;[AA] activate app 1 in task bar 
  #F2::          Send #2                                                        ;[AA] activate app 2 in task bar 
  #F3::          Send #3                                                        ;[AA] activate app 3 in task bar 
  #F4::          Send #4                                                        ;[AA] activate app 4 in task bar 
  #F5::          Send #5                                                        ;[AA] activate app 5 in task bar 
  #F6::          Send #6                                                        ;[AA] activate app 6 in task bar 
  #F7::          Send #7                                                        ;[AA] activate app 7 in task bar 
  #F8::          Send #8                                                        ;[AA] activate app 8 in task bar 
  #F9::          Send #9                                                        ;[AA] activate app 9 in task bar 
  
  ^#r::          SaveWinID("r")                                                 ;[AA] Save window ID for subsequent activation w/ win + r
  ^#t::          SaveWinID("t")                                                 ;[AA] Save window ID for subsequent activation w/ win + t
  ^#g::          SaveWinID("g")                                                 ;[AA] Save window ID for subsequent activation w/ win + g
  ^#f::          SaveWinID("f")                                                 ;[AA] Save window ID for subsequent activation w/ win + f
  #r::           ActivateWinID("r")                                             ;[AA] Activate previously saved window ID
  #t::           ActivateWinID("t")                                             ;[AA] Activate previously saved window ID
  #g::           ActivateWinID("g")                                             ;[AA] Activate previously saved window ID
  #f::           ActivateWinID("f")                                             ;[AA] Activate previously saved window ID
  
  #q::           ActivateApp("ppt_path")                                        ;[AA] Activate Powerpoint
  #w::           ActivateApp("doc_path")                                        ;[AA] Activate Word
  #e::           ActivateApp("xls_path")                                        ;[AA] Activate Excel
  #a::           ActivateApp("editor_path")                                     ;[AA] Activate default editor
  #s::           ActivateApp("html_path")                                       ;[AA] Activate web browser
  #d::           ActivateApp("pdf_path")                                        ;[AA] Activate pdf viewer
  #b::           ActivateApp("explorer.exe")                                    ;[AA] Activate File explorer                                                                                   
  #c::           ActivateCalc()                                                 ;[AA] Activate Calculator
 
; WINDOWS MANAGEMENT (ORANGE)___________________________________________________

  #SC027::       WinMinimize,A                                                  ;[WM] minimize window
  #SC027::       WinMinimize,A                                                  ;[WM] minimize window
  #del::         AlwaysOnTop(1)                                                 ;[WM] Always on top: ON
  #ins::         AlwaysOnTop(0)                                                 ;[WM] Always on top: OFF
  +#tab::        ActivatePrevInstance()                                         ;[WM] rotate through active program instances starting from oldest
  #tab::         ActivateNextInstance()                                         ;[WM] rotate through active program instances starting from newest

; MEMORY FUNCTIONS (BLUE)_______________________________________________________
  ; hotkey modifier keys (+#^) can be changed, however the hotkey assignment 
  ; must end in the numbers 0-9 for memory keyboard shortcuts
  
  $+#0::                                                                        ;[MS] overwrite 0.txt with selected text 
  $+#9::                                                                        ;[MS] overwrite 9.txt with selected text 
  $+#8::                                                                        ;[MS] overwrite 8.txt with selected text 
  $+#7::                                                                        ;[MS] overwrite 7.txt with selected text 
  $+#6::                                                                        ;[MS] overwrite 6.txt with selected text 
  $+#5::                                                                        ;[MS] overwrite 5.txt with selected text 
  $+#4::                                                                        ;[MS] overwrite 4.txt with selected text 
  $+#3::                                                                        ;[MS] overwrite 3.txt with selected text 
  $+#2::                                                                        ;[MS] overwrite 2.txt with selected text 
  $+#1::         OverwriteMemory()                                              ;[MS] overwrite 1.txt with selected text 

  !#0::                                                                         ;[MS] add selected text to the bottom of 0.txt
  !#9::                                                                         ;[MS] add selected text to the bottom of 9.txt
  !#8::                                                                         ;[MS] add selected text to the bottom of 8.txt
  !#7::                                                                         ;[MS] add selected text to the bottom of 7.txt
  !#6::                                                                         ;[MS] add selected text to the bottom of 6.txt
  !#5::                                                                         ;[MS] add selected text to the bottom of 5.txt
  !#4::                                                                         ;[MS] add selected text to the bottom of 4.txt
  !#3::                                                                         ;[MS] add selected text to the bottom of 3.txt
  !#2::                                                                         ;[MS] add selected text to the bottom of 2.txt
  !#1::          AddToMemory()                                                  ;[MS] add selected text to the bottom of 1.txt

  #0::                                                                          ;[MS] paste contents of 0.txt 
  #9::                                                                          ;[MS] paste contents of 9.txt   
  #8::                                                                          ;[MS] paste contents of 8.txt   
  #7::                                                                          ;[MS] paste contents of 7.txt 
  #6::                                                                          ;[MS] paste contents of 6.txt    
  #5::                                                                          ;[MS] paste contents of 5.txt   
  #4::                                                                          ;[MS] paste contents of 4.txt   
  #3::                                                                          ;[MS] paste contents of 3.txt   
  #2::                                                                          ;[MS] paste contents of 2.txt   
  #1::           RetrieveMemory()                                               ;[MS] paste contents of 1.txt  

  ^#LButton::    RetrieveMemory("^#LButton")                                    ;[MS] double click and paste contents of 1.txt at cursor position
  #!LButton::    RetrieveMemory(,"#!LButton")                                   ;[MS] paste contents of single digit .txt file entered at prompt

; TEXT FUNCTIONS (PURPLE)_______________________________________________________

  #y::           % (t := !t) ? ConvertUpper() : ConvertLower()                  ;[TF] Toggle transform selected text to uppercase or lowercase  
  +#y::          % (t := !t) ? Capitalize1stLetter(,,0) : Capitalize1stLetter() ;[TF] Toggle capitalize the first letter of all selected words (title case) vs only the first word
  #u::           SelectWord()                                                   ;[TF] select word at current cursor position
  #i::           ReplaceAwithB()                                                ;[TF] replace multiple consecutive spaces w/ one space in selected text
  #o::           RemoveBlankLines()                                             ;[TF] remove blank lines in selected text
  #p::           sendinput ^{home}                                              ;[TF] Ctrl + Home
  #SC01A::       sendinput ^{end}                                               ;[TF] Ctrl + End  (note: SC01A = "[" to see a SC code reference table type "Lsck" in a Command Box)
  
  ^!h::          sendinput {home}                                               ;[TF] Home
  ^!l::          sendinput {end}                                                ;[TF] End
  #j::           Sendinput {WheelDown 5}                                        ;[MF] scroll wheel down                                               
  #k::           Sendinput {WheelUp 5}                                          ;[MF] scroll wheel Up                                               

#IfWinActive

  




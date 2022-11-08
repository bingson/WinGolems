; ACTIVATE APPS (GREEN) ________________________________________________________
    #IF
    ; AA("application_exe_path")
    ;SaveWinID("unique_string")
    ; ActivateWinID("unique_string")
  
    $#z::   AA("obsidian_path")                                                  ;Apps| Activate Obsidian               
    $#x::   AA("pdf_path")                                                       ;Apps| Activate pdf reader                 
    $#c::   AA("cmd.exe")                                                        ;Apps| Activate Command window
    $#a::   AA("editor_path")                                                    ;Apps| Activate text/code editor                 
    $#s::   AA("html_path", " --overscroll-history-navigation=0")                ;Apps| Activate Edge browser
    $#q::   AA("xls_path")                                                       ;Apps| Activate Excel         
    $#w::   AA("doc_path")                                                       ;Apps| Activate Word        
    $+#w::  AA("ppt_path")                                                       ;Apps| Activate Word        
    $#r::   AA("C:\Program Files\KeePassXC\KeePassXC.exe")                       ;Apps| Activate keepass
    $#t::   ActivateCalc()                                                       ;Apps| Activate Calculator    
    $#b::   AA("explorer.exe")                                                   ;Apps| Activate File Explorer 
    $+#b::  send #e                                                              ;new explorer instance
    $+#r::  AA("C:\Program Files\WizTree\WizTree64.exe")                         ;Apps| Activate wiztree
    $#n::   AA("html2_path"," --overscroll-history-navigation=0")                ;Apps| Activate Chrome browser
    $#u::   AA(A_ProgramFiles "\Anki\anki.exe")                                  ;Apps| Anki
    $#m::   AA(A_ProgramFiles "\VideoLAN\VLC\vlc.exe")                           ;Apps| Obsidian
    $#y::   everythingSearch()                                                   ;Apps| everything search
    $<!#m:: AA(PF_x86 "\foobar2000\foobar2000.exe")                              ;Apps| foobar
                                                                                
                                                                                
                                                                                
    $+#p::           AA(PF "\HyperSnap v8.20\HyperSnapPortable.exe", "HprSnap8.exe",2)                                                                
    :X:edge~win::   CC("html_path",GC("edge_path")), CC("html2_path",GC("chrome_path")), PU("1: edge, 2:chrome")
    :X:chrome~win:: CC("html_path",GC("chrome_path")), CC("html2_path",GC("edge_path")), PU("1: chrome, 2:edge")

   ;#SC02b::      AA("- Remote Desktop",,1)                                       ;Apps| remote desktop
   ;#n::           AA(A_ScriptDir "\assets\win\Power BI Desktop - Shortcut.lnk", "pbidesktop.exe",2) ;Apps| Activate Power BI     

; SAVE/ACTIVATE WINDOW ID ______________________________________________________
    
    #If GetKeyState("printscreen", "P")
    rctrl & n::                                                                   
    rctrl & m::                                                                   
    rctrl & SC033::                                                               
    rctrl & SC034::                                                               
    rctrl & SC035::
    rctrl & ESC::                                                               ;Apps: Save window ID for printscreen + esc activation
    rctrl & F1::                                                                ;Apps: Save window ID for printscreen+F1 activation
    rctrl & F2::                                                                ;Apps: Save window ID for printscreen+F2 activation
    rctrl & F3::                                                                ;Apps: Save window ID for printscreen+F3 activation
    rctrl & F4::                                                                ;Apps: Save window ID for printscreen+F4 activation
    rctrl & F5::                                                                ;Apps: Save window ID for printscreen+F5 activation
    rctrl & F6::                                                                ;Apps: Save window ID for printscreen+F6 activation
    rctrl & F7::                                                                ;Apps: Save window ID for printscreen+F7 activation
    rctrl & F8::                                                                ;Apps: Save window ID for printscreen+F8 activation
    rctrl & q::                                                                 ;Apps: Save window ID for printscreen+q activation
    rctrl & w::                                                                 ;Apps: Save window ID for printscreen+w activation
    rctrl & e::                                                                 ;Apps: Save window ID for printscreen+e activation
    rctrl & r::                                                                 ;Apps: Save window ID for printscreen+r activation
    rctrl & a::                                                                 ;Apps: Save window ID for printscreen+a activation
    rctrl & s::                                                                 ;Apps: Save window ID for printscreen+s activation
    rctrl & d::                                                                 ;Apps: Save window ID for printscreen+d activation
    rctrl & f::                                                                 ;Apps: Save window ID for printscreen+f activation
    rctrl & z::                                                                 ;Apps: Save window ID for printscreen+z activation
    rctrl & x::                                                                 ;Apps: Save window ID for printscreen+x activation
    rctrl & C::                                                                 ;Apps: Save window ID for printscreen+C activation
    rctrl & v:: SaveWinID(StrReplace(A_ThisHotkey,"rctrl & "))                  ;Apps: Save window ID for printscreen+v activation
                                                                                
    #If GetKeyState("PrintScreen", "P")
    $esc::                                                                      ;ActvateApp: activate saved Window ID
    $SC033::                                                                    ;ActvateApp: activate saved Window ID
    $SC034::                                                                    ;ActvateApp: activate saved Window ID
    $SC035::                                                                    ;ActvateApp: activate saved Window ID
    $m::                                                                        ;ActvateApp: activate saved Window ID
    $n::                                                                        ;ActvateApp: activate saved Window ID
    $q::                                                                        ;ActvateApp: activate saved Window ID
    $w::                                                                        ;ActvateApp: activate saved Window ID
    $e::                                                                        ;ActvateApp: activate saved Window ID
    $r::                                                                        ;ActvateApp: activate saved Window ID
    $a::                                                                        ;ActvateApp: activate saved Window ID
    $s::                                                                        ;ActvateApp: activate saved Window ID
    $d::                                                                        ;ActvateApp: activate saved Window ID
    $f::                                                                        ;ActvateApp: activate saved Window ID
    $z::                                                                        ;ActvateApp: activate saved Window ID
    $x::                                                                        ;ActvateApp: activate saved Window ID
    $C::                                                                        ;ActvateApp: activate saved Window ID
    $v::     ActivateWinID(ltrim(A_ThisHotkey,"$"))                             ;ActvateApp: activate saved Window ID
                                                                                
                                        
    #IF

; ACTIVATE POSITION IN TASKBAR _________________________________________________
    ;replacement for native windows app activation with lwin + #
    printscreen & F9::                                                          ;activate 10th app on taskbar
    printscreen & F8::                                                          ;activate 9th app on taskbar
    printscreen & F7::                                                          ;activate 8th app on taskbar
    printscreen & F6::                                                          ;activate 7th app on taskbar
    printscreen & F5::                                                          ;activate 6th app on taskbar
    printscreen & F4::                                                          ;activate 5th app on taskbar
    printscreen & F3::                                                          ;activate 4th app on taskbar
    printscreen & F2::                                                          ;activate 3rd app on taskbar
    printscreen & F1::  SI("#" (substr(A_ThisHotkey,0) + 1)), CFW()             ;activate 2nd app on taskbar
    printscreen & esc:: SI("#1"),CFW()                                          ;activate 1st app on taskbar (equivalent to win + 1)
; MEMORY FUNCTIONS (BLUE)_______________________________________________________
    ; Note: The below memory functions use the last key pressed to identify which memory file to operate on. 
    ;       enter "?" in a command box to see additional memory file commands
    ; e.g., ^!a = AddToMemory() ; ctrl+alt+a -> will save selected text to a file called a.txt in the WinGolems/mem_cache folder
  
    #IF GC("T_mem",1) 
    $^!0::                                                                      ;Mem: overwrite 0.txt with selected text
    $^!9::                                                                      ;Mem: overwrite 9.txt with selected text
    $^!8::                                                                      ;Mem: overwrite 8.txt with selected text
    $^!7::                                                                      ;Mem: overwrite 7.txt with selected text
    $^!6::                                                                      ;Mem: overwrite 6.txt with selected text
    $^!5::                                                                      ;Mem: overwrite 5.txt with selected text
    $^!4::                                                                      ;Mem: overwrite 4.txt with selected text
    $^!3::                                                                      ;Mem: overwrite 3.txt with selected text
    $^!2::                                                                      ;Mem: overwrite 2.txt with selected text
    $^!1:: OverwriteMemory()                                                    ;Mem: overwrite 1.txt with selected text
                                                                                
    PrintScreen & 0::                                                           ;Memory: overwrite 0.txt
    PrintScreen & 9::                                                           ;Memory: overwrite 9.txt
    PrintScreen & 8::                                                           ;Memory: overwrite 8.txt
    PrintScreen & 7::                                                           ;Memory: overwrite 7.txt
    PrintScreen & 6::                                                           ;Memory: overwrite 6.txt
    PrintScreen & 5::                                                           ;Memory: overwrite 5.txt
    PrintScreen & 4::                                                           ;Memory: overwrite 4.txt
    PrintScreen & 3::                                                           ;Memory: overwrite 3.txt
    PrintScreen & 2::                                                           ;Memory: overwrite 2.txt
    PrintScreen & 1:: OverwriteMemory()                                         ;Memory: overwrite 1.txt
                                                                                
    
    $+#0::                                                                      ;Mem: add selected text to the bottom of 0.txt
    $+#9::                                                                      ;Mem: add selected text to the bottom of 9.txt
    $+#8::                                                                      ;Mem: add selected text to the bottom of 8.txt
    $+#7::                                                                      ;Mem: add selected text to the bottom of 7.txt
    $+#6::                                                                      ;Mem: add selected text to the bottom of 6.txt
    $+#5::                                                                      ;Mem: add selected text to the bottom of 5.txt
    $+#4::                                                                      ;Mem: add selected text to the bottom of 4.txt
    $+#3::                                                                      ;Mem: add selected text to the bottom of 3.txt
    $+#2::                                                                      ;Mem: add selected text to the bottom of 2.txt
    $+#1:: AddToMemory()                                                        ;Mem: add selected text to the bottom of 1.txt
                                                                                
    $#0::                                                                       ;Mem: paste contents of 0.txt
    $#9::                                                                       ;Mem: paste contents of 9.txt
    $#8::                                                                       ;Mem: paste contents of 8.txt
    $#7::                                                                       ;Mem: paste contents of 7.txt
    $#6::                                                                       ;Mem: paste contents of 6.txt
    $#5::                                                                       ;Mem: paste contents of 5.txt
    $#4::                                                                       ;Mem: paste contents of 4.txt
    $#3::                                                                       ;Mem: paste contents of 3.txt
    $#2::                                                                       ;Mem: paste contents of 2.txt
    $#1:: RetrieveMemory()                                                      ;Mem: paste contents of 1.txt
                                                                                
    $<!space:: RunCmd("V" GC("CommaAlias")), W("a")                             ;Mem: (V command) selects last word typed and replaces it with \mem_cache .txt file with the corresponding name (e.g., typing "1" + !space => paste 1.txt).                                                                                                                                                  
    $>!space:: RunCmd("V" GC("PeriodAlias")), W("a")                            ;Mem: (V command) selects last word typed and replaces it with \mem_cache .txt file with the corresponding name (e.g., typing "1" + !space => paste 1.txt).                                                                                                                                                  
                                                                                
  
; MANAGE SAVED LINKS ___________________________________________________________
  ;load LINK -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    #If
    home & 0::                                                                  ;load saved file/folder path or URL
    home & 9::                                                                  ;load saved file/folder path or URL
    home & 8::                                                                  ;load saved file/folder path or URL
    home & 7::                                                                  ;load saved file/folder path or URL
    home & 6::                                                                  ;load saved file/folder path or URL
    home & 5::                                                                  ;load saved file/folder path or URL
    home & 4::                                                                  ;load saved file/folder path or URL
    home & 3::                                                                  ;load saved file/folder path or URL
    home & 2::                                                                  ;load saved file/folder path or URL
    home & 1::                                                                  ;load saved file/folder path or URL
    home & z::                                                                  ;load saved file/folder path or URL
    home & y::                                                                  ;load saved file/folder path or URL
    home & x::                                                                  ;load saved file/folder path or URL
    home & w::                                                                  ;load saved file/folder path or URL
    home & v::                                                                  ;load saved file/folder path or URL
    home & u::                                                                  ;load saved file/folder path or URL
    home & t::                                                                  ;load saved file/folder path or URL
    home & s::                                                                  ;load saved file/folder path or URL
    home & r::                                                                  ;load saved file/folder path or URL
    home & q::                                                                  ;load saved file/folder path or URL
    home & p::                                                                  ;load saved file/folder path or URL
    home & o::                                                                  ;load saved file/folder path or URL
    home & n::                                                                  ;load saved file/folder path or URL
    home & m::                                                                  ;load saved file/folder path or URL
    home & l::                                                                  ;load saved file/folder path or URL
    home & k::                                                                  ;load saved file/folder path or URL
    home & j::                                                                  ;load saved file/folder path or URL
    home & i::                                                                  ;load saved file/folder path or URL
    home & h::                                                                  ;load saved file/folder path or URL
    home & g::                                                                  ;load saved file/folder path or URL
    home & f::                                                                  ;load saved file/folder path or URL
    home & e::                                                                  ;load saved file/folder path or URL
    home & d::                                                                  ;load saved file/folder path or URL
    home & c::                                                                  ;load saved file/folder path or URL
    home & b::                                                                  ;load saved file/folder path or URL
    home & a::                                                                  ;load saved file/folder path or URL
    PgDn & 0::                                                                  ;load saved file/folder path or URL
    PgDn & 9::                                                                  ;load saved file/folder path or URL
    PgDn & 8::                                                                  ;load saved file/folder path or URL
    PgDn & 7::                                                                  ;load saved file/folder path or URL
    PgDn & 6::                                                                  ;load saved file/folder path or URL
    PgDn & 5::                                                                  ;load saved file/folder path or URL
    PgDn & 4::                                                                  ;load saved file/folder path or URL
    PgDn & 3::                                                                  ;load saved file/folder path or URL
    PgDn & 2::                                                                  ;load saved file/folder path or URL
    PgDn & 1::                                                                  ;load saved file/folder path or URL
    PgDn & z::                                                                  ;load saved file/folder path or URL
    PgDn & y::                                                                  ;load saved file/folder path or URL
    PgDn & x::                                                                  ;load saved file/folder path or URL
    PgDn & w::                                                                  ;load saved file/folder path or URL
    PgDn & v::                                                                  ;load saved file/folder path or URL
    PgDn & u::                                                                  ;load saved file/folder path or URL
    PgDn & t::                                                                  ;load saved file/folder path or URL
    PgDn & s::                                                                  ;load saved file/folder path or URL
    PgDn & r::                                                                  ;load saved file/folder path or URL
    PgDn & q::                                                                  ;load saved file/folder path or URL
    PgDn & p::                                                                  ;load saved file/folder path or URL
    PgDn & o::                                                                  ;load saved file/folder path or URL
    PgDn & n::                                                                  ;load saved file/folder path or URL
    PgDn & m::                                                                  ;load saved file/folder path or URL
    PgDn & l::                                                                  ;load saved file/folder path or URL
    PgDn & k::                                                                  ;load saved file/folder path or URL
    PgDn & j::                                                                  ;load saved file/folder path or URL
    PgDn & i::                                                                  ;load saved file/folder path or URL
    PgDn & h::                                                                  ;load saved file/folder path or URL
    PgDn & g::                                                                  ;load saved file/folder path or URL
    PgDn & f::                                                                  ;load saved file/folder path or URL
    PgDn & e::                                                                  ;load saved file/folder path or URL
    PgDn & d::                                                                  ;load saved file/folder path or URL
    PgDn & c::                                                                  ;load saved file/folder path or URL
    PgDn & b::                                                                  ;load saved file/folder path or URL
    PgDn & a::                                                                  ;load saved file/folder path or URL
    ESC & 0::                                                                   ;load file/folder path or URL
    ESC & 9::                                                                   ;load file/folder path or URL
    ESC & 8::                                                                   ;load file/folder path or URL
    ESC & 7::                                                                   ;load file/folder path or URL
    ESC & 6::                                                                   ;load file/folder path or URL
    ESC & 5::                                                                   ;load file/folder path or URL
    ESC & 4::                                                                   ;load file/folder path or URL
    ESC & 3::                                                                   ;load file/folder path or URL
    ESC & 2::                                                                   ;load file/folder path or URL
    ESC & 1::                                                                   ;load file/folder path or URL
    ESC & z::                                                                   ;load file/folder path or URL
    ESC & y::                                                                   ;load file/folder path or URL
    ESC & x::                                                                   ;load file/folder path or URL
    ESC & w::                                                                   ;load file/folder path or URL
    ESC & v::                                                                   ;load file/folder path or URL
    ESC & u::                                                                   ;load file/folder path or URL
    ESC & t::                                                                   ;load file/folder path or URL
    ESC & s::                                                                   ;load file/folder path or URL
    ESC & r::                                                                   ;load file/folder path or URL
    ESC & q::                                                                   ;load file/folder path or URL
    ESC & p::                                                                   ;load file/folder path or URL
    ESC & o::                                                                   ;load file/folder path or URL
    ESC & n::                                                                   ;load file/folder path or URL
    ESC & m::                                                                   ;load file/folder path or URL
    ESC & l::                                                                   ;load file/folder path or URL
    ESC & k::                                                                   ;load file/folder path or URL
    ESC & j::                                                                   ;load file/folder path or URL
    ESC & i::                                                                   ;load file/folder path or URL
    ESC & h::                                                                   ;load file/folder path or URL
    ESC & g::                                                                   ;load file/folder path or URL
    ESC & f::                                                                   ;load file/folder path or URL
    ESC & e::                                                                   ;load file/folder path or URL
    ESC & d::                                                                   ;load file/folder path or URL
    ESC & c::                                                                   ;load file/folder path or URL
    ESC & b::                                                                   ;load file/folder path or URL
    ESC & a::  LoadLink(substr(A_ThisHotkey,0))                                 ;load file/folder path or URL
                                                                                
  ;SWITCH LINK SET -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    F2 & 0::                                                                    ;switch mode
    F2 & 9::                                                                    ;switch mode
    F2 & 8::                                                                    ;switch mode
    F2 & 7::                                                                    ;switch mode
    F2 & 6::                                                                    ;switch mode
    F2 & 5::                                                                    ;switch mode
    F2 & 4::                                                                    ;switch mode
    F2 & 3::                                                                    ;switch mode
    F2 & 2::                                                                    ;switch mode
    F2 & 1::                                                                    ;switch mode
    F2 & z::                                                                    ;switch mode
    F2 & y::                                                                    ;switch mode
    F2 & x::                                                                    ;switch mode
    F2 & w::                                                                    ;switch mode
    F2 & v::                                                                    ;switch mode
    F2 & u::                                                                    ;switch mode
    F2 & t::                                                                    ;switch mode
    F2 & s::                                                                    ;switch mode
    F2 & r::                                                                    ;switch mode
    F2 & q::                                                                    ;switch mode
    F2 & p::                                                                    ;switch mode
    F2 & o::                                                                    ;switch mode
    F2 & n::                                                                    ;switch mode
    F2 & m::                                                                    ;switch mode
    F2 & l::                                                                    ;switch mode
    F2 & k::                                                                    ;switch mode
    F2 & j::                                                                    ;switch mode
    F2 & i::                                                                    ;switch mode
    F2 & h::                                                                    ;switch mode
    F2 & g::                                                                    ;switch mode
    F2 & f::                                                                    ;switch mode
    F2 & e::                                                                    ;switch mode
    F2 & d::                                                                    ;switch mode
    F2 & c::                                                                    ;switch mode
    F2 & b::                                                                    ;switch mode
    F2 & a::  SwitchMode()                                                      ;switch mode
    
    INS & 0::                                                                   ;switch mode
    INS & 9::                                                                   ;switch mode
    INS & 8::                                                                   ;switch mode
    INS & 7::                                                                   ;switch mode
    INS & 6::                                                                   ;switch mode
    INS & 5::                                                                   ;switch mode
    INS & 4::                                                                   ;switch mode
    INS & 3::                                                                   ;switch mode
    INS & 2::                                                                   ;switch mode
    INS & 1::                                                                   ;switch mode
    INS & z::                                                                   ;switch mode
    INS & y::                                                                   ;switch mode
    INS & x::                                                                   ;switch mode
    INS & w::                                                                   ;switch mode
    INS & v::                                                                   ;switch mode
    INS & u::                                                                   ;switch mode
    INS & t::                                                                   ;switch mode
    INS & s::                                                                   ;switch mode
    INS & r::                                                                   ;switch mode
    INS & q::                                                                   ;switch mode
    INS & p::                                                                   ;switch mode
    INS & o::                                                                   ;switch mode
    INS & n::                                                                   ;switch mode
    INS & m::                                                                   ;switch mode
    INS & l::                                                                   ;switch mode
    INS & k::                                                                   ;switch mode
    INS & j::                                                                   ;switch mode
    INS & i::                                                                   ;switch mode
    INS & h::                                                                   ;switch mode
    INS & g::                                                                   ;switch mode
    INS & f::                                                                   ;switch mode
    INS & e::                                                                   ;switch mode
    INS & d::                                                                   ;switch mode
    INS & c::                                                                   ;switch mode
    INS & b::                                                                   ;switch mode
    INS & a:: SwitchMode()                                                      ;switch mode
                                                                                

    #If GetKeyState("ralt", "P")
    rshift & esc:: 
    rshift & F8::
    rshift & F7::
    rshift & F6::
    rshift & F5::
    rshift & F4::  
    rshift & F3::  
    rshift & F2::  
    rshift & F1::      SetModeQuickSlot("rshift & ")                            ;
                                                                                ;ralt & rshift takes priority over >!

    #IF
    $>+esc::                                                                    ;load quickslot
    $>+F8::                                                                     ;load quickslot 
    $>+F7::                                                                     ;load quickslot 
    $>+F6::                                                                     ;load quickslot 
    $>+F5::                                                                     ;load quickslot 
    $>+F4::                                                                     ;load quickslot 
    $>+F3::                                                                     ;load quickslot 
    $>+F2::                                                                     ;load quickslot 
    $>+F1::  LoadModeQuickSlot(">+")                                            ;load quickslot
                                                                                
   ;SAVE LINK -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
        
    end & 0::                                                                   ;save file/folder path or URL
    end & 9::                                                                   ;save file/folder path or URL
    end & 8::                                                                   ;save file/folder path or URL
    end & 7::                                                                   ;save file/folder path or URL
    end & 6::                                                                   ;save file/folder path or URL
    end & 5::                                                                   ;save file/folder path or URL
    end & 4::                                                                   ;save file/folder path or URL
    end & 3::                                                                   ;save file/folder path or URL
    end & 2::                                                                   ;save file/folder path or URL
    end & 1::                                                                   ;save file/folder path or URL
    end & z::                                                                   ;save file/folder path or URL
    end & y::                                                                   ;save file/folder path or URL
    end & x::                                                                   ;save file/folder path or URL
    end & w::                                                                   ;save file/folder path or URL
    end & v::                                                                   ;save file/folder path or URL
    end & u::                                                                   ;save file/folder path or URL
    end & t::                                                                   ;save file/folder path or URL
    end & s::                                                                   ;save file/folder path or URL
    end & r::                                                                   ;save file/folder path or URL
    end & q::                                                                   ;save file/folder path or URL
    end & p::                                                                   ;save file/folder path or URL
    end & o::                                                                   ;save file/folder path or URL
    end & n::                                                                   ;save file/folder path or URL
    end & m::                                                                   ;save file/folder path or URL
    end & l::                                                                   ;save file/folder path or URL
    end & k::                                                                   ;save file/folder path or URL
    end & j::                                                                   ;save file/folder path or URL
    end & i::                                                                   ;save file/folder path or URL
    end & h::                                                                   ;save file/folder path or URL
    end & g::                                                                   ;save file/folder path or URL
    end & f::                                                                   ;save file/folder path or URL
    end & e::                                                                   ;save file/folder path or URL
    end & d::                                                                   ;save file/folder path or URL
    end & c::                                                                   ;save file/folder path or URL
    end & b::                                                                   ;save file/folder path or URL
    end & a::                                                                   ;save file/folder path or URL
    F1 & 0::                                                                    ;save file/folder path or URL
    F1 & 9::                                                                    ;save file/folder path or URL
    F1 & 8::                                                                    ;save file/folder path or URL
    F1 & 7::                                                                    ;save file/folder path or URL
    F1 & 6::                                                                    ;save file/folder path or URL
    F1 & 5::                                                                    ;save file/folder path or URL
    F1 & 4::                                                                    ;save file/folder path or URL
    F1 & 3::                                                                    ;save file/folder path or URL
    F1 & 2::                                                                    ;save file/folder path or URL
    F1 & 1::                                                                    ;save file/folder path or URL
    F1 & z::                                                                    ;save file/folder path or URL
    F1 & y::                                                                    ;save file/folder path or URL
    F1 & x::                                                                    ;save file/folder path or URL
    F1 & w::                                                                    ;save file/folder path or URL
    F1 & v::                                                                    ;save file/folder path or URL
    F1 & u::                                                                    ;save file/folder path or URL
    F1 & t::                                                                    ;save file/folder path or URL
    F1 & s::                                                                    ;save file/folder path or URL
    F1 & r::                                                                    ;save file/folder path or URL
    F1 & q::                                                                    ;save file/folder path or URL
    F1 & p::                                                                    ;save file/folder path or URL
    F1 & o::                                                                    ;save file/folder path or URL
    F1 & n::                                                                    ;save file/folder path or URL
    F1 & m::                                                                    ;save file/folder path or URL
    F1 & l::                                                                    ;save file/folder path or URL
    F1 & k::                                                                    ;save file/folder path or URL
    F1 & j::                                                                    ;save file/folder path or URL
    F1 & i::                                                                    ;save file/folder path or URL
    F1 & h::                                                                    ;save file/folder path or URL
    F1 & g::                                                                    ;save file/folder path or URL
    F1 & f::                                                                    ;save file/folder path or URL
    F1 & e::                                                                    ;save file/folder path or URL
    F1 & d::                                                                    ;save file/folder path or URL
    F1 & c::                                                                    ;save file/folder path or URL
    F1 & b::                                                                    ;save file/folder path or URL
    F1 & a::  saveLink(substr(A_ThisHotkey,0))                                  ;save file/folder path or URL
                                                                                
                                                                                
        
    #If





; ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... 
; SYSTEM CONVENIENCE ___________________________________________________________
  ; SHORTCUTS -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

    $+#s::               screenShot()                                           ;Convenience: screenshot
    $>^capslock::        capslock                                               ;Convenience: capslock
    $^SC027::            Send {blind}{AppsKey}                                  ;Convenience: simulate appkey
    $!SC027::            Sendinput {esc}                                        ;Convenience: simulate esc key (alt + semicolon)
    lwin & pgup::        suspend                                                ;WinGolems: toggle all hotkeys ON|OFF except for this one
    HOME & END::                                                                ;WinGolems: reload WinGolems
    $F8::                                                                       ;WinGolems: reload WinGolems      
    lwin & pgdn::        reloadWG()                                             ;WinGolems: reload WinGolems
    esc & pgdn::         ExitApp                                                ;WinGolems: quit WinGolems
    printscreen & lwin:: Sendinput ^{esc}                                       ;native windows start button function

  ; CLIPBOARD -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    $>^c::     addtoCB("A")                                                     ; append text to clipboard
    $+!#c::    OCRtoClipboard("A","V2")                                         ;OCR image text and put resultant string in clipboard (click and drag rectangle area)
    $+^#c::    OCRtoClipboard("A","UWP")                                        ;OCR image text and append resultant string to the clipboard (click and drag rectangle area)
    #If GetKeyState("rctrl", "P")                                               
    ralt & c::                                                                  ;prepend text to clipboard
    #If                                                                         
    $+^c::     addtoCB("P")                                                     ;prepend text to clipboard

  ; WINDOWS SETTINGS -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    ;#u::                run, ms-settings:screenrotation                        ;WinOS: Display settings
    $*!#b:: BluetoothSettings()                                                 ;WinSetting: bluetooth settings (reassign less used windows sys shortcuts)
    $*!#d:: DisplaySettings()                                                   ;WinSetting: display settings 
    $*!#n:: NotificationWindow()                                                ;WinSetting: notification window
    $*!#r:: RunProgWindow()                                                     ;WinSetting: run program
    $*!#p:: PresentationDisplayMode()                                           ;WinSetting: presentation display mode
    $*!#i:: WindowsSettings()                                                   ;WinSetting: windows settings
                                                                                
  ; WINDOWS MANAGEMENT -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    #If Titletest("Calculator")
    $^w::    WinClose,A                                                         ;close calculator
                                                                                
    #If IsCmode()                                                               
    ;sc027:: GotoDesktop("1")                                                   ;VirtualDesktop: Switch to desktop 1 requires: https://github.com/FuPeiJiang/VD.ahk
    ;sc028:: GotoDesktop("2")                                                   ;VirtualDesktop: Switch to desktop 2 requires: https://github.com/FuPeiJiang/VD.ahk
    lwin::   ActivatePrevInstance(),,SI("{lwin up}")                            ;WindowMgmt: rotate through app instances from most recent
                                                                                
    #IF                                                                         
                                                                                      
    rshift & printscreen:: ActivatePrevInstance(),SI("{printscreen up}{rshift up}") ;WindowMgmt: rotate through app instances from most recent                                     
    printscreen & rshift::                                                      ;WindowMgmt: rotate through app instances from oldest (no thumbnail previews)
    $#capslock::           ActivateNextInstance(),SI("{lwin up}")               ;WindowMgmt: rotate through app instances from oldest (no thumbnail previews)
    >!SC028::              MaximizeWin(),SI("{ralt up}")                        ;WindowMgmt: maximize window
                                                                                
    printscreen & SC027::                                                       ;Convenience: minimize window
    $#SC027::             MinimizeWin()                                         ;Convenience: minimize window
    $#del::               AlwaysOnTop(1)                                        ;WindowMgmt: Window always on top: ON
    $#ins::               AlwaysOnTop(0)                                        ;WindowMgmt: Window always on top: OFF
    $<!esc::              WinClose,A                                            ;WindowMgmt: close active window
    $!#esc::              CloseClass()                                          ;WindowMgmt: close all instances of the active program
    $^#sc027::            Send {lwin down}d{lwin up}                            ;WindowMgmt: show desktop
                                                                                

    #If GetKeyState("PrintScreen", "P")
    rctrl & right:: S("{blind}",200),W("rc"),S("^#{right}")                     ;switch virtual desktop
    rctrl & left::  S("{blind}",200),W("rc"),S("^#{left}")                      ;switch virtual desktop
    $left::         Sendinput #{left}                                           ;move window to left half
    $right::        Sendinput #{right}                                          ;move window to right half
    $up::           Sendinput #{up}                                             ;move window to right half
    $down::         Sendinput #{down}                                           ;move window to right half
                                                                                
                                                                                
    
    #IF GetKeyState("lctrl", "P")
    lalt & PgDn::   WinToDesktop((CurrentDesktopNum() = 1) ? "2" : "1")         ;VirtualDesktop: Move active Window to other desktop (between desktops 1 and 2) requires: https://github.com/FuPeiJiang/VD.ahk
    ; lalt & PgDn:: % (t := !t) ? WinToDesktop("2") : WinToDesktop("1")         ;VirtualDesktop: Move active Window to other desktop (between desktops 1 and 2) requires: https://github.com/FuPeiJiang/VD.ahk
    #IF

    lalt & c:: s("{blind}",200),W("ra"),moveWinBtnMonitors("L")                 ;WindowMgmt: move window to left monitor
    ralt & m:: s("{blind}",200),W("ra"),moveWinBtnMonitors("R")                 ;WindowMgmt: move window to right monitor

    #If GetKeyState("rshift", "P")                                              
    ralt & m:: s("{blind}",200),W("ra","rs"),moveWinBtnMonitors("L")            ;WindowMgmt: move window to left monitor
    #If GetKeyState("lshift", "P")                                              
    lalt & c:: s("{blind}",200),W("ra","rs"),moveWinBtnMonitors("R")            ;WindowMgmt: move window to left monitor
    #IF                                                                            
; MODIFIER KEYS ________________________________________________________________
  
    :X:tmod~win:: TC("T_MK", "Extra Modifier keys = ")                          ;toggle modifier keys
                                                                                
    ; replacement keys for original modifier key function   
    #IF IsCMODE()                                                               
    $ins::        sendinput {ins}                                               ;replacement for using ins key as a modifier key
    $1::                                                                        ;replacement for using F1  key as a modifier key
    $f1::         SendInput {F1}                                                ;replacement for using F1 key as a modifier key
    $r::                                                                        
    $2::          SendInput {F2}                                                ;replacement for using F2 key as a modifier key
    $f12::        SendInput {F12}                                               ;replacement for using F12 key as a modifier key
    $n::                                                                        ;replacement for using PgDn key as a modifier key
    $down::       SendInput {pgdn}                                              ;replacement for using PgDn key as a modifier key
    $o::                                                                        ;replacement for using PgUp key as a modifier key
    $up::         SendInput {pgup}                                              ;replacement for using PgUp key as a modifier key
    PrintScreen:: SendInput {PrintScreen}                                       ;replacement for using PrintScreen key as a modifier key
                                                                                
  
  ; modifier key assignment -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    #IF GC("T_MK",1)
    ESC & SC029::                                                               ;modifier key
    ESC & F1::                                                                  ;modifier key
    ESC & F2::                                                                  ;modifier key
    rshift & pgdn::                                                             ;modifier key
    rshift & pgup::                                                             ;modifier key
    pgdn & rshift::                                                             ;modifier key
    pgup & pgdn::                                                               ;modifier key
    pgdn & pgup::                                                               ;modifier key
    pgup & up::                                                                 ;modifier key
    pgdn & up::                                                                 ;modifier key
    pgup & left::                                                               ;modifier key
    pgup & right::                                                              ;modifier key
    pgdn & right::                                                              ;modifier key
    $printscreen::                                                              ;modifier key
    $F1::                                                                       ;modifier key
    $F2::                                                                       ;modifier key
    $F3::                                                                       ;modifier key
    $F4::                                                                       ;modifier key
    $F12::                                                                      ;modifier key
    $pgup::                                                                     ;modifier key
    $pgdn::                                                                     ;modifier key
    $ins::                                                                      ;modifier key
    $end::                                                                      ;modifier key
    $home::         return                                                      ;modifier key

; TAB NAVIGATION _______________________________________________________________
  
    #IF WinActive("ahk_exe Code.exe")                                           
    $^b::     Sendinput ^{PgUp}                                                 ;Navigation: navigate to left tab
    $^space:: Sendinput ^{PgDn}                                                 ;Navigation: navigate to right tab
                                                                                
    #IF !WinActive("ahk_exe " exe["doc"])                                       
    $^b::     Sendinput ^+{tab}                                                 ;Navigation: navigate to left tab
    $^space:: Sendinput ^{tab}                                                  ;Navigation: navigate to right tab

; WEB SEARCH ___________________________________________________________________
    #IF                                                                         
    $>!SC035::  search("google.com/search?q=")                                  ;search: google search selected text
    $+#SC035::  search("autohotkey.com/docs/search.htm?q=",,"&m=2")             ;search: AutoHotkey documentation
    $+>!SC035:: search("google.com/search?tbm=isch&q=")                         ;search: google image search
    #If isCMODE()                                                               ;(+capslock) search clipboard contents instead of selected text
    $SC035::    search("google.com/search?q=",clipboard)                        ;Convenience: google search selected text
    $SC034::    search("google.com/search?tbm=isch&q=")                         ;search (+capslock): use clipboard contents to search google image
    $SC033::    search("youtube.com/results?search_query=")                     ;search (+capslock): use clipboard contents to search youtubes
                                                                                
    RSHIFT & SC035:: search("autohotkey.com/docs/search.htm?q=",clipboard,"&m=2") ;Convenience: google search selected text
    LSHIFT & SC035:: search("google.com/search?q=",clipboard)                   ;Convenience: google search selected text
    LSHIFT & SC034:: search("google.com/search?tbm=isch&q=",clipboard)          ;search (+capslock): use clipboard contents to search google image
    LSHIFT & SC033:: search("youtube.com/results?search_query=",clipboard)      ;search (+capslock): use clipboard contents to search youtubes
                                                                                
                                                                                
                                                                                
; COMMAND CHORDS _______________________________________________________________
                                                                                
                                                                                
    #If    
    $#SC035::     
    $>^SC035::     
    ChordSearch(options :="L1 T10", escape := "{esc}{ralt}",PUmenu:="zb\SearchMenu", noLRshift := 0) {
        global C
        
        
        menu := rtrim(AccessCache(PUmenu,,0),"`n")
        PU(menu,C.Eyellow,,,,10000,13,,"Lucida Sans Typewriter",1)              ;pop up website menu
                                                                                
        keysPressed :=  KeyWaitHook(options,escape)
        input := !noLRshift ? (Instr(keysPressed,"<+") ? clipboard : (Instr(keysPressed,">+") ? clip() : "")) : ""
        keysPressed := noLRshift ? trim(keysPressed, "<>") : keysPressed ;removes left and right shift distinction

        Gui, PopUp: cancel
        Switch % keysPressed
        {
            Case "<+a",">+a","a":   (input ? Search("www.amazon.ca/s?k=", input)                                                               : LURL("www.amazon.ca"))
            Case "<+b",">+b","b":   (input ? Search("www.imdb.com/find?q=", input)                                                             : LURL("www.imdb.com"))
            Case "<+i",">+i","i":   (input ? Search("google.com/search?tbm=isch&q=", input)                                                    : LURL("https://images.google.com/"))
            Case "<+d",">+d","d":   (input ? Search("www.dictionary.com/browse/", input)                                                       : LURL("www.dictionary.com"))
            Case "<+e",">+e","e":   (input ? Search("www.aliexpress.com/wholesale?catId=0&initiative_id=SB_20210825091515&SearchText=", input) : LURL("www.aliexpress.com"))
            Case "<+f",">+f","f":   (input ? Search("ca.finance.yahoo.com/quote/", input)                                                      : LURL("ca.finance.yahoo.com"))
            Case "<+h",">+h","h":   (input ? Search("math.stackexchange.com/search?q=", input)                                                 : LURL("math.stackexchange.com")) 
            Case "<+p",">+p","p":   (input ? search("stackexchange.com/search?q=", input)                                                      : LURL("stackexchange.com"))
            Case "<+m",">+m","m":   (input ? Search("google.com/maps/search/", input)                                                          : LURL("google.com/maps/"))
            Case "<+o",">+o","o":   (input ? Search("www.stackoverflow.com/search?q=", input)                                                  : LURL("www.stackoverflow.com"))
            Case "<+r",">+r","r":   (input ? Search("https://www.reddit.com/search/?q=", input)                                                : LURL("https://www.reddit.com"))
            Case "<+s",">+s","s":   (input ? Search("www.twitter.com/search?q=", input)                                                        : LURL("www.twitter.com"))
            Case "<+t",">+t","t":   (input ? Search("www.thesaurus.com/browse/", input)                                                        : LURL("www.thesaurus.com"))
            Case "<+v",">+v","v":   (input ? Search("www.bing.com/videos/search?q=", input)                                                    : LURL("www.bing.com/videos"))
            Case "<+w",">+w","w":   (input ? Search("en.wikipedia.org/w/index.php?search=", input)                                             : LURL("en.wikipedia.org"))
            Case "<+y",">+y","y":   (input ? Search("youtube.com/results?search_query=", input)                                                : LURL("youtube.com"))
            Case ">+?":              OP(A_ScriptDir "\mem_cache\" PUmenu ".txt")       ;edit chord command menu
            default:
                sleep,0
                ; msgbox % "Nothing assigned to " keysPressed " which was pressed"
        }
        return 
    }

    ;lalt & SC033::
    $<!SC033::     
    ChordTextManipulation(options := "L1 M T10", escape := "{esc}{ralt}", PUmenu := "zb\ChordTextMenu", noLRshift := 1) {
        global C
        
        menu := rtrim(AccessCache(PUmenu,,0),"`n")
        PU(menu,C.lblue,,,,990000,12,700,"Lucida Sans Typewriter",1)
        keysPressed :=  KeyWaitHook("L1 M T10",escape)
        input := !noLRshift ? (Instr(keysPressed,"<+") ? clipboard : (Instr(keysPressed,">+") ? clip() : "")) : ""
        keysPressed := noLRshift ? trim(keysPressed, "<>") : keysPressed ;removes left and right shift distinction
        Gui, PopUp: cancel

        Switch % keysPressed
        {
            Case "v" :  FormatBreaks("1 break")                                             ;TEXT MANIPULATION| replace multiple paragraph breaks w/ 1 break in selected text
            Case "+v":  FormatBreaks("no break")                                            ;TEXT MANIPULATION| replace multiple paragraph breaks with space (remove paragraphs breaks)
            Case "l" :  RemoveBlankLines()                                                  ;TEXT MANIPULATION! remove empty lines starting from selected text
            Case "+" :  ReplaceAwithB(",", "+")                                             ;TEXT MANIPULATION replace "," with "+" in selected text
            Case "," :  ReplaceAwithB("+", ",")                                             ;C.TM: replace "+" with "," in selected text
            Case "-" :  clip(CS(clip(), {"_":" ","-":" "}))                                 ;C.TM: replace "_" with " " in selected text
            Case "a" :  SortSelectedText()                                                  ;TEXT MANIPULATION Sort Selected Text
            Case "+a":  SortSelectedText("R")                                               ;TEXT MANIPULATION Sort Selected Text
            Case "s" :  ReplaceAwithB()                                                     ;TEXT MANIPULATION replaces multiple consecutive spaces with character length 1 space
            Case "+s":  ReplaceAwithB(" ")                                                  ;TEXT MANIPULATION! remove all spaces from selected text
            Case "2" :  SelectLine(), txt := clip(), SI("{right}{enter}"), clip(txt)        ;TEXT MANIPULATION: duplicate current line
            Case "m" :  ReplaceAwithB("_"," "),Capitalize1stLetter(,,0),,ReplaceAwithB(" ") ;CamelCase
            Case "n" :  AddSpaceBtnCaseChange(), ReplaceAwithB(" ","_")                     ;snake_case
            Case "+n":  AddSpaceBtnCaseChange()                                             ;add space between case change
            Case "i" :  SaveMousPos("i",1)                                                  ;save mouse position for #i
            Case "+i":  resetMousPos("i")                                                   ;reset mouse position for #i
            Case "d" :  SaveMousPos("d",1)                                                  ;save mouse position for #d
            Case "+d":  resetMousPos("d")                                                   ;reset mouse position for #d
            Case "e" :  SI("#{SC034}")                                                      ;emojis
            Case "c" :  SI("#F6")                                                           ;color picker
            Case "o" :  OCRtoClipboard(,"V2")                                               ;color picker
            Case "+o":  OCRtoClipboard(,"UWP")                                              ;color picker
            Case "w" :                                                                      ;set cursor width (1-9)
                                                                                
                        PU("Enter cursor width (1-9)",C.lyellow,,,,100000)
                        width :=  KeyWaitHook("L1 M",escape)
                        Gui, PopUp: cancel
                        if width ~= "[0-9]"
                            SetCursorWidth(width), PU("cursor width: " width)
                        Else
                            PU("Must be a number input", C.pink)                                              
                                                         

            Case "+?": OP(A_ScriptDir "\mem_cache\" PUmenu ".txt")           
            default:
                ; msgbox % "Nothing assigned to " keysPressed " which was pressed"
                sleep,0
        }
        return 
    }
        



#IF
; ACTIVATE APPS (GREEN) ________________________________________________________
  ; AA("application_exe_path")
  ; SaveWinID("unique_string")
  ; ActivateWinID("unique_string")
  
  #IF GC("T_base",1) 
  #c up::           AA("cmd.exe")                                               ;Apps| Activate Command window
  #t up::           ActivateCalc()                                              ;Apps| Activate Calculator    
  #x up::           AA("pdf_path")                                              ;Apps| editor                 
  #a up::           AA("editor_path")                                           ;Apps| editor                 
  #q up::           AA("xls_path")                                              ;Apps| Activate Excel         
  #w up::           AA("doc_path")                                              ;Apps| Activate Word          
  #b up::           AA("explorer.exe")                                          ;Apps| Activate File Explorer 
  #z up::           AA("obsidian_path")                                         ;Apps| Obsidian               
  #s up::           AA("edge_path")                                             ;Apps| Activate Edge browser
  #SC035 up::       AA("chrome_path")                                           ;Apps| Activate Chrome browser
  printscreen & l:: AA(UProfile "\Desktop\Power BI Desktop - Shortcut.lnk", "pbidesktop.exe",2) ;Apps| power BI                        
  ;#x up::          AA("ppt_path")                                              ;Apps| Activate PowerPoint   


; SYSTEM CONVENIENCE ___________________________________________________________
  +#s::               send {printscreen}                                        ;snipping tool  
  <!capslock::        SI("{del}"),W("la","cl")                                  ;Convenience: del                                                                                               
  +#capslock::        W("ls","lwin"), ActivatePrevInstance()                    ;WindowMgmt: rotate through app instances from most recent                   
  printscreen & rshift::                                                        ;WindowMgmt: rotate through app instances from oldest (no thumbnail previews)
  #capslock::         W("lwin"), ActivateNextInstance()                         ;WindowMgmt: rotate through app instances from oldest (no thumbnail previews)
  >^capslock::        capslock                                                  ;Convenience: capslock                                                                                 
  >!SC035::           w("ra"),search()                                          ;Convenience: google search selected text 
  ^#o up::            W("lc","lw"), reloadWG()                                  ;WinGolems: reload WinGolems 
  #!o up::            suspend                                                   ;WinGolems: toggle all hotkeys ON|OFF except for this one
  ^SC027::            Send {AppsKey}                                            ;WinOS: simulate appkey
  $^!space up::       MaximizeWin()                                             ;WindowMgmt: maximize window
  $#SC027::           w("lw"), MinimizeWin()                                    ;WindowMgmt: minimize window
  #del::              AlwaysOnTop(1)                                            ;WindowMgmt: Window always on top: ON
  #ins::              AlwaysOnTop(0)                                            ;WindowMgmt: Window always on top: OFF
  <!esc::             WinClose,A                                                ;WindowMgmt: close active window
  !#esc::             CloseClass()                                              ;WindowMgmt: close all instances of the active program
  ^#sc027::           Send {lwin down}d{lwin up}                                ;WindowMgmt: show desktop
  #u::                run, ms-settings:screenrotation 
  !#b up::            BluetoothSettings()                                       ;WinSetting: bluetooth settings (reassign less used windows sys shortcuts)
  !#d up::            DisplaySettings()                                         ;WinSetting: display settings 
  !#n up::            NotificationWindow()                                      ;WinSetting: notification window
  !#r up::            RunProgWindow()                                           ;WinSetting: run program
  !#p up::            PresentationDisplayMode()                                 ;WinSetting: presentation display mode
  !#i up::            WindowsSettings()                                         ;WinSetting: windows settings
  ralt & PgDn::       % (t := !t) ? WinToDesktop("2") : WinToDesktop("1")       ;VirtualDesktop: Move active Window to other desktop (between desktops 1 and 2) requires: https://github.com/FuPeiJiang/VD.ahk
  ralt & sc028::      GotoDesktop("1")                                          ;VirtualDesktop: Switch to desktop 1 requires: https://github.com/FuPeiJiang/VD.ahk
  ralt & enter::      GotoDesktop("2")                                          ;VirtualDesktop: Switch to desktop 2 requires: https://github.com/FuPeiJiang/VD.ahk
  !SC027::            Sendinput {esc}                                           ;WinOS: simulate esc key (alt + semicolon)
  #IF IsCMODE()
  SC027::             Sendinput {esc}                                           ;WinOS: simulate esc key (+capslock) 
  #IF

; NAVIGATION (PURPLE) __________________________________________________________
  
    #IF !WinActive("ahk_exe " exe["doc"])                                          ; can be toggled on/off by entering Gtc,T_tabNav in a CB              
    ^b::                SI("^{PgUp}",50),W("c")                                      ;Navigation: navigate to left tab
    ^space::            SI("^{PgDn}",50),W("c")                                      ;Navigation: navigate to right tab

    #if

    :X:tfn~win:: TC("T_Mod","Extra Modifier Keys: ")
; ADDITIONAL MODIFIER KEYS _____________________________________________________
    #IF GC("T_Mod",1)
    printscreen::
    F1::
    ; F2::
    ; F3::
    ; F11::
    F12::
    pgdn::
    end::
    home:: return
    #IF


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
  
  <!space::          RunCmd(GC("LaltSpaceCommand","V")), W("a")                 ;Mem: (V command) selects last word typed and replaces it with \mem_cache .txt file with the corresponding name (e.g., typing "1" + !space => paste 1.txt).      
  >!space::          RunCmd(GC("RaltSpaceCommand","V")), W("a")                 ;Mem: (V command) selects last word typed and replaces it with \mem_cache .txt file with the corresponding name (e.g., typing "1" + !space => paste 1.txt).        
  
  <+#c::             addtoCB("A")                                               ; append text to clipboard
  >+#c::             addtoCB("P")                                               ; prepend text to clipboard

  /* 
    $^!lbutton::        s("{blind}",100),RetrieveMemory(A_ThisHotkey,,,1)        ;Mem: double click and paste contents of 1.txt at cursor position       
    $^#lbutton::        s("{blind}",100),RetrieveMemory(,A_ThisHotkey)           ;Mem: double click and paste contents of number entered at prompt   
    $<!lbutton up::     s("{blind}",100), Clicks(2), s("^v")                     ;MouseFn: triple click, paste clipboard contents
    $<+<!lbutton up::    s("{blind}",100), Clicks(3), s("^v")                    ;MouseFn: double click, paste clipboard contents
  */

#IF
/*
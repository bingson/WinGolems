
#IF
; ACTIVATE APPS (GREEN) ________________________________________________________
  ; AA("application_exe_path")
  ; SaveWinID("unique_string")
  ; ActivateWinID("unique_string")
  
    #c::           AA("cmd.exe")                                                ;Apps| Activate Command window
    #t::           ActivateCalc()                                               ;Apps| Activate Calculator    
    #x::           AA("pdf_path")                                               ;Apps| Activate pdf reader                 
    #a::           AA("editor_path")                                            ;Apps| Activate text/code editor                 
    #q::           AA("xls_path")                                               ;Apps| Activate Excel         
    #w::           AA("doc_path")                                               ;Apps| Activate Word          
    #b::           AA("explorer.exe")                                           ;Apps| Activate File Explorer 
    #z::           AA("obsidian_path")                                          ;Apps| Activate Obsidian               
    #s::           AA("html_path")                                              ;Apps| Activate Edge browser
    #SC035::       AA("html2_path")                                             ;Apps| Activate Chrome browser
    printscreen & l:: AA(UProfile "\Desktop\Power BI Desktop - Shortcut.lnk", "pbidesktop.exe",2) ;Apps| Activate Power BI                        
    ;#x up::          AA("ppt_path")                                            ;Apps| Activate PowerPoint   

; SAVE/ACTIVATE WINDOW by ID ___________________________________________________
    >^>!SC033::                                                                 ; save current window ID to printscreen + "," 
    >^>!SC034::                                                                 ; save current window ID to printscreen + "." 
    >^>!SC035::                                                                 ; save current window ID to printscreen + "/" 
    >^>!m::                                                                     ; save current window ID to printscreen + m 
    >^>!n::                SaveWinID(ltrim(A_ThisHotkey, ">^>!"))               ; save current window ID to printscreen + n
    
    ^!ESC:: 
    ^!F1::                                                                      ;Apps: Save window for win+F1 activation
    ^!F2::                                                                      ;Apps: Save window for win+F2 activation
    ^!F3::                                                                      ;Apps: Save window for win+F3 activation
    ^!F4::                                                                      ;Apps: Save window for win+F4 activation
    ^!F5::                                                                      ;Apps: Save window for win+F5 activation
    ^!F6::                                                                      ;Apps: Save window for win+F6 activation
    ^!F7::                                                                      ;Apps: Save window for win+F7 activation
    ^!F8::                 SaveWinID(ltrim(A_ThisHotkey, "^!"))                 ;Apps: Save window for win+F8 activation
    
    home & q::                                                                  ; Save current window ID to printscreent + q
    home & w::                                                                  ; Save current window ID to printscreent + w
    home & e::                                                                  ; Save current window ID to printscreent + e
    home & a::                                                                  ; Save current window ID to printscreent + a
    home & s::                                                                  ; Save current window ID to printscreent + s
    home & d::                                                                  ; Save current window ID to printscreent + d
    home & z::                                                                  ; Save current window ID to printscreent + z
    home & x::                                                                  ; Save current window ID to printscreent + x
    home & c::             SaveWinID(ltrim(A_ThisHotkey, "home & "))            ; Save current window ID to printscreent + c
    
    #If GetKeyState("PrintScreen", "P")
    esc::                                                                       ;ActvateApp: activate saved Window ID                  
    SC033::                                                                     ;ActvateApp: activate saved Window ID                  
    SC034::                                                                     ;ActvateApp: activate saved Window ID                  
    SC035::                                                                     ;ActvateApp: activate saved Window ID
    m::                                                                         ;ActvateApp: activate saved Window ID
    n::                                                                         ;ActvateApp: activate saved Window ID
    q::                                                                         ;ActvateApp: activate saved Window ID
    w::                                                                         ;ActvateApp: activate saved Window ID
    e::                                                                         ;ActvateApp: activate saved Window ID
    a::                                                                         ;ActvateApp: activate saved Window ID
    s::                                                                         ;ActvateApp: activate saved Window ID
    d::                                                                         ;ActvateApp: activate saved Window ID
    z::                                                                         ;ActvateApp: activate saved Window ID
    x::                                                                         ;ActvateApp: activate saved Window ID
    C::                  ActivateWinID(A_ThisHotkey)                            ;ActvateApp: activate saved Window ID
  
    F1::                                                                        ;Apps: Activate saved F1 window
    F2::                                                                        ;Apps: Activate saved F2 window
    F3::                                                                        ;Apps: Activate saved F3 window
    F4::                                                                        ;Apps: Activate saved F4 window
    F5::                                                                        ;Apps: Activate saved F5 window
    F6::                                                                        ;Apps: Activate saved F6 window
    F7::                                                                        ;Apps: Activate saved F7 window
    F8::                ActivateWinID(A_ThisHotkey)                             ;Apps: Activate saved F8 window
    
    #IF

    #F1::                                                                       ;Apps: Activate saved F1 window
    #F2::                                                                       ;Apps: Activate saved F2 window
    #F3::                                                                       ;Apps: Activate saved F3 window
    #F4::                                                                       ;Apps: Activate saved F4 window
    #F5::                                                                       ;Apps: Activate saved F5 window
    #F6::                                                                       ;Apps: Activate saved F6 window
    #F7::                                                                       ;Apps: Activate saved F7 window
    #F8::                ActivateWinID(ltrim(A_ThisHotkey, "#"))                ;Apps: Activate saved F8 window
  
  
; WEB SEARCH ___________________________________________________________________
    
    #IF
    :X:tcs~win:: TC("T_SearchCB","Clipboard Search mode: ")                     ;search: toggle clipboard search mode
    
    ; search selected text; when clipboard search mode is on searches clipboard contents instead of selected text
    >!SC035::       search("google.com/search?q=")                              ;search: google search selected text
    !#SC035::       search("en.wikipedia.org/w/index.php?search=")              ;search: wikipedia
    pgdn & rshift:: search("youtube.com/results?search_query=")                 ;search: youtubes
    +#SC035::       search("autohotkey.com/docs/search.htm?q=",,"&m=2")         ;search: AutoHotkey documentation
    >+>!SC035::     search("google.com/search?tbm=isch&q=")                     ;search: google image
    ^#SC035::       search("google.com/maps/search/")                           ;search: maps
    
    #If isCMODE()   ; (+capslock) search clipboard contents instead of selected text
    >!SC035::       search("google.com/search?q=",clipboard)                     ;Convenience: google search selected text
    !#SC035::       search("en.wikipedia.org/w/index.php?search=",clipboard)     ;search (+capslock): use clipboard contents to search wikipedia
    pgdn & rshift:: search("youtube.com/results?search_query=",clipboard)        ;search (+capslock): use clipboard contents to search youtubes
    +#SC035::       search("autohotkey.com/docs/search.htm?q=",clipboard,"&m=2") ;search (+capslock): use clipboard contents to search AutoHotkey documentation
    >+>!SC035::     search("google.com/search?tbm=isch&q=",clipboard)            ;search (+capslock): use clipboard contents to search google image
    ^#SC035::       search("google.com/maps/search/",clipboard)                  ;search (+capslock): use clipboard contents to search maps
    #If    




; SYSTEM CONVENIENCE ___________________________________________________________
  
  
  /*
  */  
  <^#c::              OCRtoClipboard(,"V2")                                     ;OCR image text and put resultant string in clipboard (click and drag rectangle area)
  !#c::               OCRtoClipboard(,"UWP")                                    ;OCR image text and append resultant string to the clipboard (click and drag rectangle area)
  >^c::               addtoCB("A")                                              ; append text to clipboard

  <+#c::              OCRtoClipboard("A","V2")                                     ;OCR image text and put resultant string in clipboard (click and drag rectangle area)
  >+#c::              OCRtoClipboard("A","UWP")                                    ;OCR image text and append resultant string to the clipboard (click and drag rectangle area)
  
  +>^c::              addtoCB("P")                                              ; prepend text to clipboard
  ~<^c::              UpdateDisplay()                                           ;Update Command Box display of clipboard contents in Command Box
  +#s::               send {printscreen}                                        ;snipping tool  
  +#capslock::        W("ls","lw"), ActivatePrevInstance()                      ;WindowMgmt: rotate through app instances from most recent                   
  printscreen & rshift::                                                        ;WindowMgmt: rotate through app instances from oldest (no thumbnail previews)
  #capslock::         W("lw"), ActivateNextInstance()                           ;WindowMgmt: rotate through app instances from oldest (no thumbnail previews)
  >^capslock::        capslock                                                  ;Convenience: capslock                                                                                 
  lwin & pgup::       reloadWG()                                                ;WinGolems: reload WinGolems 
  esc & pgup::        suspend                                                   ;WinGolems: toggle all hotkeys ON|OFF except for this one
  f1 & pgup::         ExitApp                                                   ;WinGolems: quit WinGolems
  ^SC027::            Send {AppsKey}                                            ;WinOS: simulate appkey
  $^!space up::       MaximizeWin()                                             ;WindowMgmt: maximize window
  $#SC027::           w("lw"), MinimizeWin()                                    ;WindowMgmt: minimize window
  #del::              AlwaysOnTop(1)                                            ;WindowMgmt: Window always on top: ON
  #ins::              AlwaysOnTop(0)                                            ;WindowMgmt: Window always on top: OFF
  <!esc::             WinClose,A                                                ;WindowMgmt: close active window
  !#esc::             CloseClass()                                              ;WindowMgmt: close all instances of the active program
  ^#sc027::           Send {lwin down}d{lwin up}                                ;WindowMgmt: show desktop
  #u::                run, ms-settings:screenrotation                           ;WinOS: Display settings
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
  $<!c::              moveWinBtnMonitors("L")                                   ;WindowMgmt: move window to left monitor
  $>!m::              moveWinBtnMonitors("R")                                   ;WindowMgmt: move window to right monitor

  ; ADDITIONAL MODIFIER KEYS -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    
    :X:tmod~win::    TC("T_Mod", "Extra Modifier keys = ")                      ; toggle modifier keys

    #IF GC("T_Mod",1)
    printscreen::                                                               ; modifier key
    F1::                                                                        ; modifier key
    F12::                                                                       ; modifier key
    pgup::                                                                      ; modifier key
    pgdn::                                                                      ; modifier key
    end::                                                                       ; modifier key
    home:: return                                                               ; modifier key
    #IF

  ; NAVIGATION (PURPLE) -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
  
    #IF !WinActive("ahk_exe " exe["doc"])                                       ; can be toggled on/off by entering Gtc,T_tabNav in a CB              
    ^b::                SI("^{PgUp}"),W("c")                                 ;Navigation: navigate to left tab
    ^space::            SI("^{PgDn}"),W("c")                                 ;Navigation: navigate to right tab

    #IF



; MEMORY FILE FUNCTIONS (BLUE)__________________________________________________
  
  ; Note: The below memory functions use the last key pressed to identify which memory file to operate on. 
  ;       enter "?" in a command box to see additional memory file commands
  ; e.g., ^!a = AddToMemory() ; ctrl+alt+a -> will save selected text to a file called a.txt in the WinGolems/mem_cache folder

    #IF GC("T_mem",1) 
    ^!0::                                                                       ;Mem: overwrite 0.txt with selected text
    ^!9::                                                                       ;Mem: overwrite 9.txt with selected text
    ^!8::                                                                       ;Mem: overwrite 8.txt with selected text
    ^!7::                                                                       ;Mem: overwrite 7.txt with selected text
    ^!6::                                                                       ;Mem: overwrite 6.txt with selected text
    ^!5::                                                                       ;Mem: overwrite 5.txt with selected text
    ^!4::                                                                       ;Mem: overwrite 4.txt with selected text
    ^!3::                                                                       ;Mem: overwrite 3.txt with selected text
    ^!2::                                                                       ;Mem: overwrite 2.txt with selected text
    ^!1::              OverwriteMemory()                                        ;Mem: overwrite 1.txt with selected text

    PrintScreen & 0::                                                           ;Memory: overwrite 0.txt
    PrintScreen & 9::                                                           ;Memory: overwrite 9.txt
    PrintScreen & 8::                                                           ;Memory: overwrite 8.txt
    PrintScreen & 7::                                                           ;Memory: overwrite 7.txt
    PrintScreen & 6::                                                           ;Memory: overwrite 6.txt
    PrintScreen & 5::                                                           ;Memory: overwrite 5.txt
    PrintScreen & 4::                                                           ;Memory: overwrite 4.txt
    PrintScreen & 3::                                                           ;Memory: overwrite 3.txt
    PrintScreen & 2::                                                           ;Memory: overwrite 2.txt
    PrintScreen & 1::      OverwriteMemory()                                    ;Memory: overwrite 1.txt
    
    
    +#0::                                                                       ;Mem: add selected text to the bottom of 0.txt
    +#9::                                                                       ;Mem: add selected text to the bottom of 9.txt
    +#8::                                                                       ;Mem: add selected text to the bottom of 8.txt
    +#7::                                                                       ;Mem: add selected text to the bottom of 7.txt
    +#6::                                                                       ;Mem: add selected text to the bottom of 6.txt
    +#5::                                                                       ;Mem: add selected text to the bottom of 5.txt
    +#4::                                                                       ;Mem: add selected text to the bottom of 4.txt
    +#3::                                                                       ;Mem: add selected text to the bottom of 3.txt
    +#2::                                                                       ;Mem: add selected text to the bottom of 2.txt
    +#1::              AddToMemory()                                            ;Mem: add selected text to the bottom of 1.txt
    #0::                                                                        ;Mem: paste contents of 0.txt
    #9::                                                                        ;Mem: paste contents of 9.txt
    #8::                                                                        ;Mem: paste contents of 8.txt
    #7::                                                                        ;Mem: paste contents of 7.txt
    #6::                                                                        ;Mem: paste contents of 6.txt
    #5::                                                                        ;Mem: paste contents of 5.txt
    #4::                                                                        ;Mem: paste contents of 4.txt
    #3::                                                                        ;Mem: paste contents of 3.txt
    #2::                                                                        ;Mem: paste contents of 2.txt
    #1::                RetrieveMemory()                                        ;Mem: paste contents of 1.txt
    
    <!space::          RunCmd(GC("CommaAlias","V")), W("a")                     ;Mem: (V command) selects last word typed and replaces it with \mem_cache .txt file with the corresponding name (e.g., typing "1" + !space => paste 1.txt).
    >!space::          RunCmd(GC("PeriodAlias","V")), W("a")                    ;Mem: (V command) selects last word typed and replaces it with \mem_cache .txt file with the corresponding name (e.g., typing "1" + !space => paste 1.txt).        

  /* 
    $^!lbutton::        s("{blind}",100),RetrieveMemory(A_ThisHotkey,,,1)       ;Mem: double click and paste contents of 1.txt at cursor position       
    $^#lbutton::        s("{blind}",100),RetrieveMemory(,A_ThisHotkey)          ;Mem: double click and paste contents of number entered at prompt   
    $<!lbutton up::     s("{blind}",100), Clicks(2), s("^v")                    ;MouseFn: triple click, paste clipboard contents
    $<+<!lbutton up::   s("{blind}",100), Clicks(3), s("^v")                    ;MouseFn: double click, paste clipboard contents
  */


#IF
/*
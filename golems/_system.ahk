#IF
; LWIN MODIFIER KEY ____________________________________________________________
  
  ~LWin::       Send {Blind}{vk07}                                              ;Convenience: disables the ability for the left Win to activate the Start Menu, while allowing its use as a modifier 
  *LWin::       Send {Blind}{LWin Down}                                         ;C: renders windows key inert so it can act as a modifier key for AHK hotkeys (start menu: ^#enter or lwin + left mouse click)
  LWin Up::     Send {Blind}{vk07}{LWin Up}                                     ;C: renders windows key inert so it can act as a modifier key for AHK hotkeys (start menu: ^#enter or lwin + left mouse click)

; CB SYSTEM COMMANDS ___________________________________________________________
  :X:b~win::    BluetoothSettings()                                             ;SC: bluetooth settings
  :X:d~win::    DisplaySettings()                                               ;SC: display settings
  :X:n~win::    NotificationWindow()                                            ;SC: notification window
  :X:v~win::    SoundSettings()                                                 ;SC: sound settings
  :X:r~win::    RunProgWindow()                                                 ;SC: run program
  :X:x~win::    StartContextMenu()                                              ;SC: context menu for the Start button
  :X:k~win::    QuickConnectWindow()                                            ;SC: quick connect window
  :X:i~win::    WindowsSettings()                                               ;SC: windows settings
  :X:p~win::    PresentationDisplayMode()                                       ;SC: presentation display mode
  :X:s~~win::   PowerOptions("sleep")                                           ;SC: enter sleep mode
  :X:h~~win::   PowerOptions("hybernate")                                       ;SC: enter hybernate mode
  :X:sd~~win::  PowerOptions("shutdown")                                        ;SC: shutdown + power down 
  :X:rs~~win::  PowerOptions("restart")                                         ;SC: restart the computer
  :X:a~win::    Run assets\win\Alarms & Clock.lnk                               ;SC: alarm clock
  :X:m~win::    sendEmail()                                                     ;SC: send mail
  :X:ce~~win::  CloseAllPrograms()                                              ;SC: close all open programs 
  :X:ss~win::   CloudSync("ON")                                                 ;SC: turn on cloud sync 
  :X:qs~win::   CloudSync("OFF")                                                ;SC: turn off cloud sync
  :X:lt~win::   WinLLock(True)                                                  ;SC: turn on win+L locks computer
  :X:lf~win::   WinLLock(False)                                                 ;SC: turn off win+L locks computer
  :X:ap~win::   Run assets\win\Add Remove Programs.lnk                          ;SC: open add remove programs 
  :X:s~win::    send ^{esc}                                                     ;SC: open start menu (alt: Ctrl+Esc)
  :X:de~win::   send #{tab}                                                     ;SC: desktop environment overview
  :X:t~win::    SysTray()                                                       ;SC: system tray
  ~#left::
  ~#right::
  ~+#left::                                                                     ;SC: cursor follows active window when moving apps btn monitors (if turned on)
  ~+#right::                                                                    ;SC: cursor follows active window when moving apps btn monitors (if turned on)
  ~+!tab::                                                                      ;SC: cursor follows active window when switch apps with alt+tab (if turned on)
  ~!tab::       settimer, CFW,-250                                              ;SC: cursor follows active window when switch apps with alt+tab (if turned on)


  :X:tm~win::                                                                   ;SC: open task manager with hotstring combines with max + cursor follows task manager window
  :X:.~win::                                                                    ;SC: open task manager with hotstring combines with max + cursor follows task manager window
                send +^{esc}                                                    ;     TskMgrExt() will be executed after
  ~+^esc::      TskMgrExt()                                                     ;SC: maximize + mouse cursor follows window after task manager opens


; CB AHK UTILITIES _____________________________________________________________

  :X:wg~win::   LoadURL("https://github.com/bingson/wingolems")                 ;AHK: Load WinGolems GitHub Page
  :X:oc~win::   OpenFolder("mem_cache\")                                        ;AHK: open cache folder in file explorer
  :X:kh~win::   KeyHistory                                                      ;AHK: open key history
  :X:ws~win::   WindowSpy()
  :X:ec~win::   EditFile(config_path)                                           ;AHK: edit config.ini file
  :X:tut~win::  loadURL("autohotkey.com/docs/Tutorial.htm")                     ;AHK: AHK beginner tutorial
  :X:tcf~win::  TC("T_CF", "Cursor follows active window: ")                    ;AHK: toggle mouse cursor follows active window
  :X:clp~win::  WriteToINI(A_ComputerName, "CL_pfx")                            ;AHK: store selected text as label prefix
  :X:cls~win::  WriteToINI(A_ComputerName, "CL_sfx")                            ;AHK: store selected text as label suffix
  :X:cl~win::   CreateLabel("CL_pfx", "CL_sfx")                                 ;AHK: create hotstring label with execution option
  :X:!cl~win::  CreateLabel("!", "CL_sfx")                                      ;AHK: create normal label
  
  :X:gl~win::   GenerateHotkeyList()                                            ;AHK: generate a list of hotkeys in working directory.
  
  :X:q~~win::                                                                   ;AHK: quit ahk script
  +^#q::        ExitApp                                                         ;AHK: quit ahk script
  :X:r~~win::   reloadWG()                                                      ;AHK: reload ahk script 

  #^s::return                                                                   ;AHK: prevent windows speech recognition from popping up

  ; GuiControl, 2: +HScroll, CB_Display
  
 
; DEVELOPER OPTIONS ____________________________________________________________

  :X:td~win:: TC("T_d","Developer options: ")                               ;[T] toggle developer optns
  ; CB -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    
    #IF WinActive("ahk_id " CB_hwnd) and GC("T_d",0)                        ; If Command or Function Box active
    printscreen & space::  GUISubmit()                                          ;CB| submit GUI input
    #IF GC("T_d",0) & 
    printscreen & space::  CB()

  ; MEMORY -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    #IF GC("T_d",0) 

    PrintScreen & 0::                                                           ;Memory: paste overwrite 0.txt at current cursor position
    PrintScreen & 9::                                                           ;Memory: paste overwrite 9.txt at current cursor position
    PrintScreen & 8::                                                           ;Memory: paste overwrite 8.txt at current cursor position
    PrintScreen & 7::                                                           ;Memory: paste overwrite 7.txt at current cursor position
    PrintScreen & 6::                                                           ;Memory: paste overwrite 6.txt at current cursor position
    PrintScreen & 5::                                                           ;Memory: paste overwrite 5.txt at current cursor position
    PrintScreen & 4::                                                           ;Memory: paste overwrite 4.txt at current cursor position
    PrintScreen & 3::                                                           ;Memory: paste overwrite 3.txt at current cursor position
    PrintScreen & 2::                                                           ;Memory: paste overwrite 2.txt at current cursor position
    PrintScreen & 1::      RetrieveMemory(,,"PrintScreen")                      ;Memory: paste overwrite 1.txt at current cursor position
    
    #IF GC("T_d",0) and GetKeyState("shift", "P")
    PrintScreen & 0::                                                           ;Memory: paste overwrite 0.txt at current cursor position
    PrintScreen & 9::                                                           ;Memory: paste overwrite 9.txt at current cursor position
    PrintScreen & 8::                                                           ;Memory: paste overwrite 8.txt at current cursor position
    PrintScreen & 7::                                                           ;Memory: paste overwrite 7.txt at current cursor position
    PrintScreen & 6::                                                           ;Memory: paste overwrite 6.txt at current cursor position
    PrintScreen & 5::                                                           ;Memory: paste overwrite 5.txt at current cursor position
    PrintScreen & 4::                                                           ;Memory: paste overwrite 4.txt at current cursor position
    PrintScreen & 3::                                                           ;Memory: paste overwrite 3.txt at current cursor position
    PrintScreen & 2::                                                           ;Memory: paste overwrite 2.txt at current cursor position
    PrintScreen & 1::      RetrieveMemory(,,"PrintScreen")                      ;Memory: paste overwrite 1.txt at current cursor position
    
  ; REPOSITION WINDOW -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    #IF GC("T_d",0)
    PrintScreen & sc033::   
    ;"f" : "0Maximize"                                        ;FunctionBox: resize & move window
                q := { "q" : "1TopLeft"         
                     , "e" : "1TopRight"        
                     , "z" : "2BottomLeft"      
                     , "c" : "2BottomRight"     
                     , "a" : "0LeftHalf"     
                     , "d" : "0RightHalf"       
                     , "w" : "0TopHalf"         
                     , "s" : "0BottomHalf"      
                     , "dd": "5RightHalfSmall"       
                     , "aa": "5LeftHalfSmall"       
                     , "ww": "6TopHalfSmall"
                     , "ss": "6BottomHalfSmall"
                     , "qq": "L1TopLeftSmall"    
                     , "qa": "L2TopMidLeftSmall"    
                     , "za": "L3BottomMidLeftSmall"    
                     , "zz": "L4BottomLeftSmall" 
                     , "ee": "R1TopRightSmall"   
                     , "ed": "R2TopMidRightSmall"    
                     , "cd": "R3BottomMidRightSmall"                                     ; "r" optn sorts menu order by value instead of by key (default)  
                     , "cc": "R4BottomRightSmall" }
                FB("MoveWin", q, C.bwhite,, "rs")   ; "s" optn adds a space between case changes for GUI menu
                return
                                                                                              
  ; CONVENIENCE -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    #IF GC("T_d",0) 
    :X:ta~win::            CC("T_TM",1),CC("T_FM",1),CC("T_CF",1),CC("T_d",1)   ;turn on all interface layers and UI options 
                           ,CC("T_adv",1),PU("Advanced Mode: ON")   
                           
    !pgdn::                HideShowTaskbar(hide := !hide)                       ;Convenience| toggle taskbar 
    printscreen Up::                                                            ;Convenience| makes printscreen key inert so it can be used as a modifier key
    *printscreen::         Send {Blind}{vk07}                                   ;Convenience| makes printscreen key inert so it can be used as a modifier key
    :X:pscrn~win::         Send {PrintScreen}                                   ;windows 10 printscreen command
    *#i::                  SaveMousPos("i",1)                                   ;MouseFn: Left click and save mouse position
    *^#i::                 RecallMousePosClick("i")                             ;MouseFn: Move to saved mouse position and left click
    #o::                   Click, middle                                        ;MouseFn: mouse middle click
    PrintScreen & sc028::                                                       ;MouseFn: mouse Right click
    #sc028::               Click, Right                                         ;MouseFn: mouse Right click
    >+esc::                EditFile("golems\_system.ahk")                       ;Convenience: open _system.ahk
    lwin & rctrl::         ActivateWinID("Rctrl")                               ;ActvateApp: activate saved Window ID
    #n::                   AA("editor_path")                                    ;ActivateApp: Editor
    ralt & right::         s("{blind}"), s("{F11}")                             ;Convenience: full screen {F11}
    printscreen & lwin::   CursorJump("BL")
    lwin & printscreen::   CursorJump("BR")
                                                                                    
    
    #IF GC("T_d",0) and !WinActive("ahk_exe " exe["editor"])                    ; When editor not active 
    ^!d::             SelectLine(), s("^c"), s("right"), s("enter"), s("^v")    ;Convenience: duplicate line
    ralt & down::     s("{blind}"), s("{F11}")                                  ;Convenience: full screen {F11}

    
    #If GC("T_d",0) and GetKeyState("PrintScreen", "P")                         ; convert printscreen to another modifier key 
    $!k::                           CursorJump("T")                             ;MouseFn: move mouse cursor to top edge
    $!j::                           CursorJump("B",,"-20")                      ;MouseFn: move mouse cursor to bottom edge
    $!h::                           CursorJump("L","20")                        ;MouseFn: move mouse cursor to Left edge
    $!l::                           CursorJump("R","-40")                       ;MouseFn: move mouse cursor to Right edge
    p::                             WinClose,A                                  ;Convenience: close active window
    lctrl::                                                                     ;ActvateApp: activate saved Window ID
    ralt::                          ActivateWinID("Lctrl")                      ;ActvateApp: activate saved Window ID
    rctrl::                         ActivateWinID("Rctrl")                      ;ActvateApp: activate saved Window ID
    alt & lctrl::                   SaveWinID("Lctrl")                          ;ActvateApp (+ Alt): Save window ID for later activation 
    alt & rctrl::                   SaveWinID("Rctrl")                          ;ActvateApp (+ Alt): Save window ID for later activation 
    alt & q::                       SaveWinID("Q")                              ;ActvateApp (+ Alt): Save window ID for later activation w/ alt & q
    alt & w::                       SaveWinID("W")                              ;ActvateApp (+ Alt): Save window ID for later activation w/ alt & q
    alt & a::                       SaveWinID("A")                              ;ActvateApp (+ Alt): Save window ID for later activation w/ alt & a
    alt & s::                       SaveWinID("S")                              ;ActvateApp (+ Alt): Save window ID for later activation w/ alt & s
    alt & z::                       SaveWinID("Z")                              ;ActvateApp (+ Alt): Save window ID for later activation w/ alt & z
    alt & x::                       SaveWinID("X")                              ;ActvateApp (+ Alt): Save window ID for later activation w/ alt & x
    q::                             ActivateWinID("Q")                          ;ActvateApp: activate saved Window ID
    w::                             ActivateWinID("W")                          ;ActvateApp: activate saved Window ID
    a::                             ActivateWinID("A")                          ;ActvateApp: activate saved Window ID
    s::                             ActivateWinID("S")                          ;ActvateApp: activate saved Window ID
    z::                             ActivateWinID("Z")                          ;ActvateApp: activate saved Window ID
    x::                             ActivateWinID("X")                          ;ActvateApp: activate saved Window ID
    ralt & k::                      CursorJump("T")                             ;MouseFunctions: move mouse cursor to top edge
    ralt & j::                      CursorJump("B",,"-20")                      ;MouseFunctions: move mouse cursor to bottom edge
    ralt & h::                      CursorJump("L","20")                        ;MouseFunctions: move mouse cursor to Left edge
    ralt & l::                      CursorJump("R","-40")                       ;MouseFunctions: move mouse cursor to Right edge
    sc028::                         Click, Right                                ;MouseFunctions: mouse Right click
    !r::                            RunProgWindow()                             ;convenience: run programs alternate shortcut
    SC035::                         search()                                    ;Convenience: google search selected text
    SC027::                         WinMinimize,A                               ;Convenience: minimize window
    h::                             sendinput ^{Left 4}                         ;TextNavigation: jump left 4 words (ctrl+left x 4)
    l::                             sendinput ^{Right 4}                        ;TextNavigation: jump right 4 words (ctrl+right x 4)
    i::                             SaveMousPos("i",1)                          ;MouseFunctions: Left click and save mouse position
    j::                             Sendinput {Blind}{WheelDown 5}              ;MouseFunctions: scroll wheel down
    k::                             Sendinput {Blind}{WheelUp 5}                ;MouseFunctions: scroll wheel Up
    b::                             AA("explorer.exe", "buffer_path", True)     ;AA: File explorer open at buffer_path defined in config.ini (defaults to My Documents if none found)
#IF
  
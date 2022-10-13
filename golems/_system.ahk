#IF
; DISABLE KEYS _________________________________________________________________
    ;#^s::return                                                                ;AHK: prevent windows speech recognition from popping up  
    LWin::       Send {Blind}{vk07}                                             ;Convenience: disables the ability for the left Win to activate the Start Menu, while allowing its use as a modifier 
    *LWin::       Send {Blind}{LWin Down}                                       ;C: renders windows key inert so it can act as a modifier key for AHK hotkeys (start menu: ^#enter or lwin + left mouse click)
    LWin Up::     Send {Blind}{vk07}{LWin Up}                                   ;C: renders windows key inert so it can act as a modifier key for AHK hotkeys (start menu: ^#enter or lwin + left mouse click)
; CB SYSTEM COMMANDS ___________________________________________________________
    
    :X:b~win::     BluetoothSettings()                                          ;SC: bluetooth settings
    :X:d~win::     DisplaySettings()                                            ;SC: display settings
    <!#n up::                                                                   ;SC: notification window
    :X:n~win::     NotificationWindow()                                         ;SC: notification window
    :X:v~win::     SoundSettings()                                              ;SC: sound settings
    <!#r up::                                                                   ;SC: run program 
    :X:r~win::     RunProgWindow()                                              ;SC: run program
    <!#x up::                                                                   ;SC: context menu for the Start button 
    :X:x~win::     StartContextMenu()                                           ;SC: context menu for the Start button
    :X:k~win::     QuickConnectWindow()                                         ;SC: quick connect window
    :X:i~win::     WindowsSettings()                                            ;SC: windows settings
    :X:p~win::     PresentationDisplayMode()                                    ;SC: presentation display mode
    :X:s~~win::    PowerOptions("sleep")                                        ;SC: enter sleep mode

    #If GetKeyState("F12", "P")
    esc & del::                                                                 ;SC: (+shift) enter hybernate mode
    :X:h~~win::    W("esc"),PowerOptions("hybernate")                           ;SC: enter hybernate mode
    esc & end::                                                                 ;SC: (+shift) shutdown + power down  
    :X:sd~~win::   W("esc"),clearQuickAccessHistory(),PowerOptions("shutdown")  ;SC: shutdown + power down
    esc & home::                                                                ;SC: (+shift) close all open programs  
    :X:ce~~win::   W("esc"), CloseAllPrograms()                                             ;SC: close all open programs 
    #If
    
    :X:ch~~win:: clearQuickAccessHistory()                                      ;SC: clear file explorer quick access history

    :X:rs~~win::   PowerOptions("restart")                                        ;SC: restart the computer 
    F12 & a::                                                                     ;SC: alarm clock 
    :X:alarm~win::
    :X:a~win::     WinTimer()

    ;:X:ss~win::    CloudSync("ON")                                               ;SC: turn on cloud sync 
    ;:X:qs~win::    CloudSync("OFF")                                              ;SC: turn off cloud sync
    :X:ap~win::    Run assets\win\Add Remove Programs.lnk                         ;SC: open add remove programs 
    :X:phone~win:: Run assets\win\Your Phone.lnk                                  ;SC: open add remove programs 
    :X:s~win::     Send ^{esc}                                                    ;SC: open start menu (alt: Ctrl+Esc)
    :X:de~win::    Send #{tab}                                                    ;SC: desktop environment overview
    :X:t~win::     SysTray()                                                      ;SC: system tray
    
    ;#left::  MoveWin("L"), s(,,250), CFW()                                        ;CB: move CB window to left half                                 
    ;#right:: MoveWin("R"), s(,,250), CFW()                                        ;CB: move CB window to right half          

    
    ~#left::
    ~#right:: 
    ~+#left::                                                                     ;SC: cursor follows active window when moving apps btn monitors (if turned on)
    ~+#right::                                                                    ;SC: cursor follows active window when moving apps btn monitors (if turned on)
    ~+!tab::                                                                      ;SC: cursor follows active window when switch apps with alt+tab (if turned on)
    ~!tab::       settimer, CFW,-200                                              ;SC: cursor follows active window when switch apps with alt+tab (if turned on)
    


    :X:light~win::
    :X:dark~win::
    :X:TDL~win::  toggle_DarkMode()                                               ;SC: toggle dark/light mode 

    :X:taskmanager~win::                                                          ;SC: open task manager with hotstring combines with max + cursor follows task manager window
    
    ;                Send +^{esc}                                                    ;     TskMgrExt() will be executed after
    ~+^esc::      TskMgrExt()                                                     ;SC: maximize + mouse cursor follows window after task manager opens


; CB AHK UTILITIES _____________________________________________________________

    :X:wg~win::   LURL("https://github.com/bingson/wingolems")                    ;AHK: Load WinGolems GitHub Page   
    :X:om~win::   OpenFolder("mem_cache\")                                        ;AHK: open cache folder in file explorer
    :X:kh~win::   KeyHistory                                                      ;AHK: open key history
    :X:ll~win::   ListLines                                                       ;AHK: Displays the script lines most recently executed.
    :X:ws~win::   WindowSpy()                                                     ;AHK: open window spy 
    :X:ec~win::   EditFile(config_path)                                           ;AHK: edit config.ini file
    :X:tut~win::  LURL("autohotkey.com/docs/Tutorial.htm")                        ;AHK: AHK beginner tutorial
    :X:tcf~win::  TC("T_CF", "Cursor follows active window: ")                    ;AHK: toggle mouse cursor follows active window
    :X:clp~win::  WriteToINI(A_ComputerName, "CL_pfx")                            ;AHK: store selected text as label prefix
    :X:cls~win::  WriteToINI(A_ComputerName, "CL_sfx")                            ;AHK: store selected text as label suffix
    :X:cl~win::   CreateLabel("CL_pfx", "CL_sfx")                                 ;AHK: create hotstring label with execution option
    :X:!cl~win::  CreateLabel("!", "CL_sfx")                                      ;AHK: create normal label
    :X:gl~win::   GenerateHotkeyList()                                            ;AHK: generate a list of hotkeys in working directory.
    :X:q~~win::                                                                   ;AHK: quit ahk script
    +^#q::        ExitApp                                                         ;AHK: quit ahk script
    :X:r~~win::   reloadWG()                                                      ;AHK: reload ahk script 
    esc:: Send {esc}
; UPDATE WINGOLEMS _____________________________________________________________
  :X:uw~win::
  files := [ "golems\_functions.ahk"
           , "golems\_system.ahk"
           , "golems\_CB.ahk"
           , "golems\A_Quick_Start.ahk"
           , "golems\1_Apps_Misc.ahk"
           , "golems\2_Text_Manipulation.ahk"
           , "golems\3_File_Management.ahk"
           , "golems\4_App_Examples.ahk"
           , "mem_cache\help.txt"
           , "mem_cache\zb\SearchMenu.txt"
           , "mem_cache\zb\ChordTextMenu.txt"
           , "lib"
           , "assets\Screens"
           , "assets\tutorial"
           , "assets"
           , "Readme.md"
           , "golems\tools"]
  ,dest_path := UProfile "\WinGolems\"
  ,copyFiles(dest_path, files*)
  run Ahk2Exe.exe /in %dest_path%WinGolems.ahk /icon %dest_path%assets\Aikawns\W\gold.ico
  PU("WinGolems Updated")
  return
; TOGGLES ______________________________________________________________________
  
    :X:tm~win::        TC("T_mem", "memory layer: ")                              ;[T] Toggle memory hotkeys
    :X:tb~win::        TC("T_base", "base layer: ")                               ;[T] Toggle base interface template
    :X:tt~win::        TC("T_TM","Text_Manipulation: ")                           ;[T] Toggle Text_Manipulation template ON|OFF by typing "tt" in a Command Box or "tt~win" anywhere in windows           
    :X:tf~win::        TC("T_FM","File_Management: ")                             ;[T] Toggle File_Navigation template ON|OFF
    :X:td~win::        TC("T_d","Developer options: ")                            ;[T] Toggle developer optns
    :X:ln~win::        WinLLock(True)                                             ;[T] turn on win+L locks computer
    :X:lf~win::        WinLLock(False)                                            ;[T] turn off win+L locks computer

    
; DEVELOPER OPTIONS ____________________________________________________________

  ; MEMORY -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    #IF GC("T_d",0) 

    
    /*
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

    */    
   
  ; CONVENIENCE -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    #IF GC("T_d",0) 
    :X:ta~win::            CC("T_TM",1),CC("T_FM",1),CC("T_CF",1),CC("T_d",1)   ;turn on all interface layers and UI options 
                           ,CC("T_adv",1),PU("Advanced Mode: ON")   
                           
    <+F11::                HideShowTaskbar(hide := !hide)                       ;Convenience| toggle taskbar 
    printscreen Up::                                                            ;Convenience| makes printscreen key inert so it can be used as a modifier key
    *printscreen::         Send {Blind}{vk07}                                   ;Convenience| makes printscreen key inert so it can be used as a modifier key
    :X:pscrn~win::         Send {PrintScreen}                                   ;windows 10 printscreen command
                                                                                    
    #IF GC("T_d",0) and !WinActive("ahk_exe " exe["editor"])                    ; When editor not active 
    ^!d::             SelectLine(), s("^c"), s("right"), s("enter"), s("^v")    ;Convenience: duplicate line
    ralt & down::     s("{blind}"), s("{F11}")                                  ;Convenience: full screen {F11}
    
    #If GC("T_d",0) and GetKeyState("PrintScreen", "P")                         ; convert printscreen to another modifier key 
    p::                             WinClose,A                                  ;Convenience: close active window
    sc028::                         Click, Right                                ;MouseFunctions: mouse Right click
    ralt & r::                      RunProgWindow()                             ;send #r ; run programs alternate shortcut 
    j::                             Sendinput {Blind}{WheelDown 5}              ;MouseFunctions: scroll wheel down
    k::                             Sendinput {Blind}{WheelUp 5}                ;MouseFunctions: scroll wheel Up
    b::                             AA("explorer.exe")     ;AA: File explorer open at buffer_path defined in config.ini (defaults to My Documents if none found)
#IF
  
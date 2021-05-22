; MANIPULATE ACTIVE WINDOW _____________________________________________________

 ^#sc027::                Send {lwin down}d{lwin up}                            ;[MAW] show desktop
 ^#w::                    WinClose,A                                            ;[MAW] close active window
 ^#q::                    CloseClass()                                          ;[MAW] close all instances of the active program
 +#capslock::             ActivatePrevInstance()                                ;[MAW] rotate through instances of active program starting from oldest 
 #capslock::              ActivateNextInstance()                                ;[MAW] rotate through instances of active program starting from newest 
 >+enter::                send {F11}                                            ;[MAW] full screen {F11}
 PrintScreen & space::                                                          ;[MAW] move window btn monitors
 +#space::                Send {lwin down}{shift down}{Left}{shift up}{lwin up} ;[MAW] move window btn monitors    
 #ins::                   AlwaysOnTop()                                         ;[MAW] Always on top: ON
 #del::                   AlwaysOnTop("OFF")                                    ;[MAW] Always on top: Off
 PrintScreen & Left::     send {LWin down}{Left}{LWin up}                       ;[MAW] resize window to left half of screen
 PrintScreen & Right::    send {LWin down}{Right}{LWin up}                      ;[MAW] resize window to right half of screen
 PrintScreen & sc034::                                                          ;[MAW] maximize window
 $#space::                                                                      ;[MAW] maximize window
 PrintScreen & Up::                                                             ;[MAW] maximize window   
 #Up::                    WinMaximize,A                                         ;[MAW] maximize window 
 PrintScreen & SC027::                                                          ;[MAW] minimize window 
 +#k::                                                                          ;[MAW] minimize window 
 #SC027::                 WinMinimize,A                                         ;[MAW] minimize window 
 !#SC027::                Send #{SC027}                                         ;[MAW] insert emoji popup
 PrintScreen & PgDn::     MoveWindowToOtherDesktop()                            ;[MAW] MoveWindowToOtherDesktop

; SYS SETTINGS _________________________________________________________________

 End & F10:: Run explorer.exe ms-settings:bluetooth                             ;[SS] bluetooth settings
 End & F7::  Run explorer.exe ms-settings:display                               ;[SS] display setting
 End & F3::  Run explorer.exe %A_WinDir%\system32\mmsys.cpl                     ;[SS] sound settings
 End & k::   send {lwin down}k{lwin up}                                         ;[SS] quick connect window
 End & a::   Send {lwin down}a{lwin up}                                         ;[SS] notification window
 End & x::   Send {lwin down}x{lwin up}                                         ;[SS] power shell
 End & i::   Send {lwin down}i{lwin up}                                         ;[SS] windows settings
 End & r::   Send {lwin down}r{lwin up}                                         ;[SS] run program
 End & p::   Send {lwin down}p{lwin up}                                         ;[SS] activate monitor 
  
; SYS COMMANDS _________________________________________________________________

 ^#!Left:: Send {ctrl down}{lwin down}{Left}{ctrl up}{lwin up}                  ;[SC] switch desktop environments (Left)
 ^#!Right:: Send {ctrl down}{lwin down}{Right}{ctrl up}{lwin up}                ;[SC] switch desktop environments (Right)
 End & F9::  Run assets\win\Add Remove Programs.lnk                             ;[SC] Add Remove Programs 
 End & c::   Run assets\win\Alarms & Clock.lnk                                  ;[SC] alarm clock
 +^!del::    DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)  ;[SC] enter sleep with the '(single quote) key 
 ^#!del::    DllCall("PowrProf\SetSuspendState", "int", 1, "int", 0, "int", 0)  ;[SC] enter hybernate with the '\' key 
 ^#!esc::    ShutDown, 9                                                        ;[SC] shutdown + power down 
 +^!esc::    ShutDown, 2                                                        ;[SC] restart the computer
 End & F4:: CloseEverything()                                                   ;[SC] close all open programs 
 ^#!F12::  CloudSync("ON")                                                      ;[SC] turn on google cloud sync
 +^#F12::  CloudSync("OFF")                                                     ;[SC] turn off google cloud sync

; FAX/SCANNER __________________________________________________________________

 #IfWinActive ahk_class 7a56577c-6143-43d9-bdcb-bcf234d86e98
 !s::                                                                           ;[FS] Scan document
    send !fns
    sleep, sleep_num
    send s
    return
 #IfWinActive


; FILE EXPLORER ________________________________________________________________
 
 #IfWinActive ahk_group FileListers
 $+!c::     clipboard := Explorer_GetSelection()                                ;[FE] store file path(s) of selected file(s) in clipboard
 ^s::       SelectByRegEx()                                                     ;[FE] select files by regex
 !r::       Send {F2}                                                           ;[FE] rename file
 ^!c::      SendInput !dcmd{Enter}                                              ;[FE] Open Command Prompt Here
 !b::       send !{left}                                                        ;[FE] prev folder
 !n::       send !{right}                                                       ;[FE] forward folder
 ^!k::                                                                          ;[FE] up one directory level
 !u::       send !{up}                                                          ;[FE] up one directory level

 ^q::                                                                           ;[FE] close file exploer window
 !p::       Send ^w                                                             ;[FE] close file exploer window
 !z::       Send !vn{enter}                                                     ;[FE] panes: toggle navigation pane
 ^p::       Send {alt down}p{alt up}                                            ;[FE] panes: toggle preview plane

 <^j::                                                                          ;[FE] sort by name
    send {Ctrl Down}{NumpadAdd}{Ctrl up}     
    send !vo{enter} 
    return  
 
 <^k::                                                                          ;[FE] sort by date modified
    send {Ctrl Down}{NumpadAdd}{Ctrl up}     
    send !vo{Down}{enter}   
    return  
 
 >^j::                                                                          ;[FE] sort by type
    send {Ctrl Down}{NumpadAdd}{Ctrl up}     
    send !vo{Down}{Down}{enter} 
    return  
 
 >^k::                                                                          ;[FE] sort by size
    send {Ctrl Down}{NumpadAdd}{Ctrl up}     
    send !vo{Down}{Down}{Down}{enter}   
    return  
 
 ^u::      send !vg{up 4}{enter}                                                ;[FE] groups: toggle groupby name/remove grouping
 ^o::      Send !vg{down 2}{enter}                                              ;[FE] groups: group by file type
 ^i::      Send !vg{down 1}{enter}                                              ;[FE] groups: group by date
 !sc035::                                                                       ;[FE] groups: group folding: Expand all 
 ^sc035::  ExpandCollapseAllGroups()                                            ;[FE] groups: group folding: Collapse all
 
 ^SC034::                                                                       ;[FE] activate navigation pane
 +!Left::                                                                       ;[FE] activate navigation pane
 +!Space:: ControlFocus, SysTreeView321, ahk_class CabinetWClass                ;[FE] activate navigation pane
 
 +!Right::                                                                      ;[FE] activate current folder pane 
 >+Space::                                                                      ;[FE] activate current folder pane 
 <!Space::                                                                      ;[FE] activate current folder pane 
 >!Space:: ControlFocus, DirectUIHWND2, ahk_class CabinetWClass                 ;[FE] activate current folder pane 
 
 !SC027::                                                                       ;[FE] view: detailed view with resized columns
    send {ctrl down}{shift down}6{ctrl up}{shift up}
    send {Ctrl Down}{NumpadAdd}{Ctrl up}
    return
     
 del & v::                                                                      ;[FE] hide/unhide invisible files
    send !v
    sleep, med 
    send {h 2}
    return

 #IfWinActive    

; COMMAND WINDOW _______________________________________________________________

 SetTitleMatchMode, 2
 #If WinActive("ahk_class ConsoleWindowClass") 
 :X:R.exe::      clip("C:\R\R-4.0.5\bin\R.exe")                                 ;[C] R terminal (for pkg installation)
 :X:conda dir::  clip("conda info --envs")                                      ;[C] conda info --envs
 :X:j>::         clip("jupyter notebook")                                       ;[C] jupyter notebook
 :X:jl>::        clip("jupyterlab")                                             ;[C] jupyterlab
 #IfWinActive

; AHK RELATED __________________________________________________________________
 
 >+esc:: getMousePos()                                                          ;[AHK] display current mouse cursor coordinates in a tool tip
 :X:kh~~:: KeyHistory                                                           ;[AHK] open key history
 :X:ws~~:: run, C:\Program Files\AutoHotkey\WindowSpy.ahk                       ;[AHK] open windows spy
 +^#r::       ExitApp                                                           ;[AHK] quit ahk script
 End & l:: % (toggle := !toggle) ? WinLLock(False) : WinLLock(TRUE)             ;[AHK] toggle to enable win+L to lock screen

 Lwin & home::                                                                  ;[AHK] generate a list of hotkeys in working directory.
    ReleaseModifiers()
    GenerateHotkeyList()                                             
    return

 Lwin & end::                                                                   ;[AHK] open last generated list of hotstrings and hotkeys
    :*:hl~~::                                                                   ;[AHK] open last generated list of hotstrings and hotkeys
    ReleaseModifiers()
    EditFile("HotKey_List.txt", "vscode_path")
    return
 #enter::                                                                       ;[AHK] reload all ahk scripts with ~^#r reload hotkey
 $^#r::                                                                         ;[AHK] reload all ahk scripts with ~^#r reload hotkey
    Reload                                               
    return                                               
                                               
 $^#b::                                                                         ;[AHK] run test script
    sleep, med*2 
    run test.ahk                      
    return                                          

; MEMORY SYSTEM ________________________________________________________________

 del & 9::                                                                      ;[MS] cut selected text and overwrite mem slot 9
 del & 8::                                                                      ;[MS] cut selected text and overwrite mem slot 8
 del & 7::                                                                      ;[MS] cut selected text and overwrite mem slot 7
 del & 6::                                                                      ;[MS] cut selected text and overwrite mem slot 6
 del & 5::                                                                      ;[MS] cut selected text and overwrite mem slot 5
 del & 4::                                                                      ;[MS] cut selected text and overwrite mem slot 4
 del & 3::                                                                      ;[MS] cut selected text and overwrite mem slot 3
 del & 2::                                                                      ;[MS] cut selected text and overwrite mem slot 2
 del & 1::                                                                      ;[MS] cut selected text and overwrite mem slot 1
 del & 0::                                                                      ;[MS] cut selected text and overwrite mem slot 0
 ^#9::                                                                          ;[MS] copy selected text and overwrite mem slot 9
 ^#8::                                                                          ;[MS] copy selected text and overwrite mem slot 8
 ^#7::                                                                          ;[MS] copy selected text and overwrite mem slot 7
 ^#6::                                                                          ;[MS] copy selected text and overwrite mem slot 6
 ^#5::                                                                          ;[MS] copy selected text and overwrite mem slot 5
 ^#4::                                                                          ;[MS] copy selected text and overwrite mem slot 4
 ^#3::                                                                          ;[MS] copy selected text and overwrite mem slot 3
 ^#2::                                                                          ;[MS] copy selected text and overwrite mem slot 2
 ^#1::                                                                          ;[MS] copy selected text and overwrite mem slot 1
 ^#0::                                                                          ;[MS] copy selected text and overwrite mem slot 0
    OverwriteMemory() {
        slot       := substr(A_ThisHotkey, 0)                                 
        del_toggle := Instr(A_ThisHotkey, "del") ? True : False                 
        WriteToCache("m" slot, del_toggle)                                      ;     note: if no text selected, no overwrite will occur
        ShowModePopup("m" slot "`noverwritten",,"200")
        return
    }
 
 !#9::                                                                          ;[MS] copy selection and add to bottom of mem slot 9
 !#8::                                                                          ;[MS] copy selection and add to bottom of mem slot 8
 !#7::                                                                          ;[MS] copy selection and add to bottom of mem slot 7
 !#6::                                                                          ;[MS] copy selection and add to bottom of mem slot 6
 !#5::                                                                          ;[MS] copy selection and add to bottom of mem slot 5
 !#4::                                                                          ;[MS] copy selection and add to bottom of mem slot 4
 !#3::                                                                          ;[MS] copy selection and add to bottom of mem slot 3
 !#2::                                                                          ;[MS] copy selection and add to bottom of mem slot 2
 !#1::                                                                          ;[MS] copy selection and add to bottom of mem slot 1 
 !#0::                                                                          ;[MS] copy selection and add to bottom of mem slot 0
    AddToMemory(del_after_copy = "0", prepend = False){
        slot            := substr(A_ThisHotkey, 0)
        new_text_to_add := trim(clip())
        if (prepend = True) {
            FilePrepend("mem_cache\m" slot ".txt", new_text_to_add) 
            ShowModePopup("added to top `nm" slot ,,"250")
        } else {
            FileAppend % "`n" . new_text_to_add, mem_cache\m%slot%.txt           
            ShowModePopup("added to bottom `nm" slot ,,"250")
        }
        ; cut := Instr(A_ThisHotkey, "!") ? True : False 
        if (cut = true)
           send {del}
        return
   } 

 +#9::                                                                          ;[MS] paste contents of mem slot 9   
 +#8::                                                                          ;[MS] paste contents of mem slot 8   
 +#7::                                                                          ;[MS] paste contents of mem slot 7 
 +#6::                                                                          ;[MS] paste contents of mem slot 6    
 +#5::                                                                          ;[MS] paste contents of mem slot 5   
 +#4::                                                                          ;[MS] paste contents of mem slot 4   
 +#3::                                                                          ;[MS] paste contents of mem slot 3   
 +#2::                                                                          ;[MS] paste contents of mem slot 2   
 +#1::                                                                          ;[MS] paste contents of mem slot 1 
 +#0::                                                                          ;[MS] paste contents of mem slot 0 
 :*:m>::                                                                        ;[MS] paste contents of mem slot # by typing "m>" followed by the slot number 
    RetrieveMemory() {
        hotstring_pressed := Instr(A_ThisHotkey, "#") ? True : False
        if (hotstring_pressed = False)
            input, mem_slot, L1 T5
        else
            mem_slot := substr(A_ThisHotkey, 0) 
        AccessCache("m" mem_slot)  
        return
    } 
     
; DYNAMIC HOTSTRING CREATION ___________________________________________________
  
 /*** CreateHotstringSnippet() -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
 
   CreateHotstringSnippet() will create a .txt copy of selected text
   in the mem_cache folder that can be retrieved through dynamically created 
   hotstring (i.e., hotstring can be used immediately after creation). 
 
    — Python and R hotstring snippets are kept in separate directories. So the same
      hotstring name can be applied to corresponding layers of abstraction. 
      For example, "plot_scatter_plot" can be used in both python and R to output 
      language/api specific syntax for the same idea.
  
    — To see an index of hotstrings created through CreateHotstringSnippet() open 
      mem_cache/hotstring_creation_log.csv
 
    — FORMAT:
 
      1) First line of text will be transformed into the hotstring trigger string
         with a ">" character appended to the end.
      2) Second line will be transformed into a comment in the target .ahk file
      3) Third line should be the target text to store
 
    — EXAMPLE:
 
      hotstring_label
      comment/description of hotstring for hotkey_help.ahk indexing>
      text to store
 
      select above 3 lines and press insert & w to create a hotstring.
      Afterwards, typing "hotstring_label>" will output "text to store"  
 */
 
 
 Home & F8::                                                                    ;[D] open hotstring_creation_log.csv
 :*:hs~~::                                                                      ;[D] open hotstring_creation_log.csv
 run %A_ScriptDir%\mem_cache\hotstring_creation_log.csv
 return

 ^#!w:: CreateHotstringSnippet("80", "windows_sys.ahk")                         ;[D] create windows hotstring
 ^#!r:: CreateHotstringSnippet("80", "R.ahk")                                   ;[D] create R programming hotstring
 ^#!p:: CreateHotstringSnippet("80", "Python.ahk")                              ;[D] create python programming hotstring 

 ; -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
 
 :*:sck>::                                                                      ;[D] sc key legend
 AccessCache("sck")
 return
 
 :*:3key>::                                                                     ;[D] example of 3 button hotkey using &
 :*:3k>::                                                                       ;[D] example of 3 button hotkey using &
 AccessCache("3key")
 return

 :*:test_ahk>::                                                                 ;[D] code for testing ahk code
 AccessCache("test_ahk")
 return
 
 :*:cc>::                                                                       ;[D] 6-digit RGB color values
 :*:color_code>::                                                               ;[D] 6-digit RGB color values
 AccessCache("color_code")
 return

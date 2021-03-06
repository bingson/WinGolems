
; INITIALIZATION (start of auto-execution section) _____________________________
  ; ENSURE RUNNIG SCRIPT AS ADMIN -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- s
    ;https://www.reddit.com/r/AutoHotkey/comments/ac1epn/groggy_guide_admin_rights_privilege_level/
    if !A_IsAdmin || !(DllCall("GetCommandLine","Str")~=" /restart(?!\S)")
      Try Run % "*RunAs """ (A_IsCompiled?A_ScriptFullPath """ /restart":A_AhkPath """ /restart """ A_ScriptFullPath """")
      Finally ExitApp

  ; SCRIPT CONFIG -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    ; explained: https://www.autohotkey.com/boards/viewtopic.php?f=7&t=6413
    
    SetWorkingDir %A_ScriptDir%
    #MenuMaskKey vk07                                                           ; vk07 is no mapping; Avoid Ctrl getting stuck in down state, even when not physically pressed https://www.autohotkey.com/boards/viewtopic.php?t=29595
    #MaxMem 128
    #MaxHotkeysPerInterval 99000000
    ListLines Off ;On                                                           ; ListLines/KeyHistory are used to log lines of code and keys for debugging
    #KeyHistory 0 ;100                                                          ; change to a higher number for debugging
    #UseHook
    #InstallKeybdHook                                                           ; The keyboard hook monitors keystrokes for the purpose of activating hotstrings and any keyboard hotkeys
    #InstallMouseHook                                                           ; The mouse hook monitors mouse clicks for the purpose of activating mouse hotkeys and facilitating hotstrings.
    #Singleinstance Force                                                       ; only one instance of this script can be active
    SetMouseDelay, 10                                                           ; mouse click commands become less reliable at lower settings
    SetDefaultMouseSpeed, 0
    SetBatchLines, -1
    SetWinDelay, -1
    ;SetBatchLines, 20ms                                                        ; for slower computers 
    ;SetWinDelay, 10
    SetControlDelay, 20
    SendMode Event
    SetBatchLines, 10ms
    ListLines Off ;On                                                           ; ListLines/KeyHistory are used to log lines of code and keys for debugging
    SetKeyDelay, 10, 50
    SetWinDelay, 10
    Process, Priority, , A
    DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")                   ; adjusts Screen bounds / MouseGetPos / WinGetPos coordinates for different DPI scaling in multi monitor setups https://bityl.co/D5Ea
  ; GLOBAL VARIABLES -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
  
    #NoEnv                                                                      ; prevents empty variables from being looked up as potential environment variables
    EnvGet, hdrive, Homedrive                                                   ; see a list of available Environment variables at the command prompt by typing SET
    EnvGet, hpath, Homepath
    EnvGet, UProfile, UserProfile
    EnvGet, PF_x86, ProgramFiles(x86)
    EnvGet, winpath, windir
    config_path := A_ScriptDir "\config.ini"
    
    SetTrayIcon(A_ScriptDir "\assets\Aikawns\W\gold.ico")                       ; set static icon color: black, blue, dg (dark green), gold, grey, lg (light green), orange, pink, red, violet
    
    ; uncomment to disable WIN+L key for locking screen upon WinGolems startup  ; requires registry write premission, end & L hotkey toggles this as well
    ; WinLLock(False, True)                                                     ; False = disables windows lockscreen key hook; frees WIN+L key combo for ahk usage.
                                                                                ; True = enables windows lockscreen key hook (WIN+L); Second True disables pop up window confirmation
  ; FIRST TIME SETUP-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    ; only executed if no config.ini detected
    ; change the following default application associations.
    ; To generate a new configuration file reflecting changes in app associations,
    ; delete config.ini and reload WinGolems.ahk
    
    apps := [ "winword.exe"         ; Word          -> docm,doc,docx,dotx,dotm
            , "excel.exe"           ; Excel         -> xlsx,xlsm,xltx,xltm
            , "powerpnt.exe"        ; PowerPoint    -> ppt,pptx,pptm
            , "acrord32.exe"        ; Adobe Acrobat -> pdf
            , "chrome.exe"          ; Chrome        -> html, urls, ipynb
            , "code.exe" ]          ; VS Code       -> IDE + editor of last resort
    
    ConfigureWinGolems(config_path, apps *)

; LOAD AHK SCRIPTS (GOLEMS) ____________________________________________________ 

#Include %A_ScriptDir%\golems\
#Include _functions.ahk                                                         ; ***end of auto-execution section***
#Include _system.ahk
#Include _CB.ahk

#Include %A_ScriptDir%\golems\
#Include *i A_Quick_Start.ahk

; AHK files included earlier will have priority over ones included later, if there's overlap

/* #INCLUDE MECHANICS ********************************************************** 
 * Start.ahk:
 * include Return.ahk
 * MsgBox, this message will not be shown
 * 
 * Return.ahk:
 * Return <- After the return line, no more code will execute unless it's
 * started by a hotkey, gui action, timer, etc. Encountering
 * a "Return" will end the auto-execute section of any script.
 * 
 * Note: Encountering a return from a Gosub block where only variables are
 * initialized will not end the autoexecute -> providing a way of declaring
 * variables in other ahk files through gosubs variable intialization blocks.
 * 
 * You can think of #Include as "pasting" the included script's contents at the
 * line where you wrote #Include.
 * 
 * If the included script only contains functions, that include line won't end the
 * auto-execute section. If the included script contains a hotkey/hotstring with a return
 * statement, ahk will stop execution at that point. From that point on, functions/hotkeys/hotstrings
 * will still be loaded as usual but variables and class objects can only be created within functions
 * (ie., will otherwise never be initialized).
 * 
 *******************************************************************************/
; INITS ________________________________________________________________________
 SetWorkingDir %A_ScriptDir%
 #Singleinstance Force
 SetTitleMatchMode 2
 ; #If WinActive("ahk_exe explorer.EXE")
 ; #If WinActive("Notepad++") 
 SetWorkingDir %A_ScriptDir%
 #MaxHotkeysPerInterval 99000000
 SetBatchLines -1
 ListLines Off                                                                  ; ListLines/KeyHistory are used to log keys for debugging
 #KeyHistory 0                                                                  ; higher number for debugging
 #UseHook                                                
 #InstallKeybdHook                                               
 ; #InstallMouseHook                                             
 Process, Priority, , A                                                         
 SetKeyDelay, 10, 10                                             
 SetMouseDelay, 20                                                              ; mouse click commands become less reliable at lower settings
 SetDefaultMouseSpeed, 20                                                    
 SetWinDelay, 10                                                               
 SetControlDelay, 20                                                            
 SendMode Event                                                                 ; faster input
 ; INITIALIZE GLOBAL VARIABLES  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
 hypersnap_prefix := "HR_"                                                     ; set file naming prefix for hypersnap screenshots  
 img_width        := 425                                                       ; set image resize pixel width for hypersnap, jupyter, and office apps
 c_dist           := 80                                                        ; number of character lengths to reach comment column (code formatting functions)
 short            := 100                                                       ; set waiting time in milliseconds between actions for specific functions
 med              := 300                                                       ; set waiting time in milliseconds between actions for specific functions
 long             := 900                                                       ; set waiting time in milliseconds between actions for specific functions

 #NoEnv                                                                        ; prevents empty variables from being looked up as potential environment variables
 #Include %A_ScriptDir%
 #Include golems\_functions.ahk 
 EnvGet, hdrive, Homedrive                                                     ; see a list of Environment variables at the command prompt by typing SET
 EnvGet, hpath, Homepath
 EnvGet, UProfile, UserProfile
 EnvGet, PF_x86, ProgramFiles(x86)
 config_path      := A_ScriptDir "\config.ini"
 icon_path        := A_ScriptDir "\assets\Aikawns\T\"
 ChangeTrayIcon(icon_path)
 Gosub, AutoexecutionGosub, AutoexecutionGosub, AutoexecutionGosub, Autoexecution
 
 ~^#b::                                                                        ; reload script, MASTER.ahk has same hotkey which runs test.ahk
    send, {ctrl down}s{ctrl up}
    return

 +^#b::
    ExitApp ; quit running test script
    return


Autoexecution:




return ; end of auto execution section -----------------------------------------

; #t::
; #g:: 
























/* TEST AREA-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 











; CODE EXAMPLES ________________________________________________________________
 

 /* VARIABLES / FREE KEYS
    PrintScreen & PgUp::
    #pgup::             
    #pgdn::
    PrintScreen & Pgdn::
    #m
    PrintScreen M
    !#esc::
    ^#esc::
    #p:: 
    ^!t::  
    ; ^#p::
    !#esc::
    ^#esc::
    #esc

    var  = func() ... is not valid, unless you want the literal text "func()"
    var := func() ... will return the value/output of func(), if any

    var  = 5+5 ... will be the literal text "5+5"
    var := 5+5 ... will result in "10"

    var  = 5+%aaa% ... will be the literal text "5+8" if aaa contained "8"
    var := 5+aaa   ... will result in "13" if aaa contained "8"

 */
 
 
 /* EXCLUDE PROGRAM FROM HOTKEY

    #IfWinNotActive ahk_class Chrome_WidgetWin_1 

    SetTitleMatchMode,RegEx
    #IfWinActive ahk_class (SciTEWindow|Notepad)

    $Left::MsgBox

    #IfWinActive

 */
 
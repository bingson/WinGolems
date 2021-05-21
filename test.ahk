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
 hypersnap_prefix := "HR_"                                                      ; set file naming prefix for hypersnap screenshots  
 img_width        := 425                                                        ; set image resize pixel width for hypersnap, jupyter, and office apps
 c_dist           := 80                                                         ; number of character lengths to reach comment column (code formatting functions)
 short            := 100                                                        ; set waiting time in milliseconds between actions for specific functions
 med              := 300                                                        ; set waiting time in milliseconds between actions for specific functions
 long             := 900                                                        ; set waiting time in milliseconds between actions for specific functions
 
 #NoEnv                                                                         ; prevents empty variables from being looked up as potential environment variables
 #Include %A_ScriptDir% 
 #Include golems\_functions.ahk  
 EnvGet, hdrive, Homedrive                                                      ; see a list of Environment variables at the command prompt by typing SET
 EnvGet, hpath, Homepath 
 EnvGet, UProfile, UserProfile
 EnvGet, PF_x86, ProgramFiles(x86)
 config_path      := A_ScriptDir "\config.ini"
 ; config_path      := UProfile "\Google Drive\secure\config.ini"
 
 icon_path        := A_ScriptDir "\assets\Aikawns\T\"
 ChangeTrayIcon(icon_path)
 Gosub, Autoexecution
 
 ~^#b::                                                                         ; save and rerun test script
    send, ^s                                                                    ; master.ahk has the run test.ahk code that is execution after a small sleep period
    return

 end & b::
    ReleaseModifiers()
    ExitApp                                                                     ; close running test script
    return

Autoexecution: 

CreateConfigINI()

return ; end of auto execution section _________________________________________











/* TEST AREA ___________________________________________________________________




/* REFERENCE ___________________________________________________________________
 LINKS -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
  Math operations:   https://www.autohotkey.com/boards/viewtopic.php?t=64545 
  Escape chars:      https://www.autohotkey.com/docs/misc/EscapeChar.htm
  Classes tutorial:  https://www.autohotkey.com/boards/viewtopic.php?f=7&t=6033 
  Advanced classes:  https://www.autohotkey.com/boards/viewtopic.php?f=7&t=6177 
  regex:             https://www.autohotkey.com/boards/viewtopic.php?t=28031
  variables:         https://www.autohotkey.com/docs/Variables.htm
 
 FREE KEYS -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
 
    PrintScreen & PgUp::
    #pgup::             
    #pgdn::#pgdn::bb
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

 VARIABLES -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

    var  = func() ... is not valid, unless you want the literal text "func()"
    var := func() ... will return the value/output of func(), if any

    var  = 5+5 ... will be the literal text "5+5"
    var := 5+5 ... will result in "10"

    var  = 5+%aaa% ... will be the literal text "5+8" if aaa contained "8"
    var := 5+aaa   ... will result in "13" if aaa contained "8"

 SC KEY REFERENCE -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

  sc027 = {;:}    sc028 = {"'}    sc029 = {`~}     sc033 = {,<}      sc02b = {\|}
 
  sc034 = {.>}    sc035 = {/?}    sc00D = {=+}     sc00C = {-_} 
 
  sc01a or b = {[} or {]} 


*/
 
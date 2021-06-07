; SCRIPT OPTIMIZATION SETTINGS (start of auto-execution section) _______________
  ; Info: https://www.autohotkey.com/boards/viewtopic.php?f=7&t=6413
 
  SetWorkingDir %A_ScriptDir%
  #MaxHotkeysPerInterval 99000000
  SetBatchLines -1
  ListLines Off                                                                 ; ListLines/KeyHistory are used to log keys for debugging
  #KeyHistory 0                                                                 ; higher number for debugging 
  #UseHook                                                
  #InstallKeybdHook                                                             ; The keyboard hook monitors keystrokes for the purpose of activating hotstrings and any keyboard hotkeys
  ; #InstallMouseHook                                                           ; The mouse hook monitors mouse clicks for the purpose of activating mouse hotkeys and facilitating hotstrings.
  #Singleinstance Force                                                         ; only one instance of this script can be active
  Process, Priority, , A                                                         
  SetKeyDelay, 10, 10                                             
  SetMouseDelay, 20                                                             ; mouse click commands become less reliable at lower settings
  SetDefaultMouseSpeed, 0                                                    
  SetWinDelay, 10                                                               
  SetControlDelay, 20                                                            
  SendMode Event                                                                
  ; SetTimer, Reload, 60000                                                     ; reloads the script once every minute; makes the script reliable when running multiple ahk scripts on older hardware
                                                                                ; or when multiple scripts (not recommended) are loaded in the system tray simultaneously instead of included into 1 script 
; INITIALIZE GLOBAL VARIABLES __________________________________________________
  
  config_path := A_ScriptDir "\config.ini"
  
  #NoEnv                                                                        ; prevents empty variables from being looked up as potential environment variables
  EnvGet, hdrive, Homedrive                                                     ; see a list of available Environment variables at the command prompt by typing SET
  EnvGet, hpath, Homepath
  EnvGet, UProfile, UserProfile
  EnvGet, PF_x86, ProgramFiles(x86)
  
  short            := 100                                                       ; set sleep time in milliseconds between actions for specific functions
  med              := 300                                                       
  long             := 900                                                       
  thm_sys          := new TapHoldManager(270,,maxTaps = 3,"$","")               ; instantiate TapHoldManager class for double press to execute hotkeys
  
  GroupAdd, FileListers, ahk_class CabinetWClass                                ; create reference group for file explorer and save as dialogue boxes
  GroupAdd, FileListers, ahk_class WorkerW
  GroupAdd, FileListers, ahk_class #32770, ShellView
  
  gosub, test_autoexecution                                                     ; initializes variables for script testing template
  gosub, JL_AutoExecution                                                       ; [JL]  win_goto.ahk  
  gosub, MAW_AutoExecution                                                      ; [MAW] win_sys.ahk   
  ; gosub, coding_autoexecution  
  ; gosub, Bing_autoexecution    
  ; gosub, chrome_autoexecution  

  icon_path   := A_ScriptDir "\assets\Aikawns\W\"                               ; set tray icon to desired letter path
  SetTrayIcon(icon_path "lg.ico")                                               ; set static icon color, black, blue, dg (dark green), gold, grey, lg (light green), orange, pink, red, violet

  ; uncomment to disable WIN+L key for locking screen upon WinGolems startup    ; requires registry write premission, end & L hotkey toggles this as well
  ; WinLLock(False, True)                                                       ; False = disables windows lockscreen key hook; frees WIN+L key combo for ahk usage.
                                                                                ; True = enables windows lockscreen key hook (WIN+L); Second True disables pop up window confirmation 
; FIRST TIME SETUP (only executed if no config.ini detected)____________________
 ; please confirm/change the following application associations. 
 ; To generate an updated config.ini reflecting new changes, delete config.ini 
 ; and reload/rerun wingolems.ahk 

 apps := [ "winword.exe"           ; Word          -> docm,doc,docx,dotx,dotm  
         , "excel.exe"             ; Excel         -> xlsx,xlsm,xltx,xltm               
         , "powerpnt.exe"          ; PowerPoint    -> ppt,pptx,pptm            
         , "acrord32.exe"          ; Adobe Acrobat -> pdf                       
         , "chrome.exe"            ; Chrome        -> html, urls, ipynb                   
         , "googledrivesync.exe"   ; Google Drive  -> backup program
         , "code.exe" ]            ; VS Code       -> IDE + editor of last resort
         
 ConfigureWinGolems(config_path, apps*)
 

; LOAD AHK SCRIPTS (end of auto-execution section)______________________________
 #Include %A_ScriptDir%\golems                                                  ; folder reference changes subsequent includes to look from that location
 #Include _functions.ahk   
 #Include *i win_text_navigation.ahk            
 #Include *i win_sys.ahk   
 #Include *i win_goto.ahk   
 #Include *i win_mem_system.ahk   
 #Include *i test.ahk   
 #Include *i R.ahk                               
 #Include *i Python.ahk                          
 #Include *i TapHoldManager.ahk
 
 #Include %A_ScriptDir%\..\Google Drive\secure\
 #Include *i bing.ahk
 #Include *i mm.ahk                     
 #Include *i %A_ScriptDir%\..\ahk\golems\coding_environments.ahk
 #Include *i %A_ScriptDir%\..\ahk\golems\chrome.ahk
 

/* #INCLUDE MECHANICS ********************************************************** 
 Start.ahk:
     #include Return.ahk
     MsgBox, this message will not be shown
 
 Return.ahk: 
     Return <- After the return line, no more code will execute unless it's 
               started by a hotkey, gui action, timer, etc. Encountering 
               a "Return" will end the auto-execute section of any script.
               
               Note: Encountering a return from a Gosub block where only variables are 
               initialized will not end the autoexecute -> providing a way of declaring 
               variables in other ahk files through gosubs variable intialization blocks.  

 You can think of #Include as "pasting" the included script's contents at the 
 line where you wrote #Include. 
 
 If the included script only contains functions, that include line won't end the 
 auto-execute section. If the included script contains a hotkey/hotstring with a return
 statement, ahk will stop execution at that point. From that point on, functions/hotkeys/hotstrings
 will still be loaded as usual but variables and class objects can only be created within functions
 (ie., will otherwise never be initialized).

*******************************************************************************/
